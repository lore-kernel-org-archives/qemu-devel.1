Received: from eggs.gnu.org ([209.51.188.92]:40682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBHiV-0005nw-Cq
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 07:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBHiU-00060q-97
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 07:36:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hBHiT-0005u5-DK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 07:36:34 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <73925ca6-37ee-f932-ceb5-3144cd6b05cc@redhat.com>
Date: Tue, 2 Apr 2019 14:36:23 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <91001240-9112-4247-8D6A-6205F8DE1251@oracle.com>
References: <20190402080215.10747-1-vkuznets@redhat.com>
	<7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
	<461676dd-8a04-3d3e-86c0-76e143fa27b9@redhat.com>
	<47EDAADB-151A-43DC-B137-6E6DCD11BB64@oracle.com>
	<73925ca6-37ee-f932-ceb5-3144cd6b05cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>



> On 2 Apr 2019, at 13:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 02/04/19 11:08, Liran Alon wrote:
>>> -
>>> -            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
>>> -                IOAPIC_TRIGGER_LEVEL) {
>>> +            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
>>>                continue;
>>>            }
>> I think above =E2=80=9Cif=E2=80=9D of checking remote-irr should just =
be removed.
>> But the rest seems good :)
>>=20
>=20
> It seems more logical, as the condition is now the opposite of
> ioapic_set_irq: ioapic_set_irq services the interrupt if remote-irr =3D =
0,
> EOI does it if remote-irr =3D 1.
>=20
> Paolo

At this point at ioapic_eoi_broadcast(), you already know you got an EOI =
for a level-triggered interrupt.
Therefore, the remote-irr must be already set to 1. Otherwise, this is a =
bug. You can assert on this if you wish.
(Note that remote-irr is a read-only property that cannot be overwritten =
by guest writing to IOAPIC redirection-table)

-Liran
