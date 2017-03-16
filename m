Received: from eggs.gnu.org ([2001:4830:134:3::10]:35638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQrN-0003J1-4k
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQrJ-0005js-W7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:34:13 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
	<95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
	<878to5psky.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d39e125-e0cf-5ecf-3564-9a6a5b3b0bb6@redhat.com>
Date: Thu, 16 Mar 2017 09:34:04 +0100
MIME-Version: 1.0
In-Reply-To: <878to5psky.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, fred.konrad@greensocs.com



On 16/03/2017 08:51, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 14/03/2017 18:34, BALATON Zoltan wrote:
>>> Like from the display controller models that use
>>> memory_region_get_dirty() to check if the frambuffer needs to be
>>> updated? But all display adaptors seem to do this and the problem was
>>> only seem on ppc so it may be related to something ppc specific.
>>
>> You need to use test_and_clear_dirty instead of get_dirty/reset_dirty.
>> Or alternatively you need to reset immediately after get_dirty.  At
>> least cg3.c is doing
>>
>> 	read dirty bitmap
>> 	read VRAM
>> 	clear dirty bitmap
>>
>> which has a race.
>=20
> Are you saying this is also racy also in the KVM case or just that TCG
> doesn't currently sync up with the current dirty bitmap mechanism?

It's okay for KVM because the dirty bitmap is copied from KVM by the
device itself, before updating the screen (with
memory_region_sync_dirty_bitmap).  For TCG, on the other hand, there is
full concurrency between the CPU that sets the bits and the device that
clears them.

> AIUI the memory regions are under RCU so you always get a consistent
> view (with updates after you take a copy going to the next iteration).

No, RCU only protects against resizes of the bitmap.  The bitmap is not
copied on every access (of course :)).

> What I think needs doing is hooking into the ->log-sync mechanism to
> reset SoftMMU TLB entries so the dirty detection carries on for the nex=
t
> sync point?

It's much simpler than that, just clear the dirty bitmap bit before
reading the memory.

Paolo
