Received: from eggs.gnu.org ([2001:4830:134:3::10]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGUu7-0000bT-Bh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGUu3-00047W-B7
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:00:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34829
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cGUu2-00046w-SB
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:00:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBCHsSVY086202
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 13:00:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 279yg165xu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 13:00:41 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 12 Dec 2016 18:00:39 -0000
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
	<f1f93b66-c414-9dce-ecc4-2239ceaa1774@linux.vnet.ibm.com>
	<20161212174707.GE3808@thinpad.lan.raisama.net>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 19:00:35 +0100
MIME-Version: 1.0
In-Reply-To: <20161212174707.GE3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <a3724e25-cbc8-8392-93ac-7ff13dcf3f81@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/12/2016 06:47 PM, Eduardo Habkost wrote:
>>>> +             */
>>> I think this should not just be a 'temporary hack'... rather document
>>> this behaviour for abstract classes?
>>>
>> Connie, I have to disagree with you on this. I'm fine with this as a
>> temporary hack provided it remedies the acute problem, but I would this
>> becoming state of art.
>>
>> The reason for this how abstract class is usually understood in OOP:
>> it's like a normal class except you can not instantiate it.  Adding an
>> extra property rule, and especially such a convoluted one, could result
>> in a conflict between intuition and reality.  And it's not like we have
>> no plan how to do this cleanly.
>>
>> Why do I say convoluted:
>> * Inheriting form abstract and from non-abstract behaves differently.
>> * Theoretically we have something like non-abstract (C_3) inherits for
>> abstract (AC_2) inherits from non-abstract (C_1)  inherits from abstract
>> (AC_0), and we set the property P both via AC_0 and AC_2 for an instance
>> of C1 we would/could end up having the same problem as we have now (via
>> AC_0 taking precedence over AC_2) -- at least I think so. 
> Well, we could change the code to:
> 1) Not check object_class_is_abstract(), and simply register the
>    globals for all subtypes;
> 2) Call qdev_prop_set_globals_for_type() only for
>    object_class_get_name(), instead of doing it for all
>    parent classes in qdev_prop_set_globals().
> 
> But this sounds like a more complicated way of implementing
> exactly the same behavior implemented by Greg Kurz in "qdev: fix
> the order compat and global properties are applied".
> 

Yeah. This is what I meant with "And it's not like we have
no plan how to do this cleanly.", was trying to convince Connie
that this called a hack for a reason. I think we are on the same
page. I think this is a really good way to solve the acute problem
with a small LOC number.

Halil
