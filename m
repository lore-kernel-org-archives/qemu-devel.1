Received: from eggs.gnu.org ([2001:4830:134:3::10]:56438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <justsendmailnothingelse@gmail.com>)
	id 1fsUG5-0002Yx-8T
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <justsendmailnothingelse@gmail.com>)
	id 1fsUG3-0006NF-Sw
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <justsendmailnothingelse@gmail.com>)
	id 1fsUG3-0006N5-Ln
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:37:15 -0400
Received: by mail-qt0-x244.google.com with SMTP id f19-v6so859702qtf.2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 07:37:15 -0700 (PDT)
Sender: sendmail <justsendmailnothingelse@gmail.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<20180822134440.GK12750@redhat.com>
From: Laine Stump <laine@laine.org>
Message-ID: <cb831d07-a3f2-9c6a-dbd4-a727c8f13e4f@laine.org>
Date: Wed, 22 Aug 2018 10:37:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180822134440.GK12750@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Libvirt <libvir-list@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu list <qemu-devel@nongnu.org>

On 08/22/2018 09:44 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 22, 2018 at 09:54:55AM -0300, Eduardo Habkost wrote:
>> On Wed, Aug 22, 2018 at 01:26:01PM +0100, Daniel P. Berrangé wrote:
>>> On Wed, Aug 22, 2018 at 09:01:35AM -0300, Eduardo Habkost wrote:
>>>> On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
>>>>> On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
>>>>>> On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
>>>>>>> If we decide we want to explicitly spell out the options instead
>>>>>>> of relying on QEMU changing behavior based on the slot type, which
>>>>>>> is probably a good idea anyway, I think we should have
>>>>>>>
>>>>>>>   virtio-0.9 => disable-legacy=no,disable-modern=no
>>>>>>>   virtio-1.0 => disable-legacy=yes,disable-modern=no
>>>>>>>
>>>>>>> There's basically no reason to have a device legacy-only rather
>>>>>>> than transitional, and spelling out both options instead of only
>>>>>>> one of them just seems more robust.
>>>>>> I agree with both of those, but the counter-argument is that "virtio"
>>>>>> already describes a transitional device like your proposal for
>>>>>> virtio-0.9 (at least today), and it makes the versioned models less
>>>>>> orthogonal. In the end, I could go either way...
>>>>> Yeah, Dan already made that argument and convinced me that we
>>>>> should use virtio-0.9 for legacy only, virtio-1.0 for modern only
>>>>> and plain virtio for no enforced behavior / transitional.
>>>> I don't understand why we are optimizing the new system for the
>>>> less useful use cases:
>>>>
>>>> I don't see a use case where virtio-0.9 (legacy-only) would be
>>>> more useful than virtio-transitional.  I don't see why anybody
>>>> would prefer a legacy-only device instead of a transitional
>>>> device.  Even if your guest has only legacy drivers, it might be
>>>> upgraded and get new drivers in the future.
>>>>
>>>> I don't see a use case where virtio-1.0 (modern-only) would be
>>>> more useful than "virtio".  If you are running i440fx, you get a
>>>> transitional device with "virtio", and I don't see why anybody
>>>> would prefer a modern-only device.  If you are running Q35, you
>>>> already get a modern-only device with "virtio".
>>>>
>>>> The most useful feature users need is the ability to ask for a
>>>> transitional virtio device on Q35, and this use case is
>>>> explicitly being left out of the proposal.  Why?
>>> You can already get a transitional device on Q35, albeit with manual
>>> placement. Adding flags for magic placement for the existing devices
>>> is not something that is suitable for the XML. The ability to get
>>> legacy-only, or modern-only doesn't exist today in any way, so that
>>> would be a valid new feature.
>> Transitional devices and modern-only devices are different kinds
>> of devices.  Making the guest see a different type of device
>> depending on where it's plugged is why we got into this mess, why
>> would we recommend applications to rely on this behavior?
>>
>> That's why I like your virtio-0.9/virtio-1.0 proposal.  I just
>> don't see why you think virtio-transitional should be out of it.
> An explicit virtio-transitional device is still two separate
> devices pretending to be the same thing, but magically changing
> their identity at runtime. We've already got that situation with
> existing device models, and I'm loathe to see us add 2nd device
> model with that same behaviour, just for sake of having a slightly
> different PCI bus placement strategy to support outdated guest OS.
>
>>> Honestly though, the longer this discussion goes on, the more I think
>>> the answer is just "do nothing". All this time spent on discussion,
>>> and future time spent on implementing new logic in apps, is merely
>>> to support running RHEL-6 on Q35.  I think we should just say that
>>> RHEL-6 should use i440fx forever and be done with it.
>> I'm not sure if you are saying that we (Red Hat) shouldn't spend
>> time implementing it, or that the libvirt upstream project should
>> reject the patches if somebody implements it.  I would understand
>> the former, but not the latter.
> Even if someone is willing to implement it in libvirt, we have to
> consider the cost of supporting it in both libvirt and applications
> using libvirt and the complexity it adds to our story about the
> docs / best practices for configuring guests.
>
> Even though I do kind of like the virtio-0.9/virtio-1.0 device model
> as concepts, I'm yet to be convinced that implementing them in libvirt
> and then also in all the downstream applications (oVirt, OpenStack,
> virt-manager, cockpit, etc) is actually worth the cost.

I'm starting to lean towards this opinion too - I was thinking about
this over the weekend, and it does seem like the code in the management
apps will be convoluted/complex/your favorite adjective. Going into this
I had the naive impression that a simple bit of logic in the management
application could just take the union of supported devices from
libosinfo(guestOS) and domaincapabilities(qemu), then pick the top model
name from the list. It's unfortunately not that simple, so we're going
to end up with a bunch of extra code in the management application
(multiplied by the number of management apps, multiplied by the number
of different virtio devices) and that code will need to be maintained.

In the meantime, the only advantages over just giving up and using 440fx
for RHEL6 would be 1) consistent support for using Q35 on all
"supported" guest OSes, 2) the possibility of doing SecureBoot, and 2)
being able to someday in the future eliminate all 440fx-specific code
from the set of code that needs to be tested/maintained by downstream
maintainers. (1) is nice and clean, but the value is dubious if it's
achieved by "unclean" code elsewhere. (2) is a non-feature for almost
everyone, and (3) isn't going to happen anyway, since any existing
guests have already been setup using 440fx as the machinetype, and we
can't force people to change the machinetype of an existing guest (as
Dan says, over the amount of time needed to make that an acceptable
requirement, the guest OSes in question could likely reach EOL anyway).

So, while technically it's just a tiny change in the configuration of
the guest that's needed to make RHEL6+Q35+virtio work, all the trappings
around it turn it into a big mess that will likely be more trouble than
the trouble of just using 440fx for a couple guest OSes. (By comparison,
I think it might be cleaner/simpler/less bug prone to simply backport
the virtio-1.0 driveres to RHEL6


Am I giving up too easily?

(NB: of course if we want to require 440fx for RHEL6, we'll still need
to do the work on libosinfo to report "supported machinetype", and on
all the management applications to honor that information)
