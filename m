Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d88v9-0000aF-UT
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d88v6-0005ZC-Qr
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d88v6-0005YS-KW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:27:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49HNUAD109280
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 13:27:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2abd21puuw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:27:31 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 9 May 2017 18:27:29 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-10-pasic@linux.vnet.ibm.com>
	<20170508172757.GI2120@work-vm>
	<f0c6584a-1cd9-9aca-8eee-ef5cac26c613@linux.vnet.ibm.com>
	<20170508183718.GL2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 19:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170508183718.GL2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <f5907f9a-a004-f24f-edce-7e049cc14187@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] s390x/css: turn on channel subsystem
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/08/2017 08:37 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 05/08/2017 07:27 PM, Dr. David Alan Gilbert wrote:
>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>>> Turn on migration for the channel subsystem and the new scheme for
>>>> migrating virtio-ccw proxy devices (instead of letting the transport
>>>> independent child device migrate it's proxy, use the usual
>>>> DeviceClass.vmsd mechanism) for future machine versions.
>>
>> [..]
>>
>>>> @@ -1365,6 +1373,11 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>>>>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
>>>>  
>>>>  
>>>> +    /* Avoid generating unknown section for legacy migration target. */
>>>> +    if (!css_migration_enabled()) {
>>>> +        DEVICE_GET_CLASS(ccw_dev)->vmsd = NULL;
>>>> +    }
>>>> +
>>>
>>> That's a very odd thing to do; can't you use a .needed at the
>>> top level of the vmstate_virtio_ccw_dev to avoid having to
>>> set it to NULL like this?
>>>
>>
>> I agree it's odd. As far as I remember I can't use .needed but
>> I will double check.
> 
> You can have top level .needed's - both vmstate_globalstate in
> migration.c and colo's colo_state use them.
> 

Works like charm. I'm really happy to get rid of this ugly hunk.  Thanks
a lot! 

I was probably confused by the fact that I want to use the same vmsd with
vmstate_save_state when the needed is false. That works, but I have probably 
blindly assumed (back then) it does not. Of course it does make sense to
ignore .needed in that function, because for a vmsd coming from a
recursive call while processing a filed then the non-presence of a field
should be indicated by field_exists.

I wonder if adding a comment at the definition site would be helpful.
Something like:


 struct VMStateDescription {
....
     void (*pre_save)(void *opaque);
+    /* Controls the existence of sections and subsections, but not fields. */
     bool (*needed)(void *opaque);
     VMStateField *fields;
     const VMStateDescription **subsections;
 };

Halil

> Dave
> 
>> Many thanks for your review!
>>
>> Halil
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
