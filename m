Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD34C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF25A20878
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPJK9+XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGth-00039D-3P
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGsz-0002Qx-Q0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGsv-0006CO-QI
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600437426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5E2jZQ57Wk1/8/tFFFS81NFNtLxLlABYt1+5KRz7oh0=;
 b=MPJK9+XLnXXccvFIbqJWaXlEDYoV0jj3t8baPZ3BWM+mDVShLr5TYMZWNQtJ4fDqxHlvA1
 p4tHQhhmFojxh9iXPsleY1SGefQUiW2mKW5B4RWN8pZqxGKI79ncaGBRec8w6lnGE5EcS8
 pNLhCJstziM9onryCinCMI88WeCDmxk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-wqDRAtiFPdu4VDpM35S5XA-1; Fri, 18 Sep 2020 09:57:04 -0400
X-MC-Unique: wqDRAtiFPdu4VDpM35S5XA-1
Received: by mail-oi1-f198.google.com with SMTP id k7so2623628oif.22
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5E2jZQ57Wk1/8/tFFFS81NFNtLxLlABYt1+5KRz7oh0=;
 b=QseFQh5B3C2orRdhKbbchEmLB+rNpuzEKi7zKNNo12mJjXuEr0aLaWruChDX5vqpPf
 tx2SKaAJH41vVKB0NcEM0x1cnDh/SEX+f06viw8r2q54a/0wQsXlAxB8aGhBdxiTcAmL
 WRATxkj5NG4dTO+7JFUCrNJ5xNl2EQr42hodNR1w3hau6urZJFiWeZNtORK7Od0DW26j
 4xQqrjwvJ8ukvCdP8j60iNAcGBF89ZLUNeEShHt54tiypn02M9p+o3SLYMulYpn+LLR+
 umpUWCwDV46V24A/XX3HmuxUyC2ip70NmHyjyWk+DfGJqN57HstXTBmTt8VexGbp5ICd
 X5ug==
X-Gm-Message-State: AOAM530xvvKLeLkbonbv/qCU4P5UvUcD/v+uorx+obt5pLVC+MfAJYZ8
 X46dUaMlt9ryBFIjJ2afHsYwz6Gw29jT6jZJtBl/DcPhxLQaZVEVa730R+ZRHgQdGVbav2n8oyZ
 kdAQ0sKm2kqwtYfI+4HjhB2bB+kkJqow=
X-Received: by 2002:a05:6830:1d5:: with SMTP id
 r21mr24779304ota.244.1600437424022; 
 Fri, 18 Sep 2020 06:57:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7/kgZHxqVB7yKtSTLfIedrcwAw5tGGT6UHSaQRm7HUgFDXd7OZl73UFzzzFRZyiFOE70MEVj6ZbJth64MhwA=
X-Received: by 2002:a05:6830:1d5:: with SMTP id
 r21mr24779291ota.244.1600437423805; 
 Fri, 18 Sep 2020 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200914140641.21369-1-peter.maydell@linaro.org>
 <20200914140641.21369-33-peter.maydell@linaro.org>
 <CAP+75-XNAKE8n7MffAsSJFO1EVzAmTZsv4COyZoFWKEOELOO5A@mail.gmail.com>
In-Reply-To: <CAP+75-XNAKE8n7MffAsSJFO1EVzAmTZsv4COyZoFWKEOELOO5A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 18 Sep 2020 15:56:53 +0200
Message-ID: <CAP+75-VmpCCnqLi_uX+GPc=-SF07WXMRZ1BDrNpuEzVOJpvy_A@mail.gmail.com>
Subject: Re: [PULL 32/36] tests/acceptance: console boot tests for quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 3:52 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Havard,
>
> On Mon, Sep 14, 2020 at 5:47 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > From: Havard Skinnemoen <hskinnemoen@google.com>
> >
> > This adds two acceptance tests for the quanta-gsj machine.
> >
> > One test downloads a lightly patched openbmc flash image from github an=
d
> > verifies that it boots all the way to the login prompt.
> >
> > The other test downloads a kernel, initrd and dtb built from the same
> > openbmc source and verifies that the kernel detects all CPUs and boots
> > to the point where it can't find the root filesystem (because we have n=
o
> > flash image in this case).
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > Message-id: 20200911052101.2602693-15-hskinnemoen@google.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> [...]
> > +    def test_arm_quanta_gsj_initrd(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:quanta-gsj
> > +        """
> > +        initrd_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.=
xz')
> > +        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
> > +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinit=
rd_hash)
> > +        kernel_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/uImage-gsj.bin')
> > +        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
> > +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> > +        dtb_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
> > +        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
> > +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> > +
> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200n8 '
> > +                               'earlycon=3Duart8250,mmio32,0xf0001000'=
)
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-initrd', initrd_path,
> > +                         '-dtb', dtb_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU 0=
x0')
> > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket =
0')
> > +        self.wait_for_console_pattern(
> > +                'Give root password for system maintenance')
>
> This test is failing (timeout) on our CI:

Oops I meant to keep the other one: test_arm_quanta_gsj
(not test_arm_quanta_gsj_initrd).

> https://gitlab.com/philmd/qemu/-/jobs/745483978#L857


