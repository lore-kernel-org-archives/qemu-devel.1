Received: from eggs.gnu.org ([2001:4830:134:3::10]:58403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrDN-00012W-49
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrDL-0001uw-PO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:31:13 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csrDL-0001tn-IM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:31:11 -0400
Received: by mail-wr0-x236.google.com with SMTP id w11so87190205wrc.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 06:31:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328130843.1931-1-stefanha@redhat.com>
References: <20170328130843.1931-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 14:30:46 +0100
Message-ID: <CAFEAcA-Vu34pX6e=yK4ax0C8j5t12ad_Rm1SAaPbJEhvXcr54w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: eliminate Python dependency for
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 14:08, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The ./configure script should produce --help output even if Python is
> not installed.
>
> Listing trace backends is simple: show the names of all Python modules
> in scripts/tracetool/backend/ whose source code contains 'PUBLIC =
> True'.
>
> Perform the backend enumeration in shell instead of Python so that we
> can move the Python check until after ./configure --help.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks. I think we should postpone this to 2.10 since we've had
this behaviour since forever, but it's a useful start to getting
our --help text into a less confusing place in configure.

> @@ -1328,7 +1313,7 @@ Advanced options (experts only):
>                             set block driver read-only whitelist
>                             (affects only QEMU, not qemu-img)
>    --enable-trace-backends=B Set trace backend
> -                           Available backends: $($python $source_path/scripts/tracetool.py --list-backends)
> +                           Available backends: $(grep -le '^PUBLIC\s*=\s*True$' scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/' | xargs echo)


'\s' doesn't work with NetBSD grep (it isn't POSIX). I think you need
   '^PUBLIC[[:space:]]*=[[:space:]]True'

(or just use ' ' since we don't have to contend with tabs here, as
you suggested on IRC).

I think we should also move the determining of the list of backends
out of the --help text itself, so set an avail_trace_backends
variable first and then just substitute the variable here.

thanks
-- PMM
