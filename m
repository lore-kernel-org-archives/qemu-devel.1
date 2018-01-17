Received: from eggs.gnu.org ([2001:4830:134:3::10]:37074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ebqHv-00021o-FU
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ebqHs-0001Nk-7m
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:10:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58990
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ebqHs-0001Nb-22
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:10:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HG9aVk058924
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 11:10:03 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fj7hq781k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 11:09:54 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 17 Jan 2018 16:07:43 -0000
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
	<94c656aa-4c1d-5297-8e3a-2816c3628290@redhat.com>
	<34233d9f-2a81-3e81-8ea1-c8f11ccb29bc@de.ibm.com>
	<66733c96-819a-c1ef-fada-42057324d224@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2018 17:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <66733c96-819a-c1ef-fada-42057324d224@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <616ff4d0-f8e0-b8f3-e631-f469b82a1735@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 01/17/2018 04:10 PM, David Hildenbrand wrote:
>>> As soon as we enable bits for CPU models, we guarantee that migration
>>> works. While introducing this change we already had one example where
>>> this was not the case. Not good. (and remember having another such
>>> exception)
>> The point is migration continues to work. In fact I had a different version
>> of this patch set that did it the other way around. Keep 82 a transparent
>> and add a new cpu misc facility that takes care of the migration state.
>>> It is easier to patch a feature in than silently enabling *anything*
>>> somebody thinks is transparent (but its not). Especially not for the
>>> host model. The expanded host model is migration safe.
>> I really do not care about -cpu host (host-passthrough) for migration safety, 
>> because its not. And as you said: host-model (expanded) will work.
>>
> It will if the world would be perfect.
> 
> expand "-cpu host" -> -cpu z14-base,stfle_82=on
> 
> stfle_82 would now not be properly migrated. Yes, it might work somehow
> right now. But it is not clean.
> 

Based on the code (did not test) I would expect to see this in the
scenario I think you are talking about David:

0. Libvirt uses cpu mode host (not host-passtrough).
1. Source: -"cpu host" expands to "-cpu z14-base,stfle_82=on" as you said
the whole environment (host cpu, kvm, qemu) is supporting 82 inclusive migration
2. Target: libvirt requires "-cpu z14-base,stfle_82=on" when trying to migrate
2.1. If the target environment as a whole does not fully support 82 the model
checking refuses the migration. It does not matter if the reason is QEMU missing
patch #2 or lack of HW support or whatever.
2.2 If the target environment as a whole does fully support 82 the model migration
works, and is safe. If the target QEMU does not have patch #2 we will end up here.
But we may end up here for other reasons.

Both outcomes are works as designed, as far as my understanding of the design goes.
Or am I wrong?

Assumed my reasoning above is correct, I really don't get what is not clean.
Except 'blindly' trusting the hardware that it works as advertised (and
fixing the mess only if it turns out that there is a mess).

On a meta level I think I understand your concerns David to some extent.
But for my taste here you are too concerned about the user shooting herself
into the foot (because equipment malfunction or user error).

Let me also note, that while we might very well end up propagating bugs
to the user, we also give the user the means to mitigate these (e.g.
by turning the buggy features explicitly off like -cpu host,stfle_82=off).

Regards,
Halil
