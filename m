Received: from eggs.gnu.org ([2001:4830:134:3::10]:55201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eHDG2-0002lp-75
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eHDG1-0006K8-7i
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:26:54 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:43108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eHDG1-0006Jo-2N
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:26:53 -0500
Received: by mail-ot0-x22f.google.com with SMTP id 105so11344080oth.10
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:26:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511288389.1080.14.camel@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
	<CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
	<1501112787.4073.49.camel@redhat.com>
	<CAPcyv4gbC6Hx_4YsCfOd2t=fn=wPGp5h__1QH=-p40TPFNbFzA@mail.gmail.com>
	<0a26793f-86f7-29e7-f61b-dc4c1ef08c8e@gmail.com>
	<CAPcyv4iw2cCpDmr+4kxsFvdy+iGZiz=ok-kLhsDKpqDy+szf-Q@mail.gmail.com>
	<378b10f3-b32f-84f5-2bbc-50c2ec5bcdd4@gmail.com>
	<CAPcyv4jR_LdbsX-rAsHC7++C6d-WYC084uWXzr+08PSYwoXFMw@mail.gmail.com>
	<ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
	<CAPcyv4gKzvd39WbnKjbs3Bn9+o1tt=vz90CYMFu0DF5PsfHUig@mail.gmail.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 21 Nov 2017 10:26:50 -0800
Message-ID: <CAPcyv4jJGg4AceWYY74EoiM+8f8NEotOVCvJu8aMXGjkvRPpMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Tue, Nov 21, 2017 at 10:19 AM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 2017-11-03 at 14:21 +0800, Xiao Guangrong wrote:
>> On 11/03/2017 12:30 AM, Dan Williams wrote:
>> >
>> > Good point, I was assuming that the mmio flush interface would be
>> > discovered separately from the NFIT-defined memory range. Perhaps
>> > via
>> > PCI in the guest? This piece of the proposal  needs a bit more
>> > thought...
>> >
>>
>> Consider the case that the vNVDIMM device on normal storage and
>> vNVDIMM device on real nvdimm hardware can both exist in VM, the
>> flush interface should be able to associate with the SPA region
>> respectively. That's why I'd like to integrate the flush interface
>> into NFIT/ACPI by using a separate table. Is it possible to be a
>> part of ACPI specification? :)
>
> It would also be perfectly fine to have the
> virtio PCI device indicate which vNVDIMM
> range it flushes.
>
> Since the guest OS needs to support that kind
> of device anyway, does it really matter which
> direction the device association points?
>
> We can go with the "best" interface for what
> could be a relatively slow flush (fsync on a
> file on ssd/disk on the host), which requires
> that the flushing task wait on completion
> asynchronously.
>
> If that kind of interface cannot be advertised
> through NFIT/ACPI, wouldn't it be perfectly fine
> to have only the virtio PCI device indicate which
> vNVDIMM range it flushes?
>

Yes, we could do this with a custom PCI device, however the NFIT is
frustratingly close to being able to define something like this. At
the very least we can start with a "SPA Range GUID" that is Linux
specific to indicate "call this virtio flush interface on FUA / flush
cache requests" as a stop gap until a standardized flush interface can
be defined.
