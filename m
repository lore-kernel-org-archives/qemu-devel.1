Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A68C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2E420720
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFhlIagc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2E420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlY0G-0001Hf-Tk
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlXzW-0000ii-VF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:20:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlXzT-0002Vt-NT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592400030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KvL6JPDM5Bs304wmUfojRZwfrhejcfmhKrmqDw/vA6g=;
 b=FFhlIagcz5oAEVFxwtzDL2DwXMqkks7zR3WlbMDAxOyxv6TRFlHGVXyL1NYSkpDWZaMYeV
 ZOQjHR8A0OU5oB9Jp9vsIiyAy4sN6rzfKXllcr9lrp/qS631p9gUEFBE6xgYYieSJ/CHuz
 +n457N+Q7SZgCKdXb3GUKmxzaZus5q0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-xnf-onp8Pyua6KJMX0tZyg-1; Wed, 17 Jun 2020 09:20:26 -0400
X-MC-Unique: xnf-onp8Pyua6KJMX0tZyg-1
Received: by mail-ej1-f71.google.com with SMTP id d14so1027565ejt.14
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KvL6JPDM5Bs304wmUfojRZwfrhejcfmhKrmqDw/vA6g=;
 b=YmHl5ogvNnCt6NSlbkvgkPNpsw1gdbS8MzH8O9WjYOnjceHl7NA9I4+rVSKIkDL6ro
 TmIAUAOIo7GXr3Fn9BqlN0gA/D9bIez1WM1EsdIMl9v7vEO7vUZSPnxAYfnM2bD7BLlH
 14Yfq3MoG3boyTCCmYGgOiypkfeZaSR/HIs/VlSRSeeEQxKfh3iEqiZosUDQeRNwOfg6
 08aF8CsT3r2Cx+mfLXvbEiCKRCekPQWirb7lh4DJQNSCQrpHsDfz5FPE9fYEmByiOJCR
 s+xaXEMvG6tgLlOjEm4yaAhgmi9+vlNHk551uIsu/qgMU9TzW+tO4uT7NzesTcwxphnS
 rp0A==
X-Gm-Message-State: AOAM530uR9MZoLJbe9s5yk6BOIB3k58KvBQ05Ni7BlNjqvrq9DOduvOS
 Xq/AmZOQQnj7rsQqfPtqO44jtgDRqKZzlnKTDx1Rsb6+5NEBDdjyveM3lzCiG3YcFN95Ud7+hvg
 nRLkS0wKojcZxIuc=
X-Received: by 2002:a17:907:20e5:: with SMTP id
 rh5mr7830985ejb.80.1592400025241; 
 Wed, 17 Jun 2020 06:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyXC/InxaAvblEDASDuskYWIcKJStuCM36lCrKpAb73Z9av/o7NDz3Rxz2NMfWDGo12nsJ2Q==
X-Received: by 2002:a17:907:20e5:: with SMTP id
 rh5mr7830963ejb.80.1592400025037; 
 Wed, 17 Jun 2020 06:20:25 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id z3sm13481906ejl.38.2020.06.17.06.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 06:20:24 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add various undefined MMIO r/w functions
To: Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200617053934.122642-1-ppandit@redhat.com>
 <20200617063956.GA12597@umbus.fritz.box> <20200617070621.29051d4b@x1.home>
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
Message-ID: <8357f8a5-83e3-47a7-57c9-b88edfa3812c@redhat.com>
Date: Wed, 17 Jun 2020 15:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617070621.29051d4b@x1.home>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@163.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 3:06 PM, Alex Williamson wrote:
> On Wed, 17 Jun 2020 16:39:56 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Wed, Jun 17, 2020 at 11:09:27AM +0530, P J P wrote:
>>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>>
>>> Hello,
>>>
>>> This series adds various undefined MMIO read/write functions
>>> to avoid potential guest crash via a NULL pointer dereference.  
>>
>> Hrm.  If this is such a common problem, maybe we should just add a
>> NULL check in the common paths.
> 
> +1, clearly the behavior is already expected.  Thanks,

20 months ago Peter suggested:

"assert that every MemoryRegionOps has pointers to callbacks
 in it, when it is registered in memory_region_init_io() and
 memory_region_init_rom_device_nomigrate()."

https://www.mail-archive.com/qemu-devel@nongnu.org/msg573310.html

Li Qiang refers to this post from Paolo:

>  static const MemoryRegionOps notdirty_mem_ops = {
> +    .read = notdirty_mem_read,
>      .write = notdirty_mem_write,
>      .valid.accepts = notdirty_mem_accepts,
>      .endianness = DEVICE_NATIVE_ENDIAN,

"This cannot happen, since TLB_NOTDIRTY is only added
 to the addr_write member (see accel/tcg/cputlb.c)."

https://www.mail-archive.com/qemu-devel@nongnu.org/msg561345.html


