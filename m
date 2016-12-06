Received: from eggs.gnu.org ([2001:4830:134:3::10]:34366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cEF14-0003hK-Jh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cEF11-00047c-GP
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:38:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cEF11-00047Q-74
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:38:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6CY8FL063146
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 07:38:31 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275qv2jnud-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 07:38:31 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 12:38:29 -0000
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
	<20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
	<20161205174130.GH13060@thinpad.lan.raisama.net>
	<7663fe2f-ae4e-dccd-6422-bd2fba5c9e7d@linux.vnet.ibm.com>
	<20161206101110.164b8a93@bahia>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 13:38:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161206101110.164b8a93@bahia>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <80731f31-83c1-0f36-e949-e6f20790921a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/06/2016 10:11 AM, Greg Kurz wrote:
>> Given the current doc:
>> > """
>> > -global driver.prop=value
>> > -global driver=driver,property=property,value=value
>> >     Set default value of driver's property prop to value, e.g.:
>> > 
>> >          qemu-system-i386 -global ide-drive.physical_block_size=4096 -drive
>> > file=file,if=ide,index=0,media=disk
>> > 
>> >     In particular, you can use this to set driver properties for devices which
>> >     are created automatically by the machine model. To create a device which is
>> >     not created automatically and set properties on it, use -device.
>> > 
>> >     -global driver.prop=value is shorthand for -global driver=driver,property=prop,
>> > value=value. The longhand syntax works even when
>> >     driver contains a dot. 
>> > """
>> > I think this OOP argument, which I do not completely understand,
> With the current code, properties from the parent classes implicitly
> prevail and this has nothing to do with command line order, or order
> of appearance in HW_COMPAT_*.
>

Yeah and IMHO this is exactly the problem :).
 
> From an OOP perspective, we usually expect child classes to override
> parent classes behavior, not the contrary.
> 


I know, but the question is if it is the right analogy. The point is (as
you yourself already stated in a follow up email) the semantic of global
properties can be very well defined as for each instance of the class X
set property P to value V (that is imperatively). Now if it is possible
that same data exposed by properties is set more than once (e.g. via
parent and via child) and we want to remain deterministic we need to say
which write is going to win by being the last one.

Another option would be to say define this in a functional manner and
say the value of a property is going to be V unless ... ( here we need
to state that child takes precedence over parent and bring in command
line in in some way too -- where I do not know if parent command line
should take precedence over compat property on the child or the other
way around).

Because IMHO the first option is not consistent with the doc I'm in
favor of that, but then it has not much to do with overriding behavior.

Thanks for the explanation. Given your other email I think we are in
agreement now. I still think a bit more documentation (not necessarily
user documentation) would not hurt, as IMHO the OOP intuition you stated
is a valid one too (not my favored one though) and thus it would not
hurt to have the design decision captured in natural language too.

Cheers,
Halil
