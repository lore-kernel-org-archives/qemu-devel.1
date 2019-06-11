Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7076C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9186E2089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQsynWVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9186E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadpM-0006qA-BX
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hadod-0006RK-RU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hadoc-0008Bx-Ek
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:15:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hadoa-0007vl-CY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:15:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so1575167wmd.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9Rr8lSaecndUxXufH6wnDj6cieWo8lBMRPasPYtUc68=;
 b=fQsynWVgHqfoww3Jx1mXChwhJ0YC7kaKmV+rq7IZtAkD3dZ2gupp/FN++ABbvRtS46
 sTwFZ7pAx0xnUYWhYiGRGTrEY2qDel765cMuBk13q0qMoobBvG9OY1EGHoJ8TzkZE2Pu
 3pofGEJq2QVxx60QQxES2wQf3DaN/nj2i+LmRh0cxGKQHtV8opGYrHcUzYmj7z467fES
 ftyGjpLBNy+OTDSanAWcaMa6tW079V+2X9+alSgnmEJ0uH4CpPs7mRUowrhkthD0XxKb
 mpoNor64bL2mLnVlfzEQKbM0TTLm7E6r6cEkabfTkGADzPAaIHj8vfOMuWCZGVsarl6Q
 y0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9Rr8lSaecndUxXufH6wnDj6cieWo8lBMRPasPYtUc68=;
 b=D4OcZPkpbUZnL33kGKVyQmwfkx64dhF3+mn2kG1G7SMhBLoZoWH4jONqlpjwDbwDCS
 qde9CiAcREap3nYVtylVW4irffJIVXM3qqG7hS8bNsLZXik0e48GkLkSPHDKFotFoDFq
 yzI9jI46A1l0fyAOzjI0pSa8Ej+2oogGJtlYMx3hCxwGoTJAoScnte/kWSbnWwGIybIl
 RmUh1j0/QlFdCmi3d9+sAvjKg7NvFT89Iz0CF9LfQPrPNjPYe4vlrD0CRnFhDpkwcWer
 ZVWDgnHSiVi3NNOUeNqeIXkhCpVacWValWgp0ME0Ls0vAdxwfOSw61xhnskVk6KZl6xF
 CKjw==
X-Gm-Message-State: APjAAAXzJ8VKQKDW4I1U/z50L8BbXXgrX93pBxPps4LD5Xn9UBLOhp0u
 yZoKaZY3tTuIAZYeqwaPTaIG70de
X-Google-Smtp-Source: APXvYqyqzt9no1p4Sz6/ziuz2yyp6Jf1HJ0WI7zFZuJ0GSgkOZ3ECg1qxons3vbJJNu++iTrENQd+g==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr16055324wml.37.1560248119653; 
 Tue, 11 Jun 2019 03:15:19 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
 by smtp.gmail.com with ESMTPSA id j16sm30292194wre.94.2019.06.11.03.15.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:15:18 -0700 (PDT)
To: Andrea Bolognani <abologna@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <20190606161943.GA9657@paraplu>
 <20190606141904-mutt-send-email-mst@kernel.org>
 <c8f1fff2075c64ff6a3e5a2c63d667849acbd23c.camel@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <49ed5a38-14e9-697c-d7a0-57e827e1b3a7@gmail.com>
Date: Tue, 11 Jun 2019 13:15:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8f1fff2075c64ff6a3e5a2c63d667849acbd23c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] PCI(e): Documentation "io-reserve" and related
 properties?
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/7/19 2:43 PM, Andrea Bolognani wrote:
> On Thu, 2019-06-06 at 14:20 -0400, Michael S. Tsirkin wrote:
>> On Thu, Jun 06, 2019 at 06:19:43PM +0200, Kashyap Chamarthy wrote:
>>> Hi folks,
>>>
>>> Today I learnt about some obscure PCIe-related properties, in context of
>>> the adding PCIe root ports to a guest, namely:
>>>
>>>      io-reserve
>>>      mem-reserve
>>>      bus-reserve
>>>      pref32-reserve
>>>      pref64-reserve
>>>
>>> Unfortunately, the commit[*] that added them provided no documentation
>>> whatsover.
>>>
>>> In my scenario, I was specifically wondering about what does
>>> "io-reserve" mean, in what context to use it, etc.  (But documentation
>>> about other properties is also welcome.)
>>>
>>> Anyone more well-versed in this area care to shed some light?
>>>
>>>
>>> [*] 6755e618d0 (hw/pci: add PCI resource reserve capability to legacy
>>>      PCI bridge, 2018-08-21)
>> So normally bios would reserve just enough io space to satisfy all
>> devices behind a bridge. What if you intend to hotplug more devices?
>> These properties allow you to ask bios to reserve extra space.
> Is it fair to say that setting io-reserve=0 for a pcie-root-port
> would be a way to implement the requirements set forth in
>
>    https://bugzilla.redhat.com/show_bug.cgi?id=1408810
>
> ? I tested this on aarch64 and it seems to work as expected, but
> then again without documentation it's hard to tell.
>
> More specifically, I created an aarch64/virt guest with several
> pcie-root-ports and it couldn't boot much further than GRUB when
> the number of ports exceeded 24, but as soon as I added the
> io-reserve=0 option I could get the same guest to boot fine with
> 32 or even 64 pcie-root-ports. I'm attaching the boot log for
> reference: there are a bunch of messages about the topic but they
> would appear to be benign.
>
> Hotplug seemed to work too: I tried with a single virtio-net-pci
> and I could access the network. My understanding is that PCIe
> devices are required to work without IO space, so this behavior
> matches my expectations.
>
> I wonder, though, what would happen if I had something like
>
>    -device pcie-root-port,io-reserve=0,id=pci.1
>    -device pcie-pci-bridge,bus=pci.1
>
> Would I be able to hotplug conventional PCI devices into the
> pcie-pci-bridge, or would the lack of IO space reservation for
> the pcie-root-port cause issues with that?
>

You would not have any IO space for a PCI device or PCIe device
that for some reason will require IO space (even if they shouldn't)
and the hotplug operation would fail.

On the other hand, if the pcie-pci-bridge device itself will require
some IO space, it will work.. it worth trying.

Thanks,
Marcel






