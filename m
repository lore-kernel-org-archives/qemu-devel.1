Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E0FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08A122200
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/PENxJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08A122200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIdR-0005t6-1b
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvIcU-0004pN-22
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:57:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvIcS-0004Nt-Av
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=etprOSjj5ufJtLQjzfFPIW2kynJKt7RtjKDFY3yw2GA=;
 b=C/PENxJky+L6LeiKrKlGZAwvoBp2eU3xMg5jnbsKs+i3n3oE4tHJGch9Daac1AT2f9yyNe
 s3rerKw/FBWqWmK3mGTXxOEKCEKT5YltjcRVNNZDe8OeuZyNKWrhKjiZmr9wqL6/FHp8Jk
 /v4HCtcnxM/mfYJKxldzyrmzuuw88Vw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-_5WfNwdXNTq8kgHuEujudQ-1; Tue, 14 Jul 2020 06:56:58 -0400
X-MC-Unique: _5WfNwdXNTq8kgHuEujudQ-1
Received: by mail-wr1-f69.google.com with SMTP id 89so21135976wrr.15
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=etprOSjj5ufJtLQjzfFPIW2kynJKt7RtjKDFY3yw2GA=;
 b=JStGnIvbXzu8oRAbbgHjIIZJAO2NPVZJsF5NA0B/2m/GjeUn7wNXOg+kErFEZmsZBN
 wHQv54RcwGqALB4+x1otHGlhe7T6g0iYRZFAPhz4KWcoK5wtp6bROf3zb7oh2L4Fqwse
 kZLhcBWdUXcrWApWHK6bWOAkxL+6GAfiIxza22a/N8etmWG4uOOhUEy4X4JWjkoI6+MI
 DoIJnGUfmWI7vX6ZA+A3e94KH4dXniGu4cdICsrlMcR5+NILmEfZnuCmxNJnsNN33/52
 WSIykQZnUy7PiQ7e92k5E/JrXCQROEL0vaEKNDtHKyGZ73+Gv41Gkun9sctAwk3x9CLH
 xbzw==
X-Gm-Message-State: AOAM530ScILz3qg/BRsRLo/Q+kqY9n9drbk+9xGphtZb6vAVMv+bMYLM
 FuyNcHakHau5Xdfuy6UNeZNi5zdXehZ+fgljGu3h2mggPKWxPiK5zQ9ggeWSi+eQvIIcwDHBQu7
 XjaSkC7ab+/3BBUc=
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr4454374wru.8.1594724217173;
 Tue, 14 Jul 2020 03:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCfNNvU/t4u/7bsk5rZF6KZpw6xwwr8YofNqAjQUzzbGNL2Pp/maBHie8w1a3gQ945c/QQow==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr4454356wru.8.1594724217034;
 Tue, 14 Jul 2020 03:56:57 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u20sm3680661wmm.15.2020.07.14.03.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 03:56:56 -0700 (PDT)
Subject: Re: [PATCH for-5.1] acpi-pm-tmr: allow 2-byte reads
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20200714095518.16241-1-mjt@msgid.tls.msk.ru>
 <464386eb-ad88-2fe8-d943-6febe511eb6a@redhat.com>
 <44bb4516-197d-27dd-4977-dfc6c064154c@msgid.tls.msk.ru>
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
Message-ID: <17588aac-6a14-0aef-6e60-a38436d2046c@redhat.com>
Date: Tue, 14 Jul 2020 12:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <44bb4516-197d-27dd-4977-dfc6c064154c@msgid.tls.msk.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Simon John <git@the-jedi.co.uk>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 12:55 PM, Michael Tokarev wrote:
> 14.07.2020 13:26, Philippe Mathieu-Daudé пишет:
>> On 7/14/20 11:55 AM, Michael Tokarev wrote:
>>> As found in LP#964247, MacOS Catalina performs 2-byte reads
>>> on the acpi timer address space while the spec says it should
>>> be 4-byte. Allow 2-byte reads.
>>
>> https://bugs.launchpad.net/qemu/+bug/964247 is about Unity-2D shell...
> 
> It's a debian bug# ( http://bugs.debian.org/964247 ), not LP, the
> right LP bug is LP#1886318 . Mixed the two wrongly, I'm sorry for that.

Ah, no worry. Please include in the tags:

BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247

> I resent a v2, also allowing 1-byte access as suggested by mst.
> 
>> What is the target hardware used here?
> 
> It's x86.
> 
> Thanks,
> 
> /mjt
> 


