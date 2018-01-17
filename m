Received: from eggs.gnu.org ([2001:4830:134:3::10]:34367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebqCK-0003oY-Qx
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebqCE-0007Xi-Ts
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:04:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ebqCE-0007XZ-OF
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:04:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HG1ISX072300
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 11:04:12 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fj9mtr63h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 11:04:11 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 16:04:10 -0000
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
	<94c656aa-4c1d-5297-8e3a-2816c3628290@redhat.com>
	<34233d9f-2a81-3e81-8ea1-c8f11ccb29bc@de.ibm.com>
	<66733c96-819a-c1ef-fada-42057324d224@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 17:04:05 +0100
MIME-Version: 1.0
In-Reply-To: <66733c96-819a-c1ef-fada-42057324d224@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2a6eb56a-5bde-6520-d282-269a176254e2@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 01/17/2018 04:10 PM, David Hildenbrand wrote:
> 
>>> And exactly for this reason I tend to nack patch nr 3 (if that is of any
>>> weight :) ).
>>
>> I have communicated the mistake to asll relevant parties - it will not happen again
>> (famous last words).
> 
> An I already saw it happen in the past. (I think I really have to dig
> out that one feature to make a point :P ). Mistakes happen, but we don't
> have to propagate them to customers if we can catch them early :)
> 
>>
>>>
>>> As soon as we enable bits for CPU models, we guarantee that migration
>>> works. While introducing this change we already had one example where
>>> this was not the case. Not good. (and remember having another such
>>> exception)
>>
>> The point is migration continues to work. In fact I had a different version
>> of this patch set that did it the other way around. Keep 82 a transparent
>> and add a new cpu misc facility that takes care of the migration state.
>>>
>>> It is easier to patch a feature in than silently enabling *anything*
>>> somebody thinks is transparent (but its not). Especially not for the
>>> host model. The expanded host model is migration safe.
>>
>> I really do not care about -cpu host (host-passthrough) for migration safety, 
>> because its not. And as you said: host-model (expanded) will work.
>>
> 
> It will if the world would be perfect.
> 
> expand "-cpu host" -> -cpu z14-base,stfle_82=on
> 
> stfle_82 would now not be properly migrated. Yes, it might work somehow
> right now. But it is not clean.
> 
>>>
>>> And as we saw, in the unlikely event of such heavy changes, we need to
>>> touch fw/linux/qemu either way.
>>>
>>> But there is more I dislike about the approach in patch 3:
>>>
>>> 1. feature names. We need aliases. Different QEMU versions on the same
>>> hw might end up not understanding what a feature means. (old one: only
>>> knows stfl_123, new one knows stfl_123 a.k.a crazy_feat)
>>
>> I plan to keep the old names. e.g. stfle131 is better than sea_esop2.
> 
> 
> Oh god no. With vx, te, iep one at least has a rough idea what is happening.
> 
> -cpu z14-base,stfle123,stfle234,stfle323 ... :(
> 
> 
> This all smells like a huge hack for a scenario that happened once. I
> prefer to do it the clean way. Enable only what you checked works and
> what you can actually give a name.
> 
> Especially we will lose the ability to know which bit was valid for
> which hardware generation - which is key when working with IBC.
> 
> I am not sure if giving all that up is worth it.
> 

I will spin up a second patch that enables stfle81 and name it "ppa15".
We can then discuss patch 3 on the slow path with enough time to think
about this.
