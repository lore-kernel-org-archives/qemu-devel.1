Received: from eggs.gnu.org ([2001:4830:134:3::10]:59234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVxAS-0004ol-0a
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVxAO-00084j-Ul
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:50:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVxAO-00082g-Py
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:50:16 -0400
References: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
	<776e542e-b6e1-ccbb-fb9a-ea7d521cd955@redhat.com>
	<d1756dd7-a838-6977-0847-3a4bd5c93689@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79d04e9f-df54-16ac-3c66-09424f515635@redhat.com>
Date: Thu, 21 Jun 2018 12:50:08 +0200
MIME-Version: 1.0
In-Reply-To: <d1756dd7-a838-6977-0847-3a4bd5c93689@redhat.com>
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
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 20/06/2018 22:28, John Snow wrote:
>=20
> ...Oh. So the PIO Setup FIS ... gets generated before the data is sent,
> but we don't copy it to the HBA memory buffers and notify the client
> until afterwards, but this is per-DRQ, I think, and not per-IDE command=
.

No, the copy happens before: "When a PIO setup FIS arrives from the
device, the HBA copies it to the PSFIS area of this structure".

However, the interrupt happens after the data is received too (and
whether it happens is decided per-FIS, i.e. per-DRQ).

>> Putting things together, there are two bugs in QEMU;
>>
>> - the PIO Setup interrupt must be generated at the end of data transfe=
r
>>
> Oops.
>=20
>> - the PIO Setup interrupt must not be generated for the ATAPI command
>> transfer
>>
> Oops again. I ought to have stopped you but I was long aware that the
> PIO Setup FIS ought to be generated "before" the transfer. I suppose
> what we were doing was more correct, though.

Not really, it's half and half and in fact the second of these two bugs
was very much preexisting.

Certainly it was wrong to generate the interrupt after the callback was
invoked, i.e. per command rather than per-DRQ.  This was the important
part of the original patch series because it is what made the recursion
not a tail recursion.

It's really hard to review this stuff since you have to find all the
tidbits across the AHCI and SATA (and sometimes ATA command set) specs.
If anything the blame goes to both of us for not testing the CD-ROM boot
case, rather than to you for missing it during the code review!

And on the bright side, it's still a win:

- it's possible to fix the bug without jeopardizing the whole READ CD ser=
ies

- we've learnt more of the interactions between the AHCI and SATA specs

- the bug was discovered quickly enough

Paolo
