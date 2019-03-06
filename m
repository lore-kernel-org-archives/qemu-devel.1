Received: from eggs.gnu.org ([209.51.188.92]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1ZPR-0004Cy-8d
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1ZPQ-0000mf-Ee
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:28:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1ZPQ-0000m6-76
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:28:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x26GPVSP165299
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 11:28:43 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r2h78a2rs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 11:28:43 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 6 Mar 2019 16:28:42 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
	<20190304144010.109e5ee1.cohuck@redhat.com>
	<cf5e9c71-a78a-02b1-eaa8-4c8ba5c2c8a3@linux.ibm.com>
	<20190306162729.0698ccb5.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 6 Mar 2019 11:28:37 -0500
MIME-Version: 1.0
In-Reply-To: <20190306162729.0698ccb5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <75da1e7f-3be4-ccb9-719e-c40c39f93f79@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/6/19 10:27 AM, Cornelia Huck wrote:
> On Wed, 6 Mar 2019 09:55:40 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> On 3/4/19 8:40 AM, Cornelia Huck wrote:
>>> On Fri,  1 Mar 2019 13:59:21 -0500
>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>>>> @@ -532,7 +559,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>>>>            !ipl->netboot &&
>>>>            ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
>>>>            is_virtio_scsi_device(&ipl->iplb)) {
>>>> -        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
>>>> +        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), &devtype);
>>>
>>> It feels wrong to have a variable that is not used later... what about
>>> either
>>> - making s390_get_ccw_device() capable of handling a NULL second
>>>     parameter, or
>>> - (what I think would be nicer) passing in the devtype as an optional
>>>     parameter to gen_initial_iplb() so you don't need to do the casting
>>>     dance twice?
>>>    
>>
>> I'm with you on everything suggested for this patch except this last item. I'm not sure
>> what you are suggesting here. I can easily visualize passing NULL for devtype when we want
>> to ignore it but I'm not sure what you mean by 'optional parameter'
> 
> Hm, actually you'd need the device as well :) Basically,
> 
> static bool s390_gen_initial_iplb(S390IPLState *ipl, CcwDevice *ccw_dev, int devtype)
> {
> (...)
>      if (!ccw_dev) {
>          //get ccw_dev, which also gives us the devtype
>      }
> 
>      if (ccw_dev) {
>          //as before; devtype is valid here
>          (...)
>          return true;
>      }
>      return false;
> }
> 
> So you can call it with s390_gen_initial_iplb(ipl, NULL, 0) if you
> don't have the values already.
> 
> 
Ahh, makes sense now. Thanks for clarifying. I can do it that way, but it does seem a bit 
redundant to allow s390_gen_initial_iplb to be called either with, or without the device 
type data. In the case where it is called without, it just has to make the call to 
s390_get_ccw_device anyway. So, to me, it seems like added lines of code for very little 
benefit. Why not either always call s390_get_ccw_device from inside s390_gen_initial_iplb, 
or always require the parameters to be valid?

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
