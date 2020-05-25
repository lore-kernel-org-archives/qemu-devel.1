Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67DDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D052071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbjqtzlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D052071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdCvS-0001ki-J2
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdCuo-0001EC-NR
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:13:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdCun-0003Fj-Nb
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590412392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6Asb8qh3vzfVJ8VsVryFQmM6PWVGQrwTaZUO4GFR6AE=;
 b=NbjqtzlfLP8EvmfSC9ACKyudsA+w8ip/lIE6dTlFRs121C2/PONlSilp/B1BFHqtuqs+i8
 ug5Oy553VR8OoXH1GjTeTkSfRmoPQ1AO46XmB+B1DlDySCT2t7wd/vVtvUbl3bOWc92cB5
 39Z02DlQUjhLb7XZlHBXQydoUdf07ck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-vPuK2qnfMUiKKDNWIeIVEg-1; Mon, 25 May 2020 09:13:06 -0400
X-MC-Unique: vPuK2qnfMUiKKDNWIeIVEg-1
Received: by mail-wr1-f72.google.com with SMTP id e1so5736998wrm.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 06:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6Asb8qh3vzfVJ8VsVryFQmM6PWVGQrwTaZUO4GFR6AE=;
 b=lToN7JyRGrA0RO0feEM/v8XCEa9nJgfN2xlCpVw58dwL+q9FKFWzEIwIOa1cZhrnzZ
 /NnCE3kpBVrT/Lir0YDBaLzcIpSOSkSd1ZjYiXYhMuC2pzxAa6477+F4POdUvxOQ/acu
 kx5j3M+wVqRpxFjl7iPFVYCS79j769E61loZ5JPBjgjzNQzWZm0Y527NNO+J5BBONF83
 08D1I2v+Netsj/64OuAY1MYvyZjZF9P/HZjyzkhGDrLLeEIc8ybCmkL9gvHi1PdU7dDG
 WYvNxGquHO3w+cYsyX/1RQY279m24Ph0YaN7XJIYhABAuW5ZE3pvyQc02LpJpc6cuy3v
 OuNQ==
X-Gm-Message-State: AOAM530xP1wT1VhavxG6+kx6MP90gLBDXSAEU2iIC3RsPNs7e54Y/WFo
 yR1S601awkj3xvaYqOOQokgDfJTQlJBfvd2yWJoxXV4nvnqz88qhH+b6oM5enxhMzFoubT6fd6L
 gnHr41u3CSlnapWw=
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr1325237wrs.292.1590412384901; 
 Mon, 25 May 2020 06:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI7vOnvETFOQUWIwKysZsjDCTvYAX/lpkpwK36+RS6v7US2m/RUwYdkwH53xGjyYFUcUXUPQ==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr1325214wrs.292.1590412384641; 
 Mon, 25 May 2020 06:13:04 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g82sm1710886wmf.1.2020.05.25.06.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 06:13:04 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Add a boot test for the
 xlnx-versal-virt machine
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200525072630.22280-1-thuth@redhat.com>
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
Message-ID: <53caef52-ad35-d44b-02a2-e0acd441b9a4@redhat.com>
Date: Mon, 25 May 2020 15:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525072630.22280-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 9:26 AM, Thomas Huth wrote:
> As described by Edgar here:
> 
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html
> 
> we can use the Ubuntu kernel for testing the xlnx-versal-virt machine.
> So let's add a boot test for this now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 0653c8c1bf..430a6c3b43 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -307,6 +307,30 @@ class BootLinuxConsole(Test):
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
>  
> +    def test_aarch64_xlnx_versal_virt(self):
> +        """
> +        :avocado: tags=arch:aarch64
> +        :avocado: tags=machine:xlnx-versal-virt

Thanks for adding this test!

Please also add:

           :avocado: tags=device:pl011
           :avocado: tags=device:arm_gicv3

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        """
> +        kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'netboot/ubuntu-installer/arm64/linux')
> +        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> +                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'netboot/ubuntu-installer/arm64/initrd.gz')
> +        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-m', '2G',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Checked W+X mappings: passed')
> +
>      def test_arm_virt(self):
>          """
>          :avocado: tags=arch:arm
> 


