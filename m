Received: from eggs.gnu.org ([2001:4830:134:3::10]:32778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzg6W-0005cd-Nx
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzg6T-0002Rz-Kb
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37638
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzg6T-0002Ri-Ed
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:36:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v949ZLMM060292
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 05:36:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcpnaj5ck-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 05:36:28 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 10:36:26 +0100
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
	<20170711145441.33925-6-pasic@linux.vnet.ibm.com>
	<d3f02459-af9f-d9d4-5d63-ea2a9f104cdd@redhat.com>
	<20171004101626.61060703.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 11:36:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171004101626.61060703.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4580f147-0f8c-5d47-fcc1-01ab949d3e81@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 10/04/2017 10:16 AM, Cornelia Huck wrote:
> On Tue, 3 Oct 2017 13:58:29 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 11.07.2017 16:54, Halil Pasic wrote:
>>> Turn on migration for the channel subsystem for the next machine.  For
>>> legacy machines we still have to do things the old way.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> ---
>>>  hw/s390x/css.c             | 5 +++++
>>>  hw/s390x/s390-virtio-ccw.c | 9 ++++-----
>>>  include/hw/s390x/css.h     | 4 ++++
>>>  3 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index 20b5fbed68..b89b60751a 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -407,6 +407,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
>>>      return 0;
>>>  }
>>>  
>>> +void css_register_vmstate(void)
>>> +{
>>> +    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
>>> +}
>>> +
>>>  IndAddr *get_indicator(hwaddr ind_addr, int len)
>>>  {
>>>      IndAddr *indicator;
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 751febb87a..20e3f06519 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -206,7 +206,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>>  
>>>      s390mc->ri_allowed = true;
>>>      s390mc->cpu_model_allowed = true;
>>> -    s390mc->css_migration_enabled = false; /* TODO: set to true */
>>> +    s390mc->css_migration_enabled = true;
>>>      mc->init = ccw_init;
>>>      mc->reset = s390_machine_reset;
>>>      mc->hot_add_cpu = s390_hot_add_cpu;
>>> @@ -482,10 +482,9 @@ bool css_migration_enabled(void)
>>>  
>>>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>>>  {
>>> -    /*
>>> -     * TODO Once preparations are done register vmstate for the css if
>>> -     * css_migration_enabled().
>>> -     */
>>> +    if (css_migration_enabled()) {
>>> +        css_register_vmstate();
>>> +    }
>>>  }  
>>
>> The location for the above hunk seems to be quite unfortunate: For the
>> s390-ccw-virtio-2.11 machine, we now do not call css_register_vmstate()
>> anymore.
> 
> Hm, you're right... only setting the boolean should be done in the
> compat callbacks.

Nod.

> 
>>
>> Maybe this should rather go into ccw_init() instead?
> 
> Sounds reasonable. Halil, can you please check (and send a patch if it
> makes sense?)

Makes sense. I will send a patch today.

Halil
> 
