Received: from eggs.gnu.org ([2001:4830:134:3::10]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d98kI-00029t-PW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d98kF-0007YO-Ls
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:28:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36722
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d98kF-0007Y5-FE
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:28:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4CBPVSU063302
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:28:26 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ad2xs9nnc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:28:26 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 12 May 2017 12:28:23 +0100
References: <20170510151209.32767-1-pasic@linux.vnet.ibm.com>
	<20170511130210.2c24d9de.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 13:28:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170511130210.2c24d9de.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <68b56ac2-6169-8bae-ac97-a33e3aaa940f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: catch section mismatch on
 load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/11/2017 01:02 PM, Cornelia Huck wrote:
> On Wed, 10 May 2017 17:12:09 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Prior to the virtio-ccw-2.7 machine (and commit 2a79eb1a), our virtio
>> devices residing under the virtual-css bus do not have qdev_path based
>> migration stream identifiers (because their qdev_path is NULL). The ids
>> are instead generated when the device is registered as a composition of
>> the so called idstr, which takes the vmsd name as its value, and an
>> instance_id, which is which is calculated as a maximal instance_id
>> registered with the same idstr plus one, or zero (if none was registered
>> previously).
>>
[..]
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 15c4f4b..6cff3a3 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
[..]
>> +        /* Only possible if machine < 2.7 (no css_dev_path) */
>> +
>> +        error_setg(&err, "%x != %x", old_devno,  s->devno);
>> +        error_append_hint(&err, "Devno mismatch, tried to load wrong section!"
>> +                          " Likely reason: some sequences of plug and unplug"
>> +                          " can break migration for machine versions prior"
> 
> s/prior/prior to/

Fixed. Thanks! Will wait a couple of days, maybe somebody has something
else to say, and then re-spin.

Regards,
Halil

> 
>> +                          " 2.7 (known design flaw).\n");
>> +        error_report_err(err);
>> +        return -EINVAL;
>> +    }
>>      /* Re-assign subch. */
>>      if (old_schid != s->schid) {
>>          old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index e7167e3..4f7efa2 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -1274,9 +1274,13 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>>      SubchDev *s = ccw_dev->sch;
>>      VirtIODevice *vdev = virtio_ccw_get_vdev(s);
>>      int len;
>> +    int ret;
>>
>>      s->driver_data = dev;
>> -    subch_device_load(s, f);
>> +    ret = subch_device_load(s, f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>>      /* Re-fill subch_id after loading the subchannel states.*/
>>      if (ck->refill_ids) {
>>          ck->refill_ids(ccw_dev);
> 
> Patch looks sane to me, but I second the question about how to handle
> this when using vmstates.
> 
