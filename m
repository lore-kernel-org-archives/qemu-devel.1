Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD6B22453
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnYGb4Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD6B22453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMR8-0003u1-7w
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvMQB-0002zW-0Y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:00:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvMQ7-0005t9-J9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:00:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id t18so13241321otq.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r5oiMP4tCWVkF0mn3zMNFuadBPyU+S4nEE9KnOVOcTI=;
 b=LnYGb4HqvSr1i208KTdSKi6M1f3PBIfu5IpiLpu+VhkqAPd5TZ7jQ7P8CJgIbSB5zc
 OGU3EDXgF6jyrUTSMl9VN+rPvxFEi9pBzo90FBo8AjjKJUJ/gT/SQLoCgaz4sOcxuDjD
 jsWuP8Fd3qRXIeGPlllMzF9v36425yPiB+BfQic3RI82bYpVqdfMhqV66Qq5bgwcYtrB
 vRuQVsRqIDWBLmdFxOaLrT7kHBVlA4XUP51eAjMY5ooYhLDGrigjyqhK8MWisu9k3w64
 iyNAu610LsMHxucU0eWlJD8b6/QlWvjI1WYlMoNupzKXL9jWngnqRuUbQWb9RDSsKN1b
 Mt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r5oiMP4tCWVkF0mn3zMNFuadBPyU+S4nEE9KnOVOcTI=;
 b=c0Uu/RJC60yc2Qdf80pP2IXhn5ml4Svedr0VLnFI8tHTn7xrp2UO7FJQMVDvIn56wJ
 C27Bs57B4yBwD5e4OTldwb727yN/YJ6DFASMC0O8OFH7D/8T//OoX5X+f7bpN6ustJZF
 gYhm4vxXH00QeZ91fpYhymJXIsxFyjcbif/9UW/GkcGsv9LpbCjyNYJ4Z3EIqNxFbNKY
 uPs+taKmZg0tu8i2gWZY0NTfW8vB+YqsBMPx2TqAI0suk++3Vmsy9rT4qpSpSS/pv1dU
 lF/WLlM/FM11jsBcnWK3Cou6JBUUyou8MV+hgMzfRwdBJvL2m36UsEd5sW6UsgP8Tk0y
 RESA==
X-Gm-Message-State: AOAM530YVvb6OqDBZ3jNGU9JP1GVgi9XfnZr9onLf3n+CGGS0+Kwu8wj
 ZyYGxB1PcBNWF39x7juFuZ2xXM1vKw+3KR8CUqrcy8is
X-Google-Smtp-Source: ABdhPJw7xPJ3guVc1lP+X354Njli8ve2d/JU29HBg9tZIkjpZAR2oC25fDuL4l9FIRMA6L7ytuV99l9uT18ZrZkkXpI=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr4230778otk.221.1594738833592; 
 Tue, 14 Jul 2020 08:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-5-peter.maydell@linaro.org> <871rleywhn.fsf@linaro.org>
In-Reply-To: <871rleywhn.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 16:00:22 +0100
Message-ID: <CAFEAcA-qkx_AVrYAsc0K=DYBnX8VGBftihuXDbJN-3qsc6OzEQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 4/4] docs/system: Document the arm virt board
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 15:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Document the arm 'virt' board, which has been undocumented
> > for far too long given that it is the main recommended board
> > type for arm guests.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/system/arm/virt.rst   | 157 +++++++++++++++++++++++++++++++++++++
> >  docs/system/target-arm.rst |   1 +
> >  MAINTAINERS                |   1 +
> >  3 files changed, 159 insertions(+)
> >  create mode 100644 docs/system/arm/virt.rst
> >
> > diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> > new file mode 100644
> > index 00000000000..6a7823d8bca
> > --- /dev/null
> > +++ b/docs/system/arm/virt.rst
> > @@ -0,0 +1,157 @@
> > +'virt' generic virtual platform (``virt``)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The `virt` board is a platform which does not correspond to any
> > +real hardware; it is designed for use in virtual machines.
> > +It is the recommended board type if you simply want to run
> > +a guest such as Linux and do not care about reproducing the
> > +idiosyncrasies and limitations of a particular bit of real-world
> > +hardware.
> > +
> > +This is a "versioned" board model, so as well as the ``virt`` machine
> > +type itself (which may have improvements, bugfixes and other minor
> > +changes between QEMU versions) a version is provided that guarantees
> > +to have the same behaviour as that of previous QEMU releases, so
> > +that VM migration will work between QEMU versions. For instance the
> > +``virt-5.0`` machine type will behave like the ``virt`` machine from
> > +the QEMU 5.0 release, and migration should work between ``virt-5.0``
> > +of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
> > +is not guaranteed to work between different QEMU releases for
> > +the non-versioned ``virt`` machine type.
> > +
> > +Supported devices
> > +"""""""""""""""""
> > +
> > +The virt board supports:
> > +
> > +- Flash memory
> > +- One PL011 UART
> > +- An RTC
> > +- The fw_cfg device that allows a guest to obtain data from QEMU
> > +- A PL061 GPIO controller
> > +- An optional SMMUv3 IOMMU
> > +- hotpluggable DIMMs
> > +- hotpluggable NVDIMs
> > +- 32 virtio-mmio transport devices
>
> We seem to miss out we also support the virtio-pci transports here.

That's just a special case of "PCI", which I did indeed somehow forget.

 + PCI devices

thanks
-- PMM

