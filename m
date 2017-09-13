Received: from eggs.gnu.org ([2001:4830:134:3::10]:43970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsAms-0007lJ-DK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsAmr-0004h6-DU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:18 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box> <20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
	<4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
	<d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
	<20170913060203.GG7550@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <760c3889-8561-9bce-e565-ccbcb9eb8cf5@ilande.co.uk>
Date: Wed, 13 Sep 2017 17:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170913060203.GG7550@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org

On 13/09/17 07:02, David Gibson wrote:

>>> Alexey - do you recall from your analysis why these fields were no
>>> longer deemed necessary, and how your TCG tests were configured?
>>
>> I most certainly did not do analysis (my bad. sorry) - I took the patch
>> from David as he left the team, fixed to compile and pushed away. I am also
>> very suspicions we did not try migrating TCG or anything but pseries. My
>> guest that things did not break (if they did not which I am not sure about,
>> for the TCG case) because the interrupt controller (XICS) or the
>> pseries-guest took care of resending an interrupt which does not seem to be
>> the case for mac99.
> 
> Right, that's probably true.  The main point, though, is that these
> fields were dropped a *long* time ago, when migration was barely
> working to begin with.  In particular I'm pretty sure most of the
> non-pseries platforms were already pretty broken for migration
> (amongst other things).
> 
> Polishing the mac platforms up to working again, including migration,
> is a reasonable goal.  But it can't be at the expense of pseries,
> which is already working, used in production, and much better tested
> than mac99 or g3beige ever were.

Oh I completely agree since I'm well aware pseries likely has more users
than the Mac machines - my question was directed more about why we
support backwards migration.

I spent several hours yesterday poking my Darwin test case with trying
the different combinations of pending_interrupts, irq_input_state and
access_type and could easily provoke migration failures unless all 3 of
the fields were present so a practical test shows they are still
required for TCG migration. I think ppc_set_irq()'s use of the interrupt
fields in hw/ppc/ppc.c and the subsequent reference to pending
interrupts in target/ppc may explain why I see freezes/hangs until a key
is pressed in many cases.


ATB,

Mark.
