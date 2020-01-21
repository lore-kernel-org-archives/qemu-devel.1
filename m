Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B651C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97BB217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYCbM8ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97BB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvN1-00045W-5y
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itvMC-0003N5-EW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itvMB-0008Lo-30
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:22:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itvMA-0008LY-UZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579620138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3V7dMFaoRcmOUBXPFzzzFhlcGAtNf2zDD3yULqx7wAU=;
 b=fYCbM8ouf3PwupNFyefPA7uYM6TAcOjDRSzHh9IOlcQq5xidqF8ng+7XKQsoiKDVt1HvfO
 zh1VJF548OJ48dV/Jwnj0F5/xBandoMkBvlCz1feNJ2koZve4BPtmBYBk00MJ8P0J8XSYR
 svQII+4DiO52o4I572cKf0lUViVDtxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-3TInlix2Mma095X71ZgdoQ-1; Tue, 21 Jan 2020 10:22:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59AC21137847;
 Tue, 21 Jan 2020 15:22:15 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 205A41001902;
 Tue, 21 Jan 2020 15:22:10 +0000 (UTC)
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200120132441.11884-1-thuth@redhat.com>
 <20200120182747.5135fea8.cohuck@redhat.com>
 <95fa3c7d-8879-1401-6847-c5fa82a0cd3c@linux.ibm.com>
 <20200121154608.0b043233.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6eceafc9-afb5-05a7-0713-2295886f6917@redhat.com>
Date: Tue, 21 Jan 2020 16:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200121154608.0b043233.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3TInlix2Mma095X71ZgdoQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 15.46, Cornelia Huck wrote:
> On Tue, 21 Jan 2020 09:33:02 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 1/20/20 12:27 PM, Cornelia Huck wrote:
>>> On Mon, 20 Jan 2020 14:24:41 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   
>>>> The AIS feature has been disabled late in the v2.10 development cycle since
>>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>>>> to enable it again for newer machine types, but apparently we forgot to do
>>>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
>>>>
>>>> While at it, also add a more verbose comment why we need the *_allowed()
>>>> wrappers in s390-virtio-ccw.c.
>>>>
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   v3: Moved "s390mc->kvm_ais_allowed = false" to the end of the function
>>>>
>>>>   hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>>>>   include/hw/s390x/s390-virtio-ccw.h |  3 +++
>>>>   target/s390x/kvm.c                 |  9 ++++++---
>>>>   3 files changed, 26 insertions(+), 6 deletions(-)  
>>>   
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 15260aeb9a..cf4fb4f2d9 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>       /*
>>>>        * The migration interface for ais was introduced with kernel 4.13
>>>>        * but the capability itself had been active since 4.12. As migration
>>>> -     * support is considered necessary let's disable ais in the 2.10
>>>> -     * machine.
>>>> +     * support is considered necessary, we only try to enable this for
>>>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>>>>        */
>>>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>>>> +    if (kvm_ais_allowed() &&
>>>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {  
>>>
>>> Hnm, we actually need a kernel irqchip with the kvm flic to get ais to
>>> work; else we'll fail with
>>>
>>> qemu-system-s390x: Failed to inject airq with AIS supported
>>>
>>> in the kernel_irqchip=off case, as we won't have an I/O adapter
>>> registered.
>>>
>>> Adding 'kvm_kernel_irqchip_required() &&' seems to do the trick;
>>> comments?
>>>   
>>
>> In spirit, I agree with this idea.  But, a quick test shows that putting 
>> this check here results in ais=off for the 'none' machine case (libvirt 
>> capabilities detection).  I think we have to only look at 
>> kvm_kernel_irqchip_required() when working with a real machine.
> 
> Sigh, I think you're right again. We need to check for the 'none'
> machine here; but I can't think of a non-ugly way to do so...

I think it might work when using kvm_kernel_irqchip_allowed() instead of
kvm_kernel_irqchip_required() ... Matthew, could you please give it a
try with this patch on top of mine:

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -368,7 +368,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * support is considered necessary, we only try to enable this for
      * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    if (kvm_ais_allowed() &&
+    if (kvm_ais_allowed() && kvm_kernel_irqchip_allowed() &&
         kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
         kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
     }

 Thomas


