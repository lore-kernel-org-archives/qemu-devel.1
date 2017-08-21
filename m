Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djoLz-0006Yj-UQ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djoLw-0005Kg-IS
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:10:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1djoLw-0005IJ-9l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:10:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LF8D0i085078
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:10:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cfw5qfy1r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:10:54 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 16:10:52 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
	<feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
	<20170821141353.32a1242c.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 17:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170821141353.32a1242c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <aa499e7a-2692-d3b8-d3f5-c8bc1d5783d2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com



On 08/21/2017 02:13 PM, Cornelia Huck wrote:
> On Mon, 21 Aug 2017 14:00:15 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 08/21/2017 11:16 AM, Cornelia Huck wrote:
>>> If we don't provide pci, we cannot have a pci device for which we
>>> have to translate to adapter routes: just return -ENODEV.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  target/s390x/kvm.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 9de165d8b1..d8db1cbf6e 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2424,6 +2424,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>>>      uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>>>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
>>>
>>> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
>>> +        /* How can we get here without pci enabled? */
>>> +        g_assert(false);  
>>
>> You don't tell us about the g_assert in the commit message.
>> Do you expect G_DISABLE_ASSERT being defined for production 
>> builds. I've grepped for G_DISABLE_ASSERT and found nothing.
> 
> AFAIK this is set by distribution builds. I've also noticed that mingw
> builds treat (g_)assert() as if code flow continues, but I don't know
> whether asserts do anything there at all.
> 

After thinking some more,  I would prefer the the commit message being
modified so, that it's clear, what we really want is the assert; or this
assert being dropped or replaced with some kind of warning/tracing.

I assume no production QEMU should ever return -ENODEV here (and if it
does, it's due to an QEMU bug). So the assert is there to communicate
with the devel, and just in case if the client code fails to fulfill
their part of the contract.  In this case we shall fail fast and hard,
and no such QEMU should ship. The return -ENODEV is then 'just in case'
on the square -- a failsafe for the failsafe (which does make sense
to me).

On the contrary if we assume this is a legit error condition (and a part
of the contract) then according to HACKING 7.2 Handling errors we shall
not call exit() or abort() to handle an error that can be triggered by
the guest in particular and operation related errors in general. Makes
perfect sense to me.

Pierre helped me, kvm_arch_fixup_msi_route is guest triggered and also
considering this particular case killing off the QEMU, and the guest does
not seem like the lesser evil.

The situation is just complicated by the fact that there is code which
relies on assert(true) asserting for correctness (e.g. virtio goes so far
to make builds with normal asserts disabled fail). Thus for me it's hard
to assume that the assertion is guaranteed to be disabled in production.

But if it ain't disabled than it calls abort() which we should not
do (HACKING and IMHO common sense).

TL;DR

I'm for modifying the commit message so it tells us about
the assert.

>>
>> And why g_assert over assert (again no guidance in HACKING
>> mostly asking for my own learning)?
> 
> I do recall a recent(ish) discussion, but not the details. Anyway,
> using glib interfaces seems more consistent.

We can't live with NDEBUG is another reason for using g_assert (makes
my preferred solution work).

Regards,
Halil

[..]
