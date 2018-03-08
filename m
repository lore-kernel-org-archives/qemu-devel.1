Received: from eggs.gnu.org ([2001:4830:134:3::10]:59201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxpf-00071N-KQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etxpc-0002d7-J0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:51:51 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:40708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etxpc-0002bb-Ba
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:51:48 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t6so144396wmt.5
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:51:48 -0800 (PST)
Date: Thu, 8 Mar 2018 15:51:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308155145.GD2769@stefanha-x1.localdomain>
References: <4509561520419741@web56g.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <4509561520419741@web56g.yandex.ru>
Subject: Re: [Qemu-devel] BUG? Using memory after freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksey Kuleshov <rndfax@yandex.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 01:49:01PM +0300, Aleksey Kuleshov wrote:
> Hello!

Thanks for the email!  I have CCed the PCI maintainers, Michael Tsirkin
and Marcel Apfelbaum.

In the future you can find out who to contact using:

  $ scripts/get_maintainers -f hw/pci/pci_bridge.c

> Explanation of what I saw is follows.
>=20
> In hw/pci/pci_bridge.c function pci_bridge_update_mappings does follows:
> ```
> void pci_bridge_update_mappings(PCIBridge *br)
> {
>     PCIBridgeWindows *w =3D br->windows;
>=20
>     /* Make updates atomic to: handle the case of one VCPU updating the b=
ridge
>      * while another accesses an unaffected region. */
>     memory_region_transaction_begin();
>     pci_bridge_region_del(br, br->windows);
>     br->windows =3D pci_bridge_region_init(br);
>     memory_region_transaction_commit();
>     pci_bridge_region_cleanup(br, w);
> }
> ```
>=20
> It calls memory_region_transaction_commit which calls flatview_unref:
> ```
> static void flatview_unref(FlatView *view)
> {
>     if (atomic_fetch_dec(&view->ref) =3D=3D 1) {
>         trace_flatview_destroy_rcu(view, view->root);
>         assert(view->root);
>         call_rcu(view, flatview_destroy, rcu);
>     }
> }
> ```
> As far as I understood, call_rcu can be considered as a deferred call to =
flatview_destroy.
>=20
> Then in pci_bridge_update_mappings there is a call to pci_bridge_region_c=
leanup which does:
> ```
> static void pci_bridge_region_cleanup(PCIBridge *br, PCIBridgeWindows *w)
> {
>     object_unparent(OBJECT(&w->alias_io));
>     object_unparent(OBJECT(&w->alias_mem));
>     object_unparent(OBJECT(&w->alias_pref_mem));
>     object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_IO_LO]));
>     object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_IO_HI]));
>     object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_MEM]));
>     g_free(w);
> }
> ```
> Note g_free(w). "w" holds MemoryRegions, which are part of that FlatView
> which is going to be destroyed some time later in the future.
>=20
> When RCU thread kicks in, flatview_destroy is called on MemoryRegions whi=
ch were
> part of that "w" which is now freed and QEMU seg faults.
>=20

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoVwRAAoJEJykq7OBq3PIFPUH/jE3rKYv7Oi/j+kvKgn33aQs
wWWwBAWFqIhwSewYilvFzL019sRZ8gUp9jTmZZlqgxoy/vXpL54BEXws/zQVP/qX
QSYKao5Y4/pR/eExleQcbv2th+EstyXlZhXOOw5eNN3UgdrNGWFZjUNtFJ09aoxD
ruZh3lkSMsIeR8xwFBN3Vp/nBzzK7RMBdj6dU4uAMDuCTFBNjIdl2rNU072SPL03
yIcsHJakU984fwPvbfSUV2qs1Vz940gYHWTlOhT/5Zm9doNX68t8lA61JlDs1zmA
8Rsr5PEnGXgKckIxKhhLlBFpvj3zLNjqmDVKF+JRVv9Bf5SVkrcCSLCQzPNfWSo=
=xHPv
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
