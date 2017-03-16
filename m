Received: from eggs.gnu.org ([2001:4830:134:3::10]:59068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1coP4k-0007NL-AW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1coP4j-0003SE-KQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:39:54 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
Date: Thu, 16 Mar 2017 07:39:43 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, fred.konrad@greensocs.com



On 14/03/2017 18:34, BALATON Zoltan wrote:
> Like from the display controller models that use
> memory_region_get_dirty() to check if the frambuffer needs to be
> updated? But all display adaptors seem to do this and the problem was
> only seem on ppc so it may be related to something ppc specific.

You need to use test_and_clear_dirty instead of get_dirty/reset_dirty.
Or alternatively you need to reset immediately after get_dirty.  At
least cg3.c is doing

	read dirty bitmap
	read VRAM
	clear dirty bitmap

which has a race.

Paolo
