Received: from eggs.gnu.org ([2001:4830:134:3::10]:45169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbPK1-0001Py-P2
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbPJy-0002tM-Gv
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:17:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbPJy-0002sm-7O
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:17:54 -0500
References: <20170207155956.21573-1-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <30b06d2a-36ac-e3d7-f057-8c8277cf70fe@redhat.com>
Date: Wed, 8 Feb 2017 11:17:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170207155956.21573-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/07/17 16:59, Paolo Bonzini wrote:
> I have converted all .gz and .bz2 files to .xz on download.qemu.org
> and this patch would change the links in the website.  This would save
> about 5 GB of bandwidth every day (about 20% savings).
> 
> xz should be available for all platforms.  Besides providing better
> compression ratios, decompression of .xz files is about twice as fast
> compared to bzip2.  Compression instead is about 5.5 times slower.

Not wanting to waste your time, but did you try decompression with
lbzip2? :) Given the above data (i.e., xz decompression is only twice as
fast as single-threaded bzip2 decompression), if you speed up bzip2
decompression four-fold (hence quad-core), then bzip2 would win by a
factor of two.

In addition, lbzip2 uses a separate, heavily optimized bzip2 compression
algorithm, which (as far as I remember!) is faster than libbz2's
implementation even in single-threaded mode.

(IOW, I disagree with Eric's statement "bzip2 is pointless these days"
-- it is niche, yes, but some uses remain in the multi-core world.)

Here's my completely ad-hoc test.

(0) My laptop is a Lenovo W541, quad core, HT enabled (hence 8 logical
processors, but the extra hyper-threads are practically useless for
multi-threaded compression, because of their contention for the
core-level cache). IOW, my laptop counts as a quad core for the purpose
at hand.

(1) I downloaded <http://download.qemu-project.org/qemu-2.8.0.tar.xz>
from the website, and decompressed it. I didn't measure the time, I just
wanted the TAR file. Size: 177,428,480 bytes.

(2) I re-compressed the TAR with "absurd" XZ compression settings (we're
trying to save server-side upload bandwidth, so maximum compression
settings are justified). Results:

$ time -p xz -9 --extreme --keep --threads=0 qemu-2.8.0.tar
real 83.54
user 83.51
sys 0.07

Output size: 22,337,312 bytes; which is approximately 12.59% of the
original.

(3) Compression with lbzip2 (default is maximum block size, so no need
for "-9"):

$ time -p lbzip2 --keep qemu-2.8.0.tar
real 1.96
user 15.19
sys 0.14

Output size: 28,509,351; which is approximately 16.07% of the original.


So in compression, lbzip2 saves about 3.48% less, relative to the
original, than xz.

In exchange, the CPU time burned for lbzip2 compression is (user + sys
for (3)) / (user + sys for (2)):

  (15.19 + 0.14) / (83.51 + 0.07) ~= 18.34%

of XZ's CPU demand.

And wall clock time for lbzip2 compression (again, using my quad-core
laptop) is:

  1.96 / 83.54 = 2.34%

of XZ's wall clock time.


Let's see decompression:

(4) Decompression with XZ (no multi-threaded decompression is available):

$ time -p xz --decompress --stdout qemu-2.8.0.tar.xz >/dev/null
real 1.39
user 1.38
sys 0.00

(5) Decompression with lbzip2:

$ time -p lbzip2 --decompress --stdout qemu-2.8.0.tar.bz2 >/dev/null
real 0.87
user 6.78
sys 0.06

The CPU demand is significantly higher for lbzip2 decompression:

  (6.78 + 0.06) / 1.38 ~= 495.65%

But the wall clock time is better:

  0.87 / 1.39 ~= 62.59%

(6) Baseline for standard bzip2 decompression (same file from (3)):

$ time -p bzip2 --decompress --stdout qemu-2.8.0.tar.bz2 >/dev/null
real 3.23
user 3.21
sys 0.02

CPU demand relative to XZ decompression:

  (3.21 + 0.02) / 1.38 ~= 234.06%

Wall clock time relative to XZ decompression:

  3.23 / 1.39 ~= 232.37%


So here's the morale that I draw for the BZ2 *format* (for my quad-core
laptop), relative to the XZ format *and* utility:

* Using lbzip2 for compression on the "server side" (assuming my laptop
  is the "server"),
  * we save a whole lot on CPU demand and wall clock time during
    compression, but that's done only once, so it doesn't really matter,
  * we lose 3.48% compression efficiency, which directly translates to
    server upload bandwidth, which may or may not matter.
* Using lbzip2 decompression on the client side (assuming my laptop is
  the client),
  * the CPU demand is almost 5-fold of that of xz decompression,
  * but the wall clock time is approx. 62.59% of that of xz
    decompression.
* Using traditional bzip2 decompression on the client side, it's a pure
  loss:
  * more than 2-fold CPU demand, relative to XZ decompression,
  * more than 2-fold wall clock time, relative to XZ decompression.
* I didn't consider differences in download costs for the clients (I
  think those are negligible).

Thus, if most (interactive) clients use lbzip2 and are at least
quad-core, then the BZ2 format is worth it, for the wall clock time
savings. Otherwise, XZ is better.

... I agree that xz is more widely known and available than lbzip2.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _download/source.html   | 4 ++--
>  _includes/releases.html | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/_download/source.html b/_download/source.html
> index 1ac8f4f..d090a5e 100644
> --- a/_download/source.html
> +++ b/_download/source.html
> @@ -15,8 +15,8 @@
>  
>  	{% for release in site.data.releases offset: 0 limit: 1 %}
>  	<p>To download and build QEMU {{release.branch}}.{{release.patch}}:</p>
> -<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2
> -tar xvjf qemu-{{release.branch}}.{{release.patch}}.tar.bz2
> +<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz
> +tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
>  cd qemu-{{release.branch}}.{{release.patch}}
>  ./configure
>  make
> diff --git a/_includes/releases.html b/_includes/releases.html
> index 2caab8d..226c719 100644
> --- a/_includes/releases.html
> +++ b/_includes/releases.html
> @@ -1,9 +1,9 @@
>  <ul>
>  {% for release in site.data.releases offset: 0 limit: 4 %}
>  <li><strong><a
> -  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2">{{release.branch}}.{{release.patch}}</a></strong>
> +  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
>    {{release.date}}<br><a
> -  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2.sig">signature</a> &mdash; <a
> +  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a> &mdash; <a
>    href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
>  {% endfor %}
>  </ul>
> 
