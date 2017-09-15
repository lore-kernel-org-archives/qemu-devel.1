Received: from eggs.gnu.org ([2001:4830:134:3::10]:47068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dssKN-0002oM-P0
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dssKI-0000Zt-Pt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:14:47 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dssKI-0000Z0-JK
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:14:42 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 147F1AC350
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 17:14:40 +0200 (CEST)
Date: Fri, 15 Sep 2017 17:14:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170915171432.7a5cb91a@bahia.lan>
In-Reply-To: <e0f55ca1-81e1-9c03-c6ad-0d099360db55@redhat.com>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541712226.1616.17581342887936984948.stgit@bahia.lan>
	<e0f55ca1-81e1-9c03-c6ad-0d099360db55@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Rwl_JvF7sr1JIlh66p2Kaqh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/3] kvm: check KVM_CAP_SYNC_MMU with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/Rwl_JvF7sr1JIlh66p2Kaqh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Sep 2017 07:32:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 14.09.2017 21:25, Greg Kurz wrote:
> > On a server-class ppc host, this capability depends on the KVM type,
> > ie, HV or PR. If both KVM are present in the kernel, we will always
> > get the HV specific value, even if we explicitely requested PR on
> > the command line.
> >=20
> > This can have an impact if we're using hugepages or a balloon device.
> >=20
> > Since we've already created the VM at the time any user calls
> > kvm_has_sync_mmu(), switching to kvm_vm_check_extension() is
> > enough to fix any potential issue.
> >=20
> > It is okay for the other archs that also implement KVM_CAP_SYNC_MMU,
> > ie, mips, s390, x86 and arm, because they don't depend on the VM being
> > created or not.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  accel/kvm/kvm-all.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index f85553a85194..323c567cfb68 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2234,7 +2234,7 @@ int kvm_device_access(int fd, int group, uint64_t=
 attr,
> >  /* Return 1 on success, 0 on failure */
> >  int kvm_has_sync_mmu(void)
> >  {
> > -    return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> > +    return kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> >  } =20
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
> ... but while you're at it, maybe it would be better to use a bool
> variable for the state of this extension, too, and only check for the
> extension one time at the end of kvm_init() ? kvm_has_sync_mmu() is
> apparently used multiple times in other source files, so we might be
> able to save some cycles by doing the syscall only once?
>=20
>  Thomas
>=20
>=20

Oops, I had overlooked your answer... yes it makes sense indeed.

I'll post a v2 of this patch (not resending the whole series).

Cheers,

--
Greg

--Sig_/Rwl_JvF7sr1JIlh66p2Kaqh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbvuWAAKCRAC/DrrAQHb
wkJXAJ9bffsRUO1tJlF+HUT9/Nt0Vk5+QACfTazvcZqMKPN6PI2jA9lHU5vWEa8=
=PBgc
-----END PGP SIGNATURE-----

--Sig_/Rwl_JvF7sr1JIlh66p2Kaqh--
