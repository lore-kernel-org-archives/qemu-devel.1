Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fx82I-0006Q7-Fk
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fx82D-0008EL-HL
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:54:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fx82D-0008Db-Bg
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:54:09 -0400
Date: Tue, 4 Sep 2018 11:54:02 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1604D594-E6D4-48BB-A270-F7CF1092978B@caviumnetworks.com>
Content-Transfer-Encoding: quoted-printable
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
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Auger Eric <eric.auger@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Sep 04, 2018 at 09:16:58AM +0000, Jaggi, Manish wrote:
> > On 31-Aug-2018, at 4:41 PM, Andrew Jones <drjones@redhat.com> wrote:
> > I think the sequence should look something like this:
> >=20
> >  1) Guest running on Host A with processor a
> >  2) Stop guest and save its state for migration
> >  3) Migrate guest to Host B with processor b (b is "close enough" to =
a)
> >  4) Restore guest state after migration
> >     If guest is running with '-cpu host'
> >       4.a) Inform KVM of any configuration that impacts invariant reg=
isters
> >       4.b) Update the guest's view of all invariant registers to matc=
h the
> >            host
> >     EndIf
> >  5) Run guest
> >=20
> > 4.a and 4.b require new code both in QEMU and KVM. 4.a may require a =
new
> > KVM API, unless the existing API can be leveraged.
> >=20
> > The definition of "close enough" is left to the users and/or higher l=
ayers
> > of the Virt stack.
> >=20
>=20
> Thanks for detailing the sequence.=20
> I got another comment from Juan and David which is not to use -cpu host=
, see below
>=20
> "I really think that the right approach here is not using -cpu host.  Y=
ou
> do the full work, create a model as David says, and be sure that you ca=
r
> run that model on both cpus.  It is a lot of work, but it is the only
> way to make sure that this is going to work long term.=E2=80=9D
>=20
> Not using -cpu host is orthogonal to the sequence we have been discussi=
ng in this thread.
> Use something like -cpu cortex-a57 (this however does not work so far)
> This would avoid close-enough definition, but would need substantial wo=
rk.
>=20
> So which approach should be taken here, whats your take...
>=20

Inventing a base-AArch64 cpu model that can then be extended with optiona=
l
features is a nice way to extend the migratability of a guest, however
it's hard to do because of errata. Since errata workarounds are enabled
per MIDR, then we'd need to invent our own MIDR and also some way to
communicate which errata we want to enable, possibly through some paravir=
t
mechanism or through some implementation defined system registers that
KVM would need to reserve and define.

That's not just a ton of work for the entire virt stack (not just KVM and
QEMU, but also all the layers above), but it's possible that it won't be
useful in the end anyway. There's risk that enabling just one erratum
workaround would restrict the guest to hosts of the exact same type
anyway. For each erratum that needs to be enabled, the probability of
enabling an incompatible one goes up, so it may not be likely to do much
better than '-cpu host' in the end. I'm afraid that until errata are
primarily showing up in optional CPU features that can simply be disabled
for the workaround, that we're stuck with '-cpu host'. I'd be happy to
discuss it more though.

In short, I'd go with the proposal above, for now, with possibly one
change. libvirt folk (Andrea Bolognani and Pino Toscano) suggest that
the guest invariant register updating on the destination host only be
done if the user opts-in to it. This is because right now if a user
tries to migrate to a host that is not 100% identical the migration
will fail, which makes the "mistake" clear. If we silently change the
behavior to allow it, then what could have been a mistake, because
the hosts aren't actually "close enough", may go unnoticed. I'm not
100% sure we need another user opt-in flag to be set, though, as I
think the '-cpu host' indicates the user expects the VCPU to look
like the host CPU, and even after migration that expectation should be
met. Simply, users that migrate '-cpu host' VMs need to know what they're
doing.

Thanks,
drew
