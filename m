Received: from eggs.gnu.org ([209.51.188.92]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkUqB-0008UO-GT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.mielke@gmail.com>) id 1gkUq8-0005Et-H4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:09:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mark.mielke@gmail.com>)
	id 1gkUq8-0005A4-3I
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:09:44 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so15220897wra.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:09:44 -0800 (PST)
MIME-Version: 1.0
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
	<20190118134451.GM20660@redhat.com>
In-Reply-To: <20190118134451.GM20660@redhat.com>
From: Mark Mielke <mark.mielke@gmail.com>
Date: Fri, 18 Jan 2019 09:09:31 -0500
Message-ID: <CALm7yL2g6a=3P_9ujmi_CbKXp8pisWfH1cD8hHMBhc7hf1aqUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 8:44 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Fri, Jan 18, 2019 at 01:57:31PM +0100, Paolo Bonzini wrote:
> > On 18/01/19 11:21, Daniel P. Berrang=C3=A9 wrote:
> > > Yes, this is exactly why I said we should make the migration blocker
> > > be conditional on any L2 guest having been started. I vaguely recall
> > > someone saying there wasn't any way to detect this situation from
> > > QEMU though ?
> > You can check that and give a warning (check that CR4.VMXE=3D1 but no
> > other live migration state was transferred).  However, without live
> > migration support in the kernel and in QEMU you cannot start VMs *for
> > the entire future life of the VM* after a live migration.  So even if w=
e
> > implemented that kind of blocker, it would fail even if no VM has been
> > started, as long as the kvm_intel module is loaded on migration.  That
> > would be no different in practice from what we have now.
> Ahh, I was mis-understanding that it only applied to L2 VMs that
> existed at the time the migration is performed. Given that it breaks
> all future possibility of launching an L2 VM, this strict blocker does
> make more sense.
>

To explain my use case more fully:

Right now all guests are on Linux 4.14.79+ hypervisors, with Qemu 2.12.1+.

I understand the value of this feature, and I need to get all the guests to
Linux 4.19.16+ hypervisors, with Qemu 3.2 (once it is available).

As documented, and as best as I can read from the source code and this
mailing list, the recommended solution would be for me to upgrade Linux and
Qemu on existing hypervisors, and then restart the entire environment.
After it comes up with the new kernel, and the new qemu, everything will be
"correct".

This model will not be well received by users. We have long running
operations of all sorts, and restarting them all at the same time is a very
big problem.

I would like to heal this system over time.

The first stage will include introducing new Linux 4.19.16+ hypervisors,
and migrating the guests to these machines carefully and opportunistically.
Carefully means that machines that will use L2 guests will need to be
restarted in discussion with the users(or their hypervisors avoided from
this exercise), but most (80%+) of machines that will never launch an L2
guest can migrate live with low risk (at least according to our experience
to date). This will allow existing hypervisors to be freed up so that they
too can be upgraded to Linux 4.19.16+.

The second stage will include upgrading to Qemu 3.2 once it is available
and demonstrated to be stable for our use cases. However, I will need to be
able to live migrate most (80%+) systems from Qemu 2.12.1+ to Qemu 3.2. We
would again handle the machines with L2 guests with care.

If Qemu 3.2 will be ready sooner (weeks?), I would wait before migration,
and combine the above two steps such the new hypervisors would have both
Linux 4.19.16+ and Qemu 3.2. But, if Qemu 3.2 is months away, I would keep
it as two steps.

A large number of systems would be shut down and replaced as part of normal
processes, which would automatically heal these.

The long running machines would not be healed, but they would be no worse
than they are today.

To achieve this, I need a path to live migrate from Qemu 2.12.1+ with VMX
bit set in the guest, to Qemu 3.2. Further complicating things is that we
are using OpenStack, so options for tweaking flags on a case by case basis
would be limited or non-existent.

I'm totally fine with the understanding that any machine not restarted is
still broken under Qemu 3.2, just as it was broken under Qemu 2.12. New
machines will be correct, and the broken machines can be fixed
opportunistically and in discussion with the users.

And, we don't need a system-wide restart of the whole cluster to deploy
Qemu 3.2.

--=20
Mark Mielke <mark.mielke@gmail.com>
