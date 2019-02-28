Received: from eggs.gnu.org ([209.51.188.92]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzNwA-0001vw-3r
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzNw5-0005dT-Bo
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:49:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzNvx-0005aj-Pr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:49:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so9660934wmi.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 07:49:15 -0800 (PST)
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
Date: Thu, 28 Feb 2019 16:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190228145624.24885-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

Hi Peter,

On 2/28/19 3:56 PM, Peter Maydell wrote:
> Add support to our configure and makefile machinery for building
> our rST docs into HTML files.
> 
> Building the documentation now requires that sphinx-build is
> available; this seems better than allowing half the docs to
> be built if it is not present but having half of them missing.
> (In particular it means that assuming that distros configured with
> --enable-docs they'll get a helpful error from configure telling
> them the new build dependency.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure |  4 ++--
>  Makefile  | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 694088a4ec9..bf6850d4bd9 100755
> --- a/configure
> +++ b/configure
> @@ -4565,11 +4565,11 @@ fi
>  
>  # Check if tools are available to build documentation.
>  if test "$docs" != "no" ; then
> -  if has makeinfo && has pod2man; then
> +  if has makeinfo && has pod2man && has sphinx-build; then

Unrelated to your patch, I tried that on fresh Fedora image where no
python2 installed (on purpose). sphinx-build is not included in the
suggested python3-sphinx. Once python2-sphinx installed (which pull a
lot of py2 packages) I could test your series.

>      docs=yes
>    else
>      if test "$docs" = "yes" ; then
> -      feature_not_found "docs" "Install texinfo and Perl/perl-podlators"
> +      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and python-sphinx"
>      fi
>      docs=no
>    fi
> diff --git a/Makefile b/Makefile
> index 7fa04e08212..d6b897be0bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -388,7 +388,7 @@ dummy := $(call unnest-vars,, \
>  
>  include $(SRC_PATH)/tests/Makefile.include
>  
> -all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
> +all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
>  
>  qemu-version.h: FORCE
>  	$(call quiet-command, \
> @@ -633,6 +633,14 @@ dist: qemu-$(VERSION).tar.bz2
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
>  
> +# Note that these commands assume that there are no HTML files in
> +# the docs subdir in the source tree! If there are then this will
> +# blow them away for an in-source-tree 'make clean'.
> +define clean-manual =
> +rm -rf docs/$1/_static
> +rm -f docs/$1/objects.inv docs/$1/searchindex.js docs/$1/*.html
> +endef
> +
>  distclean: clean
>  	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
>  	rm -f config-all-devices.mak config-all-disas.mak config.status
> @@ -653,6 +661,9 @@ distclean: clean
>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
>  	rm -f docs/qemu-block-drivers.7
>  	rm -f docs/qemu-cpu-models.7
> +	rm -f .doctrees
> +	$(call clean-manual,devel)
> +	$(call clean-manual,interop)
>  	for d in $(TARGET_DIRS); do \
>  	rm -rf $$d || exit 1 ; \
>          done
> @@ -686,7 +697,18 @@ else
>  BLOBS=
>  endif
>  
> -install-doc: $(DOCS)
> +define install-manual =
> +for d in $$(cd docs && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
> +for f in $$(cd docs && find $1 -type f); do $(INSTALL_DATA) "docs/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
> +endef
> +
> +# Note that we deliberately do not install the "devel" manual: it is
> +# for QEMU developers, and not interesting to our users.
> +.PHONY: install-sphinxdocs
> +install-sphinxdocs: sphinxdocs
> +	$(call install-manual,interop)

Again, not related to your patch, but 'make install-sphinxdocs' clone
libfdt + capstone, requires C compiler to build libfdt.a and C++ to
build libcapstone.a. Once both build we can generate the doc.

> +
> +install-doc: $(DOCS) install-sphinxdocs
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
> @@ -837,6 +859,23 @@ docs/version.texi: $(SRC_PATH)/VERSION
>  %.pdf: %.texi docs/version.texi
>  	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
>  
> +# Sphinx builds all its documentation at once in one invocation
> +# and handles "don't rebuild things unless necessary" itself.
> +# The '.doctrees' files are cached information to speed this up.

Can you add .doctrees to .gitignore?

> +.PHONY: sphinxdocs
> +sphinxdocs: docs/devel/index.html docs/interop/index.html
> +
> +# Canned command to build a single manual
> +build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -d .doctrees/$1 $(SRC_PATH)/docs/$1 docs/$1 ,"SPHINX","docs/$1")
> +# We assume all RST files in the manual's directory are used in it
> +manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
> +
> +docs/devel/index.html: $(call manual-deps,devel)
> +	$(call build-manual,devel)
> +
> +docs/interop/index.html: $(call manual-deps,interop)
> +	$(call build-manual,interop)
> +
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
>  
> @@ -865,7 +904,7 @@ docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
>  
> -html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
> +html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
>  pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
>  txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.
