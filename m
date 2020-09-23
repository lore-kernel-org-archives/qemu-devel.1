Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E75C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A967121924
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PavmOOIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A967121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKzXj-000576-Iu
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKzWf-00042I-2J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKzWc-0008R5-26
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600847352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ALFwEpL5TVYfps9hWbZSD/NBMWHoHt8EPL1gwcXQAkM=;
 b=PavmOOIRlGzozq9IT75xm5sndAPhftHJIPBY7pj1sDRd4/PQ2QB3lz65o2NIPB/iiHRznk
 m/yBa7PeQQXbSgj3RPoWMhXZ0zKF+2lCcFIwmW2I1OPgjfQIjS9B4Vq0TQ03Ao7fO7d1hh
 yQphc/UeJDTal3wXD8Q7ptQ7Aim2dx4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Ip3ZDClbMxOcAKzAQVPViw-1; Wed, 23 Sep 2020 03:49:08 -0400
X-MC-Unique: Ip3ZDClbMxOcAKzAQVPViw-1
Received: by mail-wm1-f72.google.com with SMTP id m10so1046317wmf.5
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 00:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ALFwEpL5TVYfps9hWbZSD/NBMWHoHt8EPL1gwcXQAkM=;
 b=K8BNCUPGTUnkMEjyXc/yxwrMfes6Hp4JN/Eu3MqzRClWsyxco0GH2DIdV9NNNwxc92
 ziP1lIQ9UKxEgZ9g2de3lAn/BgROYhJRcY8PCXclxpQtlHCutyKg0uTptXX1AwwTldis
 221+Gi9JCgDuUVB06DUrwsHH/bF6XJvn0IPHL8YuKvonTP148LSM42WRYi7aneCT4mHo
 IZ5H7FNj/fa/x6d1chcvN19JX97EYET5khszclXGKdOuUS6XpAdL5Cf0j96QfG0kYngf
 RCjPjDKoYNt7VdmlPSEP1sQRW4VrCLHFhvZhCApYBwffxnHg+CKZBkqU6hkkf2IXf+PC
 4hFQ==
X-Gm-Message-State: AOAM530EiVA+5VCtQPDypN5Owc9p/MK5GFwjYvIbevtQXjr7FzXI+xlM
 jif4xWKHiNFFpVAVBlzobt3VI4ax4XNi0sXBUxbQTfwGHNNHn+Z/SC8P5CHh40Mbjv6MTb8cVRG
 gilOdFr49C9j9W6k=
X-Received: by 2002:adf:b1d8:: with SMTP id r24mr9397943wra.194.1600847347562; 
 Wed, 23 Sep 2020 00:49:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY/EIzr728t2y8XY4556760jjmkCOis+rV7+sBfr63bVLYTG5ONDXRPV0LQX0OIazY+whrlg==
X-Received: by 2002:adf:b1d8:: with SMTP id r24mr9397923wra.194.1600847347308; 
 Wed, 23 Sep 2020 00:49:07 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i3sm28884625wrs.4.2020.09.23.00.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 00:49:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
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
Message-ID: <8711f367-c055-4f61-0043-3880fff95315@redhat.com>
Date: Wed, 23 Sep 2020 09:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922230505.4089701-2-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 1:05 AM, John Snow wrote:
> I'm proposing that I split the actual Python library off from the other
> miscellaneous python scripts we have and declare it maintained. Add
> myself as a maintainer of this folder, along with Cleber.
> 
> v2: change python/* to python/, thanks Alex.

^ Can you drop that line from the description when applying please?

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Cleber Rosa <crosa@redhat.com>
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d17cad19a..c0222ee645 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2355,11 +2355,18 @@ S: Maintained
>  F: include/sysemu/cryptodev*.h
>  F: backends/cryptodev*.c
>  
> +Python library
> +M: John Snow <jsnow@redhat.com>
> +M: Cleber Rosa <crosa@redhat.com>
> +R: Eduardo Habkost <ehabkost@redhat.com>
> +S: Maintained
> +F: python/
> +T: git https://gitlab.com/jsnow/qemu.git python
> +
>  Python scripts
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Cleber Rosa <crosa@redhat.com>
>  S: Odd fixes
> -F: python/qemu/*py
>  F: scripts/*.py
>  F: tests/*.py
>  
> 


