Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B294C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA0920829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctzpP+Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA0920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAn7-0001WX-Uv
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAj4-0004rg-EB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:10:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAj0-0007p5-4v
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600175421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VElwLtldMdzAzbIH83dptm3TWF5gu9/Ka09EwJe1qJE=;
 b=ctzpP+Vt4tiUkeFbCCZetzbBABybUynGLdKiImHpBWedVkg91g5/cx2NJMFn1GI6j/SRPY
 Do1NGsi0dG7A0wUy3KtaFS5y3x2x3ckSQFMdkMmOtRJJUuipaXm8ApD4pPDQrTefGTXm05
 G7TniqYHYfYJf+9G7mJPaMrOh098R14=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-PdQ4KeI8OMydub5fHDMqaA-1; Tue, 15 Sep 2020 09:10:19 -0400
X-MC-Unique: PdQ4KeI8OMydub5fHDMqaA-1
Received: by mail-wm1-f69.google.com with SMTP id d22so1150228wmd.6
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZnmYLUJpxZini+8wtnPPPhWUisUNOVJvVQpp12RtXBw=;
 b=ubkNe9e66eP1W8HyN6vGG8NJNRNcTbeK4mdsMAFr25S8pbwdMM3XzbRsHgaQM3oL3x
 rPxGup7Z5zOzj4JQrtMkEuQMwuqeNuJJ7vNwqIUZODmf0/XRZKsXmbzsv/ojYsmczN2X
 U2R3y5Ic9gq/Py7sB3ezBES34Q+JZkQHcQFmxXF4Stw/C2JRo5AcF4/aW19Cu6IVxxKs
 UGBq98ux5G5xYCBb8SyNjThddNkcggZOyeDFjkDGqAsfVq9nt3i1xmv3trA9KiiB8TjJ
 +uty3gXsUCR5kfu4Pm5hbF3AcshCj0B3rKx36t0MLkrTnSylltt5YAEADkZAXFQSEDbi
 PBJA==
X-Gm-Message-State: AOAM533YE4/O9jwjhj0v/W7n0lk9bKpmM6PBVoFctLo7ZmGT3UzBkifE
 jLPtdN+OQvU/WPn4MUVN88nReah+zN5OLRxoqzOLuJ/Yw45fUds8B6caNPU3CuHFi7a6shRwhwO
 Ejmh0HTl7aaRyC2M=
X-Received: by 2002:adf:df05:: with SMTP id y5mr23302953wrl.39.1600175418054; 
 Tue, 15 Sep 2020 06:10:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvm60OC68Wii4jGXeK9dZ2I01GwLs+S4NZtUdzAbQ/2WDLVdKcu78xGX7zH461pDc5//tW2g==
X-Received: by 2002:adf:df05:: with SMTP id y5mr23302929wrl.39.1600175417902; 
 Tue, 15 Sep 2020 06:10:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q18sm25854070wre.78.2020.09.15.06.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 06:10:17 -0700 (PDT)
Subject: Re: [PATCH 13/15] spapr: Add a return value to spapr_check_pagesize()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-14-groug@kaod.org>
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
Message-ID: <630e183a-c090-3866-1ad0-d196f368ed48@redhat.com>
Date: Tue, 15 Sep 2020 15:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914123505.612812-14-groug@kaod.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:35 PM, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/ppc/spapr.h | 2 +-
>  hw/ppc/spapr.c         | 4 +---
>  hw/ppc/spapr_caps.c    | 7 +++++--
>  3 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


