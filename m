Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88235C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DCD20675
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBGpkNo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DCD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqa5T-0000uO-KE
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqa4f-00082o-Hi
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqa4d-0007mt-Sj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593599678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HW4TRYO5doK6FZ7/lBPGJ5oFhPVv30XQeWgQH/uLLJM=;
 b=NBGpkNo51ekYgVyWtTSA4cOE5piKHgPYo8ATUR/gDgZyhmasoNXNzKLfZ5W0MlyYffItHa
 6o9c8I3NK8fi83qf9Oa0FOBNxGCsd6mp0UDS+0pCZWSJluFtp+Yj/h/jIQecjRRQBFsU0o
 GPkr/kj3BZJga7KmbqPddhKwukGc0gQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-YMutI1JHNH-D-G_KBGSbWg-1; Wed, 01 Jul 2020 06:34:37 -0400
X-MC-Unique: YMutI1JHNH-D-G_KBGSbWg-1
Received: by mail-ed1-f71.google.com with SMTP id d3so5302894edq.14
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HW4TRYO5doK6FZ7/lBPGJ5oFhPVv30XQeWgQH/uLLJM=;
 b=gML8QzRP0cRnR2FMzT50z44bzy3XhoRCpS8s+wxKJyVLEo1TRsnSNMKImqlXgMdFNK
 kJ1Q4EtwptplL4Qsv6nEU2DElX4yK3hcrEndnweb1HT2EB44ZvQvNs3IYs5PF0UuP3ia
 CYBoTZ3Oi8R2aO29cKngXE7jOyhGo637qMhYqDul0rPvy4CtQPP/5fyrCdextrGbB9q1
 A/iT3drlgT1HkvYW7jJAzm/pxMF+uWveZ2B2oUYJlosDh/acbsjgYrypHnKqDqTb9fGj
 jmXHpZpmXFdV2EjHjPta+sjA2VLAWxQLgUfApGS+pT7zo45bOmsRJpAdnLCP2g2pLmZS
 O5Cg==
X-Gm-Message-State: AOAM533QZULpTkcSC439ua+VN03Y6uQ2ggFhR2MZswCFcVadmuqRYZBj
 /F96gHsTPoikljdFlen/Xr45XEXzTl4zy4p4neInMUNKCQixtehkxLk1BqEynUBgxYxdGUhtKkb
 EcYbkaB9EQYI/K4c=
X-Received: by 2002:a05:6402:a43:: with SMTP id
 bt3mr17882488edb.332.1593599676063; 
 Wed, 01 Jul 2020 03:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyctP41VBtBTZbDevrVeLtbhb9f0xNkZzRnQtPXpjx1Dti5hf7eoYqyrLWCK9xGm+Nk2rHzNw==
X-Received: by 2002:a05:6402:a43:: with SMTP id
 bt3mr17882477edb.332.1593599675923; 
 Wed, 01 Jul 2020 03:34:35 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id di20sm6022570edb.26.2020.07.01.03.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 03:34:35 -0700 (PDT)
Subject: Re: [PATCH v10 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR; crypto: Add
 tls-cipher-suites
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
 <20200701103155.GE1427561@redhat.com>
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
Message-ID: <d5865bcf-406a-0078-6d43-70f4abaede40@redhat.com>
Date: Wed, 1 Jul 2020 12:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701103155.GE1427561@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 12:31 PM, Daniel P. Berrangé wrote:
> On Tue, Jun 23, 2020 at 07:27:21PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series has 3 parts:
>>
>> - First we add the tls-cipher-suites object
>>
>> - We add the ability to QOM objects to produce data
>>   consumable by the fw_cfg device,
>>
>> - Then we let the tls-cipher-suites object implement
>>   the FW_CFG_DATA_GENERATOR interface.
>>
>> This is required by EDK2 'HTTPS Boot' feature [*] to tell
>> the guest which TLS ciphers it can use.
> 
> On my crypto side, the series is ready to merge.
> 
> The code is split 50/50 between crypto subsystem and firmware
> subsystem, so the question is who wants to merge it ?
> 
> If Laszlo wants to merge it, then consider the whole series
> to have   Acked-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

> 
> If Laszlo wants me to merge it, then I'll just wait for him
> to give his Ack.
> 
> Soft-freeze is fast approaching in less than a week...

Yes, but Laszlo isn't available until tomorrow. I prefer to wait
until Friday for his feedback first. If he is too busy, then
your help is obviously welcomed!

Thanks,

Phil.


