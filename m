Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eAINv-0001z1-4J
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eAINp-0006Tq-Ch
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:30:27 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eAINp-0006RX-2k
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:30:21 -0400
Received: by mail-oi0-x233.google.com with SMTP id v132so122028oie.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 09:30:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86754966-281f-c3ed-938c-f009440de563@gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
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
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Nov 2017 09:30:16 -0700
Message-ID: <CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
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
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Thu, Nov 2, 2017 at 1:50 AM, Xiao Guangrong
<xiaoguangrong.eric@gmail.com> wrote:
[..]
>> Yes, the GUID will specifically identify this range as "Virtio Shared
>> Memory" (or whatever name survives after a bikeshed debate). The
>> libnvdimm core then needs to grow a new region type that mostly
>> behaves the same as a "pmem" region, but drivers/nvdimm/pmem.c grows a
>> new flush interface to perform the host communication. Device-dax
>> would be disallowed from attaching to this region type, or we could
>> grow a new device-dax type that does not allow the raw device to be
>> mapped, but allows a filesystem mounted on top to manage the flush
>> interface.
>
>
> I am afraid it is not a good idea that a single SPA is used for multiple
> purposes. For the region used as "pmem" is directly mapped to the VM so
> that guest can freely access it without host's assistance, however, for
> the region used as "host communication" is not mapped to VM, so that
> it causes VM-exit and host gets the chance to do specific operations,
> e.g, flush cache. So we'd better distinctly define these two regions to
> avoid the unnecessary complexity in hypervisor.

Good point, I was assuming that the mmio flush interface would be
discovered separately from the NFIT-defined memory range. Perhaps via
PCI in the guest? This piece of the proposal  needs a bit more
thought...
