Received: from eggs.gnu.org ([2001:4830:134:3::10]:44165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cDxmu-0004Hd-K2
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cDxmr-0007MX-BX
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:14:52 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:42631
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cDxmr-0007M6-2n
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:14:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5IA4Ru080423
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 13:14:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27571cry9a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 13:14:47 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 5 Dec 2016 18:14:45 -0000
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
	<20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
	<20161205174130.GH13060@thinpad.lan.raisama.net>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 5 Dec 2016 19:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <20161205174130.GH13060@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <7663fe2f-ae4e-dccd-6422-bd2fba5c9e7d@linux.vnet.ibm.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/05/2016 06:41 PM, Eduardo Habkost wrote:
> On Mon, Dec 05, 2016 at 06:25:55PM +0100, Cornelia Huck wrote:
>> > On Mon, 5 Dec 2016 14:48:29 -0200
>> > Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > 
>>> > > On Mon, Dec 05, 2016 at 04:42:00PM +0100, Cornelia Huck wrote:
>>>> > > > On Mon, 05 Dec 2016 16:21:22 +0100
>>>> > > > Greg Kurz <groug@kaod.org> wrote:
>>>> > > > 
>>>>> > > > > The current code recursively applies global properties from child up to
>>>>> > > > > parent. So, if you have:
>>>>> > > > > 
>>>>> > > > > -global virtio-pci.disable-modern=on
>>>>> > > > > -global virtio-blk-pci.disable-modern=off
>>>>> > > > > 
>>>>> > > > > Then the default value of disable-modern for a virtio-blk-pci device is on,
>>>>> > > > > which looks wrong from an OOP perspective.
>>>>> > > > > 
>>>>> > > > > This patch reverses the logic, so that a child property always prevail.
>>>> > > > 
>>>> > > > This sounds reasonable...
>>>> > > > 
>>>>> > > > > 
>>>>> > > > > This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
>>>>> > > > > hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
>>>>> > > > > HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
>>>>> > > > > would silently override global properties passed on the command line for
>>>>> > > > > virtio subtypes.
>>>>> > > > > 
>>>>> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
>>>>> > > > > ---
>>>>> > > > > 
>>>>> > > > > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
>>>>> > > > > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
>>>>> > > > > tag to pass global properties to QEMU. This patch ensures that XML files
>>>>> > > > > used with older machine types remain valid with newer versions of QEMU.
>>>>> > > > > 
>>>>> > > > > FWIW I guess it could help to have this fix in 2.8, and also probably in
>>>>> > > > > 2.7.1.
>>>> > > > 
>>>> > > > ...but I'm a bit worried about doing that change this late in the
>>>> > > > cycle, as we may introduce subtle changes for other configurations. At
>>>> > > > the very least, we should look over the existing backwards compat
>>>> > > > properties (I'll look at those I'm familiar with).
>>> > > 
>>> > > This patch would change the behavior for:
>>> > >  -global virtio-blk-pci.disable-modern=on
>>> > >  -global virtio-pci.disable-modern=off
>>> > > 
>>> > > And I am not sure the new behavior would be correct. Shouldn't we
>>> > > apply the properties in the order specified in the command-line?
>> > 
>> > Probably; but how should this interact with compat props?
> compat props should be always applied in the order they appear.
> -global should always be applied after compat props.
> 
> So, it looks like we have two additional reasons to just follow
> the order the global properties were registered.
> 

How about a docs update? 

Given the current doc:
"""
-global driver.prop=value
-global driver=driver,property=property,value=value
    Set default value of driver's property prop to value, e.g.:

         qemu-system-i386 -global ide-drive.physical_block_size=4096 -drive
file=file,if=ide,index=0,media=disk

    In particular, you can use this to set driver properties for devices which
    are created automatically by the machine model. To create a device which is
    not created automatically and set properties on it, use -device.

    -global driver.prop=value is shorthand for -global driver=driver,property=prop,
value=value. The longhand syntax works even when
    driver contains a dot. 
"""
I think this OOP argument, which I do not completely understand,
is not the right direction.

Yet I do not think the current state of documentation gives a
definitive answer on what behavior should take place in the
scenarios described above.

Maybe it's my mistake, but I did not find a statement about
the order in which global properties are to be applied
(please point me to it if I've missed it).

Another problem with the doc (IMHO) is that it's not
really defined what a driver is. So I can't even tell if
-global virtio-pci.disable-modern=off is even legit on
the command line.

Regarding the order compat props. applied before command line it
makes a lot of sense to me with the documentation stating "In 
particular, you can use this to set driver properties for devices which
are created automatically by the machine model."
