Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F08C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7B32078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXJDwQcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7B32078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJcq-00083Q-5M
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJJBU-0000hf-0M
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:24:28 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:34689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJJBQ-00068k-ME
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:24:27 -0400
Received: by mail-vs1-xe41.google.com with SMTP id y190so3943157vsy.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sM/DvbAmUefzPfv9k6dUc54IMv/ZOAiE5sKS7mi8c/Q=;
 b=jXJDwQcfQDa7yQ2b2J8VWXTOJ1ZoyVUVHZ0/EcT4dwdIs6+11pebKJxLYbQGxJAYsx
 W6qTSQL+KTBTCmc2Gq0AAVN6YN/9IurgKV1WWCtukCrU/56bLgOwEqRJslkzysmWg3n7
 8xYx+bUhw+UkJRt6jvC87m8yKnGDf/URZHFjd9XAQHjosKDRNFw+GKSWG7soZebNCMdI
 r04GgnFIOwOHzMevmoVjc2L4cXxe+9ssshaBikGAZkucBxUgdZXlVGqe+JGKO3DQ4vJC
 J1KIzqkhHChb7YkrYHkhLTkzeVUUUcZCxsY9U5UPPCaw6UsqQWo/sfX4BM1kFVg0BGJ2
 QjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sM/DvbAmUefzPfv9k6dUc54IMv/ZOAiE5sKS7mi8c/Q=;
 b=W7RezSZJ4EzcC6VvaC7i5H+2gwJ2duANZMZAcpaoYt1Tpz9dOUzJq1IDpIvlg4XV5K
 ivlUkXahcy1r94Fo2ThMsFQO2eN/X6g6Lu+L2tc/V/DXrB8aN8b3G39GRJF6sDPHWONK
 Y6TRj+P6+1WYQ8V/zp7XYjsg8+6J09UwWQ6reGJo+UjwTX8VxomrHOsZkpLJ1cRzM2bx
 tUok+t70EgzRzm/nVgKdBjhNSzvOUJINeLbvTfxJn7sq/YjkrpthMrEtmwEsJp3dBzH+
 BizcVvAc2mYDYF2f1bCCseILHC0kOaGNahDCeRne4kgCCF56d/I3/aS+85RYsSKmhKeD
 lzjw==
X-Gm-Message-State: AOAM530jETQ7DOC8XulFUpjZbyB4b+CPGEE0Gt42L30pDGDHME/jVgi/
 9Bgzdc9NjHukFRRro14GCCa878Bnlzr1shJ7vg/nzw==
X-Google-Smtp-Source: ABdhPJyW42Z/EtCvWvAqOcKXStP+QhmnNb44gPLa64hvQVUbjwuWzr483zUP62onWEWW/4ucHNtga6YhwwZecHyRR9g=
X-Received: by 2002:a05:6102:379:: with SMTP id
 f25mr12705732vsa.47.1600446262954; 
 Fri, 18 Sep 2020 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200914140641.21369-1-peter.maydell@linaro.org>
 <20200914140641.21369-33-peter.maydell@linaro.org>
 <CAP+75-XNAKE8n7MffAsSJFO1EVzAmTZsv4COyZoFWKEOELOO5A@mail.gmail.com>
 <CAP+75-VmpCCnqLi_uX+GPc=-SF07WXMRZ1BDrNpuEzVOJpvy_A@mail.gmail.com>
In-Reply-To: <CAP+75-VmpCCnqLi_uX+GPc=-SF07WXMRZ1BDrNpuEzVOJpvy_A@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 18 Sep 2020 09:24:11 -0700
Message-ID: <CAFQmdRZLRDxtQBMj2fQwjwNP3Pp1DZ==Pb+jcfz4E7ivJ7eYGQ@mail.gmail.com>
Subject: Re: [PULL 32/36] tests/acceptance: console boot tests for quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Cleber Rosa Junior <crosa@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 6:57 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On Fri, Sep 18, 2020 at 3:52 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Havard,
> >
> > On Mon, Sep 14, 2020 at 5:47 PM Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > >
> > > From: Havard Skinnemoen <hskinnemoen@google.com>
> > >
> > > This adds two acceptance tests for the quanta-gsj machine.
> > >
> > > One test downloads a lightly patched openbmc flash image from github =
and
> > > verifies that it boots all the way to the login prompt.
> > >
> > > The other test downloads a kernel, initrd and dtb built from the same
> > > openbmc source and verifies that the kernel detects all CPUs and boot=
s
> > > to the point where it can't find the root filesystem (because we have=
 no
> > > flash image in this case).
> > >
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > > Message-id: 20200911052101.2602693-15-hskinnemoen@google.com
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > [...]
> > > +    def test_arm_quanta_gsj_initrd(self):
> > > +        """
> > > +        :avocado: tags=3Darch:arm
> > > +        :avocado: tags=3Dmachine:quanta-gsj
> > > +        """
> > > +        initrd_url =3D (
> > > +                'https://github.com/hskinnemoen/openbmc/releases/dow=
nload/'
> > > +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpi=
o.xz')
> > > +        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
> > > +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Din=
itrd_hash)
> > > +        kernel_url =3D (
> > > +                'https://github.com/hskinnemoen/openbmc/releases/dow=
nload/'
> > > +                '20200711-gsj-qemu-0/uImage-gsj.bin')
> > > +        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
> > > +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > > +        dtb_url =3D (
> > > +                'https://github.com/hskinnemoen/openbmc/releases/dow=
nload/'
> > > +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
> > > +        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
> > > +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash=
)
> > > +
> > > +        self.vm.set_console()
> > > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > > +                               'console=3DttyS0,115200n8 '
> > > +                               'earlycon=3Duart8250,mmio32,0xf000100=
0')
> > > +        self.vm.add_args('-kernel', kernel_path,
> > > +                         '-initrd', initrd_path,
> > > +                         '-dtb', dtb_path,
> > > +                         '-append', kernel_command_line)
> > > +        self.vm.launch()
> > > +
> > > +        self.wait_for_console_pattern('Booting Linux on physical CPU=
 0x0')
> > > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socke=
t 0')
> > > +        self.wait_for_console_pattern(
> > > +                'Give root password for system maintenance')
> >
> > This test is failing (timeout) on our CI:
>
> Oops I meant to keep the other one: test_arm_quanta_gsj
> (not test_arm_quanta_gsj_initrd).
>
> > https://gitlab.com/philmd/qemu/-/jobs/745483978#L857

Sorry about that. It only takes 60-ish seconds on my (admittedly beefy) mac=
hine.

Havard

