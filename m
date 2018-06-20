Received: from eggs.gnu.org ([2001:4830:134:3::10]:35958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVjir-00021p-Ij
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVjiq-0005Cj-Hk
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:28:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fVjiq-0005CX-Br
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:28:56 -0400
References: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
	<776e542e-b6e1-ccbb-fb9a-ea7d521cd955@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d1756dd7-a838-6977-0847-3a4bd5c93689@redhat.com>
Date: Wed, 20 Jun 2018 16:28:55 -0400
MIME-Version: 1.0
In-Reply-To: <776e542e-b6e1-ccbb-fb9a-ea7d521cd955@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org



On 06/20/2018 08:18 AM, Paolo Bonzini wrote:
> On 20/06/2018 13:07, Gerd Hoffmann wrote:
>>   Hi,
>>
>> $subject says all.  Noticed while testing the upcoming seabios update.
>> Reproducer:
>>
>>   qemu-system-x86_64 -M q35 -m 4G -cdrom Fedora-Workstation-Live-x86_6=
4-28-1.1.iso
>>
>> bisected to:
>>
>>   commit 956556e131e35f387ac482ad7b41151576fef057
>>   Author: John Snow <jsnow@redhat.com>
>>   Date:   Wed Jun 6 15:09:50 2018 -0400
>>
>>     ahci: move PIO Setup FIS before transfer, fix it for ATAPI command=
s
>>
>> cheers,
>>   Gerd
>>
>=20
> If you know where to look at, the spec is actually pretty clear with
> respect to when the interrupt is generated: "A PIO Setup FIS has been
> received with the =E2=80=98I=E2=80=99 bit set, it has been copied into =
system memory,
> and the data related to that FIS has been transferred".
>=20

You're quoting AHCI 1.3.1 section 3.3.5 here, the documentation for the
PxIS register.

...Oh. So the PIO Setup FIS ... gets generated before the data is sent,
but we don't copy it to the HBA memory buffers and notify the client
until afterwards, but this is per-DRQ, I think, and not per-IDE command.

> However, after reading the SATA specification I believe that the PIO
> Setup FIS should never generate an interrupt in SeaBIOS, because:
>=20
>   If this is the first DRQ data block for this command, the Interrupt
>   bit shall be cleared to zero. If this is not the first DRQ data block
>   for this command, the Interrupt bit shall be set to one
>=20

...and this gem is from SATA 3.2 section 11.9, "PIO data-out command
protocol." I have long wondered what controlled that 'I' bit...

> Putting things together, there are two bugs in QEMU;
>=20
> - the PIO Setup interrupt must be generated at the end of data transfer
>

Oops.

> - the PIO Setup interrupt must not be generated for the ATAPI command
> transfer
>=20

Oops again. I ought to have stopped you but I was long aware that the
PIO Setup FIS ought to be generated "before" the transfer. I suppose
what we were doing was more correct, though.

> *But* because SeaBIOS always uses DMA for ATAPI commands, there should
> never be more than one DRQ data block for each command, and it should b=
e
> possible to remove the fishy PIO Setup FIS handling in SeaBIOS.
>=20
> Paolo
>=20
