Received: from eggs.gnu.org ([2001:4830:134:3::10]:56819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqLu-0003Bh-NP
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqLt-0001uz-J6
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:16:22 -0400
Date: Tue, 27 Jun 2017 14:16:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170627131605.GG13634@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-5-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498566850-7934-5-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 4/4] block/qcow2: add zlib-fast compression
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

On Tue, Jun 27, 2017 at 02:34:10PM +0200, Peter Lieven wrote:
> this adds support for optimized zlib settings which almost
> tripples the compression speed while maintaining about
> the same compressed size.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2-cluster.c |  3 ++-
>  block/qcow2.c         | 11 +++++++++--
>  block/qcow2.h         |  1 +
>  qemu-img.texi         |  1 +
>  4 files changed, 13 insertions(+), 3 deletions(-)
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 043c1ba..83a5db2 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -627,6 +627,7 @@ The following options are available if support for the respective libraries
>  has been enabled at compile time:
>  
>     zlib            Uses standard zlib compression (default)
> +   zlib-fast       Uses zlib compression with optimized compression parameters

This looks like a poor design from a future proofing POV. I would much
rather see us introduce a more flexible modelling of compression at the
QAPI layer which lets us have tunables for each algorith, in the same
way that the qcow2 built-in encryption now has ability to set tunables
for each algorithm.

eg your "zlib-fast" impl which just uses zlib with a window size of -15
could be expressed as

   qemu-img create -o compress.format=zlib,compress.window=-15



>     lzo             Uses LZO1X compression


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
