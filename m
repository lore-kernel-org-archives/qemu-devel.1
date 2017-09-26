Received: from eggs.gnu.org ([2001:4830:134:3::10]:57501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwqVw-0006Ds-3h
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwqVr-0006sg-Qb
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:07:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwqVr-0006sT-HZ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:07:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QE5d6U103357
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:06:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7pd71nsj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:06:57 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 15:06:55 +0100
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-2-borntraeger@de.ibm.com>
	<6f4a490e-96bc-58b5-c561-4491f175e2e4@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 16:06:51 +0200
MIME-Version: 1.0
In-Reply-To: <6f4a490e-96bc-58b5-c561-4491f175e2e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <debb11b6-3eba-b2fe-961f-52df7b1c5926@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>



On 09/26/2017 03:43 PM, David Hildenbrand wrote:
> 
>> +    /* try enable the AIS facility */
>> +    test_attr.group = KVM_DEV_FLIC_AISM_ALL;
>> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
>> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
>> +    }
>> +
>>      return;
>>  fail:
>>      error_propagate(errp, errp_local);
>> @@ -578,7 +584,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
>>  
>>      flic_disable_wait_pfault(flic);
>>  
>> -    if (fs->ais_supported) {
>> +    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
> 
> I don't remember if a reset is trigger on realization. Most probably
> not, but it could be.
> 
> Would it hurt if the following code would not get called if the flic
> hasn't been used yet? (possible reset before cpu model has been
> initialized) - are kvm_s390_modify_ais_mode() calls required before ais
> can be used for the first time?

Hmm, simm/nimm should default to zero in the kernel I guess. So I think it would
not hurt. Yi Min, correct?


Anyway it seems that reset is NOT called during realize, the first
call is

                #0  0x00000000010e5178 kvm_s390_flic_reset (qemu-system-s390x)
                #1  0x000000000124bbc4 device_reset (qemu-system-s390x)
                #2  0x0000000001248cd0 qdev_reset_one (qemu-system-s390x)
                #3  0x0000000001249ea4 qdev_walk_children (qemu-system-s390x)
                #4  0x000000000124fd3a qbus_walk_children (qemu-system-s390x)
                #5  0x0000000001248e6c qbus_reset_all (qemu-system-s390x)
                #6  0x0000000001248eae qbus_reset_all_fn (qemu-system-s390x)
                #7  0x0000000001250a60 qemu_devices_reset (qemu-system-s390x)
                #8  0x0000000001143c80 s390_machine_reset (qemu-system-s390x)
                #9  0x00000000011c5b72 qemu_system_reset (qemu-system-s390x)
                #10 0x00000000011ceb8e main (qemu-system-s390x)
                #11 0x000003ff947a289a __libc_start_main (libc.so.6)
                #12 0x0000000001017646 _start (qemu-system-s390x)
