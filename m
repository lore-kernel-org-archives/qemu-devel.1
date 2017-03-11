Received: from eggs.gnu.org ([2001:4830:134:3::10]:47003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cmXKl-0005zV-VM
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cmXKk-0004LG-CW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:04:43 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cmXKk-0004ES-5m
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:04:42 -0500
Received: by mail-it0-x22c.google.com with SMTP id g138so7080870itb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 19:04:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308181158.GW7470@redhat.com>
References: <CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
	<20170306092305.GA9866@redhat.com>
	<CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
	<20170308091311.GC7470@redhat.com>
	<2881DEEC-922E-4A55-9F11-5C681F5D3648@veritas.com>
	<CAAo6VWPz9dv71ma871W69VX7iiTD0koa_32HV85u5pZZHux-0w@mail.gmail.com>
	<20170308181158.GW7470@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Fri, 10 Mar 2017 19:04:38 -0800
Message-ID: <CAAo6VWNWTZ5+MoZfxA_P6p-KHi4Rsmg-gW45x33cr51OVCASSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Wed, Mar 8, 2017 at 10:11 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Mar 08, 2017 at 09:59:32AM -0800, ashish mittal wrote:
>> On Wed, Mar 8, 2017 at 5:04 AM, Ketan Nilangekar
>> <Ketan.Nilangekar@veritas.com> wrote:
>> >
>> >
>> >> On Mar 8, 2017, at 1:13 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> >>
>> >>> On Tue, Mar 07, 2017 at 05:27:55PM -0800, ashish mittal wrote:
>> >>> Thanks! There is one more input I need some help with!
>> >>>
>> >>> VxHS network library opens a fixed number of connection channels to a
>> >>> given host, and all the vdisks (that connect to the same host) share
>> >>> these connection channels.
>> >>>
>> >>> Therefore, we need to open secure channels to a specific target host
>> >>> only once for the first vdisk that connects to that host. All the
>> >>> other vdisks that connect to the same target host will share the same
>> >>> set of secure communication channels.
>> >>>
>> >>> I hope the above scheme is acceptable?
>> >>
>> >> I don't think I'm in favour of such an approach, as it forces a single
>> >> QEMU process to use the same privileges for all disks it uses.
>> >>
>> >> Consider an example where a QEMU process has two disks, one shared
>> >> readonly disk and one exclusive writable disk, both on the same host.
>> >>
>> >
>> > This is not a use case for VxHS as a solution. We do not support sharing of vdisks across QEMU instances.
>> >
>> > Vxhs library was thus not designed to open different connections for individual vdisks within a QEMU instance.
>> >
>> > Implementing this will involve rewrite of significant parts of libvxhs client and server. Is this a new requirement for acceptance into QEMU?
>> >
>> >
>> >> It is reasonable as an administrator to want to use different credentials
>> >> for each of these. ie, they might have a set of well known credentials to
>> >> authenticate to get access to the read-only disk, but have a different set
>> >> of strictly limited access credentials to get access to the writable disk
>> >>
>> >> Trying to re-use the same connection for multiple cause prevents QEMU from
>> >> authenticating with different credentials per disk, so I don't think that
>> >> is a good approach - each disk should have totally independant state.
>> >>
>>
>> libvxhs does not make any claim to fit all the general purpose
>> use-cases. It was purpose-built to be the communication channel for
>> our block device service. As such, we do not need/support all the
>> general use-cases. For the same reason we changed the name of the
>> library from linqnio to libvxhs (v8 changelog, #2).
>
> I raise these kind of points because they are relevant to apps like
> OpenStack, against which you've proposed VHXS support. OpenStack
> intends to allow a single volume to be shared by multiple guests,
> so declare that out of scope you're crippling certain use cases
> within openstack. Of course you're free to make such a decision,
> but it makes VHXS a less compelling technology to use IMHO.
>

Fair point! Sharing of the same disk across multiple guests would
require significant work from our side, and we would like to evaluate
that after OpenStack starts supporting the feature. Would adding this
support now, be a prerequisite for merging vxhs code to qemu?

>> Having dedicated communication channels for each device, or sharing
>> the channels between multiple devices, should both be acceptable
>> choices. The latter, IO multiplexing, is also a widely adopted IO
>> model. It just happens to fit our use-cases better.
>>
>> Binding access control to a communication channel would prevent
>> anybody from using the latter approach. Having a separate way to allow
>> access-control would permit the use of latter also.
>
> Sharing access control across multiple disks does not fit in effectively
> with the model used by apps that manage QEMU. Libvirt, and apps above
> libvirt, like OpenStack, oVirt, and things like Kubernetes all represent
> the information required to connect to a network block device, on a
> per-disk basis - there's no sense of having some information that is
> shared across all disks associated with a VM.
>
> So from the POV of modelling this in QEMU, all information needs to be
> specified against the individual -drive / -blockdev. If you really must,
> you will just have to reject configurations which imply talking to the
> same host, with incompatible parameters. Better would be to dynamically
> determine if you can re-use connections, vs spawn new connection based
> on the config.
>

Would this be a prerequisite for merging vxhs?

> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
