Received: from eggs.gnu.org ([2001:4830:134:3::10]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVdFw-0000U3-Ei
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVdFs-0007PQ-Cd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:30:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVdFs-0007Nl-3E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:30:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DCT2hC032646
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:30:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3xefb6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:30:01 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 08:30:00 -0400
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-3-git-send-email-borntraeger@de.ibm.com>
	<20170713141158.32e74897@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 14:29:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170713141158.32e74897@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
Message-Id: <0d4fb206-a40d-7cac-02fe-d6b96958f04f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/s390-next 2/3] s390x/cpumodel: add zpci,
 aen and ais facilities
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

On 07/13/2017 02:11 PM, Cornelia Huck wrote:
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 78ebe83..1901153 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -302,6 +302,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>          }
>>      }
>>  
>> +    /* Try to enable AIS facility */
>> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> 
> What happens if you fail to enable it? You probably don't want to allow
> the feature bit, then?

Then this bit is off. This call will enable it in the kernel, if that fails
the kernel will return this bit as disabled.
> 
>> +
>>      qemu_mutex_init(&qemu_sigp_mutex);
>>  
>>      return 0;
> 
> Let's summarize to make sure that I'm not confused:
> 
> - Starting with zEC12 GA1, we provide zpci, aen, ais in the full model
yes

> - Starting with zEC12 GA1, we provide zpci and aen in the default model
yes. ais has to be enabled manually for z12 and z13.
The alternative is to have ais as part of the default model. This has the big
disadvantage that -cpu zEC12 and -cpu z13 will stop working for all available
distro kernels. I believe that a working -cpu z13 is more important than the
need to manually enable ais.
For the future
 - We can make ais part of the default model for a future system when that happens since
   the features for a new system will require a new host kernel anyway
 - We can also make ais part of the default model for a future machine type (e.g. 2.13)
   when we believe that the world has moved on to a newer kernel


> - In the host model, we add zpci and aen; they might be switched off
>   after applying the found model

We also get ais from the kernel, so the host model will have zpci,ais and
aen

> - Compat for 2.9 and earlier switches off zpci, aen, ais

yes 

> - We unconditionally enable the kvm part of ais

We tell the KVM code in the kernel to enable the facility bit (before the cpu
model might take it way) and if QEMU really uses ais, that the kernel does
the right thing then
> 
> I'm still not sure what's supposed to happen with new qemu + old kernel
> (no ais) + full zEC12 GA1 or later model.

We enable aen and zpci, but disable ais for that guest. In theory a guest
can drive PCI devices without AIS. This is a valid configuration since zpci
does not require ais. 
The fact that Linux requires ais to use PCI is unfortunate but that could 
be "fixed" Linux if necessary.
