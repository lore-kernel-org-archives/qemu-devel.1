Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30920C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B9D20791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMgSZCD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B9D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6EkF-0002tS-77
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 11:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6EjQ-0002Rp-MT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:01:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6EjN-0006jg-82
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597330883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=56MODbKbRGNcTK2e15ggiXI1mLw/4/DPaLtMHaIzgMg=;
 b=GMgSZCD+HCSqFV1GwAMyw3mQR42k3P6/CKo3B+dWrEGfWsCY0U68Z/DWtJlcQSI1JTCp68
 uCZi+PWiV5dqLwsFrBUOrRrbkm3CwBgmLD2E9yLYM76KySEHpCECpPKPZxeZJ70P9m/vyy
 K5SyP5cfiPqOjfJPX5RN6Bt3k4N6zxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-l3JHSU_INF-fQPbwVUZBYA-1; Thu, 13 Aug 2020 11:01:20 -0400
X-MC-Unique: l3JHSU_INF-fQPbwVUZBYA-1
Received: by mail-wr1-f70.google.com with SMTP id m7so2184677wrb.20
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 08:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=56MODbKbRGNcTK2e15ggiXI1mLw/4/DPaLtMHaIzgMg=;
 b=NSJcr1XIWL2F6YvgH7CK2PCoBZlC8zxrPbdqIaQybMpoDz1mUgJsQgyI7D7kCG2KZg
 Ml7pZJy6ilaPjGjxwGEc8KnLM1ezSK8ew8swkk2Ln+gXyTs1c5pQJNKLXf6tPY9rOIr5
 qmCVWkOrmHaA7KgtqfNu4SpqRgNGqQQo3jQRZGQDEP4fxMznzuNjHxGj6MGvrlepepsa
 luCqN3N3bOFiGJwEFL37xUGFcdmFW5dEjRrzoYnkgmJz1vAn3FA0UYIum1fpZGWRbO0b
 ptQF+/4QYCRlJj7hfJHENH8nbGXM8rOimYfENjFxTF7HxZlPjRcFRc5IX2KCunxE6Tm7
 N3PQ==
X-Gm-Message-State: AOAM533zT7MjzNPb6g/g83PEGCiESoPo2Q+lDHrLg4owNf45CUISRa85
 um31LmINYgW99ofip5nkR6sOc83Ok6/SwZtchfTDCwz3qqKmHtzon1XLYhbENHydtEbJbTkPNVp
 QmOiMK954sK7D8ts=
X-Received: by 2002:a1c:4c:: with SMTP id 73mr4702200wma.58.1597330878974;
 Thu, 13 Aug 2020 08:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0uXpb8G4OvOHL+N7t2noFIUN8lHT8Tja0P1qWvxJZB7TCIIqkN3FlynZ4W3gNI2J0a6yZ3g==
X-Received: by 2002:a1c:4c:: with SMTP id 73mr4702173wma.58.1597330878702;
 Thu, 13 Aug 2020 08:01:18 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q19sm10118505wrf.48.2020.08.13.08.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 08:01:17 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
To: P J P <ppandit@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200813063644.GB17532@yekko.fritz.box>
 <nycvar.YSQ.7.78.906.2008131830220.306228@xnncv>
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
Message-ID: <ab3807c3-c880-8112-8aab-08d10b8ead06@redhat.com>
Date: Thu, 13 Aug 2020 17:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2008131830220.306228@xnncv>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 3:43 PM, P J P wrote:
> +-- On Thu, 13 Aug 2020, David Gibson wrote --+
> | The overall idea seems fine.  Looks like we could avoid a fair bit of 
> | boilerplate - and slightly reduce our binary size - by introducing a global 
> | unimplemented_write() function.

IIRC in v2 or v3 it was mentioned each device has to be handled
differently, as it behaves differently, it sits on a particular bus, and
so on. So the preferred way is to have a device-specific handler.

(This explains v4 and why these patches took so long).

> 
> * You mean for after this assert(3) in memory_region_init_io change is merged?  
>   This series attempts to define all missing r/w calls.
> 
> * There are also unassigned_mem_read/write functions, maybe those can be 
>   reused?
> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 


