Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A212DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6662E20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Re82C88i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6662E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLhs-0000rW-H8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgLhF-0000Fw-Jb
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:12:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgLhE-0008C2-7O
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591161131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YzcpkdU6gmgtNSWUA1+uSr6y1uotxKrX7rUTKU9u3nw=;
 b=Re82C88iqHmuD5XxaJ44ZpVySCYdPmwt8hqrJP+1P9QV071wTcuAbV7M21IhMHF2siZuUQ
 sRzeQ2rwa8MRN0bWwLkLAvkqljltY0gQkPzBbIkkLacwBtE0l5RKGF8COkDd2ynlc7Q28B
 CA6yOyigOKG6BvV2N5rV9afXr04GNKY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-5_xZ73K5PHibNmw883a7VQ-1; Wed, 03 Jun 2020 01:12:09 -0400
X-MC-Unique: 5_xZ73K5PHibNmw883a7VQ-1
Received: by mail-wr1-f71.google.com with SMTP id s7so584857wrm.16
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 22:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YzcpkdU6gmgtNSWUA1+uSr6y1uotxKrX7rUTKU9u3nw=;
 b=LvJj/zm0ZUXBaTIkzJ68d5z+gJfJg6X2YAEbgOLgACZ5F1ZqPIk0dfXZ1SPbpqnw6k
 9QwaYUQj2rR7dHHcpKpJX3xfMOsM9xHRm977Jdk96Hv/QeEaoxRm3yiNjBOTo7RdWxcS
 8RI1f4iKOTOPJvHUvEU2V7KLoLj/EGruUCTjG0jgs9OZebWcLUJy/95aOfyTBVNVdqGU
 jSvKWgxDYRKXrEFpZ6ufihDDZ0OqaT1z1xsBefiTRPlvQIscCkURKvyPX8nuulS45ikM
 oEbyez/pUGTek0TLBX9I4NRF0hR7YX4hzT08OH9dVr34qxNLgze7HHVktp8Vs1litX5/
 psVQ==
X-Gm-Message-State: AOAM532jSddkN6pN18fYqZFG+sdf7KlJwNj67M/gxPtq/J9oxtyVoB3z
 uIg6Rn4AZaXqrHexcPmQj2pesyWLjKwX6r2u7TxnrtA7fHdLlreEZJ0yd9Z3gZcxV7vk5QU17aU
 l+vmT+/sTlyhay7o=
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr6735072wmc.72.1591161128498; 
 Tue, 02 Jun 2020 22:12:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhXRa6XzzImOqYzSeI+aTMd0LKtOSN8nZ+KHiQ1cImcJMNXUhjLnnW8cMfuJwZ3f3YPnTpjA==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr6735062wmc.72.1591161128313; 
 Tue, 02 Jun 2020 22:12:08 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j190sm1154460wmb.33.2020.06.02.22.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 22:12:07 -0700 (PDT)
Subject: Re: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD
 and NetBSD
To: David CARLIER <devnexen@gmail.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@readhat.com, qemu-trivial@nongnu.org
References: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
 <f9ebb603-0a0e-8775-8405-dd8de2493a3f@redhat.com>
 <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
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
Message-ID: <ee2dcfe2-66f0-63f4-33a0-e5731e5d9d08@redhat.com>
Date: Wed, 3 Jun 2020 07:12:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqx6_mWvb-5Z2Mbtw3V-q-WkZPnOF10VK=iLwSwUGnOJAQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kamil Rytarowski <kamil@netbsd.org>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, bauerchen@tencent.com, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/26/20 9:29 AM, David CARLIER wrote:
> From 792fbcd9114f43bd80fd1ef5b25cd9935a536f9f Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 08:25:26 +0100
> Subject: [PATCH] util/oslib: Returns the real thread identifier on FreeBSD and
>  NetBSD
> 
> getpid is good enough in a mono thread context, however
>  thr_self/_lwp_self reflects the real current thread identifier
>  from a given process.
> ---
>  util/oslib-posix.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 062236a1ab..916f1be224 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -48,11 +48,13 @@
>  #ifdef __FreeBSD__
>  #include <sys/sysctl.h>
>  #include <sys/user.h>
> +#include <sys/thr.h>
>  #include <libutil.h>
>  #endif
> 
>  #ifdef __NetBSD__
>  #include <sys/sysctl.h>
> +#include <lwp.h>
>  #endif
> 
>  #include "qemu/mmap-alloc.h"
> @@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
>  {
>  #if defined(__linux__)
>      return syscall(SYS_gettid);
> +#elif defined(__FreeBSD__)
> +    /* thread id is up to INT_MAX */
> +    long tid;
> +    thr_self(&tid);
> +    return (int)tid;
> +#elif defined(__NetBSD__)
> +    return _lwp_self();
>  #else
>      return getpid();
>  #endif
> 


