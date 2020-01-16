Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0699BC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44E32087E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmZZEe7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4Fd-0007Ik-Uw
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is4Eo-0006fJ-Oe
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is4El-0002MD-GR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:27:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is4El-0002Lz-C0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579177618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hoJ6cAvgWe/GOPmoU4dvaFYnBK3qXH2Bmi55JBpGKQg=;
 b=TmZZEe7WxbSqf3cz0pSfONnCRhUYsckamUJAaoURI/IqNB6dKK37g0jmEPW8baKSeNw2hq
 AVfRaEjQsp4tBJkLpo9UBalpLhxQJV9HjFeiZzRPdvnG5O9EPAQGAhPYwIBhHEI8FRoIT6
 rZDD0w+jl0uoJKTAtIcjGBc8O3FUAYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-g_nM43bINpSoX3fcBv3_8Q-1; Thu, 16 Jan 2020 07:26:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5E3195AD20;
 Thu, 16 Jan 2020 12:26:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D2B960C63;
 Thu, 16 Jan 2020 12:26:49 +0000 (UTC)
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption suppression
 again
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200116122026.5804-1-thuth@redhat.com>
 <7c5da42a-2de0-d9e6-f838-f2b0757cbcaa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6d489327-b37d-73ae-6706-03f1e4c6b495@redhat.com>
Date: Thu, 16 Jan 2020 13:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7c5da42a-2de0-d9e6-f838-f2b0757cbcaa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: g_nM43bINpSoX3fcBv3_8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/2020 13.23, David Hildenbrand wrote:
> On 16.01.20 13:20, Thomas Huth wrote:
>> The AIS feature has been disabled late in the v2.10 development
>> cycle since there were some issues with migration (see commit
>> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
>> facility"). We originally wanted to enable it again for newer
>> machine types, but apparently we forgot to do this so far. Let's
>> do it for the new s390-ccw-virtio-5.0 machine now.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c         |  4 ++++
>>  include/hw/s390x/s390-virtio-ccw.h |  4 ++++
>>  target/s390x/kvm.c                 | 11 ++++++++---
>>  3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index e7eadd14e8..6f43136396 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -456,6 +456,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>      s390mc->cpu_model_allowed = true;
>>      s390mc->css_migration_enabled = true;
>>      s390mc->hpage_1m_allowed = true;
>> +    s390mc->kvm_ais_allowed = true;
>>      mc->init = ccw_init;
>>      mc->reset = s390_machine_reset;
>>      mc->hot_add_cpu = s390_hot_add_cpu;
>> @@ -662,6 +663,9 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>>  
>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>  {
>> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>> +
>> +    s390mc->kvm_ais_allowed = false;
>>      ccw_machine_5_0_class_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>>  }
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 8aa27199c9..f142d379c6 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -21,6 +21,9 @@
>>  #define S390_MACHINE_CLASS(klass) \
>>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
>>  
>> +#define S390_CCW_MACHINE_OBJ_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(S390CcwMachineClass, obj, TYPE_S390_CCW_MACHINE)
>> +
>>  typedef struct S390CcwMachineState {
>>      /*< private >*/
>>      MachineState parent_obj;
>> @@ -40,6 +43,7 @@ typedef struct S390CcwMachineClass {
>>      bool cpu_model_allowed;
>>      bool css_migration_enabled;
>>      bool hpage_1m_allowed;
>> +    bool kvm_ais_allowed;
>>  } S390CcwMachineClass;
>>  
>>  /* runtime-instrumentation allowed by the machine */
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 15260aeb9a..4c1c8c0208 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -329,6 +329,8 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>>  
>>  int kvm_arch_init(MachineState *ms, KVMState *s)
>>  {
>> +    S390CcwMachineClass *smc = S390_CCW_MACHINE_OBJ_GET_CLASS(ms);
>> +
>>      object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>>                           false, NULL);
>>  
>> @@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      /*
>>       * The migration interface for ais was introduced with kernel 4.13
>>       * but the capability itself had been active since 4.12. As migration
>> -     * support is considered necessary let's disable ais in the 2.10
>> -     * machine.
>> +     * support is considered necessary we only enable this for newer
>> +     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.
>>       */
>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>> +    if (smc->kvm_ais_allowed &&
>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> +    }
>>  
>>      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>>      return 0;
>>
> 
> We have ri_allowed(), cpu_model_allowed(), hpage_1m_allowed().
> 
> Care to create a similar wrapper?

Honestly, why do we need these wrappers at all? They look cumbersome to
me. I'd rather remove them in case they are not urgently needed (so far
I don't see the point... could someone enlighten me why we have them?).

 Thomas


