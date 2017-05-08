Received: from eggs.gnu.org ([2001:4830:134:3::10]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7n0U-0008SQ-CY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7n0L-0004hy-Ka
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:03:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d7n0L-0004ht-EN
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:03:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48HnGuc040163
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 14:03:28 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aap5gvuye-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 14:03:28 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:03:26 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-10-pasic@linux.vnet.ibm.com>
	<20170508172757.GI2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 8 May 2017 20:03:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170508172757.GI2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <f0c6584a-1cd9-9aca-8eee-ef5cac26c613@linux.vnet.ibm.com>
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



On 05/08/2017 07:27 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Turn on migration for the channel subsystem and the new scheme for
>> migrating virtio-ccw proxy devices (instead of letting the transport
>> independent child device migrate it's proxy, use the usual
>> DeviceClass.vmsd mechanism) for future machine versions.

[..]

>> +void css_register_vmstate(void)
>> +{
>> +    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
>> +}
>> +
> 
> Why isn't that attached to a device vmsd? 

Because there is no device. The channel subsystem is not modeled 
as a QEMU device but it does have state which needs to be
migrated.

[..]

>> @@ -1365,6 +1373,11 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
>>  
>>  
>> +    /* Avoid generating unknown section for legacy migration target. */
>> +    if (!css_migration_enabled()) {
>> +        DEVICE_GET_CLASS(ccw_dev)->vmsd = NULL;
>> +    }
>> +
> 
> That's a very odd thing to do; can't you use a .needed at the
> top level of the vmstate_virtio_ccw_dev to avoid having to
> set it to NULL like this?
> 

I agree it's odd. As far as I remember I can't use .needed but
I will double check.

Many thanks for your review!

Halil
