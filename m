Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFZE-0004pf-1o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFZC-0006B3-Ra
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:39:16 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFZC-0006At-M0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:39:14 -0400
Received: by mail-ot0-x230.google.com with SMTP id l12-v6so14789091oth.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:39:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509060104.4458-4-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:38:53 +0100
Message-ID: <CAFEAcA8Qm_CQFGUbFNc27fyetggt6AjfhCXxZkU3fnbMibzLFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On 9 May 2018 at 07:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> [PMD: rebased, changed magic by definitions, use stw_be_p, add tracing,
>  check all functions in group are correct before setting the values]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> +    /* Bits 376-399: function (4 bits each group)
> +     *
> +     * Do not write the values back directly:
> +     * Check everything first writing to 'tmpbuf'
> +     */
> +    data_p =3D tmpbuf;

You don't need a tmpbuf here, because it doesn't matter if we
write something to the data array that it turns out we don't want
to write; we can always rewrite it later...

> +    for (fn_grp =3D SD_FG_MAX; fn_grp >=3D SD_FG_MIN; fn_grp--) {
> +        new_func =3D (arg >> ((fn_grp - 1) * 4)) & 0x0f;
> +        if (new_func =3D=3D SD_FN_NO_INFLUENCE) {
> +            /* Guest requested no influence, so this function group
> +             * stays the same.
> +             */
> +            new_func =3D sd->function_group[fn_grp - 1];
> +        } else {
> +            const sd_fn_support *def =3D &sd_fn_support_defs[fn_grp][new=
_func];
> +            if (mode) {
> +                if (!def->name) {
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                                  "Function %d not valid for "
> +                                  "function group %d\n",
> +                                  new_func, fn_grp);
> +                    invalid_function_selected =3D true;
> +                    new_func =3D SD_FN_NO_INFLUENCE;
> +                } else if (def->unimp) {
> +                    qemu_log_mask(LOG_UNIMP,
> +                                  "Function %s (fn grp %d) not implement=
ed\n",
> +                                  def->name, fn_grp);
> +                    invalid_function_selected =3D true;
> +                    new_func =3D SD_FN_NO_INFLUENCE;
> +                } else if (def->uhs_only && !sd->uhs_activated) {
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                                  "Function %s (fn grp %d) only "
> +                                  "valid in UHS mode\n",
> +                                  def->name, fn_grp);
> +                    invalid_function_selected =3D true;
> +                    new_func =3D SD_FN_NO_INFLUENCE;
> +                } else {
> +                    sd->function_group[fn_grp - 1] =3D new_func;

...but don't want to update the function_group[n] to the new value until
we've checked that all the selected values in the command are OK,
so you either need a temporary for the new function values, or
you need to do one pass over the inputs to check and another one to set.

> +                }
> +            }
> +            trace_sdcard_function_select(def->name, sd_fn_grp_name[fn_gr=
p],
> +                                         mode);
> +        }
> +        if (!(fn_grp & 0x1)) { /* evens go in high nibble */
> +            *data_p =3D new_func << 4;
> +        } else { /* odds go in low nibble */
> +            *(data_p++) |=3D new_func;
> +        }
> +    }
> +    if (invalid_function_selected) {
> +        /* Ignore all the set values */
> +        memset(&sd->data[14], 0, SD_FN_BUFSZ);

All-zeroes doesn't seem to match the spec. The spec says "The response
to an invalid selection of function will be 0xF", which is a bit unclear,
but has to mean at least that we return 0xf for the function groups which
were invalid selections. I'm not sure what we should return as status
for the function groups which weren't invalid; possibilities include:
 * 0xf
 * whatever the provided argument for that function group was
 * whatever the current status for that function group is

I don't suppose you're in a position to find out what an actual
hardware SD card does?

thanks
-- PMM
