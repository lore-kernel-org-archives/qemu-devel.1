Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-00016I-10
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtN-0002i8-Sb
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:40 -0400
Date: Tue, 19 Sep 2017 06:37:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918203702.GH15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-6-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-6-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 5/8] ppc/mac: More rework of the DBDMA
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:45PM +0100, Mark Cave-Ayland wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This completely reworks the handling of the control register
> according to my understanding of the HW and the spec.
>=20
> It should (hopefully ... still testing) fix a number of issues
> most notably cases of MacOS hanging.
>=20
> Also update dbdma_unassigned_rw() and dbdma_unassigned_flush() to
> have the expected behaviour now that flush is handled slightly
> differently.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.11.

> ---
>  hw/misc/macio/mac_dbdma.c |  191 +++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 139 insertions(+), 52 deletions(-)
>=20
> diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
> index 15452b9..3fe5073 100644
> --- a/hw/misc/macio/mac_dbdma.c
> +++ b/hw/misc/macio/mac_dbdma.c
> @@ -96,9 +96,8 @@ static void dbdma_cmdptr_load(DBDMA_channel *ch)
> =20
>  static void dbdma_cmdptr_save(DBDMA_channel *ch)
>  {
> -    DBDMA_DPRINTFCH(ch, "dbdma_cmdptr_save 0x%08x\n",
> -                    ch->regs[DBDMA_CMDPTR_LO]);
> -    DBDMA_DPRINTFCH(ch, "xfer_status 0x%08x res_count 0x%04x\n",
> +    DBDMA_DPRINTFCH(ch, "-> update 0x%08x stat=3D0x%08x, res=3D0x%04x\n",
> +                    ch->regs[DBDMA_CMDPTR_LO],
>                      le16_to_cpu(ch->current.xfer_status),
>                      le16_to_cpu(ch->current.res_count));
>      dma_memory_write(&address_space_memory, ch->regs[DBDMA_CMDPTR_LO],
> @@ -166,15 +165,14 @@ static int conditional_wait(DBDMA_channel *ch)
>      uint16_t sel_mask, sel_value;
>      uint32_t status;
>      int cond;
> -
> -    DBDMA_DPRINTFCH(ch, "conditional_wait\n");
> +    int res =3D 0;
> =20
>      wait =3D le16_to_cpu(current->command) & WAIT_MASK;
> -
>      switch(wait) {
>      case WAIT_NEVER:  /* don't wait */
>          return 0;
>      case WAIT_ALWAYS: /* always wait */
> +        DBDMA_DPRINTFCH(ch, "  [WAIT_ALWAYS]\n");
>          return 1;
>      }
> =20
> @@ -187,15 +185,19 @@ static int conditional_wait(DBDMA_channel *ch)
> =20
>      switch(wait) {
>      case WAIT_IFSET:  /* wait if condition bit is 1 */
> -        if (cond)
> -            return 1;
> -        return 0;
> +        if (cond) {
> +            res =3D 1;
> +        }
> +        DBDMA_DPRINTFCH(ch, "  [WAIT_IFSET=3D%d]\n", res);
> +        break;
>      case WAIT_IFCLR:  /* wait if condition bit is 0 */
> -        if (!cond)
> -            return 1;
> -        return 0;
> +        if (!cond) {
> +            res =3D 1;
> +        }
> +        DBDMA_DPRINTFCH(ch, "  [WAIT_IFCLR=3D%d]\n", res);
> +        break;
>      }
> -    return 0;
> +    return res;
>  }
> =20
>  static void next(DBDMA_channel *ch)
> @@ -226,8 +228,6 @@ static void conditional_branch(DBDMA_channel *ch)
>      uint32_t status;
>      int cond;
> =20
> -    DBDMA_DPRINTFCH(ch, "conditional_branch\n");
> -
>      /* check if we must branch */
> =20
>      br =3D le16_to_cpu(current->command) & BR_MASK;
> @@ -237,6 +237,7 @@ static void conditional_branch(DBDMA_channel *ch)
>          next(ch);
>          return;
>      case BR_ALWAYS: /* always branch */
> +        DBDMA_DPRINTFCH(ch, "  [BR_ALWAYS]\n");
>          branch(ch);
>          return;
>      }
> @@ -250,16 +251,22 @@ static void conditional_branch(DBDMA_channel *ch)
> =20
>      switch(br) {
>      case BR_IFSET:  /* branch if condition bit is 1 */
> -        if (cond)
> +        if (cond) {
> +            DBDMA_DPRINTFCH(ch, "  [BR_IFSET =3D 1]\n");
>              branch(ch);
> -        else
> +        } else {
> +            DBDMA_DPRINTFCH(ch, "  [BR_IFSET =3D 0]\n");
>              next(ch);
> +        }
>          return;
>      case BR_IFCLR:  /* branch if condition bit is 0 */
> -        if (!cond)
> +        if (!cond) {
> +            DBDMA_DPRINTFCH(ch, "  [BR_IFCLR =3D 1]\n");
>              branch(ch);
> -        else
> +        } else {
> +            DBDMA_DPRINTFCH(ch, "  [BR_IFCLR =3D 0]\n");
>              next(ch);
> +        }
>          return;
>      }
>  }
> @@ -428,7 +435,7 @@ wait:
> =20
>  static void stop(DBDMA_channel *ch)
>  {
> -    ch->regs[DBDMA_STATUS] &=3D ~(ACTIVE|DEAD|FLUSH);
> +    ch->regs[DBDMA_STATUS] &=3D ~(ACTIVE);
> =20
>      /* the stop command does not increment command pointer */
>  }
> @@ -471,18 +478,22 @@ static void channel_run(DBDMA_channel *ch)
> =20
>      switch (cmd) {
>      case OUTPUT_MORE:
> +        DBDMA_DPRINTFCH(ch, "* OUTPUT_MORE *\n");
>          start_output(ch, key, phy_addr, req_count, 0);
>          return;
> =20
>      case OUTPUT_LAST:
> +        DBDMA_DPRINTFCH(ch, "* OUTPUT_LAST *\n");
>          start_output(ch, key, phy_addr, req_count, 1);
>          return;
> =20
>      case INPUT_MORE:
> +        DBDMA_DPRINTFCH(ch, "* INPUT_MORE *\n");
>          start_input(ch, key, phy_addr, req_count, 0);
>          return;
> =20
>      case INPUT_LAST:
> +        DBDMA_DPRINTFCH(ch, "* INPUT_LAST *\n");
>          start_input(ch, key, phy_addr, req_count, 1);
>          return;
>      }
> @@ -508,10 +519,12 @@ static void channel_run(DBDMA_channel *ch)
> =20
>      switch (cmd) {
>      case LOAD_WORD:
> +        DBDMA_DPRINTFCH(ch, "* LOAD_WORD *\n");
>          load_word(ch, key, phy_addr, req_count);
>          return;
> =20
>      case STORE_WORD:
> +        DBDMA_DPRINTFCH(ch, "* STORE_WORD *\n");
>          store_word(ch, key, phy_addr, req_count);
>          return;
>      }
> @@ -562,43 +575,117 @@ void DBDMA_register_channel(void *dbdma, int nchan=
, qemu_irq irq,
>      ch->io.opaque =3D opaque;
>  }
> =20
> -static void
> -dbdma_control_write(DBDMA_channel *ch)
> +static void dbdma_control_write(DBDMA_channel *ch)
>  {
>      uint16_t mask, value;
>      uint32_t status;
> +    bool do_flush =3D false;
> =20
>      mask =3D (ch->regs[DBDMA_CONTROL] >> 16) & 0xffff;
>      value =3D ch->regs[DBDMA_CONTROL] & 0xffff;
> =20
> -    value &=3D (RUN | PAUSE | FLUSH | WAKE | DEVSTAT);
> -
> +    /* This is the status register which we'll update
> +     * appropriately and store back
> +     */
>      status =3D ch->regs[DBDMA_STATUS];
> =20
> -    status =3D (value & mask) | (status & ~mask);
> +    /* RUN and PAUSE are bits under SW control only
> +     * FLUSH and WAKE are set by SW and cleared by HW
> +     * DEAD, ACTIVE and BT are only under HW control
> +     *
> +     * We handle ACTIVE separately at the end of the
> +     * logic to ensure all cases are covered.
> +     */
> =20
> -    if (status & WAKE)
> -        status |=3D ACTIVE;
> -    if (status & RUN) {
> -        status |=3D ACTIVE;
> -        status &=3D ~DEAD;
> +    /* Setting RUN will tentatively activate the channel
> +     */
> +    if ((mask & RUN) && (value & RUN)) {
> +        status |=3D RUN;
> +        DBDMA_DPRINTFCH(ch, " Setting RUN !\n");
> +    }
> +
> +    /* Clearing RUN 1->0 will stop the channel */
> +    if ((mask & RUN) && !(value & RUN)) {
> +        /* This has the side effect of clearing the DEAD bit */
> +        status &=3D ~(DEAD | RUN);
> +        DBDMA_DPRINTFCH(ch, " Clearing RUN !\n");
> +    }
> +
> +    /* Setting WAKE wakes up an idle channel if it's running
> +     *
> +     * Note: The doc doesn't say so but assume that only works
> +     * on a channel whose RUN bit is set.
> +     *
> +     * We set WAKE in status, it's not terribly useful as it will
> +     * be cleared on the next command fetch but it seems to mimmic
> +     * the HW behaviour and is useful for the way we handle
> +     * ACTIVE further down.
> +     */
> +    if ((mask & WAKE) && (value & WAKE) && (status & RUN)) {
> +        status |=3D WAKE;
> +        DBDMA_DPRINTFCH(ch, " Setting WAKE !\n");
> +    }
> +
> +    /* PAUSE being set will deactivate (or prevent activation)
> +     * of the channel. We just copy it over for now, ACTIVE will
> +     * be re-evaluated later.
> +     */
> +    if (mask & PAUSE) {
> +        status =3D (status & ~PAUSE) | (value & PAUSE);
> +        DBDMA_DPRINTFCH(ch, " %sing PAUSE !\n",
> +                        (value & PAUSE) ? "sett" : "clear");
> +    }
> +
> +    /* FLUSH is its own thing */
> +    if ((mask & FLUSH) && (value & FLUSH))  {
> +        DBDMA_DPRINTFCH(ch, " Setting FLUSH !\n");
> +        /* We set flush directly in the status register, we do *NOT*
> +         * set it in "status" so that it gets naturally cleared when
> +         * we update the status register further down. That way it
> +         * will be set only during the HW flush operation so it is
> +         * visible to any completions happening during that time.
> +         */
> +        ch->regs[DBDMA_STATUS] |=3D FLUSH;
> +        do_flush =3D true;
>      }
> -    if (status & PAUSE)
> +
> +    /* If either RUN or PAUSE is clear, so should ACTIVE be,
> +     * otherwise, ACTIVE will be set if we modified RUN, PAUSE or
> +     * set WAKE. That means that PAUSE was just cleared, RUN was
> +     * just set or WAKE was just set.
> +     */
> +    if ((status & PAUSE) || !(status & RUN)) {
>          status &=3D ~ACTIVE;
> -    if ((ch->regs[DBDMA_STATUS] & RUN) && !(status & RUN)) {
> -        /* RUN is cleared */
> -        status &=3D ~(ACTIVE|DEAD);
> +        DBDMA_DPRINTFCH(ch, "  -> ACTIVE down !\n");
> +
> +        /* We stopped processing, we want the underlying HW command
> +         * to complete *before* we clear the ACTIVE bit. Otherwise
> +         * we can get into a situation where the command status will
> +         * have RUN or ACTIVE not set which is going to confuse the
> +         * MacOS driver.
> +         */
> +        do_flush =3D true;
> +    } else if (mask & (RUN | PAUSE)) {
> +        status |=3D ACTIVE;
> +        DBDMA_DPRINTFCH(ch, " -> ACTIVE up !\n");
> +    } else if ((mask & WAKE) && (value & WAKE)) {
> +        status |=3D ACTIVE;
> +        DBDMA_DPRINTFCH(ch, " -> ACTIVE up !\n");
>      }
> =20
> -    if ((status & FLUSH) && ch->flush) {
> +    DBDMA_DPRINTFCH(ch, " new status=3D0x%08x\n", status);
> +
> +    /* If we need to flush the underlying HW, do it now, this happens
> +     * both on FLUSH commands and when stopping the channel for safety.
> +     */
> +    if (do_flush && ch->flush) {
>          ch->flush(&ch->io);
> -        status &=3D ~FLUSH;
>      }
> =20
> -    DBDMA_DPRINTFCH(ch, "    status 0x%08x\n", status);
> -
> +    /* Finally update the status register image */
>      ch->regs[DBDMA_STATUS] =3D status;
> =20
> +    /* If active, make sure the BH gets to run */
>      if (status & ACTIVE) {
>          DBDMA_kick(dbdma_from_ch(ch));
>      }
> @@ -666,13 +753,9 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
> =20
>      value =3D ch->regs[reg];
> =20
> -    DBDMA_DPRINTFCH(ch, "readl 0x" TARGET_FMT_plx " =3D> 0x%08x\n", addr=
, value);
> -    DBDMA_DPRINTFCH(ch, "channel 0x%x reg 0x%x\n",
> -                    (uint32_t)addr >> DBDMA_CHANNEL_SHIFT, reg);
> -
>      switch(reg) {
>      case DBDMA_CONTROL:
> -        value =3D 0;
> +        value =3D ch->regs[DBDMA_STATUS];
>          break;
>      case DBDMA_STATUS:
>      case DBDMA_CMDPTR_LO:
> @@ -698,6 +781,10 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
>          break;
>      }
> =20
> +    DBDMA_DPRINTFCH(ch, "readl 0x" TARGET_FMT_plx " =3D> 0x%08x\n", addr=
, value);
> +    DBDMA_DPRINTFCH(ch, "channel 0x%x reg 0x%x\n",
> +                    (uint32_t)addr >> DBDMA_CHANNEL_SHIFT, reg);
> +
>      return value;
>  }
> =20
> @@ -776,28 +863,28 @@ static void dbdma_reset(void *opaque)
>  static void dbdma_unassigned_rw(DBDMA_io *io)
>  {
>      DBDMA_channel *ch =3D io->channel;
> -    qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
> -                  __func__, ch->channel);
> -    ch->io.processing =3D false;
> -}
> -
> -static void dbdma_unassigned_flush(DBDMA_io *io)
> -{
> -    DBDMA_channel *ch =3D io->channel;
>      dbdma_cmd *current =3D &ch->current;
>      uint16_t cmd;
>      qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
>                    __func__, ch->channel);
> +    ch->io.processing =3D false;
> =20
>      cmd =3D le16_to_cpu(current->command) & COMMAND_MASK;
>      if (cmd =3D=3D OUTPUT_MORE || cmd =3D=3D OUTPUT_LAST ||
>          cmd =3D=3D INPUT_MORE || cmd =3D=3D INPUT_LAST) {
> -        current->xfer_status =3D cpu_to_le16(ch->regs[DBDMA_STATUS] | FL=
USH);
> +        current->xfer_status =3D cpu_to_le16(ch->regs[DBDMA_STATUS]);
>          current->res_count =3D cpu_to_le16(io->len);
>          dbdma_cmdptr_save(ch);
>      }
>  }
> =20
> +static void dbdma_unassigned_flush(DBDMA_io *io)
> +{
> +    DBDMA_channel *ch =3D io->channel;
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: use of unassigned channel %d\n",
> +                  __func__, ch->channel);
> +}
> +
>  void* DBDMA_init (MemoryRegion **dbdma_mem)
>  {
>      DBDMAState *s;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnALm4ACgkQbDjKyiDZ
s5L25A/+KSq+NHmcqlPaz1WPJYaTewQnFEvly3kLEpQ09rBSbDGRe5Tw0tHerK1H
F0v4mIZa/aRqMAtC8e6ZV676e6PEmtRfn+fHxKAGG9pL63cBqIHohNa7ErLDoofU
6LnAbnnUvPMUDw0feLsOTJmGC7vetDKUzU3B2LhjV+IW9JOwETl1obGnOxcKHSnr
bNe6NEMQzBP0HVE9p0+1LOkOg76MwTwuYexMRIrHy7D6MUJZPFKYmBI6apP1Qzx0
OFkSvhT7+nFlgG4lRWWXDUBKViUcZIRMuNtjdP+wmN7nPir4Zd3zTMftzhq+tPb8
jMd0+IZFwu9CDOgMKWuaxhsccgZIOESAZf1W80ra6YD7DjACoYXxQJcshQBeTbGH
vjepc+bcQ6i4S4I5mFGgpOZ6lTPVr9xOlQOSM/iolO2J0YX6JZ+KYKc5BXT4Q+uQ
PwoeWlxXaaEIYMRQ0LleJhthzHx8yc9Ipr5lvo0T80GSL1cWOc1spnHfnNcITVtH
ORZtE8W/nckD7SPBbUpUq8tGTBG4bhhWnorACxHEVTY1nV1o0OxvOq38EMSI6B1d
JlyiJv7X1U+Rg+wXKhcH8avJnw41eFloMFKQ6ctbY5ho31R8ytGtvRSDcw+wwlTT
J+k2s3Xlm5L1vwafuKZm48k+FUnC+Lyf4o86DPZp95sBu9h70Ic=
=c3tS
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
