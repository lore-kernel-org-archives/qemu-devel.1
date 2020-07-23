Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB533C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AF1206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEfcznON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AF1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYMC-0005L6-0F
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYLc-0004u0-Jg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:21:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYLa-000320-C0
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595499665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=91DlBq5gPAm5dcxEDP+WV3OseWK82tXEJgX19IuT90E=;
 b=MEfcznONXlKgghy62GOoGhSAgj+r/CIQATAiQXvrc6OfARWsw+VjdX9Xz+yzGL9tUKUrbw
 arB21xCITg4dQX5T8QPA7Y/EWRY1MMpH/lKKewFYF1K8C6IWoSGu/lCrLuqBsAQ0nNd/u4
 EHLl8Ta+LfcI2Xe9GgDIzhVZIK9TLTw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-HHcxWzwwPYaYL5s13285ig-1; Thu, 23 Jul 2020 06:21:03 -0400
X-MC-Unique: HHcxWzwwPYaYL5s13285ig-1
Received: by mail-wr1-f72.google.com with SMTP id j5so1250700wro.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=91DlBq5gPAm5dcxEDP+WV3OseWK82tXEJgX19IuT90E=;
 b=Da4sOuWhsbqTdtvuTC735eNyZsMCr6e6MvwRTOWGfdM+j764W92r85z3OjtmoJIwaY
 NgypNhUz5kANAWBtYLkqFYuODmuW0b+nqigq2o3a+aU5VW4arGHDVFa826czVovpdiAU
 mKUd0M8X6IHSRtnB28pv3tGYzKHEy1nsmP8YMEMd1OGZ9mZq3ko+f4TxDVng7TnZkr7b
 LX3sDc8QenzVOfVELTBD0dmiiR+uUnzh0Oo+FvWsFHBuFctXolTGnS3YNDgAF+L2Nczm
 dYvpZ/0WmlKUOan2HWbyZkqJ1NEhHP2fOwuut387fY18rDX1ngx4MovGNj4mCvtSfkiD
 QgCA==
X-Gm-Message-State: AOAM531VycbftBU2rZ2Ntz6FKCtZjCqGhykGNW9pAPuoCinXw1xJVK3b
 7BrgqgFlmvZSUnh11AS7/WAXRgsoPaKh1PfixuB/lk5BOH6RxGhA4y45UKuVzR087UFcH95cHIs
 muWJxJG2e9jEN33Y=
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr3373881wro.126.1595499662269; 
 Thu, 23 Jul 2020 03:21:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqoUaGMQco5wHoTx+rvOqJQpcfxoiXoYxeFtsGhmL6eDbon9u3twg2UoQdUSHSm559wlb93A==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr3373855wro.126.1595499661993; 
 Thu, 23 Jul 2020 03:21:01 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w7sm3073599wmc.32.2020.07.23.03.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 03:21:01 -0700 (PDT)
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net> <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
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
Message-ID: <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
Date: Thu, 23 Jul 2020 12:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723084026.GB2622@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Vitaly

On 7/23/20 10:40 AM, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
>> On Wed, Jul 22, 2020 at 04:47:32PM -0400, Eduardo Habkost wrote:
>>> On Wed, Jul 22, 2020 at 08:05:01PM +0200, Jan Kiszka wrote:
>>>> On 22.07.20 19:35, Eduardo Habkost wrote:
>>>>> Hi Jan,
>>>>>
>>>>> What was the last version where it worked for you?  Does using
>>>>> "-cpu host,-vmx" help?
>>>>
>>>> Yeah, -vmx does indeed help.
>>>>
>>>> I didn't have the time to bisect yet. Just check my reflog, picked
>>>> eb6490f544, and that works.
>>>
>>> Thanks!
>>>
>>> I could reproduce it locally[1], I will bisect it.
>>>
>>> The good news is that "-cpu host,+vmx" still works, on commit
>>> eb6490f544.
>>>
>>> [1] Linux 5.6.19-300.fc32.x86_64, Intel Core i7-8665U CPU.
>>
>> Bisected to:
>>
>> commit b16c0e20c74218f2d69710cedad11da7dd4d2190
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Wed May 20 10:49:22 2020 -0400
>>
>>     KVM: add support for AMD nested live migration
>>
>>     Support for nested guest live migration is part of Linux 5.8, add the
>>     corresponding code to QEMU.  The migration format consists of a few
>>     flags, is an opaque 4k blob.
>>
>>     The blob is in VMCB format (the control area represents the L1 VMCB
>>     control fields, the save area represents the pre-vmentry state; KVM does
>>     not use the host save area since the AMD manual allows that) but QEMU
>>     does not really care about that.  However, the flags need to be
>>     copied to hflags/hflags2 and back.
>>
>>     In addition, support for retrieving and setting the AMD nested virtualization
>>     states allows the L1 guest to be reset while running a nested guest, but
>>     a small bug in CPU reset needs to be fixed for that to work.
>>
>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Guesswork led me to try reverting the chunk in kvm_put_nested_state;
> without it the reset seems to work; I can't explain that code though.
> 
> Dave
> 
>>
>> -- 
>> Eduardo
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 


