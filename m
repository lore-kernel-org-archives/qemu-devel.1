Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EC92068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCTHIwuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EC92068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvDg-0006Ii-ND
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juvCc-0005HO-Vp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50271
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juvCb-0002Oo-Ba
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594634208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ljm+0x5srJWIXcXLPJR0jRV+b/UfkA7G8EHNJf9VSI=;
 b=bCTHIwuqHYVmqFbrBRQ/rJiEQ76/FboCEGOm3SFFyI/SD3D5fLYmvzOd8eO/Le+8iOjX7D
 htCEmsztKYfiW1p9VG3ShdfVF2ulCEG0qhEW6qZTW81WPEmmuFwTOriokv4Nhges/zTFIz
 o5zSPhnRecbDOHfE255xlUjJEL+2W9c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-NRIhaypMMmKzr2zdX4NTKw-1; Mon, 13 Jul 2020 05:56:46 -0400
X-MC-Unique: NRIhaypMMmKzr2zdX4NTKw-1
Received: by mail-wm1-f69.google.com with SMTP id v11so18075349wmb.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4ljm+0x5srJWIXcXLPJR0jRV+b/UfkA7G8EHNJf9VSI=;
 b=sTgH/wTKFwFGkqEF3uwghyGkZEL1q+OzZwaoYcvIdqu1DtUj+yAlO+8Vvx68TVL0ef
 ocW1+A/x6Pgs0/oNSrQ0KnPwqsGOETcxN8B9b0BDg/lKovZ3DLipR/SFU+uq+erhufC0
 D/gp5GNcmDMv+yJSZuhA4MqNcOg5b8kDWYgolARojslVJoer6FwDDsTb4q60rVZN3gKZ
 wuAqP6vB8GdLBoHCaAVFdRrUtzZuEyJXeTXxYUahpQ8yLaiIAQkda18GL0zrNCbQxOlf
 rjoGwH3vUzPXcgRP7ZoZ85qZXabbCLzlRddefDhQesltdnYhb5dHAdR9U6NACx/0b4AQ
 0dnA==
X-Gm-Message-State: AOAM532v7/qoFukLNwaJVQjGM0Q0zO5Hkb5L8Z46aWG7gCll5WyShZfi
 2HBlG+eVXObE3wbqJriCUizBlQHwfQdd4n/EyRP5TpUNKroP8jc8jZ2xfYia8ammXPtLbgILO0l
 0h+sGA+ig0m4Wmcg=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr85573369wrm.271.1594634205444; 
 Mon, 13 Jul 2020 02:56:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzot5WTyo4kRpsamozFG82Yxj2BSiCOuFWk/wsdAHlBtKkyby0CYlE7P3WvbmmLnj1RGzZ8ww==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr85573348wrm.271.1594634205269; 
 Mon, 13 Jul 2020 02:56:45 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v12sm22691057wrt.31.2020.07.13.02.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:56:44 -0700 (PDT)
Subject: Re: [PATCH v5 09/12] tests/acceptance: Don't test reboot on cubieboard
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-10-jsnow@redhat.com>
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
Message-ID: <3df55357-12c0-61da-976e-651ae8c97f1a@redhat.com>
Date: Mon, 13 Jul 2020 11:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-10-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:06 AM, John Snow wrote:
> cubieboard does not have a functioning reboot, it halts and QEMU does
> not exit.
> 
> vm.shutdown() is modified in a forthcoming patch that makes it less tolerant
> of race conditions on shutdown; tests should consciously decide to WAIT
> or to SHUTDOWN qemu.
> 
> So long as this test is attempting to reboot, the correct choice would
> be to WAIT for the VM to exit. However, since that's broken, we should
> SHUTDOWN instead.
> 
> SHUTDOWN is indeed what already happens when the test performs teardown,
> however, if anyone fixes cubieboard reboot in the future, this test will
> develop a new race condition that might be hard to debug.
> 
> Therefore: remove the reboot test and make it obvious that the VM is
> still running when the test concludes, where the test teardown will do
> the right thing.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 5867ef760c..8b8b828bc5 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -508,9 +508,7 @@ def test_arm_cubieboard_initrd(self):
>                                                  'Allwinner sun4i/sun5i')
>          exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
>                                                  'system-control@1c00000')
> -        exec_command_and_wait_for_pattern(self, 'reboot',
> -                                                'reboot: Restarting system')
> -        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
> +        # cubieboard's reboot is not functioning; omit reboot test.
>  
>      def test_arm_cubieboard_sata(self):
>          """
> @@ -553,9 +551,7 @@ def test_arm_cubieboard_sata(self):
>                                                  'Allwinner sun4i/sun5i')
>          exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
>                                                  'sda')
> -        exec_command_and_wait_for_pattern(self, 'reboot',
> -                                                'reboot: Restarting system')
> -        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
> +        # cubieboard's reboot is not functioning; omit reboot test.
>  
>      def test_arm_orangepi(self):
>          """
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Note, if I do the pull request, I might reorder this one before the
previous one "tests/acceptance: wait() instead of shutdown() where
appropriate".


