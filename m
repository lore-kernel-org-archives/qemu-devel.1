Received: from eggs.gnu.org ([209.51.188.92]:50778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2I94-0001kQ-B7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2I93-0004Bu-LU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:14:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2I93-0004BF-F9
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:14:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id f65so13052387wma.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:14:49 -0800 (PST)
References: <20190308135744.6480-1-peter.maydell@linaro.org>
	<20190308135744.6480-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f5616ef-84a8-0923-6b1d-d52ddc8eecd8@redhat.com>
Date: Fri, 8 Mar 2019 17:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190308135744.6480-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Makefile: Don't install non-sphinx
 files in sphinx docs install
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 3/8/19 2:57 PM, Peter Maydell wrote:
> If we're doing an out-of-tree build of Sphinx, then we
> copy some extra spurious files to the install directory
> as part of 'make install':
> qemu-ga-qapi.texi
> qemu-ga-ref.7
> qemu-ga-ref.7.pod
> qemu-ga-ref.html
> qemu-ga-ref.txt
> qemu-qmp-qapi.texi
> qemu-qmp-ref.7
> qemu-qmp-ref.7.pod
> qemu-qmp-ref.html
> qemu-qmp-ref.txt
> 
> because these have been built into build/docs/interop along
> with the Sphinx interop documents. Filter them out of the
> set of files we install when we're installing the Sphinx-built
> manual files. (They are installed into their correct locations
> as part of the main install-doc target already.)
> 
> Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 9fd7f3f9bfb..6ccb8639b08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -727,9 +727,11 @@ else
>  BLOBS=
>  endif
>  
> +# Note that we manually filter-out the non-Sphinx documentation which
> +# is currently built into the docs/interop directory in the build tree.
>  define install-manual =
>  for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
> -for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
> +for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
>  endef
>  
>  # Note that we deliberately do not install the "devel" manual: it is
> 
