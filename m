Received: from eggs.gnu.org ([2001:4830:134:3::10]:52889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coQBz-0008BZ-4R
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coQBw-0006rd-2N
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:51:27 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coQBv-0006r5-Rf
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:51:23 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so40467606wma.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 00:51:23 -0700 (PDT)
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
	<95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
Date: Thu, 16 Mar 2017 07:51:41 +0000
Message-ID: <878to5psky.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, fred.konrad@greensocs.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/03/2017 18:34, BALATON Zoltan wrote:
>> Like from the display controller models that use
>> memory_region_get_dirty() to check if the frambuffer needs to be
>> updated? But all display adaptors seem to do this and the problem was
>> only seem on ppc so it may be related to something ppc specific.
>
> You need to use test_and_clear_dirty instead of get_dirty/reset_dirty.
> Or alternatively you need to reset immediately after get_dirty.  At
> least cg3.c is doing
>
> 	read dirty bitmap
> 	read VRAM
> 	clear dirty bitmap
>
> which has a race.

Are you saying this is also racy also in the KVM case or just that TCG
doesn't currently sync up with the current dirty bitmap mechanism?

AIUI the memory regions are under RCU so you always get a consistent
view (with updates after you take a copy going to the next iteration).
What I think needs doing is hooking into the ->log-sync mechanism to
reset SoftMMU TLB entries so the dirty detection carries on for the next
sync point?

--
Alex Bennée
