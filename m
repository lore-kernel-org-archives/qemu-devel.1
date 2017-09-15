Received: from eggs.gnu.org ([2001:4830:134:3::10]:46132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsl2j-0000a1-R0
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsl2i-0007qA-OI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsl2i-0007pt-Ew
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:28:04 -0400
Date: Fri, 15 Sep 2017 09:27:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170915092758.16ea52fc.cohuck@redhat.com>
In-Reply-To: <0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 14 Sep 2017 18:50:29 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/14/2017 04:26 PM, Cornelia Huck wrote:
> > On Wed, 13 Sep 2017 15:27:51 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> +static Property ccw_tester_properties[] = {
> >> +    DEFINE_PROP_UINT16("cu_type", CcwTesterDevice, cu_type,
> >> +                        0x3831),  
> > 
> > 0x4711 would be nice :)  
> 
> I don't understand the joke/pun/whatever if there is one,
> but I'm fine with changing this too.

https://en.wikipedia.org/wiki/4711

That's my default if I need a four-digit number :)

> 
> > 
> > If we want to follow up on that testdev idea (and I think we should),
> > it might make sense to have a proper type reserve to prevent accidental
> > clashes.  
> 
> I agree. Although I would still keep the cu_type configurable,
> because it might make sense to test a particular 'real' driver
> (and not a test driver like here). I haven't really thought
> this through, but it was an idea I had while agonizing over
> not having a proper type reserved.
> 
> I suppose you did something like that for virtio, or? I'm in dark
> when it comes to the question what process do we/I have to go to
> get a type,for example 0x4711, reserved.

4711 is more a joke :) It might be worth trying the same channels as
for virtio-ccw.

Christian should know more about that.

> 
> > 
> > (Or is there already something reserved for "hypervisor use" or
> > whatever?)  
> 
> Not that I know. I can't recall encountering a list of reserved
> types. Honestly I've hoped to leverage your experience (again
> because of virtio-ccw).

My thought was that the z/VM folks already might have something
(type-wise) that we could use as well. There's a surprising amount of
values that are reserved for one use or the other. But obviously, I
can't find out about that.

> 
> >   
> >> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
> >> +                       0x98),

This might also need re-evaluation - we should not really need a new
chpid type.

> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};  
> > 
> > IIUC, pci-testdev provides some unit tests to testers (like kvm-tests)
> > itself. This might be an idea to follow up on for ccw as well.
> >   
> 
> I've just had a first look at pci-testdev, and it does appear to be a similar
> concept. 
> 
> > There's quite some potential in this. We may want to make this a
> > permanent addition.
> >   
> 
> I'm happy to contribute! I'm not sure how shall we proceed though.
> Maybe with making a todo list?

I think the first step would be to figure out the ids so we don't step
on anyone's toes. Then maybe refactor a bit so that other testers can
be added easily.

For ideas about things to be tested, maybe put a list into the wiki?
