Received: from eggs.gnu.org ([2001:4830:134:3::10]:46294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fcssU-0006fH-O1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fcssP-0004wv-MQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:40:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fcssP-0004we-AW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:40:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id b15-v6so14682142wrv.10
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 06:40:21 -0700 (PDT)
Date: Tue, 10 Jul 2018 14:40:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180710134018.GC30635@stefanha-x1.localdomain>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
	<CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
	<20180703100555.GG16791@stefanha-x1.localdomain>
	<CA+a=Yy6NFKky=rBetZp1x7-vn4mRkoPLfCUqpp8L31CJegYTeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <CA+a=Yy6NFKky=rBetZp1x7-vn4mRkoPLfCUqpp8L31CJegYTeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Tao <bergwolf@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kata-dev@lists.katacontainers.io


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 11:10:12PM +0800, Peng Tao wrote:
> On Tue, Jul 3, 2018 at 6:05 PM, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> > On Mon, Jul 02, 2018 at 09:52:08PM +0800, Peng Tao wrote:
> >> On Mon, Jul 2, 2018 at 9:10 PM, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> >> > On Sat, Mar 31, 2018 at 04:45:00PM +0800, Lai Jiangshan wrote:
> >> > Risks:
> >> > 1. If one cloned VM is exploited then all other VMs are more likely =
to
> >> >    be exploitable (e.g. kernel address space layout randomization).
> >> w.r.t. KASLR, any memory duplication technology would expose it. I
> >> remember there are CVEs (e.g., CVE-2015-2877) specific to this kind
> >> attack against KSM and it was stated that "Basically if you care about
> >> this attack vector, disable deduplication.". Share-until-written
> >> approaches for memory conservation among mutually untrusting tenants
> >> are inherently detectable for information disclosure, and can be
> >> classified as potentially misunderstood behaviors rather than
> >> vulnerabilities. [1]
> >>
> >> I think the same applies to vm templating as well. Actually VM
> >> templating is more useful (than KSM) in this regard since we can
> >> create a template for each trusted tenant where as with KSM all VMs on
> >> a host are treated equally.
> >>
> >> [1] https://access.redhat.com/security/cve/cve-2015-2877
> >
> > That solves the problem between untrusted users but a breach in one
> > clone may reveal secrets of all other clones belonging to the same
> > tenant.  As a user, I would be uncomfortable knowing that if one of my
> > machines is breached then secrets used by all of my machines might be
> > exposed.
> >
> Secrets are really point 2 in your list and I'll answer it below :)
>=20
> >> > 2. If you give VMs cloned from the same template to untrusted users,
> >> >    they may be able to determine the secrets other users' VMs.
> >> In kata and runv, vm templating is used carefully so that we do not
> >> use or save any secret keys before creating the template VM. IOW, the
> >> feature is not supposed to be used generally to create any template
> >> VMs at any stage.
> >
> > At what point are templates captured to avoid these problems?  Is there
> > code that shows how to do this?
> >
> Both runv and kata pauses the VM right after the agent inside guest is
> up and running, which, in the initramfs case, translates into the
> point that kernel boots and the init process starts. If you are
> interested in seeing the actual code, you can look at
> https://github.com/hyperhq/hyperstart/ and
> https://github.com/kata-containers/agent for what is done in the guest
> at that point. If you see any secrets being saved there, I'll be more
> than happy to fix it. :)

Two things come to mind:

At that point both guest kernel and agent address-space layout
randomization (ASLR) is finished.  ALSR makes it harder for memory
corruption bugs to lead to real exploits because the attacker does not
know the full memory layout of the process.  Cloned VMs will not benefit
=66rom ASLR because much of the memory layout of the guest kernel and
agent will be identical across all clones.

Software random number generators have probably been initialized at this
point.  This doesn't mean that all cloned VMs will produce the same
sequence of random numbers since they should incorporate entropy sources
or use hardware random number generators, but the quality of random
numbers might be reduced.  Someone who knows random number generators
should take a look at this.

> >> >  Security is a
> >> > major factor for using Kata, so it's important not to leak secrets
> >> > between cloned VMs.
> >> >
> >> Yes, indeed! And it is all about trade-offs, VM templating or KSM. If
> >> we want security above anything, we should just disable all the
> >> sharing. But there is actually no ceiling (think about physical
> >> isolation!). So it's more about trade-offs. With Kata, VM templating
> >> and KSM give users options to achieve better performance and lower
> >> memory footprint with little sacrifice. The security advantage of
> >> running VM-based containers is still there.
> >
> > Adding options to enable/disable features leads to confusion among
> > users, makes performance comparisons harder, and increases support
> > overhead.
> >
> > Technical solutions to the security problems are possible.  I'm
> > interested in progress in this area because it means users don't need to
> > make a choice, they can benefit from the feature without sacrificing
> > security.
> >
> Well, that is really beyond the scope of the reviewing of this
> particular QEMU patch. But as a Kata developer, I can answer it
> anyway.
>=20
> For one thing, Kata already has quite a few configuration options that
> let users choose different features. For another thing, Kata already
> ships with KSM support by default and VM templating in Kata is better
> off than KSM in many aspects (e.g., by providing similar level of
> memory conservation w/o affecting host and guest performance). So from
> Kata containers point of view, it makes sense to have VM templating
> support and let users decide which one they want to use.
>=20
> PS: CCing kata-dev since the discussion starts to concern about Kata
> specific usage.

Thanks for doing that.  I think discussing the security implications of
vm templates (clones) is important specifically for Kata.

Stefan

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRLdCAAoJEJykq7OBq3PILawH/1/3AJ/YjBW7iJ9MGj+GuHPv
i1wTZLADF1uYhQQZVc8DWlsSHAcRdEKI0PMGS+dYI+RBGXfUrdCdwZb5CHpIcQY9
eJAQxT1HVtUKc5B7JvzotWLqFY0k8jTFiLJURlyZh5CKbW9d+enLV7XMyjmE+1w/
Z0MjF6T2lhQ4O2NpdDGZGK0pUyLzhGBeEvR/O/Is9Y4khm4OReP4Z93TI8P9+VmO
v8Wc+wfxlg1+3CWhYuS0l0hEelx8KA9W0Rh0/gMjdhq/oluFkQNBUe5f4gcA79X1
z//4eolXdTDdXUx6977If+8xY6XygwRWucLLfBgZTqwWZEkpMAPV00OKixLJtgM=
=kOyG
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
