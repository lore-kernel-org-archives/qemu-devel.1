Received: from eggs.gnu.org ([209.51.188.92]:35438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Wdt-0005Ek-JF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Wdq-0006n8-DT
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1Wdn-0006kp-BI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:31:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-5-philmd@redhat.com>
Date: Wed, 06 Mar 2019 14:31:16 +0100
In-Reply-To: <20190305162829.20079-5-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 17:28:28
	+0100")
Message-ID: <87zhq8xh7f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/mips/malta: Only accept 'monitor'
 pflash of 4MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The Malta 'mother' board can use various 'daughter' core cards [1].
> QEMU only models the CoreLV card.
>
> The CoreLV card provides [2] a Galileo GT64120 as North bridge,
> connecting the CPU via the 'CBUS'. The CBUS also connects a 'Monitor
> flash' memory and maps it to the CPU RESET vector.
> The Monitor flash size is exactly 4 MiB.
> Refuse Monitor pflash of different size.
>
> [1] https://www.linux-mips.org/wiki/MIPS_Malta#Core_cards
> [2] "Malta User's Manual"  rev. 01.05 (MIPS Technologies doc number: MD00=
048)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_malta.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 396645b1a9..04788ff50a 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1267,6 +1267,11 @@ void mips_malta_init(MachineState *machine)
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
>      if (dinfo) {
>          pflash_blk =3D blk_by_legacy_dinfo(dinfo);
> +
> +        if (blk_getlength(pflash_blk) !=3D FLASH_SIZE) {
> +                error_report("Malta CoreLV card expects a bios of 4MB");
> +                exit(1);
> +        }
>  #ifdef DEBUG_BOARD_INIT
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>                 "addr %08llx '%s'\n",

I'm in favor of insisting on image size matching flash size, but I'd
rather do it in generic code.

We're already rejecting undersized images, with a sub-optimal error
message.  We're silently ignoring the tail of oversized images.  Alex
proposed a patch to generic code that does three things:

* We reject an undersized image with a sub-optimal error message.
  Improve that message.

* We silently ignore an oversized image's tail.  Warn instead.

* As a convenience feature, don't reject undersized read-only image, but
  pad it with 0xff instead, to simulate (1) above.

[v5] hw/block: better reporting on pflash backing file mismatch
Message-Id: <20190227111347.15063-1-alex.bennee@linaro.org>

I asked for the convenience feature split off into its own patch (and
offered to do it).

If we accept Alex's work (split or not), your patch merely kills the
convenience feature for this board.  I like killing it --- I consider it
a bad idea --- but if that's not in the cards, then I prefer all boards
to implement the same set of bad ideas.
