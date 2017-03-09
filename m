Received: from eggs.gnu.org ([2001:4830:134:3::10]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ8-0001v7-ML
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ4-0003yL-Jb
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:02 -0500
Date: Thu, 9 Mar 2017 12:29:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170309012910.GJ19967@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<20170305230627.GA12030@umbus.fritz.box>
	<20170306114752.GS2778@thinpad.lan.raisama.net>
	<20170307033105.GB19967@umbus.fritz.box>
	<20170307120237.GF2778@thinpad.lan.raisama.net>
	<20170308023345.GH19967@umbus.fritz.box>
	<20170308120850.GA4694@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AwgMNpd3VkAVXjS"
Content-Disposition: inline
In-Reply-To: <20170308120850.GA4694@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>


--7AwgMNpd3VkAVXjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 09:08:50AM -0300, Eduardo Habkost wrote:
> On Wed, Mar 08, 2017 at 01:33:45PM +1100, David Gibson wrote:
> > On Tue, Mar 07, 2017 at 09:02:37AM -0300, Eduardo Habkost wrote:
> > > On Tue, Mar 07, 2017 at 02:31:05PM +1100, David Gibson wrote:
> > > > On Mon, Mar 06, 2017 at 08:47:52AM -0300, Eduardo Habkost wrote:
> > > > > On Mon, Mar 06, 2017 at 10:06:27AM +1100, David Gibson wrote:
> > > > > > On Fri, Mar 03, 2017 at 11:58:07AM -0300, Eduardo Habkost wrote:
> > > > > > > On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> > > > > > > > When running with KVM on POWER, we register some CPU types =
during
> > > > > > > > the initialization function of the ppc64 KVM code (which un=
fortunately
> > > > > > > > also can not be done via a type_init() like it is done on x=
86).
> > > > > > >=20
> > > > > > > Can you elaborate why it can't be done via type_init()? If the
> > > > > > > QOM type hierarchy depends on any runtime data unavailable at
> > > > > > > type_init(), we should fix that.
> > > > > >=20
> > > > > > Hmm.. how?  This is specifically for the special 'host' cpu in =
the
> > > > > > case of KVM.  We can't use a static configuration here, because=
 there
> > > > > > are things on the host that could limit what features of the CP=
U are
> > > > > > available for guest use.  So, we need KVM to be initialized in =
order
> > > > > > to query that information.
> > > > >=20
> > > > > There's nothing saying you need to query that information before
> > > > > type_register() or during class_init, does it? The behavior of
> > > > > TYPE_HOST_POWERPC_CPU after object_new() is called can be as
> > > > > dynamic as you want it to, but the QOM type hierarchy is supposed
> > > > > to be static.
> > > >=20
> > > > So, the thing is we have some properties that logically belong in t=
he
> > > > CPU class, rather than instance, and that's correct for all TCG CPU=
s,
> > > > but not for the KVM host CPU.  It seems nasty to have to force all
> > > > those things into the instance just because of KVM.
> > >=20
> > > You can still register any class properties you want, without
> > > querying KVM first. Are there properties that you are able to
> > > register only after querying KVM? Is the set of class properties
> > > on TYPE_HOST_POWERPC_CPU different depending on the host
> > > capabilities?
> >=20
> > Sorry, I used "properties" sloppily, not meaning QOM properties.
> >=20
> > There are several fields in the CPU class which describe CPU
> > capabilities - bitmasks indicating which instructions are available,
> > and L1 cacheline sizes.  There are some other things that are in the
> > CPU instance at the moment, but arguably would belong better in the
> > class: available page sizes and PTE encodings, for example.
> >=20
> > At the real hardware level these things are dependent only the model
> > of CPU - hence belonging in cpu class, not instance.  But, because of
> > the way virtualization works on POWER, some of the features may not be
> > available to guests, due to configuration of the hypervisor.  So for
> > the "host" cpu we need to query KVM to see which CPU features are
> > actually available.
> >=20
>=20
> I see. If there is data that is available only at PowerPCCPUClass
> and you don't want to duplicate it at PowerPCCPU, we can have a
> solution for that: instead of late-registration of the class, we
> could leave those fields to be populated after KVM is
> initialized.

Ok, that sounds workable.

> Anyway, I don't think this is urgent: the code already treats
> "host" as an exception in ppc_cpu_list(), and (AFAICS) the
> original problem this patch addresses is related to the
> inaccurate alias information only (which is not a consequence of
> the late type_register() call).

I agree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7AwgMNpd3VkAVXjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwK/kAAoJEGw4ysog2bOSo1gP/2iM39PfIsM+XcX4/7wWhxoY
XJWtrHfsBZ8Mdmsc/B41mydDxGcdZC/8aKcmGDFfgH7Ay7tlzg4DDJFfJMgUzMXX
Ge2mOQ1hezoIy8s9XXhwkRsSTBqjSo2x9c33KI2Jd1NUoT9sKo18Nl3HavDviaUv
8R9BtBojSc7qNZEgCVbtUtYeLTv0mQ5eYMON5yW9arfNJBAlL5htuk+eyXx+zObo
Uf01Rxdxj8aJShm3vev9rQCb9sgJt/5GsJg4nuFIoFCS0+3jD3/cEoqgMqY0IVdG
A85Gka+ec1fvn12853M6fMxyRK9F8Jj4LdFpmRQA3dZPinGUH9WcTii0lY/vmDVy
74hruFQsARAhTXz6obV39n+RM4ns2c55jCVaXAsCc61OjVA6ikk5nPRLPjMpgV1U
1XHRJuOnb7U1cQ/3R6l4Y1pb88NYURLjqAmCoC/ccwmXnhLjUGeIRkDr7zTsLH+t
3iFbSxTTxa8HBY0F5mw++ZvFC6uk9D8U45y51rtVAQbct8NIHV+5ngJCIJLgR5Ic
yJ114XcYn1q7dLo/P/FPqcHECFHm3aE040EJ1owwzp9yvzVuvNpiYFUreXhU1dNT
TIE9+qQ39ChkrPYfHstpevRwNvlpX8UPf9x6QvAevWw74Qs+jr/QOlGEXpAEGsbD
kIaq7Csvwv5wb5/oK+vy
=aDTZ
-----END PGP SIGNATURE-----

--7AwgMNpd3VkAVXjS--
