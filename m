Received: from eggs.gnu.org ([2001:4830:134:3::10]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1clfs8-0007Pd-9Q
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1clfs6-0003Eu-Kl
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:59:36 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:37962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1clfs6-0003Ee-FH
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:59:34 -0500
Received: by mail-it0-x22d.google.com with SMTP id m27so44684454iti.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 09:59:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2881DEEC-922E-4A55-9F11-5C681F5D3648@veritas.com>
References: <20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
	<CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
	<20170306092305.GA9866@redhat.com>
	<CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
	<20170308091311.GC7470@redhat.com>
	<2881DEEC-922E-4A55-9F11-5C681F5D3648@veritas.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 8 Mar 2017 09:59:32 -0800
Message-ID: <CAAo6VWPz9dv71ma871W69VX7iiTD0koa_32HV85u5pZZHux-0w@mail.gmail.com>
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
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Wed, Mar 8, 2017 at 5:04 AM, Ketan Nilangekar
<Ketan.Nilangekar@veritas.com> wrote:
>
>
>> On Mar 8, 2017, at 1:13 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>>
>>> On Tue, Mar 07, 2017 at 05:27:55PM -0800, ashish mittal wrote:
>>> Thanks! There is one more input I need some help with!
>>>
>>> VxHS network library opens a fixed number of connection channels to a
>>> given host, and all the vdisks (that connect to the same host) share
>>> these connection channels.
>>>
>>> Therefore, we need to open secure channels to a specific target host
>>> only once for the first vdisk that connects to that host. All the
>>> other vdisks that connect to the same target host will share the same
>>> set of secure communication channels.
>>>
>>> I hope the above scheme is acceptable?
>>
>> I don't think I'm in favour of such an approach, as it forces a single
>> QEMU process to use the same privileges for all disks it uses.
>>
>> Consider an example where a QEMU process has two disks, one shared
>> readonly disk and one exclusive writable disk, both on the same host.
>>
>
> This is not a use case for VxHS as a solution. We do not support sharing of vdisks across QEMU instances.
>
> Vxhs library was thus not designed to open different connections for individual vdisks within a QEMU instance.
>
> Implementing this will involve rewrite of significant parts of libvxhs client and server. Is this a new requirement for acceptance into QEMU?
>
>
>> It is reasonable as an administrator to want to use different credentials
>> for each of these. ie, they might have a set of well known credentials to
>> authenticate to get access to the read-only disk, but have a different set
>> of strictly limited access credentials to get access to the writable disk
>>
>> Trying to re-use the same connection for multiple cause prevents QEMU from
>> authenticating with different credentials per disk, so I don't think that
>> is a good approach - each disk should have totally independant state.
>>

libvxhs does not make any claim to fit all the general purpose
use-cases. It was purpose-built to be the communication channel for
our block device service. As such, we do not need/support all the
general use-cases. For the same reason we changed the name of the
library from linqnio to libvxhs (v8 changelog, #2).

Having dedicated communication channels for each device, or sharing
the channels between multiple devices, should both be acceptable
choices. The latter, IO multiplexing, is also a widely adopted IO
model. It just happens to fit our use-cases better.

Binding access control to a communication channel would prevent
anybody from using the latter approach. Having a separate way to allow
access-control would permit the use of latter also.

>>>
>>> If yes, then we have a couple of options to implement this:
>>>
>>> (1) Accept the TLS credentials per vdisk using the previously
>>> discussed --object tls-creds-x509 mechanism. In this case, if more
>>> than one vdisk have the same host info, then we will use only the
>>> first one's creds to set up the secure connection, and ignore the
>>> others. vdisks that connect to different target hosts will use their
>>> individual tls-creds-x509 to set up the secure channels. This is, of
>>> course, not relevant for qemu-img/qemu-io as they can open only one
>>> vdisk at a time.
>>>
>>> (2) Instead of having a per-vdisk --object tls-creds-x509, have a
>>> single such argument on the command line for vxhs block device code to
>>> consume - if that is possible! One way to achieve this could be the
>>> user/password authentication we discussed earlier, which we could use
>>> to pass the directory where cert/keys are kept.
>>>
>>> (3) Use the instance UUID, when available, to lookup the cert files
>>> per instance (i.e. for qemu-kvm), and use the --object tls-creds-x509
>>> mechanism, when instance UUID is NULL (i.e. qemu-io, qemu-img etc).
>>> The cert/key files are anyway protected by file permissions in either
>>> case, so I guess there is no additional security provided by either
>>> method.
>>
>> Regards,
>> Daniel
>> --
>> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
>> |: http://libvirt.org              -o-             http://virt-manager.org :|
>> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
