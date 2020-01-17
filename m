Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05417C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BED2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI6o6rPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BED2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isP2G-0007KN-VU
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isP1c-0006mX-UF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isP1X-0000Y4-2s
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:38:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isP1W-0000X8-V3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579257521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=U8X9n06uJZY6RjTeyMV5eWA1WPy/toyNdJM2U6vh8+U=;
 b=gI6o6rPMUqfQLx6fq0N7ahpq+/c74dME8S17rsx97zjP18GQ3P7f4vMpCAtLDvVzILTij/
 dlNTTzDPS9uQgsAXiDqnCLV0fnLR2qBGLhBsDV26wC5t0oSOzh+nMhaO5Mhn9KttC6CgS+
 vddlXPSlowxxTLFyRf6HjA9DjEu/FjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-u2zTjAl2PP2QejT9_RDp9w-1; Fri, 17 Jan 2020 05:38:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCDC0DB21;
 Fri, 17 Jan 2020 10:38:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0D586CB7;
 Fri, 17 Jan 2020 10:38:32 +0000 (UTC)
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption suppression
 again
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200116122026.5804-1-thuth@redhat.com>
 <ad421fc1-8241-3c73-e597-aebb3fc8a309@linux.ibm.com>
 <20200116212601.0fcd3be6.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d59cf080-bb0c-91af-08fc-1cfd7a32663e@redhat.com>
Date: Fri, 17 Jan 2020 11:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116212601.0fcd3be6.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: u2zTjAl2PP2QejT9_RDp9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 16/01/2020 21.26, Cornelia Huck wrote:
> On Thu, 16 Jan 2020 15:19:13 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 1/16/20 7:20 AM, Thomas Huth wrote:
>>> The AIS feature has been disabled late in the v2.10 development
>>> cycle since there were some issues with migration (see commit
>>> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
>>> facility"). We originally wanted to enable it again for newer
>>> machine types, but apparently we forgot to do this so far. Let's
>>> do it for the new s390-ccw-virtio-5.0 machine now.
>>>
>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/s390x/s390-virtio-ccw.c         |  4 ++++
>>>   include/hw/s390x/s390-virtio-ccw.h |  4 ++++
>>>   target/s390x/kvm.c                 | 11 ++++++++---
>>>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> (...)
> 
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 15260aeb9a..4c1c8c0208 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -329,6 +329,8 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>>>   
>>>   int kvm_arch_init(MachineState *ms, KVMState *s)
>>>   {
>>> +    S390CcwMachineClass *smc = S390_CCW_MACHINE_OBJ_GET_CLASS(ms);
>>> +  
>>
>> I still can't run a proper test due to unavailable hw but in the 
>> meantime I tried to virsh define a libvirt guest pointed at qemu (master 
>> + this patch).  Regardless of machine type (s390-ccw-virtio-5.0 or 
>> s390-ccw-virtio-4.2) I get:
>>
>> virsh define guest.xml
>> error: Failed to define domain from /path/to/guest.xml
>> error: invalid argument: could not find capabilities for arch=s390x 
>> domaintype=kvm
>>
>> Similarly:
>>
>> virsh domcapabilities
>> error: failed to get emulator capabilities
>> error: invalid argument: unable to find any emulator to serve 's390x' 
>> architecture
>>
>> Rolling back to qemu master, the define and domcapabilities work (with 
>> no ais of course).
>>
>> So: there is some incompatibility between the way libvirt invokes qemu 
>> to detect capabilities and this code.  The above line seems to be the 
>> root problem - if I take your patch and remove 'smc' then libvirt works 
>> as expected and I can see ais in the domcapabilities.
>>
>> Looking at those wrappers David mentioned...  I suspect you need this 
>> for the 'none' machine case.  I tried a quick hack with the following:
>>
>> bool ais_allowed(void)
>> {
>>      /* for "none" machine this results in true */
>>      return get_machine_class()->kvm_ais_allowed;
>> }
>>
>> and
>>
>> if (ais_allowed() &&
>>      kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>>      kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>> }
>>
>> This works and doesn't break libvirt compatibility detection.
> 
> Oh, "none" machine fun again... I think you're on the right track, and
> we really need a wrapper.

D'oh, so this is the real reason for the wrappers ... ok, I'll respin my
patch accordingly.

Thanks a lot for the testing, Matthew!

 Thomas


