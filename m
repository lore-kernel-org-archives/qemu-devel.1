Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtrX8-0000Yg-8D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtrX4-0001lw-Rs
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:36:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtrX4-0001fw-Lm
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:35:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8I8YQ9H128296
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:35:57 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2990vcjn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:35:57 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 09:35:55 +0100
References: <20170915163952.32147-1-cohuck@redhat.com>
	<20170915163952.32147-2-cohuck@redhat.com>
	<987d04c6-dc24-e11b-3904-303058058c3b@de.ibm.com>
	<396c3d9d-644a-c946-3099-aba94f0571e8@de.ibm.com>
	<20170918100756.75eec02d.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 10:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170918100756.75eec02d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f2ab13df-a1d6-cd1e-bcc3-23a554f0114e@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com



On 09/18/2017 10:07 AM, Cornelia Huck wrote:
> On Mon, 18 Sep 2017 09:47:00 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 09/18/2017 09:33 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 09/15/2017 06:39 PM, Cornelia Huck wrote:  
>>>> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
>>>> registering the s390 pci host bridge conditional on presense
>>>> of the zpci facility bit. Sadly, that breaks migration from
>>>> machines that did not use the cpu model (2.7 and previous).
>>>>
>>>> Create the s390 phb for pre-cpu model machines as well.
>>>>
>>>> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  hw/s390x/s390-virtio-ccw.c | 2 ++
>>>>  target/s390x/cpu_models.c  | 3 +++
>>>>  2 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index 0471407187..907abc7a32 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -269,6 +269,8 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>>>>      }
>>>>  }
>>>>
>>>> +static S390CcwMachineClass *get_machine_class(void);
>>>> +
>>>>  static void ccw_init(MachineState *machine)
>>>>  {
>>>>      int ret;
> 
> This hunk is from the previous version and should not be in there...
> 
>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>> index c295e641e6..5169379db5 100644
>>>> --- a/target/s390x/cpu_models.c
>>>> +++ b/target/s390x/cpu_models.c
>>>> @@ -196,6 +196,9 @@ bool s390_has_feat(S390Feat feat)
>>>>              }
>>>>          }
>>>>  #endif
>>>> +        if (feat == S390_FEAT_ZPCI) {
>>>> +            return true;
>>>> +        }  
>>>
>>> Shouldnt that be depend on the machine being 2.7? I mean unless I misread 
>>> the context of this patch, you hard enable the PCI facility bit for all 
>>> machines and make all s390_has_feat(S390_FEAT_ZPCI) useless?
>>>   
>>
>> Sorry, I had to lookup again the original code. So this is inside !cpu->model. 
>> Yes makes sense then.
> 
> Yes, this is hard to figure out from the context alone.

So with an improved patch description (explain the fix better)

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
