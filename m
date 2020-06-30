Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40625C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0968F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxloTcbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0968F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCkc-0003yd-9S
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCjn-0002wV-21
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:39:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCjk-0000TM-QK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3ATPNIEecoeus0NcTildAwjVvmS0pUbK+VfMvy4W4ZY=;
 b=hxloTcbinAfxf2MTzguzI6V5XhYZD9KDmPvcjXcyM58duO08LtlUBZmMzR7z3NCO3A6749
 eK0/vyHm+i406MCPeQl476VYtxjC4otIxqKEDtjFxi2ZvW/uJIkvKa1utFYevA1xOQEIWa
 qEqpkskto9JpsenuHWSMHag63jUYkFk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-86nKTYQxPdSimn9kvJv1PA-1; Tue, 30 Jun 2020 05:39:27 -0400
X-MC-Unique: 86nKTYQxPdSimn9kvJv1PA-1
Received: by mail-ed1-f72.google.com with SMTP id y4so4931948edv.17
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3ATPNIEecoeus0NcTildAwjVvmS0pUbK+VfMvy4W4ZY=;
 b=UHGCff+6QK+T14P8KFzjpGImVAkJNNQkhK10nKBTHspEe59xfMkv8jD/KkdPxNmZJX
 XYIeIGo3UubXK1efsrb1hp5oZHbk3oygGzh0kvm8TIM2i/mTgho0KRM6h/s2jmggukw2
 1tVqcSmyEscm8zKdwUR5vhyA0NcOeVuxnlTcYM+NwCNRLy+T4meVRzIJyHTedKzm5YxK
 vJb2iw81auGaegSOYr9Cv6W7gFr/LwHR7Zd0BlFYeHPL+q1G2pu8j4y6ELkJ4tRkbuL0
 QQpIgzoJQwigUL9xOkaNXuo3iuhcON9SlVsmygxA0/Ni+BQcAQ5eMt4blAn/ManEme8T
 yb4w==
X-Gm-Message-State: AOAM5310gJgEFRdRjd9YPuidAxxQm/RkcMFHVSCDVCO+7crnPBKPd+T7
 lXnp6rmtwjGEtwbPhtnle8kITirCGWLnYUlbeUfE4fRow4wi1uyqx9F8+ed/DH3LdYgI+dNAem/
 wcPLeKfDLxJ3WJfA=
X-Received: by 2002:a50:8467:: with SMTP id 94mr21559726edp.249.1593509966526; 
 Tue, 30 Jun 2020 02:39:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyagq0Zj8acaAJAvFf7ykiwaAs5XYxHoPfsR5pa2C5j5dX+noJqf1XtxjgmTRcBRGimZRwkdA==
X-Received: by 2002:a50:8467:: with SMTP id 94mr21559712edp.249.1593509966378; 
 Tue, 30 Jun 2020 02:39:26 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d22sm1583881ejc.90.2020.06.30.02.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:39:25 -0700 (PDT)
Subject: Re: [PATCH] hw/block/nvme: Align I/O BAR to 4 KiB
To: Klaus Jensen <its@irrelevant.dk>
References: <20200625154834.367-1-philmd@redhat.com>
 <20200625182326.ookc3e6rpbcypuj3@apples.localdomain>
 <a186c461-7af3-371a-f82f-7dc3ced0ea84@redhat.com>
 <20200630084645.f53iwkmpbewnhilk@apples.localdomain>
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
Message-ID: <5a205368-ca51-d3f6-22a5-5f04194150c7@redhat.com>
Date: Tue, 30 Jun 2020 11:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630084645.f53iwkmpbewnhilk@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 10:46 AM, Klaus Jensen wrote:
> On Jun 30 10:35, Philippe Mathieu-Daudé wrote:
>> Hi Klaus,
>>
>> On 6/25/20 8:23 PM, Klaus Jensen wrote:
>>> On Jun 25 17:48, Philippe Mathieu-Daudé wrote:
>>>> Simplify the NVMe emulated device by aligning the I/O BAR to 4 KiB.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>  include/block/nvme.h | 3 +++
>>>>  hw/block/nvme.c      | 5 ++---
>>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>>>> index 1720ee1d51..6d87c9c146 100644
>>>> --- a/include/block/nvme.h
>>>> +++ b/include/block/nvme.h
>>>> @@ -22,6 +22,8 @@ typedef struct NvmeBar {
>>>>      uint32_t    pmrebs;
>>>>      uint32_t    pmrswtp;
>>>>      uint32_t    pmrmsc;
>>>> +    uint32_t    reserved[58];
>>>> +    uint8_t     cmd_set_specfic[0x100];
>>>>  } NvmeBar;
>>>
>>> This ends up as a freak mix of v1.3 and v1.4 specs. Since we already
>>> have the PMR stuff in there, I think it makes more sense to align with
>>> v1.4 and remove the reserved bytes.
>>
>> I'm sorry but I don't understand what you'd prefer, removing the
>> cmd_set_specfic[] for v1.3 and instead use this?
>>
>>       uint32_t    pmrmsc;
>>  +    uint32_t    reserved[122];
>>   } NvmeBar;
>>
>> Or this?
>>
>>       uint32_t    pmrmsc;
>>  +    uint8_t     reserved[488];
>>   } NvmeBar;
>>
> 
> Yes, the second one.
> 
> But it should be 484 bytes reserved and the bug is in the pmrmsc field
> that should be uint64_t. Can you fix that as well?  :)
> 

Ah this is what you did in "hw/block/nvme: add NVMe 1.4 specific fields"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg717891.html


