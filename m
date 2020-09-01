Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59187C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152BB20BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqEfERB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152BB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8TK-0006tL-4r
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD8C2-0000BK-Fc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD8C0-0007Uc-RR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598974048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tIkB5Mw3pDQxycyw0vifTahZCjB4LDPe5cBJOsFvgCk=;
 b=WqEfERB8rqyeHaU7A+NdEifO5giNCBwLLUXPajrdRgl5XKaT439+9IilCq6h1fDOCSNbXN
 yFajQkQpBvSfbDh9uYc1R1aDJJ3kQ8A+7jOHjvDBApBw+y4dMrCEB2ozPd08SHglplhGR6
 AJ45b688lGZtqVk59xSkV+zhZxovkRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-HGnO89oIN8-YEwRF6L_0hQ-1; Tue, 01 Sep 2020 11:27:23 -0400
X-MC-Unique: HGnO89oIN8-YEwRF6L_0hQ-1
Received: by mail-wm1-f72.google.com with SMTP id d5so527981wmb.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tIkB5Mw3pDQxycyw0vifTahZCjB4LDPe5cBJOsFvgCk=;
 b=JVPClsXUm0XM2LFJDqTMM8CLyeaa2FjCJOW0AWcLN90KolalwSaopR0qiKs0AUiuYW
 zt6Dk9XiOsHqYnA+4eXE84I51kbp+XGPy7XXKIVHnhP9ejDvxgzkw74VtTbY32CIJQzI
 KikPYshSLC/UDGRyw6nRpcsFuOorjdb+5PMt+Woj8bdVsUmqOAHEA3MJ+LBrV+0rig/t
 9a7EBX3coPbWHC90jtqyK+EgfxMphkiyYfLCeYPKFayEh2pFPIz0BTXPEUjf8qoRt4oT
 hZTYN0hdwFzIjylGQvdFobdBRdLEQSr9HYBgLrX+mjA+IHL2kvYCsboDlPxtZYQkXEX/
 lHaA==
X-Gm-Message-State: AOAM533CrnJVSYzY5TO3fa4Ult7B5WKM08WBEtDxop5Lv0fWEvQl9Gf4
 u01t2s4l/Dt6oc5QdJeN4qaG/wbpQSDlM/m7VJCpFsDxNr1utTFUaJSavdcc8tHNYFk5UcF8k51
 smuO9XX3IO9uGfNI=
X-Received: by 2002:adf:fec6:: with SMTP id q6mr2499518wrs.59.1598974042218;
 Tue, 01 Sep 2020 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuY+s9Gb7SIb78y7xhPoZlMHQNMyMfjQwQQAfTVU3Y0wqzZF8QDwjmhZFJ2Tj9gZbpAOqbsQ==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr2499497wrs.59.1598974042015;
 Tue, 01 Sep 2020 08:27:22 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d18sm2550987wrm.10.2020.09.01.08.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:27:21 -0700 (PDT)
Subject: Re: [PATCH v6 00/15] block/nvme: Various cleanups required to use
 multiple queues
To: qemu-devel@nongnu.org
References: <20200821195359.1285345-1-philmd@redhat.com>
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
Message-ID: <17b0c440-f846-8eb4-2d3d-cf35ff684a5a@redhat.com>
Date: Tue, 1 Sep 2020 17:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 9:53 PM, Philippe Mathieu-Daudé wrote:
> Hi Kevin,
> 
> This series is mostly code rearrangement (cleanups) to be
> able to split the hardware code from the block driver code,
> to be able to use multiple queues on the same hardware, or
> multiple block drivers on the same hardware.
> 
> All this series is reviewed.

ping? :)

> Philippe Mathieu-Daudé (15):
>   block/nvme: Replace magic value by SCALE_MS definition
>   block/nvme: Avoid further processing if trace event not enabled
>   block/nvme: Let nvme_create_queue_pair() fail gracefully
>   block/nvme: Define INDEX macros to ease code review
>   block/nvme: Improve error message when IO queue creation failed
>   block/nvme: Use common error path in nvme_add_io_queue()
>   block/nvme: Rename local variable
>   block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures
>   block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
>   block/nvme: Replace qemu_try_blockalign(bs) by
>     qemu_try_memalign(pg_sz)
>   block/nvme: Simplify nvme_init_queue() arguments
>   block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
>   block/nvme: Simplify nvme_create_queue_pair() arguments
>   block/nvme: Extract nvme_poll_queue()
>   block/nvme: Use an array of EventNotifier
> 
>  block/nvme.c | 211 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 125 insertions(+), 86 deletions(-)
> 


