Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fRBnq-0000qO-Ag
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fRBnn-0000hd-5u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:27:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fRBnm-0000gy-Tq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:27:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w587P0fP005889
	for <qemu-devel@nongnu.org>; Fri, 8 Jun 2018 03:27:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jfgqksvw5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 03:27:13 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 8 Jun 2018 08:27:10 +0100
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-9-david@redhat.com>
	<20180608092545.52133d91.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 8 Jun 2018 09:27:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180608092545.52133d91.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <6a2bf8b2-5b15-d2ec-39e4-7afaf981fa3f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] s390x: local error handling in
 hotplug handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>



On 06/08/2018 09:25 AM, Cornelia Huck wrote:
> On Thu,  7 Jun 2018 18:52:18 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's introduce and use local error variables in the hotplug handler
>> functions.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 7ae5fb38dd..29ea50a177 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -434,18 +434,23 @@ static void s390_machine_reset(void)
>>  static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>>                                       DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        s390_cpu_plug(hotplug_dev, dev, errp);
>> +        s390_cpu_plug(hotplug_dev, dev, &local_err);
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>>                                                 DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        error_setg(errp, "CPU hot unplug not supported on this machine");
>> -        return;
>> +        error_setg(&local_err, "CPU hot unplug not supported on this machine");
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
> 
> Just seeing this patch by itself, it does not really make much sense.
> Even if this is a split out clean-up series, I'd prefer this to go
> together with a patch that actually adds something more to the
> plug/unplug functions.

+1. It is hard to see the "why". Maybe a better patch description could help here?
