Received: from eggs.gnu.org ([2001:4830:134:3::10]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVdl9-0005Yq-KW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVdl3-0004ou-Tv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:02:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60109
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVdl3-0004oI-Ok
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:02:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DCwkQ8116265
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:02:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3s794x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:02:15 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 09:02:15 -0400
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 15:02:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170713142721.3a40e083@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
Message-Id: <606fdb06-cb0e-00b3-ffa3-18a024f14309@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/s390-next 3/3] s390x/flic: migrate ais
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On 07/13/2017 02:27 PM, Cornelia Huck wrote:
> On Thu, 13 Jul 2017 12:40:29 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>
>> During migration we should transfer ais states to the target guest.
>> This patch introduces a subsection to kvm_s390_flic_vmstate and new
>> vmsd for qemu_flic. The ais states need to be migrated only when
>> ais is supported.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/intc/s390_flic.c          | 20 ++++++++++++
>>  hw/intc/s390_flic_kvm.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/s390_flic.h |  1 +
>>  3 files changed, 96 insertions(+)
>>
> 
>> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
>> index d93503f..4cf73ee 100644
>> --- a/hw/intc/s390_flic_kvm.c
>> +++ b/hw/intc/s390_flic_kvm.c
>> @@ -413,7 +413,78 @@ out:
>>      return r;
>>  }
>>  
>> +typedef struct KVMS390FLICStateMigTmp {
>> +    KVMS390FLICState *parent;
>> +    uint8_t simm;
>> +    uint8_t nimm;
>> +} KVMS390FLICStateMigTmp;
>> +
>> +static void kvm_flic_ais_pre_save(void *opaque)
>> +{
>> +    KVMS390FLICStateMigTmp *tmp = opaque;
>> +    KVMS390FLICState *flic = tmp->parent;
>> +    struct kvm_s390_ais_all ais;
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_DEV_FLIC_AISM_ALL,
>> +        .addr = (uint64_t)&ais,
>> +        .attr = sizeof(ais),
>> +    };
>> +
>> +    if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
>> +        error_report("Failed to retrieve kvm flic ais states");
> 
> There's not much else we can do in that case, is there?
> 
>> +        return;
>> +    }
>> +
>> +    tmp->simm = ais.simm;
>> +    tmp->nimm = ais.nimm;
>> +}
>> +
>> +static int kvm_flic_ais_post_load(void *opaque, int version_id)
>> +{
>> +    KVMS390FLICStateMigTmp *tmp = opaque;
>> +    KVMS390FLICState *flic = tmp->parent;
>> +    struct kvm_s390_ais_all ais = {
>> +        .simm = tmp->simm,
>> +        .nimm = tmp->nimm,
>> +    };
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_DEV_FLIC_AISM_ALL,
>> +        .addr = (uint64_t)&ais,
>> +    };
>> +
>> +    if (!ais_needed(flic)) {
>> +        return -ENOSYS;
>> +    }
> 
> I do not understand this... does that mean that
> - we should never get here or 
> - we should not try to change the fields or
> - I need coffee?

My understanding is that this should not happen with a normal setup, 
but it can happen if the user does something "wrong". For example
use qemu without libvirt and with -cpu host (which is not migration safe)
and do a migration from a host that has AIS to a host that has no AIS.
In that case the target system will reject the migration (late, but hopefully
not too late).
