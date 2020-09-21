Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847EC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C4C2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7wNf+/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C4C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKEe9-0004NM-LF
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 01:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKEdE-0003oB-Kj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 01:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKEdC-0006bT-Vz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 01:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600667093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TFMxCIDKuIDskDwvn7aUKN1riFwHjqCvETHHXZl085s=;
 b=Q7wNf+/PQcKxm2i9vtoyvB3EnU08VtgKWvFi941QYbtH6qeRyAOuUrgq+OYI1bxtlGMB/X
 idq0l6oH8orMbusE87MMa8JRM62gXFiToH/Qxd3tEf4rOItWiwGhMfbWIa/6z2eR+ApGjh
 MfKSM+EGILEBgXpjCY6tniPrSIprVdI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-gVL_3HWVMNqWA6hzc82icw-1; Mon, 21 Sep 2020 01:44:51 -0400
X-MC-Unique: gVL_3HWVMNqWA6hzc82icw-1
Received: by mail-wr1-f72.google.com with SMTP id 33so5429857wre.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 22:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TFMxCIDKuIDskDwvn7aUKN1riFwHjqCvETHHXZl085s=;
 b=jRdkw1gXVfGeNlEHyzl65ZhpOGVFQggPytY9LEGdcknBovKww9p2r4I2flYJW3YLho
 neIjUERPaSacRoD+NhBGVhMswiAUy/mFAzYpltdbykN4d507rxT/VyCO/G7KAqjvyPF5
 F43WizUFBddWUaCXDFQl9CnngjmorJfKHi95hInBeEE7WHCa/ESd7fWDIAnxX+kbAFSu
 ShA65pBQIBGxFqDhVVyQ/pqNhvSI94Ey+7SZWxNKYybyrmFqRt4iMdFofDUtWSEVsb1o
 lWCgjtz8+uWUdRgGvKzIgsQmpTCvin8zLf4Bm/cWdA7xGOOwUIZUiR68Dc708fKK4EtJ
 MqOw==
X-Gm-Message-State: AOAM532hjakla2TJMg4zpe+U700K8T6Ki35oh/wghvKEA6rcN4pdyJ3l
 gEpvh/VQ96ZdWH2uzyncaV05kpgrnAsmROu0JUoZL8X+AoeEuLWW0mO1yAHfmq9D2QfNriYTbP0
 NDbcnAnNOMogTqEo=
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr27794408wmk.69.1600667090489; 
 Sun, 20 Sep 2020 22:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE4/6Thl3r+H/pFcDlbKzPUg32LnrqMy1vAFS1D16EFrRA9EW9Gzaf5KshLOzjXvs7R/XvHg==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr27794387wmk.69.1600667090285; 
 Sun, 20 Sep 2020 22:44:50 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l18sm18583954wrp.84.2020.09.20.22.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 22:44:49 -0700 (PDT)
Subject: Re: [PATCH v3 03/16] fuzz: Add PCI features to the general fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-4-alxndr@bu.edu>
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
Message-ID: <407cc86f-a705-115d-dd75-2d1c899811cd@redhat.com>
Date: Mon, 21 Sep 2020 07:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-4-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 4:24 AM, Alexander Bulekov wrote:
> This patch compares TYPE_PCI_DEVICE objects against the user-provided
> matching pattern. If there is a match, we use some hacks and leverage
> QOS to map each possible BAR for that device. Now fuzzed inputs might be
> converted to pci_read/write commands which target specific. This means
> that we can fuzz a particular device's PCI configuration space,
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 81 +++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index bf75b215ca..7c4c1398a7 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -24,6 +24,7 @@
>  #include "exec/ramblock.h"
>  #include "exec/address-spaces.h"
>  #include "hw/qdev-core.h"
> +#include "hw/pci/pci.h"
>  
>  /*
>   * SEPARATOR is used to separate "operations" in the fuzz input
> @@ -35,12 +36,17 @@ enum cmds {
>      OP_OUT,
>      OP_READ,
>      OP_WRITE,
> +    OP_PCI_READ,
> +    OP_PCI_WRITE,
>      OP_CLOCK_STEP,
>  };

As there is no versioning, does adding new commands
invalidates the corpus?

[...]


