Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC67C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05BD206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJhvsDdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05BD206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmmS-0003nI-7L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmkk-0002BW-EC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:30:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55952
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmkh-0004rr-LP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592933430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Xg3XX3dVqUnT+oq/daXqMKBD+ESEuseNtpqI4Ildlg=;
 b=JJhvsDdFOZKOoiHPDtcqGsuN+z+RLaWxLzI3qyHT/S7QpRbg3BjN4KsVqfQuHW58d9X6Tr
 I/2jFttG3/3nNzXBu1Lo53FBJrqnAZN3tClQcvht1WOgvHrQQfZXLW3mY06iTci7zBzEFC
 /mutzgojgjbQK4tkt7uDVUm8JGqqIXs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-_52ZW0frMBq2U5F1QQ7PSA-1; Tue, 23 Jun 2020 13:30:15 -0400
X-MC-Unique: _52ZW0frMBq2U5F1QQ7PSA-1
Received: by mail-wr1-f72.google.com with SMTP id z3so10131500wrr.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Xg3XX3dVqUnT+oq/daXqMKBD+ESEuseNtpqI4Ildlg=;
 b=alJrmQkEsGYs+p27cZDTh8vzPlabZYmKMMNGmFSsTOa/Qx6UH6xdv1xQ4IvfZmMliq
 /zC7cgIa9OvBXeMDoRuFZSITM/MTg/ZLIYeioV6gttKqJFNrXVXMvo7HNvalBR6w15lP
 S0IIcr+miurKvra+lqkPXcxITQ2WoAP85o8HEo1uR4jQHgoV47OwN8CDNMBX95J/QMsV
 9Qm0aTG7s1JlbTscfGKEOTpyt0Tbi/sV8R1pi+q/vIKZcMzAXNLC1KrUuUIwiip6And8
 W6pRpYQY2jX/xh2FjJtm9Lq2phjUaOhnEE2oL9oOIfjeNwgrUB9XS8IojwDNBwFyGXWN
 FB4g==
X-Gm-Message-State: AOAM531dxC2oKr5vPIABiO5O+0ZaEfW5hqYBYS7WUla46G7bNB2Xg29k
 cLTJW4gZyUJ+UWSTiciGDaH3pq7IpxyMLXHP9NdFqJayrBK24rPyuwUrbVl1CNea4mVIpKC0NVR
 pXdPG6PPe4W4OEi8=
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr25942472wmc.80.1592933413973; 
 Tue, 23 Jun 2020 10:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4nIswCVqsPsv1x1bmIj84Dp7u+DL/Yc/6CIIeMN2hL5g2dB9ouVA7SGFUmgx/RI24hJgNXQ==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr25942457wmc.80.1592933413801; 
 Tue, 23 Jun 2020 10:30:13 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id q4sm4557280wmc.1.2020.06.23.10.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:30:13 -0700 (PDT)
Subject: Re: [PATCH v10 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR; crypto: Add
 tls-cipher-suites
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
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
Message-ID: <e4ffafc0-bc6e-33f1-10fc-414fa0c919fc@redhat.com>
Date: Tue, 23 Jun 2020 19:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623172726.21040-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 7:27 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series has 3 parts:
> 
> - First we add the tls-cipher-suites object
> 
> - We add the ability to QOM objects to produce data
>   consumable by the fw_cfg device,
> 
> - Then we let the tls-cipher-suites object implement
>   the FW_CFG_DATA_GENERATOR interface.
> 
> This is required by EDK2 'HTTPS Boot' feature [*] to tell
> the guest which TLS ciphers it can use.
> 
> Since v9:
> - intent to address Daniel suggestions, rewrite of crypto/* code

I forgot to explain the huge diff due to the rewrite.
Daniel suggested to simplify the API by returning a GByteArray:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg712887.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg712923.html

> $ git backport-diff -u v9
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/5:[0139] [FC] 'crypto: Add tls-cipher-suites object'
> 002/5:[0052] [FC] 'hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface'
> 003/5:[0010] [FC] 'softmmu/vl: Let -fw_cfg option take a 'gen_id' argument'
> 004/5:[----] [--] 'softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace'
> 005/5:[0018] [FC] 'crypto/tls-cipher-suites: Produce fw_cfg consumable blob'


