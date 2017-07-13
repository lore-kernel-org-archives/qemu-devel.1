Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVe0i-0005Ut-NM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVe0f-00054h-Ix
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:18:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48755
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVe0f-00054N-Ci
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:18:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DDDeZk117972
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:18:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bnt3m80k8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:18:24 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 14:18:22 +0100
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 15:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170713142721.3a40e083@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1798a9f2-63f0-ab03-11ad-5513d9a90da9@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 07/13/2017 02:27 PM, Cornelia Huck wrote:
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
> There's not much else we can do in that case, is there?
> 

I think this is a very good question! The ioctl should not fail
under any circumstances, but if it does we have a problem.

Carrying on happily (what we do now) means effectively discarding
ais state. In general just discarding state ain't a good idea.

In particular it might be OK, but the patch should explain that!

Regarding what could/should we do in such a case (instead
of discarding state and carrying on happily) I don't know, so
I tend to agree with you regarding 'not much else we can do'.

Adding Dave and Juan. Maybe they can tell.

Regards,
Halil

>> +        return;
>> +    }
>> +
>> +    tmp->simm = ais.simm;
>> +    tmp->nimm = ais.nimm;
>> +}
>> +
