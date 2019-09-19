Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF3C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31082196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beZXpirN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31082196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0SL-0005Y9-GQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB077-0008Ns-59
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzyR-0005vQ-21
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:12:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzyQ-0005v5-Qe
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:12:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so3878691wrm.12
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MpQDWEBIXqkZew5YlxBVPqsw/lcXmUMHEtRIUU8XYYY=;
 b=beZXpirNyzTQ73DLApDjxpQlsBA2PIS2ElLr4X1vkwol5MGmGITs4j3ePrCvsLGNCm
 dtbdsDkj5wvcoXXLkIqH5lFl/vcoCTQA3gtT7hs/drfR5CtwdfKDToHvjCRu2kjvjL4W
 pDe8JHqk/mH78KOre4nR4cTBWfBObWb6Al6T/8sVlP13++bxLlZQ4Oc9rZRwpUZHn96c
 CB158nRB5YvVRPyi+svIIQIq7gXqg3uLFW0lAeWGj0VJ50JEeoK3odf03m41U230pnSP
 8FqUJftUCj6UDaBi+/r3xoWcm3iv7azuySzFopPgA2rCsD7Sy+6Q9halOLh7f0dKhpVH
 AoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MpQDWEBIXqkZew5YlxBVPqsw/lcXmUMHEtRIUU8XYYY=;
 b=PkuBa9YLUZ/Tds75skbO2zk7JHUAGRiztQIa6jgoopsVpVkNPsSHCGWYw1qLXEkALz
 L1Tb257mhvOci3YQWWKO8tG2EJAwJVq+V6V4q5JYp64YvdbxYLupVQxC2HFXC3sDj9o0
 rU6+OsD5ptGV5HDHhCgoMsOhpoF75OVP0VJlFROewxeT3S9eipd+CqlDdZWI19dTQ4on
 Vd9IGl1g12Az3Q+ZajqTiry3MmVrLKuP2MPrpbl0lgZbv2q2oyAqNXB0knJ0UqIrFNKW
 rgK8h3gDB/NPmP35VnpjA9AbnratsO+QRDUzYz6teYKnTpiBsbqz1BhY25DAiTDRTeVk
 mQYA==
X-Gm-Message-State: APjAAAVdnqDSQPpf3qEAZTQPyvBtseHYx9YoHZBan6YpPkPcOkUwm5cW
 ES7hBKAgGJNSIPfFQdh3yEIzlFDltvc=
X-Google-Smtp-Source: APXvYqyrkUNASNBKyMAiqk1QH+3FpRVWNzllvOhTal/hoy29J1GdboiOgYbOJsiLH3oSTsZmvxbdFA==
X-Received: by 2002:a5d:618a:: with SMTP id j10mr7964838wru.168.1568913125779; 
 Thu, 19 Sep 2019 10:12:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r20sm13642120wrg.61.2019.09.19.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:12:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54D211FF92;
 Thu, 19 Sep 2019 18:12:04 +0100 (BST)
References: <20190919155957.12618-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Makefile: Fix in-tree builds when Sphinx is available
In-reply-to: <20190919155957.12618-1-peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 18:12:04 +0100
Message-ID: <87muf0yzvf.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> In commit 27a296fce9821e we switched the qemu-ga manpage over to
> being built from Sphinx.  The makefile rules for this were correct
> for an out-of-tree build, but break for in-tree builds if Sphinx is
> present and we're trying to build the documentation.
>
> Specifically, because Sphinx refuses to build output files into
> the same directory as its sources, for an in-tree build we tell
> it to build into a subdirectory docs/built, and set up a makefile
> variable MANUAL_BUILDDIR indicating where the docs are going.
> The makefile rule telling Make how to build qemu-ga.8 correctly
> used this variable, but the lines adding qemu-ga.8 to the list
> of DOCS to be built and the 'make install' rune did not. The
> effect was that for an in-tree build we told Make to build
> 'docs/interop/qemu-ga.8' but did not provide a specific rule for
> doing so, which caused Make to fall back to the old rules.make
> rule for building any "%.8" file. Make tried to invoke texi2pod
> with a bogus command line, resulting in the error:
>
>   GEN     docs/interop/qemu-ga.8
> No filename or title
> make: *** [rules.mak:394: docs/interop/qemu-ga.8]
>
> Fix this by using $(MANUAL_BUILDDIR) when constructing the
> list of DOCS files we want to build and also in the source
> file name we install for 'make install'.
>
> (Among other things, this broke the Shippable CI builds.)
>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

heh I'd manually rebuilt the patch from your last email. I guess you can
apply this one directly though and I'll clean-up when I rebase for the PR.

> ---
>  Makefile | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 111082ce545..a0c1430b407 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -324,8 +324,19 @@ endif
>  endif
>  endif
>
> +# Sphinx does not allow building manuals into the same directory as
> +# the source files, so if we're doing an in-tree QEMU build we must
> +# build the manuals into a subdirectory (and then install them from
> +# there for 'make install'). For an out-of-tree build we can just
> +# use the docs/ subdirectory in the build tree as normal.
> +ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> +MANUAL_BUILDDIR :=3D docs/built
> +else
> +MANUAL_BUILDDIR :=3D docs
> +endif
> +
>  ifdef BUILD_DOCS
> -DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/inte=
rop/qemu-ga.8
> +DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_=
BUILDDIR)/interop/qemu-ga.8
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
>  DOCS+=3Ddocs/qemu-block-drivers.7
> @@ -699,17 +710,6 @@ dist: qemu-$(VERSION).tar.bz2
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
>
> -# Sphinx does not allow building manuals into the same directory as
> -# the source files, so if we're doing an in-tree QEMU build we must
> -# build the manuals into a subdirectory (and then install them from
> -# there for 'make install'). For an out-of-tree build we can just
> -# use the docs/ subdirectory in the build tree as normal.
> -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> -MANUAL_BUILDDIR :=3D docs/built
> -else
> -MANUAL_BUILDDIR :=3D docs
> -endif
> -
>  define clean-manual =3D
>  rm -rf $(MANUAL_BUILDDIR)/$1/_static
>  rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchinde=
x.js $(MANUAL_BUILDDIR)/$1/*.html
> @@ -819,7 +819,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>  	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
>  endif
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -	$(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandi=
r)/man8"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"


--
Alex Benn=C3=A9e

