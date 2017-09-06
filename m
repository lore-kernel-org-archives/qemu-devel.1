Received: from eggs.gnu.org ([2001:4830:134:3::10]:55855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZmM-0002vx-0E
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZmI-0004ga-3b
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:50:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40721
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpZmH-0004gK-TX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:49:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86CivQt019963
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 08:49:57 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cth6x0psd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 08:49:56 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 13:49:55 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-4-pasic@linux.vnet.ibm.com>
	<20170906144221.76132052.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170906144221.76132052.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b5948d5c-cc42-5a76-061d-d65eb7b6bc7c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/06/2017 02:42 PM, Cornelia Huck wrote:
> On Tue,  5 Sep 2017 13:16:43 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Replace direct access which implicitly assumes no IDA
>> or MIDA with the new ccw data stream interface which should
>> cope with these transparently in the future.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>> ---
>>
>> Error handling: At the moment we ignore errors reported
>> by stream ops to keep the change minimal. It might make sense
>> to change this.
> 
> Do that as an add-on patch?

That was the idea.

> 
>> ---
>>  hw/s390x/virtio-ccw.c | 158 +++++++++++++++-----------------------------------
>>  1 file changed, 48 insertions(+), 110 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index b1976fdd19..72dd129a15 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -287,49 +287,19 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
>>          return -EFAULT;
>>      }
>>      if (is_legacy) {
>> -        linfo.queue = address_space_ldq_be(&address_space_memory, ccw.cda,
>> -                                           MEMTXATTRS_UNSPECIFIED, NULL);
>> -        linfo.align = address_space_ldl_be(&address_space_memory,
>> -                                           ccw.cda + sizeof(linfo.queue),
>> -                                           MEMTXATTRS_UNSPECIFIED,
>> -                                           NULL);
>> -        linfo.index = address_space_lduw_be(&address_space_memory,
>> -                                            ccw.cda + sizeof(linfo.queue)
>> -                                            + sizeof(linfo.align),
>> -                                            MEMTXATTRS_UNSPECIFIED,
>> -                                            NULL);
>> -        linfo.num = address_space_lduw_be(&address_space_memory,
>> -                                          ccw.cda + sizeof(linfo.queue)
>> -                                          + sizeof(linfo.align)
>> -                                          + sizeof(linfo.index),
>> -                                          MEMTXATTRS_UNSPECIFIED,
>> -                                          NULL);
>> +        ccw_dstream_read(&sch->cds, linfo);
>> +        be64_to_cpus(&linfo.queue);
>> +        be32_to_cpus(&linfo.align);
>> +        be16_to_cpus(&linfo.index);
>> +        be16_to_cpus(&linfo.num);
> 
> That's a very nice contraction :)

Thanks.

> 
>>          ret = virtio_ccw_set_vqs(sch, NULL, &linfo);
>>      } else {
>> -        info.desc = address_space_ldq_be(&address_space_memory, ccw.cda,
>> -                                           MEMTXATTRS_UNSPECIFIED, NULL);
>> -        info.index = address_space_lduw_be(&address_space_memory,
>> -                                           ccw.cda + sizeof(info.desc)
>> -                                           + sizeof(info.res0),
>> -                                           MEMTXATTRS_UNSPECIFIED, NULL);
>> -        info.num = address_space_lduw_be(&address_space_memory,
>> -                                         ccw.cda + sizeof(info.desc)
>> -                                         + sizeof(info.res0)
>> -                                         + sizeof(info.index),
>> -                                         MEMTXATTRS_UNSPECIFIED, NULL);
>> -        info.avail = address_space_ldq_be(&address_space_memory,
>> -                                          ccw.cda + sizeof(info.desc)
>> -                                          + sizeof(info.res0)
>> -                                          + sizeof(info.index)
>> -                                          + sizeof(info.num),
>> -                                          MEMTXATTRS_UNSPECIFIED, NULL);
>> -        info.used = address_space_ldq_be(&address_space_memory,
>> -                                         ccw.cda + sizeof(info.desc)
>> -                                         + sizeof(info.res0)
>> -                                         + sizeof(info.index)
>> -                                         + sizeof(info.num)
>> -                                         + sizeof(info.avail),
>> -                                         MEMTXATTRS_UNSPECIFIED, NULL);
>> +        ccw_dstream_read(&sch->cds, info);
>> +        be64_to_cpus(&info.desc);
>> +        be16_to_cpus(&info.index);
>> +        be16_to_cpus(&info.num);
>> +        be64_to_cpus(&info.avail);
>> +        be64_to_cpus(&info.used);
>>          ret = virtio_ccw_set_vqs(sch, &info, NULL);
>>      }
>>      sch->curr_status.scsw.count = 0;
> 
> (...)
> 
>> @@ -488,7 +446,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>          } else {
>>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
>>              /* XXX config space endianness */
> 
> Unrelated: That should be fine, I guess?
> 
>> -            cpu_physical_memory_write(ccw.cda, vdev->config, len);
>> +            /* TODO we may have made -EINVAL out of -EFAULT */
> 
> Eek.
> 

Actually I wanted to send a patch which gets rid of the -EFAULT case
in sch_handle_start_func_virtual.

IMHO a program check is more appropriate here. We did the EFAULT if
cpu_physical_memory_map failed, but we don't have that any more.

>> +            ccw_dstream_write_buf(&sch->cds, vdev->config, len);
>>              sch->curr_status.scsw.count = ccw.count - len;
>>              ret = 0;
>>          }
> 
> Looks fine in general.
> 

Thanks!
