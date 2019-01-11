Received: from eggs.gnu.org ([209.51.188.92]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghtwV-0000n6-IC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghtwU-0006n8-3d
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:21:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38586
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1ghtwS-0006f7-UE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:21:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BAF9ac109429
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:21:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pxqf2n95m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:21:17 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 11 Jan 2019 10:21:15 -0000
Date: Fri, 11 Jan 2019 11:21:03 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <04965ae7-da3d-a68a-ce0c-eb0b02e542ed@linux.ibm.com>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
	<20190108173113.3c2d830c.cohuck@redhat.com>
	<20190108175021.003deab9@oc2783563651>
	<20190108180615.7e48cf13.cohuck@redhat.com>
	<4876194e-1a87-1491-a8b3-eed5b0a9afe6@linux.ibm.com>
	<20190109111419.426ec6d7.cohuck@redhat.com>
	<a59d5b64-0fb3-4b70-96ff-b1a0c037c6ac@linux.ibm.com>
	<20190109183538.05bab3c8@oc2783563651>
	<04965ae7-da3d-a68a-ce0c-eb0b02e542ed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190111112103.693ac708@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, imammedo@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 10 Jan 2019 10:50:30 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 1/9/19 12:35 PM, Halil Pasic wrote:
> > On Wed, 9 Jan 2019 10:36:11 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> > 
> >> On 1/9/19 5:14 AM, Cornelia Huck wrote:

[..]

> >> A search reveals that max_index is used in only two places: It is used
> >> to set the index for a child of the bus (i.e., bus_add_child function in
> >> hw/core/qdev.c); and prior to this patch, to determine if max_dev has
> >> been exceeded (i.e., qbus_is_full function in qdev_monitor.c). From
> >> what I can see, the bus child index is used only to generate a property
> >> name of the format "child[%d]" so the child can be linked as a property
> >> of the bus (see bus_add_child and bus_remove_child functions in
> >> hw/core/qdev.c). Wraparound of the max_index would most likely result in
> >> generating a duplicate property name for the child.
> >>
> >> I propose two possible solutions:
> >>
> >> 1. When max_index reaches INT_MAX, do not allow any additional children
> >>      to be added to the bus.
> >>
> >> 2. Set a max_dev value of INT_MAX for the BusClass instance if the value
> >>      is not set (in the bus_class_init function in hw/core/bus.c).
> >>
> >> 3. Instead of generating the property name from the BusChild index
> >>      value, generate a UUID string. Since the index field of the BusChild
> >>      appears to be used only to generate the child's name, maybe change
> >>      the index field to a UUID field or a name field.
> >>
> > 
> > Separate problem, separate patch, or?
> 
> Good question.
>

IMHO this patch should not be delayed because of the mostly unrelated
discussion on max_index wrapping. BTW Tony do you want to do a patch on
max_index?

> > 
> > UUID instead of index solves the problem of unique names I guess, but I
> > can't tell if that would be acceptable (interface stability, etc.).
> 
> I may have missed something, but as currently used, the BusChild index
> is accessed in only two places; when the child is added to the bus and
> when it is removed from the bus. In both cases, it is used to derive
> a unique property name for the child device.
> 

The name is probably externally observable (via QMP). It could be also a
stable part of an (external) API. We would need damn good reasons to
break an external API.

> Speaking of index, it implies ordering of the bus's children. IMHO, it
> only makes semantical sense if the index changes when a child device
> with a lower index value is removed from the bus. If a child device
> has an index of 5 - i.e., the fifth child on the bus - and the child
> device with index 4 is removed, then the child device with index 5 is
> no longer the fifth child on the bus. Maybe its just the fact that
> these fields are named 'index'. The fact that they are not really used
> as indexes caused a bit of confusion for me when analyzing this code and
> seems like a misnomer to me.
> 

No comment.

> > 
> > The max_dev won't help because we can get a collision while maintaining
> > the invariant 'not more than 2 devices on the bus'.
> 
> I don't understand, can you better explain what you mean? When you
> say "we can get a collision", are you talking about the property
> name? What does max_dev have to do with that? Please explain. 

AFAIU the whole point of the exercise with max_index is to generate bus
unique names. By we can get a collision (please see
https://en.oxforddictionaries.com/definition/collision), I mean we can
end up assigning the same name to more than one device on the very same
bus.

> What do
> you mean by "maintaining the invariant 'not more than 2 devices on the
> bus'"?
> 

Let me describe the scenario. Let's have a bus with dev_max == 2. We
first add one device, then another to that bus. Then we unplug and replug
the second device. The name goes from 'child[n]' to 'child[n+1]' with
each iteration of unplug/replug with int arithmetic. That is after a
number of iterations we will reach the name 'child[0]'. But we already
have a child[0] on the bus.

> > 
> > So if we don't want to limit the number of hotplug operations, and we do
> > want to keep the allocation scheme before wrapping, the only solution I
> > see is looking for the first free identifier after we wrap.
> 
> Are you are saying to look for the first index value that is not
> assigned to a BusChild object?
> 

Only after we reach the biggest integer. We want to keep everything as
is for the cases that work today.

> > 
> > BTW I wonder if making max_index and index unsigned make things bit less
> > ugly.
> 
> I thought the same. They could also be made unsigned long or
> unsigned long long to increase the number of child devices that can be
> plugged in before having to deal with exceeding the index value.
> 

My rationale is: names with the negatives would look weird.

Regards,
Halil
