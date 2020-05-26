Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E055220776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgPWnYoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E055220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdfAz-0001hY-3q
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 15:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdfA6-0001I9-W6
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:22:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdfA5-0004fp-06
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590520971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0lDOZvNin70BZwlpd7fYYs5+G2w2klt8pUoQBw3YU8A=;
 b=KgPWnYoAHFHpPLp+qXiVYZHWoP14VRs3Of5CuyQ7LdXnQ1CSp2eW6prruHLmvDGGjwR7FP
 a9BpN5aO61VSXFUVcgksLOGXRLYaC4mMMTn62QHdD93dluinMAZGmc9+Y8JZzs0+3UDaYs
 +g+TwDX2RbRLYL5NVQKBVvHRCuIkBFE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Ik8LQHeNMp2M2V-P1qtNCg-1; Tue, 26 May 2020 15:22:46 -0400
X-MC-Unique: Ik8LQHeNMp2M2V-P1qtNCg-1
Received: by mail-ua1-f72.google.com with SMTP id v10so8260115uae.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 12:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0lDOZvNin70BZwlpd7fYYs5+G2w2klt8pUoQBw3YU8A=;
 b=tmKQ5sUNby98ZY5W3oRsgybDi12oEcLBt5BCjYj5Y4rcYvo9fn+to6Jq3VsfKKanxH
 Y46hugL/CCEuOZ9zL88PXIVUJoRVp4SinPm/hH3BPEnkcCZ9Z+1xXaXMWcbQoHppwkk0
 SAgENvdHW+fjaMCrBvqWkfi/giAWAn4/BLgs4TyxrMXNxncHSOBZkvn4Kz5Nwk/+35FC
 Kb8tbj4apmiSm7ls6Gw4pfCX1vSgB71r+X1tiSm7E8ILaiNYkb0/obvUy2md2206MFcX
 fXg0x0ISb4ThdEMSr8h3vxQaAXqaENygiT/a7Gwp1SyxGmHZ8fU55jzSr3fz3ObfDQJ6
 ZF3g==
X-Gm-Message-State: AOAM530ecUTthGWkWjTMYQNYI7ESZYBywDv6iVw7NFcoWZJtFbmi7CmE
 I3OIqd814UaGS9fHxmNctV2d1R184Aohjq2pSdO1YCfVyezFx93uSo70bCfz6Lugw/pJuA5Kb0G
 ePNcPHSFLrEM5YD37Ivn/I8f4BmCRruE=
X-Received: by 2002:a67:d984:: with SMTP id u4mr2363674vsj.33.1590520965422;
 Tue, 26 May 2020 12:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG25xKXx/tL4w2e/N6AJ5Kew/8txoJLSjakiPrtp9wjHnnoIQs+5f2L7l8lNgNG9LXHART6GgSC8U8azR+jho=
X-Received: by 2002:a67:d984:: with SMTP id u4mr2363659vsj.33.1590520965159;
 Tue, 26 May 2020 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
 <159040558755.2615.4869959098521372877.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040558755.2615.4869959098521372877.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 26 May 2020 16:22:34 -0300
Message-ID: <CAKJDGDZSJTFAVnBFJetA+kQrr9_0fK+1oPzK8isoJ6chaj9fjQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] tests/acceptance: record/replay tests with advcal
 images
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, Cleber Rosa Junior <crosa@redhat.com>,
 pbonzini@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 8:28 AM Pavel Dovgalyuk
<Pavel.Dovgaluk@gmail.com> wrote:
>
> This patch adds more record/replay tests with kernel images.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  tests/acceptance/replay_kernel.py |   80 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 4c786b1565..3849db7f3a 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -191,3 +191,83 @@ class ReplayKernel(Test):
>                                 'console=ttyS0 vga=off')
>          console_pattern = 'No filesystem could mount root'
>          self.run_rr(kernel_path, kernel_command_line, console_pattern)
> +
> +    def do_test_advcal_2018(self, day, tar_hash, kernel_name, args=()):
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day' + day + '.tar.xz')

Making the file name flexible helps in the code organization. Still,
in this specific case, due to limitations in the Avocado Asset parser,
this construction is ignored in an `avocado assets fetch <file>`
command. It results in the file being downloaded during the test run
and the time spent to download the files being accounted for in the
test time, and if the files are not saved in the Travis cache after
this test runs, it also means the files will be downloaded again every
time it runs.

The straight forward solution to that is having the complete URL
described and fetched for each test.

> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        archive.extract(file_path, self.workdir)
> +
> +        kernel_path = self.workdir + '/day' + day + '/' + kernel_name
> +        kernel_command_line = ''
> +        console_pattern = 'QEMU advent calendar'
> +        self.run_rr(kernel_path, kernel_command_line, console_pattern,
> +            args=args)
> +
> +    def test_arm_vexpressa9(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:vexpress-a9
> +        """
> +        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
> +        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage',
> +            ('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb'))
> +
> +    def test_m68k_mcf5208evb(self):
> +        """
> +        :avocado: tags=arch:m68k
> +        :avocado: tags=machine:mcf5208evb
> +        """
> +        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
> +        self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
> +
> +    def test_microblaze_s3adsp1800(self):
> +        """
> +        :avocado: tags=arch:microblaze
> +        :avocado: tags=machine:petalogix-s3adsp1800
> +        """
> +        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
> +        self.do_test_advcal_2018('17', tar_hash, 'ballerina.bin')
> +
> +    def test_ppc64_e500(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:ppce500
> +        """
> +        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
> +        self.do_test_advcal_2018('19', tar_hash, 'uImage', ('-cpu', 'e5500'))
> +
> +    def test_ppc_g3beige(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:g3beige
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf',
> +            ('-M', 'graphics=off'))
> +
> +    def test_ppc_mac99(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:mac99
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf',
> +            ('-M', 'graphics=off'))
> +
> +    def test_sparc_ss20(self):
> +        """
> +        :avocado: tags=arch:sparc
> +        :avocado: tags=machine:SS-20
> +        """
> +        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
> +        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
> +
> +    def test_xtensa_lx60(self):
> +        """
> +        :avocado: tags=arch:xtensa
> +        :avocado: tags=machine:lx60
> +        """
> +        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
> +        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf',
> +            ('-cpu', 'dc233c'))
>
>


