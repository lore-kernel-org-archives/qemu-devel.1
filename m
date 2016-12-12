Received: from eggs.gnu.org ([2001:4830:134:3::10]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGUAs-0006mx-0d
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGUAn-0003Da-W1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:14:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59265
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cGUAn-0003DM-Pk
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:13:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBCHABgR036156
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 12:13:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27a0200an9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 12:13:56 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 12 Dec 2016 17:13:54 -0000
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 18:13:50 +0100
MIME-Version: 1.0
In-Reply-To: <20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <f1f93b66-c414-9dce-ecc4-2239ceaa1774@linux.vnet.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/12/2016 01:25 PM, Cornelia Huck wrote:
>> +        if (oc && object_class_is_abstract(oc)) {
>> +            /* temporary hack to make sure we will never override
                                               ~~~~~~~~~~~~~~~~~~~~~~

I would say this is not enough to provide that guarantee. Inheriting
from non-abstract, or something like I described below, would still
get us in trouble. Or am I wrong? 

How about s/we will never/we do not/?

>> +             * globals set explicitly on -global: if an abstract class
>> +             * is on compat_props, register globals for each of their
>> +             * subclasses instead.

I'm not sure if this is clear enough regarding multilevel inheritance.
I would prefer "subtype" or "class derived from it".

>> +             */
> I think this should not just be a 'temporary hack'... rather document
> this behaviour for abstract classes?
> 

Connie, I have to disagree with you on this. I'm fine with this as a
temporary hack provided it remedies the acute problem, but I would this
becoming state of art.

The reason for this how abstract class is usually understood in OOP:
it's like a normal class except you can not instantiate it.  Adding an
extra property rule, and especially such a convoluted one, could result
in a conflict between intuition and reality.  And it's not like we have
no plan how to do this cleanly.

Why do I say convoluted:
* Inheriting form abstract and from non-abstract behaves differently.
* Theoretically we have something like non-abstract (C_3) inherits for
abstract (AC_2) inherits from non-abstract (C_1)  inherits from abstract
(AC_0), and we set the property P both via AC_0 and AC_2 for an instance
of C1 we would/could end up having the same problem as we have now (via
AC_0 taking precedence over AC_2) -- at least I think so. 

I did not test it either, but it looks sane to me. Regardless of the
comments on the comment (if you are going to consider them or not) you
can take my r-b.

Cheers,
Halil
