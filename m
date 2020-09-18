Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A7C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A35E22208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiVX6QIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A35E22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJEfd-0003Bi-E0
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 07:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJEen-0002kd-HC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:34:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJEel-0004JM-Ko
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600428862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nkqw82aX+9RdTurqIS5Dsqoo8iEGpi/E0LtA+uXJ4pA=;
 b=NiVX6QIzZC+cFUzmNgO3azd/1ylerV8+kWey5JBTIkAGuS3bz9s+L3TI8i3YmGXhlY2nLz
 FRi1Wax1R92DzX3NhjhiNBJ2Y21/m/PEldnzXCTrhyeqWv7+pVpPGeu6WWLHN8EPhnsiXO
 78Yd+l4HTYDBFYfvCyiGAMDrjSjczzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OOnsJyB4NPKJVAQY3dGmHg-1; Fri, 18 Sep 2020 07:34:18 -0400
X-MC-Unique: OOnsJyB4NPKJVAQY3dGmHg-1
Received: by mail-wr1-f70.google.com with SMTP id r16so2013161wrm.18
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 04:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nkqw82aX+9RdTurqIS5Dsqoo8iEGpi/E0LtA+uXJ4pA=;
 b=f+/zyWYKXj6XYjy2veX47N4ZlLybEwKr7l5GJeP6hfb+BtvJKzhQJiZIeeltNphEsH
 f8DSdr9pvx19JBQMQPk3nl9QCYd3Yx46CuRfQROYocTfH67qbtwarhtOHpe8v0XC2b4X
 L2z+hdFhdF9IIO08VRnvNbULJUhzd+g8We0cmVbgHUtvwQfAHj55In7y2Dox9KvBan4k
 3ex6zkcpVG28iU4tdCwujfXRyUsVU3/gtNt0xj7FgB9rZHCmtNN6DRJ1kInfYE49pTmP
 INoRzV7GESflZP6AjM0qB3SqeKdBa5TrUgnfbeBkqtnMN+aqIS/zV3lPrJm82s2jg/i2
 tm1A==
X-Gm-Message-State: AOAM532T0X/4AOTxakIqlDfQw2R9JdX/xu50RL6eFxcES7haZ3T93M8N
 cWbi2Uqq/wi1LL4DXytUx2+LVqGFu/LX5NQrnR/15RmtPKipfzyq4grRudMMS7+0NZbstetFnne
 bm8usnhEHk3fkQeM=
X-Received: by 2002:adf:c5c3:: with SMTP id v3mr14465793wrg.205.1600428856888; 
 Fri, 18 Sep 2020 04:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY5xPjSn5leCuYzaJI3Yorp3AlPOu8cmbCJTWNf8Kp6qwJQ5VGvm23NLUjvpX/UGQbrodi1A==
X-Received: by 2002:adf:c5c3:: with SMTP id v3mr14465767wrg.205.1600428856685; 
 Fri, 18 Sep 2020 04:34:16 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u17sm4541931wmm.4.2020.09.18.04.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 04:34:16 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
To: qemu-devel@nongnu.org
References: <20200917163954.50514-1-philmd@redhat.com>
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
Message-ID: <9233a701-eb83-e629-7b99-54c7d807f7ff@redhat.com>
Date: Fri, 18 Sep 2020 13:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917163954.50514-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 07:01:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 6:39 PM, Philippe Mathieu-Daudé wrote:
> Armbian servers are not very reliable and confused the GitLab CI
> users a few times this month (path updated, archives moved, and
> now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
> error). Time to disable these tests.
> Users can still use the artifacts from the cache (or manually add
> them to the cache).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
[...]
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index b79fc8daf8e..7b4310fccf3 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -127,6 +127,8 @@ def test_arm_virt(self):
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
>  
>      @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable apt.armbian.com')
>      def test_arm_cubieboard_initrd(self):
>          """
>          :avocado: tags=arch:arm
> 

Oops for this one I forgot the "from avocado import skipUnless" line.


