Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG3XT-0002Yy-JQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG3XN-0003tL-PK
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:24:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fG3XN-0003t1-Fq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:24:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48EGWYd063397
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 10:24:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hubrepead-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:24:15 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 May 2018 15:24:13 +0100
References: <20180507155130.21085-1-cohuck@redhat.com>
	<2a6f6a2a-ddaf-27ae-de04-581dcc67fdd0@linux.ibm.com>
	<20180508155551.7cea014f.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 8 May 2018 16:24:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180508155551.7cea014f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e18c6c5b-5036-fb0c-b861-5b55786cd6ba@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x: reset handling for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/08/2018 03:55 PM, Cornelia Huck wrote:
> On Tue, 8 May 2018 15:29:50 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 05/07/2018 05:51 PM, Cornelia Huck wrote:
>>> On Friday, Thomas noticed some problems with 3270 devices. One result
>>> was "s390x/css: disabled subchannels cannot be status pending", but
>>> a reboot did not cure the previous broken status. Turns out that 3270
>>> devices are missing a reset handler.
>>>
>>> This series cleans up reset handling a bit and makes sure that the base
>>> ccw device class provides a subchannel reset handler. I'm currently
>>> not sure what we should do with vfio-ccw, so the behaviour there is
>>> left unchanged.
>>
>> Had a look, and LGTM (will tag separately) modulo what follows here. I'm
>> a bit concerned about vfio-ccw not being made compliant to this new
>> he reset of CCWDeviceClass is taking care of resetting the subchannel data
>> structures. This feels like introducing a common abstraction
>> to me, but then some things bother me.
> 
> We are having a common abstraction that can be overwritten by any
> specialized implementation - and this is what vfio-ccw is doing,
> therefore nothing changes for it.
> 

Sorry my OO background is making me overthink things. I was on
the separation of concerns line: base class takes care of its
own class invariants and the the derived of its own. Considering
what your statements below, I think we are in agreement.

>> In particular the the pim, the lpm and the pam set in css_reset_sch
>> seems to suit only devices that use the virtual chp. That
>> is it ain't suits any CCWDevice instance.
> 
> Yes, we need to revisit this code and split out what makes sense and
> what doesn't. For now, we only have virtual devices and vfio-ccw, so
> we're fine. It even might make sense to keep them separate in the
> future, as having a virtual device and one only mirroring some state in
> QEMU sound like they want to be handled differently.
> 

I agree. The last sentence probably means that resetting the in QEMU
state may not be sufficient.

Another to me somewhat strange thing I noticed is this disabled_cb
used by virtio. It's is I guess the way it it is (specified in
the OASIS spec and everything), but I don't really understand how
this aligns with what the PoP says about MSCH. I mean AFAIU
MSCH does not trigger any communication between the channel subsystem
and the CU and or the device. I read the PoP as nothing is supposed
to change expect the things specified where MSCH is described. I guess
it is just another strange thing we have to live with -- for historical
reasons.

Regards,
Halil
