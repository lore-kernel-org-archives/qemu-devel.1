Received: from eggs.gnu.org ([209.51.188.92]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2GoX-0007EK-4b
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2GoU-0002ge-2C
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2GoT-0002Xg-QK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id o7so1557516wrp.12
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:49:28 -0800 (PST)
References: <20190308135744.6480-1-peter.maydell@linaro.org>
	<20190308135744.6480-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22e3ed96-e36f-2de1-4c81-66e9ff372290@redhat.com>
Date: Fri, 8 Mar 2019 15:49:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190308135744.6480-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] Makefile: Fix Sphinx documentation
 builds for in-tree builds
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
> The Sphinx build-sphinx tool does not permit building a manual
> into the same directory as its source files. This meant that
> commit 5f71eac06e15b9a3fa1134d446f broke QEMU in-source-tree
> builds, which would fail with:
>   Error: source directory and destination directory are same.
> 
> Fix this by making in-tree builds build the Sphinx manuals
> into a subdirectory of docs/.
> 
> Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d2463c92371..0194ef7fa55 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -655,12 +655,20 @@ dist: qemu-$(VERSION).tar.bz2
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
>  
> -# Note that these commands assume that there are no HTML files in
> -# the docs subdir in the source tree! If there are then this will
> -# blow them away for an in-source-tree 'make clean'.
> +# Sphinx does not allow building manuals into the same directory as
> +# the source files, so if we're doing an in-tree QEMU build we must
> +# build the manuals into a subdirectory (and then install them from
> +# there for 'make install'). For an out-of-tree build we can just
> +# use the docs/ subdirectory in the build tree as normal.
> +ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> +MANUAL_BUILDDIR := docs/built
> +else
> +MANUAL_BUILDDIR := docs
> +endif
> +
>  define clean-manual =
> -rm -rf docs/$1/_static
> -rm -f docs/$1/objects.inv docs/$1/searchindex.js docs/$1/*.html
> +rm -rf $(MANUAL_BUILDDIR)/$1/_static
> +rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
>  endef
>  
>  distclean: clean
> @@ -720,8 +728,8 @@ BLOBS=
>  endif
>  
>  define install-manual =
> -for d in $$(cd docs && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
> -for f in $$(cd docs && find $1 -type f); do $(INSTALL_DATA) "docs/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
> +for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
> +for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
>  endef
>  
>  # Note that we deliberately do not install the "devel" manual: it is
> @@ -885,17 +893,17 @@ docs/version.texi: $(SRC_PATH)/VERSION
>  # and handles "don't rebuild things unless necessary" itself.
>  # The '.doctrees' files are cached information to speed this up.
>  .PHONY: sphinxdocs
> -sphinxdocs: docs/devel/index.html docs/interop/index.html
> +sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html
>  
>  # Canned command to build a single manual
> -build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 docs/$1 ,"SPHINX","docs/$1")
> +build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
>  
> -docs/devel/index.html: $(call manual-deps,devel)
> +$(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
>  	$(call build-manual,devel)
>  
> -docs/interop/index.html: $(call manual-deps,interop)
> +$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
>  	$(call build-manual,interop)
>  
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
> 
