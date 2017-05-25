Received: from eggs.gnu.org ([2001:4830:134:3::10]:58376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1dDhAg-0006b2-41
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1dDhAc-0003Ph-8c
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:02:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1dDhAc-0003PB-0r
	for qemu-devel@nongnu.org; Wed, 24 May 2017 21:02:30 -0400
Date: Thu, 25 May 2017 11:02:16 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20170525110216.78adc508@umbus.fritz.box>
In-Reply-To: <231699708.13319856.1495627307861.JavaMail.zimbra@redhat.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<87wp97hqi4.fsf@dusky.pond.sub.org>
	<4011bf08-8686-f2ae-474e-004aa603cc0e@amsat.org>
	<87r2zeu8af.fsf@dusky.pond.sub.org>
	<231699708.13319856.1495627307861.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/arNVa7uo_jBe6HNNvviEjIq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jiri@resnulli.us, jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

--Sig_/arNVa7uo_jBe6HNNvviEjIq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 08:01:47 -0400 (EDT)
Marcel Apfelbaum <marcel@redhat.com> wrote:

> ----- Original Message -----
> > From: "Markus Armbruster" <armbru@redhat.com>
> > To: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> > Cc: qemu-devel@nongnu.org, "Mao Zhongyi" <maozy.fnst@cn.fujitsu.com>, j=
iri@resnulli.us, jasowang@redhat.com, "Michael
> > S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum" <marcel@redhat.com>
> > Sent: Wednesday, May 24, 2017 8:35:04 AM
> > Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead er=
ror handling
> >=20
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
> >  =20
> > > Hi Markus,
> > >
> > > On 05/23/2017 06:27 AM, Markus Armbruster wrote:
> > > [...] =20
> > >> There's one more cleanup opportunity:
> > >> =20
> > > [...] =20
> > >>>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->=
buf,
> > >>>      size)) {
> > >>>          return NULL;
> > >>>      } =20
> > >>
> > >> None of the pci_dma_read() calls outside rocker check the return val=
ue.
> > >> Just as well, because it always returns 0.  Please clean this up in a
> > >> separate followup patch. =20
> > >
> > > It may be the correct way to do it but this sounds like we are missing
> > > something somewhere... pci_dma_read() calls pci_dma_rw() which always
> > > returns 0. Why not let it returns void? It is inlined and never used
> > > by address. Else we should document why returning 0 is correct, and
> > > what is the reason to not use a void prototype.
> > >
> > > pci_dma_rw() calls dma_memory_rw() which does return a boolean value,
> > > false on success (MEMTX_OK) and true on error
> > > (MEMTX_ERROR/DECODE_ERROR) =20
> >=20
> > PCI question.  Michael, Marcel?
> >  =20
>=20
> Hi Markus,
>=20
> Looking at the git history, pci_dma_rw used to call cpu_physical_memory_rw
> which, at that time (commit ec17457), returned void. Since the interface =
dictated
> to return int, 0 is returned as "always OK".
>=20
> The callers to pci_dma_read did not bother to check it for obvious reason=
s (even if they should).
>=20
> In the meantime the memory API has changed to allow returning errors, but=
 since the callers of
> pci_dma_rw don't check the return value, why bother to update the PCI DMA?
>=20
> History aside (and my speculations above), it seems  the right move is to=
 update
> the return value and check it by callers, but honestly I don't have any i=
dea
> if the emulated devices expect pci dma to fail.
> Adding Paolo and David for more insights.

It seems to me that PCI DMA transfers ought to be able to fail, and
devices ought to be able to handle that (to a limited extent).

After all, what will happen if you try to DMA to PCI addresses that
simply aren't mapped.  Or which are in the domain of a vIOMMU which
wither hasn't mapped those addreses, or has them mapped read-only
(meaning host-to-device only in this context).

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/arNVa7uo_jBe6HNNvviEjIq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJi0YAAoJEGw4ysog2bOSprMP/0pFGbAaSYllQtUIItoOksFP
RExTW04IwWJq/6gJwmwpxQ6DJKtXBXDhZGILvn8PLCUngBlnYmkVUK9JpCQi1jVF
GkrXoJ+unjYvC/+NmyezzJ5kGfHob5dxcueuxx3tqbxBDNRH/E3/GWVjEysA44bH
1GgqPMpyiBRmq5BpwEZ5f9BT/6XHtN+GWPPJo4EmIgRKn9E4mLmqP7BptEZ/FLN3
Ed15Q+lUZMUsV5qM5/o1ZOhk/26rAEE+XMiQWo9XRhfsYbrmG5G0XGLW+adFIjyv
wL8e7bNNmyMdCNu0PowME3zyTITF1GcJZSz3xDQOxZSCh+HbcYGc5eb48tnJ9zY9
VbDvqHfhnJyP31OfwHj7xSUhxT+heT3ZYMkQNDpPkbuf2LJwawcov6jfdW3jMhxh
Dewb3E420jFFtXn6SLVbcfZnJLCUwqfPuXTssJBZ2H8oo0rb6nCDswMbIZ6sZLd3
j8XjVMfSqkGPTZ2OY21NL66y+jm3oIS3uOlYzhHRBuJa82XE62GvgOXepm84/Ys/
rOW1GYcg/DC7hmy17Tdh2ZttxbWco1CDvFGpP5w42bnYfu7F6XR8MuYSnjzLhYUj
MFIt1ue+RjqKBOPk63ahx6MieHrTNVFZJ3BN1hQICNJSKvYS4AbSRnc0V3WckPnE
Wm0n8tGdSdB6KhH0S+3J
=bGeS
-----END PGP SIGNATURE-----

--Sig_/arNVa7uo_jBe6HNNvviEjIq--
