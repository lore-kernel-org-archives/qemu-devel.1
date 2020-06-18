Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB6320FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbmkAl7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB6320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpwQ-0004x3-NQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpvW-00045j-Gw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:29:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpvU-0000kR-8t
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592468975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mqdASZUMOxijmMJLZGcrgpTDF/O/rzkJ6tZ7a9HNl8=;
 b=dbmkAl7KjhgG8pPX4wcgQFN97dTCPRYjrxpxQx4I2oGXQ4+i3AW/cVzUMAozAMk/GQNM28
 mtNjJBsG09oTgXhYCAiuy2Jbcsp4/+84wfpHqtGml4qzWn7MM5JZMCb4LR1ONz+x6MdKeK
 CR5A8MbC/4d3lF6nQ7LUIxnVfqXhwLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-yRxaWl5QNN-2MJuEBfR3IQ-1; Thu, 18 Jun 2020 04:29:30 -0400
X-MC-Unique: yRxaWl5QNN-2MJuEBfR3IQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6904E1005512;
 Thu, 18 Jun 2020 08:29:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 008687CAA8;
 Thu, 18 Jun 2020 08:29:26 +0000 (UTC)
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Eduardo Habkost <ehabkost@redhat.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm>
 <37e7bbbe-6792-fdaa-0046-fb8bc5b64546@redhat.com>
 <74a52916-af58-6dee-f0e0-deb2954ddd90@redhat.com>
 <20200617170242.GF2366737@habkost.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a6f1830c-c907-edc6-ee29-de6fd2442fdb@redhat.com>
Date: Thu, 18 Jun 2020 10:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200617170242.GF2366737@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------5821DBB621D8EE6C93534804"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Dann Frazier <dann.frazier@canonical.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5821DBB621D8EE6C93534804
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 06/17/20 19:02, Eduardo Habkost wrote:
> On Wed, Jun 17, 2020 at 06:43:20PM +0200, Laszlo Ersek wrote:
>> On 06/17/20 18:14, Laszlo Ersek wrote:

>>> Consider assigning a single device with a 32G BAR -- right now that's
>>> supposed to work, without the X-PciMmio64Mb OVMF knob, on even the "most
>>> basic" hardware (36-bit host phys address width, and EPT supported). If
>>> OVMF suddenly starts trusting the CPUID from QEMU, and that results in a
>>> GPA width of 40 bits (i.e. new OVMF is run on old QEMU), then the big
>>> BAR (and other stuff too) could be allocated from GPA space that EPT is
>>> actually able to deal with. --> regression for the user.
>>
>> s/able/unable/, sigh. :/
> 
> I was confused for a while, thanks for the clarification.  :)

Sorry again -- looks like yesterday was already Friday for me...

> So, I'm trying to write down which additional guarantees we want
> to give to guests, exactly.  I don't want the documentation to
> reference "host physical address bits", but actual behavior we
> don't emulate.
> 
> What does "unable to deal with" means in this specific case?  I
> remember MAXPHYADDR mismatches make EPT treatment of of reserved
> bits not be what guests would expect from bare metal, but can
> somebody point out to the specific guest-visible VCPU behavior
> that would cause a regression in OVMF?  Bonus points if anybody
> can find the exact Intel SDM paragraph we fail to implement.

When I first encountered the problem, it wasn't actually related to
64-bit PCI MMIO -- it was much earlier, namely when I worked on enabling
64GiB+ *RAM size* in OVMF. Things fell apart just from the guest memory
side of things. The 64-bit PCI MMIO concern is an extrapolation from
that, not a symptom encountered in practice.

Let me find my original message about the RAM symptom...

... Meh, I can find two discussions related to this, in my personal
archives. One is on one of our internal RH mailing lists, so I'm not
going to quote that here. The other is on the public edk2-devel mailing
list -- but from June 2015, when edk2-devel was still hosted on
sourceforge.net. The sourceforge.net archives are no longer accessible,
and GMANE (the secondary archive) is dead too.

So I'm going to have to attach the one message from the thread that I
feel contains the most information. Start reading at the string "BUG:".

Thanks,
Laszlo

--------------5821DBB621D8EE6C93534804
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Attached Message"

Return-Path: edk2-devel-bounces@lists.sourceforge.net
Received: from zmta06.collab.prod.int.phx2.redhat.com (LHLO
 zmta06.collab.prod.int.phx2.redhat.com) (10.5.81.13) by
 zmail17.collab.prod.int.phx2.redhat.com with LMTP; Wed, 10 Jun 2015
 09:08:00 -0400 (EDT)
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by zmta06.collab.prod.int.phx2.redhat.com (Postfix) with ESMTP id 8F311168D50;
	Wed, 10 Jun 2015 09:08:00 -0400 (EDT)
Received: from mx1.redhat.com (ext-mx01.extmail.prod.ext.phx2.redhat.com [10.5.110.25])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5AD80hd023153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 10 Jun 2015 09:08:00 -0400
Received: from lists.sourceforge.net (lists.sourceforge.net [216.34.181.88])
	by mx1.redhat.com (Postfix) with ESMTPS id A57E9B8BAC;
	Wed, 10 Jun 2015 13:07:58 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=sfs-ml-1.v29.ch3.sourceforge.com)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <edk2-devel-bounces@lists.sourceforge.net>)
	id 1Z2ff5-0001pG-4P; Wed, 10 Jun 2015 13:03:19 +0000
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lersek@redhat.com>) id 1Z2ff3-0001p5-96
	for edk2-devel@lists.sourceforge.net; Wed, 10 Jun 2015 13:03:17 +0000
Received-SPF: pass (sog-mx-4.v43.ch3.sourceforge.com: domain of redhat.com
	designates 209.132.183.28 as permitted sender)
	client-ip=209.132.183.28; envelope-from=lersek@redhat.com;
	helo=mx1.redhat.com;
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2ff2-0006ys-2h
	for edk2-devel@lists.sourceforge.net; Wed, 10 Jun 2015 13:03:17 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 670B536B1B6;
	Wed, 10 Jun 2015 13:03:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-80.ams2.redhat.com
	[10.36.116.80])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t5AD362h027350; Wed, 10 Jun 2015 09:03:07 -0400
Message-ID: <55783589.2050904@redhat.com>
Date: Wed, 10 Jun 2015 15:03:05 +0200
From: Laszlo Ersek <lersek@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Maoming <maoming.maoming@huawei.com>
References: <1433800011-2113-1-git-send-email-lersek@redhat.com>
	<1433800011-2113-5-git-send-email-lersek@redhat.com>
	<55764C2C.3050103@redhat.com>
In-Reply-To: <55764C2C.3050103@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-1.5 SPF_CHECK_PASS SPF reports sender host as permitted sender for
	sender-domain
	-0.0 SPF_HELO_PASS          SPF: HELO matches SPF record
	-0.0 T_RP_MATCHES_RCVD Envelope sender domain matches handover relay
	domain
	-0.0 SPF_PASS               SPF: sender matches SPF record
	0.0 AWL AWL: Adjusted score from AWL reputation of From: address
X-Headers-End: 1Z2ff2-0006ys-2h
Cc: Paolo Bonzini <pbonzini@redhat.com>, edk2-devel@lists.sourceforge.net,
        "Huangpeng \(Peter\)" <peter.huangpeng@huawei.com>
Subject: Re: [edk2] [RFC 4/4] OvmfPkg: PlatformPei: invert MTRR setup in
	QemuInitializeRam()
X-BeenThere: edk2-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
Reply-To: edk2-devel@lists.sourceforge.net
List-Id: <edk2-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/edk2-devel>,
	<mailto:edk2-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=edk2-devel>
List-Post: <mailto:edk2-devel@lists.sourceforge.net>
List-Help: <mailto:edk2-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/edk2-devel>,
	<mailto:edk2-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: edk2-devel-bounces@lists.sourceforge.net
X-RedHat-Spam-Score: -7.33  (BAYES_00,DCC_REPUT_00_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD,URIBL_BLOCKED) 216.34.181.88 lists.sourceforge.net 216.34.181.88 lists.sourceforge.net <edk2-devel-bounces@lists.sourceforge.net>
X-Scanned-By: MIMEDefang 2.75 on 10.5.110.25
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/15 04:15, Laszlo Ersek wrote:
> On 06/08/15 23:46, Laszlo Ersek wrote:
>> At the moment we work with a UC default MTRR type, and set three memory
>> ranges to WB:
>> - [0, 640 KB),
>> - [1 MB, LowerMemorySize),
>> - [4 GB, 4 GB + UpperMemorySize).
>>
>> Unfortunately, coverage for the third range can fail with a high
>> likelihood. If the alignment of the base (ie. 4 GB) and the alignment of
>> the size (UpperMemorySize) differ, then MtrrLib creates a series of
>> variable MTRR entries, with power-of-two sized MTRR masks. And, it's
>> really easy to run out of variable MTRR entries, dependent on the
>> alignment difference.
>>
>> This is a problem because a Linux guest will loudly reject any high memory
>> that is not covered my MTRR.
>>
>> So, let's follow the inverse pattern (loosely inspired by SeaBIOS):
>> - flip the MTRR default type to WB,
>> - set [0, 640 KB) to WB -- fixed MTRRs have precedence over the default
>>   type and variable MTRRs, so we can't avoid this,
>> - set [640 KB, 1 MB) to UC -- implemented with fixed MTRRs,
>> - set [LowerMemorySize, 4 GB) to UC -- should succeed with variable MTRRs
>>   more likely than the other scheme (due to less chaotic alignment
>>   differences).
>>
>> Effects of this patch can be observed by setting DEBUG_CACHE (0x00200000)
>> in PcdDebugPrintErrorLevel.
>>
>> BUG: Although the MTRRs look good to me in the OVMF debug log, I still
>> can't boot >= 64 GB guests with this. Instead of the complaints mentioned
>> above, the Linux guest apparently spirals into an infinite loop (on KVM),
>> or hangs with no CPU load (on TCG).
> 
> No, actually there is no bug in this patch (so s/RFC/PATCH/). I did more
> testing and these are the findings:
> - I can reproduce the same issue on KVM with SeaBIOS guests.
> - The exact symptoms are that as soon as the highest guest-phys address
>   is >= 64 GB, then the guest kernel doesn't boot. It gets stuck
>   somewhere after hitting Enter in grub.
> - Normally 3 GB of the guest RAM is mapped under 4 GB in guest-phys
>   address space, then there's a 1 GB PCI hole, and the rest is above
>   4 GB. This means that a 63 GB guest can be started (because 63 - 3 + 4
>   == 64), but if you add just 1 MB more, it won't boot.
> - (This was the big discovery:) I flipped the "ept" parameter of the
>   kvm_intel module on my host to N, and then things started to work. I
>   just booted a 128 GB Linux guest with this patchset. (I have 4 GB
>   RAM in my host, plus approx 250 GB swap.) The guest could see it all.
> - The TCG boot didn't hang either; I just couldn't wait earlier for
>   network initialization to complete.
> 
> I'm CC'ing Paolo for help with the EPT question. Other than that, this
> series is functional. (For QEMU/KVM at least; Xen will likely need more
> fixes from others.)

We have a root cause, it seems. The issue is that the processor in my
laptop, on which I tested, has only 36 bits for physical addresses:

  $ grep 'address sizes' /proc/cpuinfo
  address sizes   : 36 bits physical, 48 bits virtual
  ...

Which matches where the problem surfaces (64 GB guest-phys address
space) with hw-supported nested paging (EPT) enabled on the host.

In order to confirm this, a colleague of mine gave me access to a server
with 96 GB of RAM, and:

  address sizes	: 46 bits physical, 48 bits virtual

On this host I booted a 72 GB OVMF guest on QEMU/KVM, with EPT enabled,
and according to the guest dmesg, the guest saw it all.

  Memory: 74160924K/75493820K available (7735K kernel code, 1149K
  rwdata, 3340K rodata, 1500K init, 1524K bss, 1332896K reserved, 0K
  cma-reserved)

Maoming: since you reported this issue, please confirm that the patch
series resolves it for you as well. In that case, I'll repost the series
with "PATCH" as subject-prefix instead of "RFC", and I'll drop the BUG
note from the last commit message.

Thanks
Laszlo

>> Cc: Maoming <maoming.maoming@huawei.com>
>> Cc: Huangpeng (Peter) <peter.huangpeng@huawei.com>
>> Cc: Wei Liu <wei.liu2@citrix.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  OvmfPkg/PlatformPei/MemDetect.c | 43 +++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/OvmfPkg/PlatformPei/MemDetect.c b/OvmfPkg/PlatformPei/MemDetect.c
>> index 3ceb142..cceab22 100644
>> --- a/OvmfPkg/PlatformPei/MemDetect.c
>> +++ b/OvmfPkg/PlatformPei/MemDetect.c
>> @@ -194,6 +194,8 @@ QemuInitializeRam (
>>  {
>>    UINT64                      LowerMemorySize;
>>    UINT64                      UpperMemorySize;
>> +  MTRR_SETTINGS               MtrrSettings;
>> +  EFI_STATUS                  Status;
>>  
>>    DEBUG ((EFI_D_INFO, "%a called\n", __FUNCTION__));
>>  
>> @@ -214,12 +216,45 @@ QemuInitializeRam (
>>      }
>>    }
>>  
>> -  MtrrSetMemoryAttribute (BASE_1MB, LowerMemorySize - BASE_1MB, CacheWriteBack);
>> +  //
>> +  // We'd like to keep the following ranges uncached:
>> +  // - [640 KB, 1 MB)
>> +  // - [LowerMemorySize, 4 GB)
>> +  //
>> +  // Everything else should be WB. Unfortunately, programming the inverse (ie.
>> +  // keeping the default UC, and configuring the complement set of the above as
>> +  // WB) is not reliable in general, because the end of the upper RAM can have
>> +  // practically any alignment, and we may not have enough variable MTRRs to
>> +  // cover it exactly.
>> +  //
>> +  if (IsMtrrSupported ()) {
>> +    MtrrGetAllMtrrs (&MtrrSettings);
>>  
>> -  MtrrSetMemoryAttribute (0, BASE_512KB + BASE_128KB, CacheWriteBack);
>> +    //
>> +    // MTRRs disabled, fixed MTRRs disabled, default type is uncached
>> +    //
>> +    ASSERT ((MtrrSettings.MtrrDefType & BIT11) == 0);
>> +    ASSERT ((MtrrSettings.MtrrDefType & BIT10) == 0);
>> +    ASSERT ((MtrrSettings.MtrrDefType & 0xFF) == 0);
>>  
>> -  if (UpperMemorySize != 0) {
>> -    MtrrSetMemoryAttribute (BASE_4GB, UpperMemorySize, CacheWriteBack);
>> +    //
>> +    // flip default type to writeback
>> +    //
>> +    SetMem (&MtrrSettings.Fixed, sizeof MtrrSettings.Fixed, 0x06);
>> +    ZeroMem (&MtrrSettings.Variables, sizeof MtrrSettings.Variables);
>> +    MtrrSettings.MtrrDefType |= BIT11 | BIT10 | 6;
>> +    MtrrSetAllMtrrs (&MtrrSettings);
>> +
>> +    //
>> +    // punch holes
>> +    //
>> +    Status = MtrrSetMemoryAttribute (BASE_512KB + BASE_128KB,
>> +               SIZE_256KB + SIZE_128KB, CacheUncacheable);
>> +    ASSERT_EFI_ERROR (Status);
>> +
>> +    Status = MtrrSetMemoryAttribute (LowerMemorySize,
>> +               SIZE_4GB - LowerMemorySize, CacheUncacheable);
>> +    ASSERT_EFI_ERROR (Status);
>>    }
>>  }
>>  
>>
> 


------------------------------------------------------------------------------
_______________________________________________
edk2-devel mailing list
edk2-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/edk2-devel

--------------5821DBB621D8EE6C93534804--


