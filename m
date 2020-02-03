Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54153C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239E620838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9JF5z8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239E620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygAG-0001oO-32
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyg9J-0000nl-Sy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyg9I-0002JJ-CI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:08:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyg9I-0002BF-4B
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:08:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id c84so332916wme.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HN/AMUYpPDTg5XPVDPdZLw6+47h5YeQOo+AaPv3O9qI=;
 b=M9JF5z8/HFPVAZiVT2UOZq+c7ZSkNFybjS5mae6gPhULpaBjyysu9WPkZp1MQWDChY
 Qo/3GgsfJy6EE2dHj/3rHb1KHHxkfYQci0DSH/zV2MtnS3Wvvi7k+4k3v4QTeXXW7Oer
 JBr9oM9c8VpJeHmNKGN/3E12j8Qtc4FXTbmK1su5wqctpAB6gcXeheVH9Ax1wMsYjCeA
 QXyCGAx0yzpx3eaiZnaa1+0ScGnwD1w92AFPmGXU5RG+T9iY3cE71sF1Yo3KiR8Oy4Le
 iJ6sTkqb7Cf7sbexrCSEjFFY/CTtI+lUo71bUE1JdYKxS6+JjcjbcO8ZxdmnPs8mpFnT
 8t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HN/AMUYpPDTg5XPVDPdZLw6+47h5YeQOo+AaPv3O9qI=;
 b=f3xmxtrZv4TWuY32TLoFu/6Q1Yeb+bcH/BflFZqDVW4+nnPjxEG284i9Np84FXHVhK
 41Dyp/LBRCNEIyNGUjjDCtgpr4FP1Jdo+L5UTBkfyB621V1Ra5qwd/jwAfLrA/kw5xWr
 4sUzfOsMkJHAeFn0pzFM1450xN3RXTs7VSubN/v6AeQDVdvrEUCLKGfS5/DelZdKysKU
 MUzWAm/EekixtEgcYuXMuiPy6uUuBM4kDKFvE5llozbepE28GiSvcnAcZ8CsGJLHyQkp
 AsbcaUcaacpAFNQAjYTbSeD4SJOe5KARfBomqS89wLYgBJeJm3uQ8K9C6KR6QGpIGQw+
 z78g==
X-Gm-Message-State: APjAAAWpjEFYtt5PHgp3UDYD5TSwvnzBexiLQ0AlGzHIu43Y6zMGlaJO
 qAvxd8oUlf/9MFN3re6bdoTbiA==
X-Google-Smtp-Source: APXvYqwt8oIY2YrVXQnux3jqXbQmPHlx4w1FFIhOQHQ4ocULxoyUa818CbablR3n3ghREaGGq/K02w==
X-Received: by 2002:a1c:a514:: with SMTP id o20mr231429wme.179.1580753317756; 
 Mon, 03 Feb 2020 10:08:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm26458394wru.50.2020.02.03.10.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 10:08:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9CDD1FF87;
 Mon,  3 Feb 2020 18:08:35 +0000 (GMT)
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] configure: Allow user to specify sphinx-build binary
In-reply-to: <20200203132533.21850-2-peter.maydell@linaro.org>
Date: Mon, 03 Feb 2020 18:08:35 +0000
Message-ID: <875zgna6ho.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Currently we insist on using 'sphinx-build' from the $PATH;
> allow the user to specify the binary to use. This will be
> more useful as we become pickier about the capabilities
> we require (eg needing a Python 3 sphinx-build).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> I went with the most common convention for specifying "here's
> an executable", like --make=3D, --install=3D, --python=3D....
>
> The only odd one out for our current configure options seems to be
> that we want --with-git=3DGIT, not --git=3DGIT. You could argue that
> that's a better convention, but it makes more sense to me to
> stick with the convention we currently mostly have. (Perhaps
> we should even change --with-git=3D to --git=3D ?)
>
>  configure | 10 +++++++++-
>  Makefile  |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 5095f017283..830f325822a 100755
> --- a/configure
> +++ b/configure
> @@ -584,6 +584,7 @@ query_pkg_config() {
>  }
>  pkg_config=3Dquery_pkg_config
>  sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> +sphinx_build=3Dsphinx-build
>=20=20
>  # If the user hasn't specified ARFLAGS, default to 'rv', just as make do=
es.
>  ARFLAGS=3D"${ARFLAGS-rv}"
> @@ -975,6 +976,8 @@ for opt do
>    ;;
>    --python=3D*) python=3D"$optarg"
>    ;;
> +  --sphinx-build=3D*) sphinx_build=3D"$optarg"
> +  ;;
>    --gcov=3D*) gcov_tool=3D"$optarg"
>    ;;
>    --smbd=3D*) smbd=3D"$optarg"
> @@ -1677,6 +1680,7 @@ Advanced options (experts only):
>    --make=3DMAKE              use specified make [$make]
>    --install=3DINSTALL        use specified install [$install]
>    --python=3DPYTHON          use specified python [$python]
> +  --sphinx-build=3DSPHINX    use specified sphinx-build [$sphinx_build]
>    --smbd=3DSMBD              use specified smbd [$smbd]
>    --with-git=3DGIT           use specified git [$git]
>    --static                 enable static build [$static]
> @@ -4799,7 +4803,7 @@ has_sphinx_build() {
>      # sphinx-build doesn't exist at all or if it is too old.
>      mkdir -p "$TMPDIR1/sphinx"
>      touch "$TMPDIR1/sphinx/index.rst"
> -    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPD=
IR1/sphinx/out" >/dev/null 2>&1
> +    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMP=
DIR1/sphinx/out" >/dev/null 2>&1
>  }
>=20=20
>  # Check if tools are available to build documentation.
> @@ -6474,6 +6478,9 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
>  echo "make              $make"
>  echo "install           $install"
>  echo "python            $python ($python_version)"
> +if test "$docs" !=3D "no"; then
> +    echo "sphinx-build      $sphinx_build"
> +fi
>  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>  if test "$slirp" !=3D "no" ; then
>      echo "smbd              $smbd"
> @@ -7503,6 +7510,7 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $confi=
g_host_mak
>  echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
>  echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
>  echo "PYTHON=3D$python" >> $config_host_mak
> +echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
>  echo "CC=3D$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
>    echo "IASL=3D$iasl" >> $config_host_mak
> diff --git a/Makefile b/Makefile
> index a6f5d440828..1f37523b528 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1024,7 +1024,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>  # Note the use of different doctree for each (manual, builder) tuple;
>  # this works around Sphinx not handling parallel invocation on
>  # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
> -build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphinx=
-build $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(FULL=
_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"S=
PHINX","$(MANUAL_BUILDDIR)/$1")
> +build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" $(SPHI=
NX_BUILD) $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(F=
ULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 =
,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
>                $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \


--=20
Alex Benn=C3=A9e

