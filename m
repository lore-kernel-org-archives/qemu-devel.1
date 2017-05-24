Received: from eggs.gnu.org ([2001:4830:134:3::10]:37412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mapfelba@redhat.com>) id 1dDV0L-0007Kj-0I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mapfelba@redhat.com>) id 1dDV0H-0007Ye-53
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mapfelba@redhat.com>) id 1dDV0G-0007Ws-RR
	for qemu-devel@nongnu.org; Wed, 24 May 2017 08:03:01 -0400
Date: Wed, 24 May 2017 08:01:47 -0400 (EDT)
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <231699708.13319856.1495627307861.JavaMail.zimbra@redhat.com>
In-Reply-To: <87r2zeu8af.fsf@dusky.pond.sub.org>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<87wp97hqi4.fsf@dusky.pond.sub.org>
	<4011bf08-8686-f2ae-474e-004aa603cc0e@amsat.org>
	<87r2zeu8af.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jiri@resnulli.us, jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>



----- Original Message -----
> From: "Markus Armbruster" <armbru@redhat.com>
> To: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org, "Mao Zhongyi" <maozy.fnst@cn.fujitsu.com>, jir=
i@resnulli.us, jasowang@redhat.com, "Michael
> S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum" <marcel@redhat.com>
> Sent: Wednesday, May 24, 2017 8:35:04 AM
> Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead erro=
r handling
>=20
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
> > Hi Markus,
> >
> > On 05/23/2017 06:27 AM, Markus Armbruster wrote:
> > [...]
> >> There's one more cleanup opportunity:
> >>
> > [...]
> >>>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->bu=
f,
> >>>      size)) {
> >>>          return NULL;
> >>>      }
> >>
> >> None of the pci_dma_read() calls outside rocker check the return value=
.
> >> Just as well, because it always returns 0.  Please clean this up in a
> >> separate followup patch.
> >
> > It may be the correct way to do it but this sounds like we are missing
> > something somewhere... pci_dma_read() calls pci_dma_rw() which always
> > returns 0. Why not let it returns void? It is inlined and never used
> > by address. Else we should document why returning 0 is correct, and
> > what is the reason to not use a void prototype.
> >
> > pci_dma_rw() calls dma_memory_rw() which does return a boolean value,
> > false on success (MEMTX_OK) and true on error
> > (MEMTX_ERROR/DECODE_ERROR)
>=20
> PCI question.  Michael, Marcel?
>=20

Hi Markus,

Looking at the git history, pci_dma_rw used to call cpu_physical_memory_rw
which, at that time (commit ec17457), returned void. Since the interface di=
ctated
to return int, 0 is returned as "always OK".

The callers to pci_dma_read did not bother to check it for obvious reasons =
(even if they should).

In the meantime the memory API has changed to allow returning errors, but s=
ince the callers of
pci_dma_rw don't check the return value, why bother to update the PCI DMA?

History aside (and my speculations above), it seems  the right move is to u=
pdate
the return value and check it by callers, but honestly I don't have any ide=
a
if the emulated devices expect pci dma to fail.
Adding Paolo and David for more insights.

Thanks,
Marcel
