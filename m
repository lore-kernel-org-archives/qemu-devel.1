Received: from eggs.gnu.org ([2001:4830:134:3::10]:51235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cEEXb-0004Kw-OY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cEEXY-0000XN-IO
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:08:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58215
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cEEXY-0000XG-Bf
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:08:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6C5HG6144730
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 07:08:07 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 275rky5x0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 07:08:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 12:08:05 -0000
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
	<20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
	<20161205174130.GH13060@thinpad.lan.raisama.net>
	<20161206103008.5ea4ddd6@bahia>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2016 13:08:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161206103008.5ea4ddd6@bahia>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <faeed1b7-93e0-b723-4aba-675a9341ef27@linux.vnet.ibm.com>
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
To: Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/06/2016 10:30 AM, Greg Kurz wrote:
> On Mon, 5 Dec 2016 15:41:30 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
>> > On Mon, Dec 05, 2016 at 06:25:55PM +0100, Cornelia Huck wrote:
>>> > > On Mon, 5 Dec 2016 14:48:29 -0200
>>> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> > >   
>>>> > > > On Mon, Dec 05, 2016 at 04:42:00PM +0100, Cornelia Huck wrote:  
>>>>> > > > > On Mon, 05 Dec 2016 16:21:22 +0100
>>>>> > > > > Greg Kurz <groug@kaod.org> wrote:
>>>>> > > > >   
>>>>>> > > > > > The current code recursively applies global properties from child up to
>>>>>> > > > > > parent. So, if you have:
>>>>>> > > > > > 
>>>>>> > > > > > -global virtio-pci.disable-modern=on
>>>>>> > > > > > -global virtio-blk-pci.disable-modern=off
>>>>>> > > > > > 
>>>>>> > > > > > Then the default value of disable-modern for a virtio-blk-pci device is on,
>>>>>> > > > > > which looks wrong from an OOP perspective.
>>>>>> > > > > > 
>>>>>> > > > > > This patch reverses the logic, so that a child property always prevail.  
[...]
>> > compat props should be always applied in the order they appear.
>> > -global should always be applied after compat props.
>> > 
> This is actually the way they're being registered to the global_props
> static list: compat props as they appear in HW_COMPAT_* and then -global
> as they appear on the command line.
> 
>> > So, it looks like we have two additional reasons to just follow
>> > the order the global properties were registered.
>> > 
> Thinking again, maybe we just need to reverse the logic in another
> way: go through global_props and apply the property if the device
> can be casted to the corresponding class (i.e. object_class_dynamic_cast()
> != NULL). I'll try that.
> 

IMHO this is the right thing to do (and would result in the
exactly behavior outlined by Eduardo -- compat props as they
applied appear and then command line props as they appear, what
means inverse ordering in terms of overriding regarding the
result).

Halil
