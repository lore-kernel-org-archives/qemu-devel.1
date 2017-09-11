Received: from eggs.gnu.org ([2001:4830:134:3::10]:51742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drRr6-0006Tp-7k
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1drRr5-0000LG-7m
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:46:40 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cc212d72-1eff-86ae-1e34-fdc1636015e5@ilande.co.uk>
Date: Mon, 11 Sep 2017 17:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170911104854.GB2784@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lvivier@redhat.com, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 11/09/17 11:48, David Gibson wrote:

> On Mon, Sep 11, 2017 at 10:30:33AM +0100, Dr. David Alan Gilbert wrote:
>> * Greg Kurz (groug@kaod.org) wrote:
>>> On Sun, 10 Sep 2017 15:37:33 +0100
>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>>> Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescription"
>>>> appears to drop the internal CPU IRQ state from the migration stream. Whilst
>>>> testing migration on g3beige/mac99 machines, test images would randomly fail to
>>>> resume unless a key was pressed on the VGA console.
>>>>
>>>> Further investigation suggests that internal CPU IRQ state isn't being
>>>> preserved and so interrupts asserted at the time of migration are lost. Adding
>>>> the pending_interrupts and irq_input_state fields back into the migration
>>>> stream appears to fix the problem here during local tests.
>>>>
>>>> As part of this commit we bump the vmstate_ppc version from 5 to 6 to handle
>>>> the additional fields.
>>>>
>>>
>>> And so this unconditionally breaks backward migration... what about adding
>>> a subsection for this ?
>>
>> and wiring it to a flag on the machine type so that older machine types
>> don't send it.
> 
> Right, a subsection is certainly necessary to avoid breaking backwards
> migration.

The suggestion of using the VMSTATE_*_V macros with an increased version
number came from Alexey's original review of the patch many months ago
which is why I did it that way.

Out of curiosity though, what is the criteria for supporting backwards
migration? Obviously forward migration is supported as-is in this
manner, so what determines if a patch needs to be backwards compatible
and how far?

> But apart from that I want to understand better exactly why this is
> necessary.  What's the state that's being lost, and is it really not
> recoverable from anywhere else.

The test case I have is installing Darwin PPC 6.02 with qemu-system-ppc
TCG and repeatedly pausing, executing "savevm foo", then quitting and
continuing with "-loadvm foo" during the installation phase. About 1 in
10 times the installer hangs after the loadvm until I press a key, at
which point it carries on as normal.

I then proceeded to going backwards through the git history until I
found out that it was the removal of the pending_interrupts,
irq_input_state and access_type fields during the conversion to
VMStateDescription commit a90db15 which seemed to cause the problem.

> The other thing that concerns me is how we're encoding the
> information.  These are essentially internal fields, not reflecting
> something with an architected encoding - adding those to the migration
> stream is often a bad idea - it inhibits our ability to rework
> internal encodings.

I'm not sure how this should be managed, however there was a similar
issue with excp_prefix (which was also removed in a90db15) that was
fixed in 2360b6e by calling a helper in cpu_post_load(). I can't easily
see how could work with env.pending_interrupts and env.irq_input_state
though.


ATB,

Mark.
