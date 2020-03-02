Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01AB217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHIDcfo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01AB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k8u-0001Sj-T5
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k7x-0000ac-NO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k7w-0003Li-E8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:53 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k7w-0003LG-7P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:24:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id l5so12332356wrx.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6UitaXKEb66beNWcgX6MBuisxrYcJSy/apxbSN6yB/0=;
 b=bHIDcfo5dINcM3Ntpln4dpOHUou0TnD1/Gi/I5trRUrgT1RaNEvYzi1VvEViN1/flG
 SaYTXlIqPz/gqYyiDo6MALv9SeKJ8c9OilPWlL3ROsCjFqTYmZpxLGs7MhpQGaQYlvac
 DEHpvZVx/yfVTcto2oLt0OdshIW/wDNYIxp1goIs13NJQFG6AB7n5Zj8+viPe8yqx+/l
 df7gjxuXAoJIuFluCnQd5PHFHIPiFjSYOlK0R/W01pVxhoaUHXugpifmhUXpoPzG86vI
 wLNhf1+p2h4M/QJzEnmC/8MubSFgALXDOsKoHl3S03ZASHVTgLhx+xRbfhVRnMCMRtmY
 uWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6UitaXKEb66beNWcgX6MBuisxrYcJSy/apxbSN6yB/0=;
 b=hGLbGjXLsGdFS+eh6NbFbiKfxZ71tF99JnxUNm+vnRPJN6a7rBKXd/7SLV0IekxoMV
 U3IVJMzhQBPZADpXqqMXsrKzWUqYCXUv7uXKfaa1wce0yt02NzaOpmL2lF91TCrmJhYT
 qBneDDpqpqqvNidKUDTwm7WAWq1aEPUJZVeFJVJlHAPIeO9RZ2Z/nEgSOI/kjm+X7hB+
 olYt6l1Op2/qivaAimGmyb3xcxns+E4NI5MeoaSanI5BRo/u2CrL89ctgQkLPK8F5pd0
 TrTH//LlZnfZ9bDmUwLFIcqH2jrww6tSPXnEap+hC+UfNdfe+VtE/aHvmumbNFq7x+YF
 u/Ew==
X-Gm-Message-State: APjAAAXCkSDOYWgzfMoJuMP6YeGAtzkpsLV+PQ9aUDQKGIloYDJpsTpo
 q7gMMpTXldFZT27wDsN+I1OnDXZ3FHY=
X-Google-Smtp-Source: APXvYqyxX+7TqwoGw194VfH7VoZHB20gk0/hGpnz7hRDU9wCzmGmninUM3OTDKWHRb3Z83igDh6eCQ==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr21933468wrt.325.1583151890974; 
 Mon, 02 Mar 2020 04:24:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm6947096wmj.14.2020.03.02.04.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:24:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2DC6A1FF87;
 Mon,  2 Mar 2020 12:24:49 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-30-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 29/33] docs: Generate qemu.1 manpage with Sphinx
In-reply-to: <20200228153619.9906-30-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:24:49 +0000
Message-ID: <875zfn9c6m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Generate the qemu.1 manpage using Sphinx; we do this with a new
> top-level rst source file which is just the skeleton of the manpage
> and which includes .rst.inc fragments where it needs to incorporate
> sections from the larger HTML manuals.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile                     | 10 ++++----
>  docs/system/conf.py          |  2 ++
>  docs/system/qemu-manpage.rst | 45 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 6 deletions(-)
>  create mode 100644 docs/system/qemu-manpage.rst
>
> diff --git a/Makefile b/Makefile
> index f7d08997dbf..ef10b9a031d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -344,7 +344,8 @@ MANUAL_BUILDDIR :=3D docs
>  endif
>=20=20
>  ifdef BUILD_DOCS
> -DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
> +DOCS=3Dqemu-doc.html qemu-doc.txt
> +DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu.1
>  DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-img.1
>  DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> @@ -856,7 +857,7 @@ install-doc: $(DOCS) install-sphinxdocs
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
>  ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
> -	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/m=
an1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
> @@ -1082,7 +1083,7 @@ $(MANUAL_BUILDDIR)/user/index.html: $(call manual-d=
eps,user)
>=20=20
>  $(call define-manpage-rule,interop,qemu-ga.8)
>=20=20
> -$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)
> +$(call define-manpage-rule,system,qemu.1 qemu-block-drivers.7 qemu-cpu-m=
odels.7)
>=20=20
>  $(call define-manpage-rule,tools,\
>         qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> @@ -1109,9 +1110,6 @@ docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
>  docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
>  	@cp -p $< $@
>=20=20
> -qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
> -qemu.1: docs/system/qemu-option-trace.texi
> -
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html sphinxdocs
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info
>  pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref=
.pdf
> diff --git a/docs/system/conf.py b/docs/system/conf.py
> index 23cab3fb364..6251849fefc 100644
> --- a/docs/system/conf.py
> +++ b/docs/system/conf.py
> @@ -17,6 +17,8 @@ html_theme_options['description'] =3D u'System Emulatio=
n User''s Guide'
>  # One entry per manual page. List of tuples
>  # (source start file, name, description, authors, manual section).
>  man_pages =3D [
> +    ('qemu-manpage', 'qemu', u'QEMU User Documentation',
> +     ['Fabrice Bellard'], 1),
>      ('qemu-block-drivers', 'qemu-block-drivers',
>       u'QEMU block drivers reference',
>       ['Fabrice Bellard and the QEMU Project developers'], 7),
> diff --git a/docs/system/qemu-manpage.rst b/docs/system/qemu-manpage.rst
> new file mode 100644
> index 00000000000..e9a25d0680f
> --- /dev/null
> +++ b/docs/system/qemu-manpage.rst
> @@ -0,0 +1,45 @@
> +:orphan:
> +
> +..
> +   This file is the skeleton for the qemu.1 manpage. It mostly
> +   should simply include the .rst.inc files corresponding to the
> +   parts of the documentation that go in the manpage as well as the
> +   HTML manual.
> +
> +Title
> +=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +.. parsed-literal::
> +
> +   |qemu_system| [options] [disk_image]
> +
> +Description
> +-----------
> +
> +.. include:: target-i386-desc.rst.inc
> +
> +Options
> +-------
> +
> +disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
> +not need a disk image.
> +
> +.. hxtool-doc:: qemu-options.hx
> +
> +.. include:: keys.rst.inc
> +
> +.. include:: mux-chardev.rst.inc
> +
> +Notes
> +-----
> +
> +.. include:: device-url-syntax.rst.inc
> +
> +See also
> +--------
> +
> +The HTML documentation of QEMU for more precise information and Linux
> +user mode emulator invocation.


--=20
Alex Benn=C3=A9e

