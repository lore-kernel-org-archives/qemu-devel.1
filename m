Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffWUl-0004Wt-02
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffWUh-00021E-QJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:22:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffWUh-0001zM-Kh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:22:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA-w0Mcm9tLHqmXRDcrMDnE5JO4NoHPtv_RsvZ56i5A48g@mail.gmail.com>
	(Peter Maydell's message of "Tue, 17 Jul 2018 20:30:35 +0100")
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
	<20180717124646.GP18603@redhat.com> <87wottyeqk.fsf@secure.mitica>
	<CAFEAcA8S1rG4X37Qmgk5YawCh32p=yw7o=22uQuZQWJMBBke7Q@mail.gmail.com>
	<87k1ptydqg.fsf@secure.mitica>
	<CAFEAcA-w0Mcm9tLHqmXRDcrMDnE5JO4NoHPtv_RsvZ56i5A48g@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 22:22:41 +0200
Message-ID: <87a7qpy5m6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/25] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 17 July 2018 at 18:27, Juan Quintela <quintela@redhat.com> wrote:
>> On the other hand, sometimes it looks like I am the only user that use
>> this.  The original reason for this was to be able to compile out
>> drivers that downstream don't care about.  There were a couple of
>> intents to integrate with something like kernel kconfig, but I think
>> that we never end integrating anything from there.
>
> I think "be able to compile out stuff you don't want" is
> useful from a "reduce the security boundary" perspective,
> and indeed we have at least one fork of QEMU which is
> basically aimed at chopping stuff out, so there's a group
> of users who'd like to be able to do that

agreed about that.  Some of the bits are just there for historical
reasons, or it was easier to do it that way.  Case in hand, vfio-spapr,
we compile it in always, but my understanding is that it is only used on
ppc.  On the other hand, spliting things complicates things a lot, see
for instance the virtio-pci.c example that I gave on other answer.  You
can split instead of #ifdef, but need yet another registration.

>-- you're not on
> your own in that sense. But it probably does require more
> serious effort if we want to address this use case, so as
> always it comes down to whether anybody wants to do the work,
> I guess.

Completely agree.  I can justify the effort that I put to be able to
"compile less stuff and then compile faster".  Doing it properly takes
more time that I can afford right now.

I care mostly about x86_64-seftmmu with kvm, appart from the bits that I
sent, the other low hanging fruit that I can think of is:

- being able to compile only q35 or i440fx
- split CONFIG_RDMA into CONFIG_RDMA_DEVICES and CONFIG_RDMA_MIGRATION

Thing that could be clearer:
- What is the difference between CONFIG_VIRTIO_VGA and COVFIG_VIRTIO_GPU
- can we really drop/make optional isapc, yes, I know that some things
  still hang from there.
- VHOST_USER_SCSI, VHOST_USER, VIIRTIO_SCSI, VIRTIO_BLK,
  VIRTIO_DATAPLANE, VHOST_BLK and who knows what.  It is not clear to me
  which ones are the ones that I want.

Later, Juan.
