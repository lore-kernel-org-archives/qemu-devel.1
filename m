Received: from eggs.gnu.org ([2001:4830:134:3::10]:48775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPKek-0007ix-Pb
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 21:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPKeh-0002cg-N6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 21:53:26 -0500
References: <20170105202636.4003-1-andrew.smirnov@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c42c0854-2c8c-9ae4-6d66-daff02a2a290@redhat.com>
Date: Fri, 6 Jan 2017 10:53:12 +0800
MIME-Version: 1.0
In-Reply-To: <20170105202636.4003-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] fsl_etsec: Fix Tx BD ring wrapping
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-ppc@nongnu.org
Cc: Scott Wood <scottwood@freescale.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org



On 2017=E5=B9=B401=E6=9C=8806=E6=97=A5 04:26, Andrey Smirnov wrote:
> Current code that handles Tx buffer desciprtor ring scanning employs th=
e
> following algorithm:
>
> 	1. Restore current buffer descriptor pointer from TBPTRn
>
> 	2. Process current descriptor
>
> 	3. If current descriptor has BD_WRAP flag set set current
> 	   descriptor pointer to start of the descriptor ring
>
> 	4. If current descriptor points to start of the ring exit the
> 	   loop, otherwise increment current descriptor pointer and go
> 	   to #2
>
> 	5. Store current descriptor in TBPTRn
>
> The way the code is implemented results in buffer descriptor ring being
> scanned starting at offset/descriptor #0. While covering 99% of the
> cases, this algorithm becomes problematic for a number of edge cases.
>
> Consider the following scenario: guest OS driver initializes descriptor
> ring to N individual descriptors and starts sending data out. Depending
> on the volume of traffic and probably guest OS driver implementation it
> is possible that an edge case where a packet, spread across 2
> descriptors is placed in descriptors N - 1 and 0 in that order(it is
> easy to imagine similar examples involving more than 2 descriptors).
>
> What happens then is aforementioned algorithm starts at descriptor 0,
> sees a descriptor marked as BD_LAST, which it happily sends out as a
> separate packet(very much malformed at this point) then the iteration
> continues and the first part of the original packet is tacked to the
> next transmission which ends up being bogus as well.
>
> This behvaiour can be pretty reliably observed when scp'ing data from a
> guest OS via TAP interface for files larger than 160K (every time for
> 700K+).
>
> This patch changes the scanning algorithm to do the following:
>
> 	1. Restore "current" buffer descriptor pointer from
> 	   TBPTRn
>
> 	2. If "current" descriptor does not have BD_TX_READY set, goto #6
>
> 	3. Process current descriptor
>
> 	4. If "current" descriptor has BD_WRAP flag set "current"
> 	   descriptor pointer to start of the descriptor ring otherwise
> 	   set increment "current" by the size of one descriptor
>
> 	5. Goto #1
>
> 	6. Save "current" buffer descriptor in TBPTRn
>
> This way we preserve the information about which descriptor was
> processed last and always start where we left off avoiding the original
> problem. On top of that, judging by the following excerpt from
> MPC8548ERM (p. 14-48):
>
> "... When the end of the TxBD ring is reached, eTSEC initializes TBPTRn
> to the value in the corresponding TBASEn. The TBPTR register is
> internally written by the eTSEC=E2=80=99s DMA controller during
> transmission. The pointer increments by eight (bytes) each time a
> descriptor is closed successfully by the eTSEC..."
>
> revised algorithm might also a more correct way of emulating this aspec=
t
> of eTSEC peripheral.
>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Changes since v1:
>
> 	- Simplified new algorithm as per Jason Wang's suggestion
>
> Changes since v2:
>
> 	- Fixed code style problems
>
>   hw/net/fsl_etsec/rings.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index 54c0127..d0f93ee 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -358,25 +358,24 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nb=
r)
>           /* Save flags before BD update */
>           bd_flags =3D bd.flags;
>  =20
> -        if (bd_flags & BD_TX_READY) {
> -            process_tx_bd(etsec, &bd);
> -
> -            /* Write back BD after update */
> -            write_buffer_descriptor(etsec, bd_addr, &bd);
> +        if (!(bd_flags & BD_TX_READY)) {
> +            break;
>           }
>  =20
> +        process_tx_bd(etsec, &bd);
> +        /* Write back BD after update */
> +        write_buffer_descriptor(etsec, bd_addr, &bd);
> +
>           /* Wrap or next BD */
>           if (bd_flags & BD_WRAP) {
>               bd_addr =3D ring_base;
>           } else {
>               bd_addr +=3D sizeof(eTSEC_rxtx_bd);
>           }
> +    } while (TRUE);
>  =20
> -    } while (bd_addr !=3D ring_base);
> -
> -    bd_addr =3D ring_base;
> -
> -    /* Save the Buffer Descriptor Pointers to current bd */
> +    /* Save the Buffer Descriptor Pointers to last bd that was not
> +     * succesfully closed */
>       etsec->regs[TBPTR0 + ring_nbr].value =3D bd_addr;
>  =20
>       /* Set transmit halt THLTx */

Applied to -net.

Thanks
