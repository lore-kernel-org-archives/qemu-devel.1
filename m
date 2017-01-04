Received: from eggs.gnu.org ([2001:4830:134:3::10]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cOsr6-0001jD-U8
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cOsr5-0005UL-QB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:12:20 -0500
MIME-Version: 1.0
In-Reply-To: <1ab62b16-8c59-ccd6-9011-43e4571a75fb@redhat.com>
References: <1482268300-10082-1-git-send-email-andrew.smirnov@gmail.com>
	<1ab62b16-8c59-ccd6-9011-43e4571a75fb@redhat.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 4 Jan 2017 13:12:14 -0800
Message-ID: <CAHQ1cqF1ugeH0rt38MWV7Zusg2rb3Tdi6r1CmefHoon6CMWUcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fsl_etsec: Fix Tx BD ring wrapping handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, Scott Wood <scottwood@freescale.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, Dec 25, 2016 at 8:12 PM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2016=E5=B9=B412=E6=9C=8821=E6=97=A5 05:11, Andrey Smirnov wrote:
>>
>> Current code that handles Tx buffer desciprtor ring scanning employs the
>> following algorithm:
>>
>>         1. Restore current buffer descriptor pointer from TBPTRn
>>
>>         2. Process current descriptor
>>
>>         3. If current descriptor has BD_WRAP flag set set current
>>            descriptor pointer to start of the descriptor ring
>>
>>         4. If current descriptor points to start of the ring exit the
>>            loop, otherwise increment current descriptor pointer and go
>>            to #2
>>
>>         5. Store current descriptor in TBPTRn
>>
>> As it can be seen the way the code is implemented results in buffer
>> descriptor ring being scanned starting at offset/descriptor #0. While
>> covering proverbial "99%" of the cases, this algorithm becomes
>> problematic for a number of edge cases.
>>
>> Consider the following scenario: guest OS driver initializes descriptor
>> ring to N individual descriptors and starts sending data out. Depending
>> on the volume of traffic and probably guest OS driver implementation it
>> is possible that an edge case where a packet, spread across 2
>> descriptors is placed in descriptors N - 1 and 0 in that order(it is
>> easy to imagine similar examples involving more than 2 descriptors).
>>
>> What happens then is aforementioned algorithm starts at descriptor 0,
>> sees a descriptor marked as BD_LAST, which it happily sends out as a
>> separate packet(very much malformed at this point) then the iteration
>> continues and the first part of the original packet is tacked to the
>> next transmission which ends up being bogus as well.
>>
>> This behvaiour can be pretty reliably observed when scp'ing data from a
>> guest OS via TAP interface for files larger than 160K (every time for
>> 700K+).
>>
>> This patch changes the scanning algorithm to do the following:
>>
>>         1. Restore "current" and "start" buffer descriptor pointer from
>>            TBPTRn
>>
>>         2. If "current" descriptor has BD_WRAP flag set "next"
>>            descriptor pointer to start of the descriptor ring otherwise
>>            set "next" to descriptor right after "current"
>>
>>         3. Process current descriptor
>>
>>         4. If current descriptore has BD_LAST(end of a packet) set save
>>            "next" descriptor pointer in TBPTRn
>>
>>         5. Set "current" descriptor pointer to "next"
>>
>>         6. If "current" descriptor points to "start" (from #1) exit the
>> loop
>>            loop, otherwise go to #2
>
>
> Hi, I'm not familiar with this card but this seems could be simply addres=
sed
> by exiting the loop when bd_flags !=3D BD_TX_READY instead of bd_addr !=
=3D
> ring_base (which seems buggy for heavy load)?

This would change the emulated behavior, since original implementation
would scan the entirety of buffer descriptor ring and process every
entry with "READY" bit set regardless if those descriptors were placed
right after each other or had gaps.

That being said, I don't have any reason to believe that
aforementioned peculiarity is correct behavior that actual HW would
exhibit. I can't seem to find any detailed description of what goes
under the hood in RM except for this:

"... The TBPTR register is internally written by the eTSEC=E2=80=99s DMA
controller during transmission. The pointer increments by eight
(bytes) each time a descriptor is closed successfully by the eTSEC..."

And reading that seems to suggest, that what you are proposing,
besides being simpler solution, might also be the correct way to
emulate this aspect of eTSEC's DMA engine behavior.

Let me experiment and see if encounter any problems with this
approach. I'll post updated version of the patch if it works out.

Thanks,
Andrey Smirnov
