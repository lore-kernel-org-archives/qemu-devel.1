Received: from eggs.gnu.org ([209.51.188.92]:47285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcKa-0000vg-Dv
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpc9p-0002BR-Mt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:59:16 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpc9p-0002BG-Fe
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:59:13 -0500
Received: by mail-wm1-x341.google.com with SMTP id y8so6899190wmi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:59:13 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-11-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-11-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:59:11 +0000
Message-ID: <87d0obv40w.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] Makefile: Abstract out "identify the
 pkgversion" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Abstract out the "identify the pkgversion" code from the
> rule for creating qemu-version.h, so it sets makefile
> variables for QEMU_PKGVERSION and QEMU_FULL_VERSION.
> (We will want to use these when building the Sphinx docs.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d519fadee39..2d19d28a271 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -87,6 +87,20 @@ endif
>
>  include $(SRC_PATH)/rules.mak
>
> +# Create QEMU_PKGVERSION and FULL_VERSION strings
> +# If PKGVERSION is set, use that; otherwise get version and -dirty statu=
s from git
> +QEMU_PKGVERSION :=3D $(if $(PKGVERSION),$(PKGVERSION),$(shell \
> +  cd $(SRC_PATH); \
> +  if test -d .git; then \
> +    git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
> +    if ! git diff-index --quiet HEAD &>/dev/null; then \
> +      echo "-dirty"; \
> +    fi; \
> +  fi))
> +
> +# Either "version (pkgversion)", or just "version" if pkgversion not set
> +FULL_VERSION :=3D $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)=
),$(VERSION))
> +
>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
>
>  #see Makefile.objs for the definition of QAPI_MODULES
> @@ -391,23 +405,8 @@ all: $(DOCS) sphinxdocs $(TOOLS) $(HELPERS-y) recurs=
e-all modules
>
>  qemu-version.h: FORCE
>  	$(call quiet-command, \
> -		(cd $(SRC_PATH); \
> -		if test -n "$(PKGVERSION)"; then \
> -			pkgvers=3D"$(PKGVERSION)"; \
> -		else \
> -			if test -d .git; then \
> -				pkgvers=3D$$(git describe --match 'v*' 2>/dev/null | tr -d '\n');\
> -				if ! git diff-index --quiet HEAD &>/dev/null; then \
> -					pkgvers=3D"$${pkgvers}-dirty"; \
> -				fi; \
> -			fi; \
> -		fi; \
> -		printf "#define QEMU_PKGVERSION \"$${pkgvers}\"\n"; \
> -		if test -n "$${pkgvers}"; then \
> -			printf '#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION "=
)"\n'; \
> -		else \
> -			printf '#define QEMU_FULL_VERSION QEMU_VERSION\n'; \
> -		fi; \
> +                (printf '#define QEMU_PKGVERSION "$(QEMU_PKGVERSION)"\n'=
; \
> +		printf '#define QEMU_FULL_VERSION "$(FULL_VERSION)"\n'; \
>  		) > $@.tmp)
>  	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
>  	  mv $@.tmp $@; \


--
Alex Benn=C3=A9e
