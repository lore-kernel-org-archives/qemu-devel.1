Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ED3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A12E2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEX+oXST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A12E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFCey-0004xD-4R
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 04:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFCeA-00043v-V2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:37:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFCe8-0005lS-RC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599467823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HzgWFyvfTIRk2Pn6FkyJt/3wphnVZCNMo2001z+lQ9s=;
 b=VEX+oXST2mYlpXe3mkZusBlna3kwZCzxRlKRdM2yLi4GzLpOctnbT+qnRniLMZWdDeYOkc
 K8rqQntNnYSlqYcJAc7sELoKfnvyIXDjEzwOzfmG3pEXUDEk6GiFEdauy1MW62dYZVCxLo
 3fIC5MXuYzX1kY/k/Eli4iuw5j2q0Cs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-bh7h8-7APOOZvlZAUy7Avg-1; Mon, 07 Sep 2020 04:37:01 -0400
X-MC-Unique: bh7h8-7APOOZvlZAUy7Avg-1
Received: by mail-wm1-f69.google.com with SMTP id d22so1521909wmd.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 01:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HzgWFyvfTIRk2Pn6FkyJt/3wphnVZCNMo2001z+lQ9s=;
 b=qNL8zpZVoU67K7LCZz94uu4viOMbrstyqZwp38ZJ+j9j0ZaUQryB6Ej2mhLJMrbcuO
 RmsKEFhBfUucy6zT4HNidcbvpB8SAWj/fs6MGLUvCLoZumySt+HdqDZfGJmb0YUip2JX
 /RGn+2wbUisHJACh2ptEJJHIbsaZ9TQYSx1Q86GP7jHC3y5wpCQsQMT2w1OZPWEERd0V
 hoP7gMNPeHqNAgMOrgAjHmm65g26t1Fo2u/A35nNS2XTNmW4PQ7vtykm3yy10dEa9s9M
 hMTYKZq9Uq6CKkNC+q9tu3EGdHuzj1KI76DvyQIRZ4+URmnWn6OJtLWDEqEZVSl34ev0
 xuaA==
X-Gm-Message-State: AOAM533TEt2lqWxi2xIwgC0pbLHesEjHKZEqlEoVayUuikHMoyPkDx9+
 A0wv9g2aJkUTzYtHYZibGe218DxSgeI4DYlOEMl5VMrs0lzukCL0G96dAfY40eDtcaqoK48xQDS
 aaesIfaXOm43q9r8=
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr19531217wmg.0.1599467820742; 
 Mon, 07 Sep 2020 01:37:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyqFRoq3QPdiPk6VurTEFpK81EoHKfYhY8bwmLKWkhmb35cXr220B/kTot0yAxcr5u/oxIRw==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr19531182wmg.0.1599467820434; 
 Mon, 07 Sep 2020 01:37:00 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k84sm26042973wmf.6.2020.09.07.01.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 01:36:59 -0700 (PDT)
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
To: Klaus Jensen <its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
 <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
 <20200907072332.GA690013@apples.localdomain>
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
Message-ID: <8651d3fa-becf-7b86-8c16-bbfb8926cec7@redhat.com>
Date: Mon, 7 Sep 2020 10:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907072332.GA690013@apples.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 9:23 AM, Klaus Jensen wrote:
> On Sep  7 04:28, Philippe Mathieu-Daudé wrote:
>> +David in case
>>
>> On 9/4/20 4:19 PM, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> There are two reasons for changing this:
>>>
>>>   1. The nvme device currently uses an internal Intel device id.
>>>
>>>   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
>>>      support multiple namespaces" the controller device no longer has
>>>      the quirks that the Linux kernel think it has.
>>>
>>>      As the quirks are applied based on pci vendor and device id, change
>>>      them to get rid of the quirks.
>>>
>>> To keep backward compatibility, add a new 'x-use-intel-id' parameter to
>>> the nvme device to force use of the Intel vendor and device id. This is
>>> off by default but add a compat property to set this for 5.1 machines
>>> and older.
>>
>> So now what happens if you start a 5.1 machine with a recent kernel?
>> Simply the kernel will use unnecessary quirks, or are there more
>> changes in behavior?
>>
> 
> Yes, the kernel will then just apply unneccesary quirks, these are:
> 
>   1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not support
>      anything else than values 0x0 and 0x1 for CNS (Identify Namespace and
>      Identify Namespace). With multiple namespace support, this just
>      means that the kernel will "scan" namespaces instead of using
>      "Active Namespace ID list" (CNS 0x2).
> 
>   2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out with a
>      broken Write Zeroes implementation which has since been fixed in
>      commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").

OK thanks. Can you amend that information in the commit
description please?

Thanks,

Phil.


