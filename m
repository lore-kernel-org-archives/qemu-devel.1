Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2520C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63044248C6
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vdhh6TmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63044248C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmyWR-0001Mo-MY
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 07:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmyVW-0000q7-FS
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:51:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmyVT-0003ks-Oh
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592740286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2gZBdft/9c2VCRtkYO/sRgA3rZenmGkRb69KxwEwVYI=;
 b=Vdhh6TmLqMUb3qfzMvmF0rk+CIjl5GgDtExzH2b51T5/R/cKDaRma8KSsQA8C3Xw/sf0if
 f1RpyLrd5r34lrzNWEPuayt87QNxjrfpnZgMuokFMDVmJ5RHCoqMd6uqw9Yc5EObms67VY
 iOvERoaFbUfy3OFC2rCNDxls34z5c+s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-VYHk6JunMfGBHIZ2d2OOVQ-1; Sun, 21 Jun 2020 07:51:22 -0400
X-MC-Unique: VYHk6JunMfGBHIZ2d2OOVQ-1
Received: by mail-wr1-f69.google.com with SMTP id p10so8374436wrn.19
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 04:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2gZBdft/9c2VCRtkYO/sRgA3rZenmGkRb69KxwEwVYI=;
 b=MIE/VC5Z+OMfEB0oSi7cneOCSvLzdwtqHX7FGf/6HTcYYsQIaQlVl1+kJPcirI7Y2/
 78PEJFAzO3DfSVbS8t8P+SuhfPDtxiOxDVWZLCad60zOUCuD6fa8fC1VIxYmumdjQEZy
 DN93U1TTnXhrwZWnxNLibz5upZ6NczZxDrPncETqoP55wYjeLw8g0kyWQN7Bs2aKtrVx
 w6XufYGmlmeejC+eWR9p1URl+1+7s8wPOPVjwv/3m9UF4Bv8zIQ15QZf4+NG0OI6pNr5
 x6u37iZoXZrAZXyALzBx3a4RB8uKeNZfOaxuYczvf9mS1j2OqScFccTcQ1FuJv9NkXr1
 Q6VA==
X-Gm-Message-State: AOAM533AEn8OI9/gAXiM/CT/4g8HFyq5HQYIkRrhHqPt8xGLEIPnV59G
 fXmKeyVWhSsv7vuB1KyD5lLQQnsM57O32WNh3usbIGwObjx/aGrHoKTU/ZagBGiHaOud2Dl6NlB
 cExdNniYvamIsX6s=
X-Received: by 2002:a7b:c158:: with SMTP id z24mr13764206wmi.12.1592740280376; 
 Sun, 21 Jun 2020 04:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUWrCxodnwFFqlrnWbmUoPaCZLJPuRjO/1+BcTgeFMTqC9qVXhkNt8xZPtpMBAd9nRCRqqiw==
X-Received: by 2002:a7b:c158:: with SMTP id z24mr13764185wmi.12.1592740280148; 
 Sun, 21 Jun 2020 04:51:20 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y14sm12373236wma.25.2020.06.21.04.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 04:51:19 -0700 (PDT)
Subject: Re: [PATCH v3 09/11] tests/acceptance: record/replay tests with
 advcal images
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
 <159073592589.20809.5156301499042635614.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7e64598a-8496-8818-5e13-d487bb7183fb@redhat.com>
Date: Sun, 21 Jun 2020 13:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159073592589.20809.5156301499042635614.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 07:51:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, wrampazz@redhat.com, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On 5/29/20 9:05 AM, Pavel Dovgalyuk wrote:
> This patch adds more record/replay tests with kernel images.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>  - make download path fixed to allow pre-test downloading (suggested by Willian Rampazzo)
> ---
>  0 files changed
> 
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index c1ec002db6..bc21ddf082 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -186,3 +186,108 @@ class ReplayKernel(LinuxKernelTest):
>                                 'console=ttyS0 vga=off')
>          console_pattern = 'No filesystem could mount root'
>          self.run_rr(kernel_path, kernel_command_line, console_pattern)
> +
> +    def do_test_advcal_2018(self, file_path, kernel_name, args=None):
> +        archive.extract(file_path, self.workdir)
> +
> +        for entry in os.scandir(self.workdir):
> +            if entry.name.startswith('day') and entry.is_dir():
> +                kernel_path = entry.path + '/' + kernel_name
> +                break
> +
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
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day16.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'winter.zImage',
> +            ('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb'))
> +
> +    def test_m68k_mcf5208evb(self):
> +        """
> +        :avocado: tags=arch:m68k
> +        :avocado: tags=machine:mcf5208evb
> +        """
> +        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day07.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
> +
> +    def test_microblaze_s3adsp1800(self):
> +        """
> +        :avocado: tags=arch:microblaze
> +        :avocado: tags=machine:petalogix-s3adsp1800
> +        """
> +        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day17.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'ballerina.bin')
> +
> +    def test_ppc64_e500(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:ppce500
> +        """
> +        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day19.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'uImage', ('-cpu', 'e5500'))
> +
> +    def test_ppc_g3beige(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:g3beige
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day15.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'invaders.elf',
> +            ('-M', 'graphics=off'))
> +
> +    def test_ppc_mac99(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:mac99
> +        """
> +        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day15.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'invaders.elf',
> +            ('-M', 'graphics=off'))

Using QEMU built with -O3, I get:

 (4/4) tests/acceptance/replay_kernel.py:ReplayKernel.test_ppc_mac99:
replay: recording the execution...
replay: finished the recording with log size 21781169 bytes
replay: elapsed time 17.03 sec
replay: replaying the execution...
replay: successfully finished the replay
replay: elapsed time 57.04 sec
replay: replay overhead 234.93%
PASS (74.48 s)

Any idea why there is so much overhead here?

> +
> +    def test_sparc_ss20(self):
> +        """
> +        :avocado: tags=arch:sparc
> +        :avocado: tags=machine:SS-20
> +        """
> +        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day11.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'zImage.elf')
> +
> +    def test_xtensa_lx60(self):
> +        """
> +        :avocado: tags=arch:xtensa
> +        :avocado: tags=machine:lx60
> +        """
> +        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day02.tar.xz')
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf',
> +            ('-cpu', 'dc233c'))
> 


