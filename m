Received: from eggs.gnu.org ([2001:4830:134:3::10]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVc4M-0003np-OM
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVc4J-0002Jl-Hz
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:18:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVc4J-0002JZ-C4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:18:35 -0400
References: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <776e542e-b6e1-ccbb-fb9a-ea7d521cd955@redhat.com>
Date: Wed, 20 Jun 2018 14:18:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] regression: sata cdrom boot broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, f4bug@amsat.org

On 20/06/2018 13:07, Gerd Hoffmann wrote:
>   Hi,
>=20
> $subject says all.  Noticed while testing the upcoming seabios update.
> Reproducer:
>=20
>   qemu-system-x86_64 -M q35 -m 4G -cdrom Fedora-Workstation-Live-x86_64=
-28-1.1.iso
>=20
> bisected to:
>=20
>   commit 956556e131e35f387ac482ad7b41151576fef057
>   Author: John Snow <jsnow@redhat.com>
>   Date:   Wed Jun 6 15:09:50 2018 -0400
>=20
>     ahci: move PIO Setup FIS before transfer, fix it for ATAPI commands
>=20
> cheers,
>   Gerd
>=20

If you know where to look at, the spec is actually pretty clear with
respect to when the interrupt is generated: "A PIO Setup FIS has been
received with the =E2=80=98I=E2=80=99 bit set, it has been copied into sy=
stem memory,
and the data related to that FIS has been transferred".

However, after reading the SATA specification I believe that the PIO
Setup FIS should never generate an interrupt in SeaBIOS, because:

  If this is the first DRQ data block for this command, the Interrupt
  bit shall be cleared to zero. If this is not the first DRQ data block
  for this command, the Interrupt bit shall be set to one

Putting things together, there are two bugs in QEMU;

- the PIO Setup interrupt must be generated at the end of data transfer

- the PIO Setup interrupt must not be generated for the ATAPI command
transfer

*But* because SeaBIOS always uses DMA for ATAPI commands, there should
never be more than one DRQ data block for each command, and it should be
possible to remove the fishy PIO Setup FIS handling in SeaBIOS.

Paolo
