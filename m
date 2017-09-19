Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duIbx-0004Up-GB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duIbr-00013c-Hs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duIbr-00012w-Cz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:30:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDUEqd047965
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:30:41 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3130kntt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:30:39 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 14:30:31 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-4-pasic@linux.vnet.ibm.com>
	<20170919033730.GD5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919110631.59039743.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 15:30:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170919110631.59039743.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <6a51f84b-9185-ec5c-b0ec-1fc21fbfb201@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/19/2017 11:06 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 11:37:30 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:28 +0200]:
>>
>>> Replace direct access which implicitly assumes no IDA
>>> or MIDA with the new ccw data stream interface which should
>>> cope with these transparently in the future.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>
>>> ---
>>>
>>> v1 --> v2:
>>> Removed todo comments on possible errno change as with
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02441.html
>>> applied it does not matter any more.
>>>
>>> Error handling: At the moment we ignore errors reported
>>> by stream ops to keep the change minimal. An add-on
>>> patch improving on this is to be expected later.  
>> Add a TODO somewhere around the code as a reminder?
> 
> I expect Halil to have it on his TODO list and send a patch later ;)
> 
>>
>>> ---
>>>  hw/s390x/virtio-ccw.c | 156 +++++++++++++++-----------------------------------
>>>  1 file changed, 46 insertions(+), 110 deletions(-)
>>>
>>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>>> index b1976fdd19..a9baf6f7ab 100644
>>> --- a/hw/s390x/virtio-ccw.c
>>> +++ b/hw/s390x/virtio-ccw.c  
>> [...]
>>
>>> @@ -394,11 +362,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>          } else {
>>>              VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>
>>> -            features.index = address_space_ldub(&address_space_memory,
>>> -                                                ccw.cda
>>> -                                                + sizeof(features.features),
>>> -                                                MEMTXATTRS_UNSPECIFIED,
>>> -                                                NULL);
>>> +            ccw_dstream_advance(&sch->cds, sizeof(features.features));  
>> How about:
>> ccw_dstream_advance(&sch->cds, offsetof(VirtioFeatDesc, index));
> 
> I think keeping sizeof(features.features) is better: It matches the old
> code, and we really do jump over the features flag and revisit it
> later...
> 
>>
>>> +            ccw_dstream_read(&sch->cds, features.index);
>>>              if (features.index == 0) {
>>>                  if (dev->revision >= 1) {
>>>                      /* Don't offer legacy features for modern devices. */
>>> @@ -417,9 +382,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>                  /* Return zeroes if the guest supports more feature bits. */
>>>                  features.features = 0;
>>>              }
>>> -            address_space_stl_le(&address_space_memory, ccw.cda,
>>> -                                 features.features, MEMTXATTRS_UNSPECIFIED,
>>> -                                 NULL);
>>> +            ccw_dstream_rewind(&sch->cds);
>>> +            cpu_to_le32s(&features.features);
>>> +            ccw_dstream_write(&sch->cds, features.features);
>>>              sch->curr_status.scsw.count = ccw.count - sizeof(features);  
>> How about:
>> sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
> 
> Hm, I thought I had commented on this, but I seem to have missed
> these...
> 
> I'd prefer to do it as a follow-up patch.
> 
>>
>> This also applies to other places.
>>
>>>              ret = 0;
>>>          }  
>> [...]
>>
>>> @@ -501,21 +459,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>              }
>>>          }
>>>          len = MIN(ccw.count, vdev->config_len);
>>> -        hw_len = len;
>>>          if (!ccw.cda) {
>>>              ret = -EFAULT;
>>>          } else {
>>> -            config = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
>>> -            if (!config) {
>>> -                ret = -EFAULT;
>>> -            } else {
>>> -                len = hw_len;
>>> -                /* XXX config space endianness */
>>> -                memcpy(vdev->config, config, len);
>>> -                cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
>>> +            ret = ccw_dstream_read_buf(&sch->cds, vdev->config, len);
>>> +            if (!ret) {  
>> Add a TODO here, and:
>>
>> if (ccw_dstream_read_buf(&sch->cds, vdev->config, len)) {
>>     ret = -EFAULT;
>> } else {
>>     ....
>> }
> 
> I don't think that would be correct: The function will (at least
> currently) return 0 or -EINVAL, and you are now mapping any error to
> -EFAULT? (Not that it has an effect in the end: We map both to a
> channel program check as of "s390x/css: drop data-check in
> interpretation".)
> 
>>
>>>                  virtio_bus_set_vdev_config(&dev->bus, vdev->config);
>>>                  sch->curr_status.scsw.count = ccw.count - len;
>>> -                ret = 0;
>>>              }
>>>          }
>>>          break;  
>> [...]
>>
>>> @@ -714,13 +654,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>              ret = -EFAULT;
>>>              break;
>>>          }
>>> -        revinfo.revision =
>>> -            address_space_lduw_be(&address_space_memory, ccw.cda,
>>> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
>>> -        revinfo.length =
>>> -            address_space_lduw_be(&address_space_memory,
>>> -                                  ccw.cda + sizeof(revinfo.revision),
>>> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
>>> +        ccw_dstream_read_buf(&sch->cds, &revinfo, 4);  
>>                                                      ^
>> A magic number? O:)
> 
> Hah :)
> 
> We can't use sizeof(revinfo), and sizeof(revinfo.revision) +
> sizeof(revinfo.length) is a bit unwieldy. Let's keep some magic in our
> code :)
> 
>>
>>> +        be16_to_cpus(&revinfo.revision);
>>> +        be16_to_cpus(&revinfo.length);
>>>          if (ccw.count < len + revinfo.length ||
>>>              (check_len && ccw.count > len + revinfo.length)) {
>>>              ret = -EINVAL;
>>> -- 
>>> 2.13.5
>>>   
>>
>> Otherwise, looks good.
>>
> 
> Can I get an ack?
> 

I agree that further cleanups are possible (e.g. using
ccw_dstream_residual_count() and tightening error handling) but
I also prefer to see these as on-top, and prefer sticking to
change as little as possible in the transformation patch and stay
as close as possible to what we had before in terms of behavior).

Regards,
Halil 
