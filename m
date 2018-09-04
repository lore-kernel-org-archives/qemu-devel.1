Received: from eggs.gnu.org ([2001:4830:134:3::10]:36836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx8Yd-0007ux-7L
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx8Ya-0004UF-IK
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:27:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fx8Ya-0004TH-CI
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:27:36 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com> (Andrew
	Jones's message of "Tue, 4 Sep 2018 11:54:02 +0200")
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
	<DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
	<20180831111121.n7zafn6peiwe6ojn@kamzik.brq.redhat.com>
	<1604D594-E6D4-48BB-A270-F7CF1092978B@caviumnetworks.com>
	<20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 04 Sep 2018 12:27:29 +0200
Message-ID: <877ek1v9pq.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Auger Eric <eric.auger@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Sep 04, 2018 at 09:16:58AM +0000, Jaggi, Manish wrote:
>> So which approach should be taken here, whats your take...
>> 

[ Remoning Anthony form CC.  Address don't exist anymore ]

> Inventing a base-AArch64 cpu model that can then be extended with optional
> features is a nice way to extend the migratability of a guest, however
> it's hard to do because of errata. Since errata workarounds are enabled
> per MIDR, then we'd need to invent our own MIDR and also some way to
> communicate which errata we want to enable, possibly through some paravirt
> mechanism or through some implementation defined system registers that
> KVM would need to reserve and define.
>
> That's not just a ton of work for the entire virt stack (not just KVM and
> QEMU, but also all the layers above), but it's possible that it won't be
> useful in the end anyway. There's risk that enabling just one erratum
> workaround would restrict the guest to hosts of the exact same type
> anyway. For each erratum that needs to be enabled, the probability of
> enabling an incompatible one goes up, so it may not be likely to do much
> better than '-cpu host' in the end. I'm afraid that until errata are
> primarily showing up in optional CPU features that can simply be disabled
> for the workaround, that we're stuck with '-cpu host'. I'd be happy to
> discuss it more though.

Then, we are basically at the point when we can only migrate to the
exact same processor, no?


> In short, I'd go with the proposal above, for now, with possibly one
> change. libvirt folk (Andrea Bolognani and Pino Toscano) suggest that
> the guest invariant register updating on the destination host only be
> done if the user opts-in to it. This is because right now if a user
> tries to migrate to a host that is not 100% identical the migration
> will fail, which makes the "mistake" clear. If we silently change the
> behavior to allow it, then what could have been a mistake, because
> the hosts aren't actually "close enough", may go unnoticed. I'm not
> 100% sure we need another user opt-in flag to be set, though, as I
> think the '-cpu host' indicates the user expects the VCPU to look
> like the host CPU, and even after migration that expectation should be
> met. Simply, users that migrate '-cpu host' VMs need to know what they're
> doing.

I don't know really what to say here:
- on the one hand, not creating the proper cpu types is going to bite
  us, big time, later.
- on the other hand, it appears that cpu compatibility is not so
  "strong", "nice", or whatever do you want to call it on ARM land.

Why I am so worried?  Because we have spent lots (and I mean lots) of
time on x86_64 when we forgot to enable/disable/indicate that one cpu
has a new MSR/feature.  Normal problem is that it only happens when
customer is using that particular feature.  It has been the case for us
that to reporduce the problem we had to ping-pong migration several
hundred times between two different cpus until we found _why_ it failed.

So, I am pretty sure that:
a- doing it right is a lot of work now.
b- doing it fast now is a lot of work now, and much more work later.

Later, Juan.
