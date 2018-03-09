Received: from eggs.gnu.org ([2001:4830:134:3::10]:46696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1euLVz-0001Yx-QM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1euLVw-00042J-Gh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:09:07 -0500
Received: from mail-co1nam03on0064.outbound.protection.outlook.com
	([104.47.40.64]:42880
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1euLVv-000417-Ry
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:09:04 -0500
Date: Fri, 9 Mar 2018 18:08:51 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180309170851.GQ14207@toto>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 09, 2018 at 05:03:11PM +0000, Peter Maydell wrote:
> On 9 March 2018 at 15:36, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wrot=
e:
> > [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
> >  from qemu/xilinx tag xilinx-v2015.2]
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> This should ideally have a Signed-off-by: from somebody @xilinx.com as
> well as you, then.

Hi Philippe,

Feel free to add my SoB on the next spin of this:
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar


>=20
> > ---
> >  hw/sd/sd.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++=
--------
> >  hw/sd/trace-events |   1 +
> >  2 files changed, 127 insertions(+), 22 deletions(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index 235e0518d6..b907d62aef 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -124,6 +124,7 @@ struct SDState {
> >      bool enable;
> >      uint8_t dat_lines;
> >      bool cmd_line;
> > +    bool uhs_enabled;
> >  };
> >
> >  static const char *sd_state_name(enum SDCardStates state)
> > @@ -563,6 +564,7 @@ static void sd_reset(DeviceState *dev)
> >      sd->expecting_acmd =3D false;
> >      sd->dat_lines =3D 0xf;
> >      sd->cmd_line =3D true;
> > +    sd->uhs_enabled =3D false;
> >      sd->multi_blk_cnt =3D 0;
> >  }
> >
> > @@ -761,30 +763,132 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t =
addr)
> >      return ret;
> >  }
> >
> > +/* Function Group */
> > +enum {
> > +    SD_FG_MIN               =3D 1,
> > +    SD_FG_ACCESS_MODE       =3D 1,
> > +    SD_FG_COMMAND_SYSTEM    =3D 2,
> > +    SD_FG_DRIVER_STRENGTH   =3D 3,
> > +    SD_FG_CURRENT_LIMIT     =3D 4,
> > +    SD_FG_RSVD_5            =3D 5,
> > +    SD_FG_RSVD_6            =3D 6,
> > +    SD_FG_COUNT
> > +};
>=20
> Since the minimum isn't 0, this means SD_FG_COUNT isn't
> actually the count of the number of FGs. I think having
>     SD_FG_MAX =3D 6,
>=20
> would make the loops below clearer, since they become
>   for (fn_grp =3D SD_FG_MAX; fn_grp >=3D SD_FG_MIN; fn_grp--) {
>=20
> > +
> > +/* Function name */
> > +#define SD_FN_COUNT 16
> > +
> > +static const char *sd_fn_grp_name[SD_FG_COUNT] =3D {
> > +    [SD_FG_ACCESS_MODE]     =3D "ACCESS_MODE",
> > +    [SD_FG_COMMAND_SYSTEM]  =3D "COMMAND_SYSTEM",
> > +    [SD_FG_DRIVER_STRENGTH] =3D "DRIVER_STRENGTH",
> > +    [SD_FG_CURRENT_LIMIT]   =3D "CURRENT_LIMIT",
> > +    [SD_FG_RSVD_5]          =3D "RSVD5",
> > +    [SD_FG_RSVD_6]          =3D "RSVD6",
> > +};
> > +
> > +typedef struct sd_fn_support {
> > +    const char *name;
> > +    bool uhs_only;
> > +    bool unimp;
> > +} sd_fn_support;
> > +
> > +static const sd_fn_support *sd_fn_support_defs[SD_FG_COUNT] =3D {
> > +    [SD_FG_ACCESS_MODE] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default/SDR12" },
> > +        [1] =3D { .name =3D "high-speed/SDR25" },
> > +        [2] =3D { .name =3D "SDR50",    .uhs_only =3D true },
> > +        [3] =3D { .name =3D "SDR104",   .uhs_only =3D true },
> > +        [4] =3D { .name =3D "DDR50",    .uhs_only =3D true },
> > +    },
> > +    [SD_FG_COMMAND_SYSTEM] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default" },
> > +        [1] =3D { .name =3D "For eC" },
> > +        [3] =3D { .name =3D "OTP",      .unimp =3D true },
> > +        [4] =3D { .name =3D "ASSD",     .unimp =3D true },
> > +    },
> > +    [SD_FG_DRIVER_STRENGTH] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default/Type B" },
> > +        [1] =3D { .name =3D "Type A",   .uhs_only =3D true },
> > +        [2] =3D { .name =3D "Type C",   .uhs_only =3D true },
> > +        [3] =3D { .name =3D "Type D",   .uhs_only =3D true },
> > +    },
> > +    [SD_FG_CURRENT_LIMIT] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default/200mA" },
> > +        [1] =3D { .name =3D "400mA",    .uhs_only =3D true },
> > +        [2] =3D { .name =3D "600mA",    .uhs_only =3D true },
> > +        [3] =3D { .name =3D "800mA",    .uhs_only =3D true },
> > +    },
> > +    [SD_FG_RSVD_5] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default" },
> > +    },
> > +    [SD_FG_RSVD_6] =3D (sd_fn_support [SD_FN_COUNT]) {
> > +        [0] =3D { .name =3D "default" },
> > +    },
> > +};
> > +
> > +#define SD_FN_NO_INFLUENCE          (1 << 15)
> > +
> >  static void sd_function_switch(SDState *sd, uint32_t arg)
> >  {
> > -    int i, mode, new_func;
> > -    mode =3D !!(arg & 0x80000000);
> > -
> > -    sd->data[0] =3D 0x00;                /* Maximum current consumptio=
n */
> > -    sd->data[1] =3D 0x01;
> > -    sd->data[2] =3D 0x80;                /* Supported group 6 function=
s */
> > -    sd->data[3] =3D 0x01;
> > -    sd->data[4] =3D 0x80;                /* Supported group 5 function=
s */
> > -    sd->data[5] =3D 0x01;
> > -    sd->data[6] =3D 0x80;                /* Supported group 4 function=
s */
> > -    sd->data[7] =3D 0x01;
> > -    sd->data[8] =3D 0x80;                /* Supported group 3 function=
s */
> > -    sd->data[9] =3D 0x01;
> > -    sd->data[10] =3D 0x80;       /* Supported group 2 functions */
> > -    sd->data[11] =3D 0x43;
> > -    sd->data[12] =3D 0x80;       /* Supported group 1 functions */
> > -    sd->data[13] =3D 0x03;
> > -    for (i =3D 0; i < 6; i ++) {
> > -        new_func =3D (arg >> (i * 4)) & 0x0f;
> > -        if (mode && new_func !=3D 0x0f)
> > -            sd->function_group[i] =3D new_func;
> > -        sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
> > +    int fn_grp, new_func, i;
> > +    uint8_t *data_p;
> > +    bool mode =3D extract32(arg, 31, 1);  /* 0: check only, 1: do swit=
ch */
> > +
> > +    stw_be_p(sd->data + 0, 0x0001);     /* Maximum current consumption=
 */
>=20
> Previously we were writing 0x00, 0x01 to the first 2 bytes of data;
> now we will write 0x01, 0x00. Are you sure that's right ? I guess
> it's the difference between claiming 1mA and 256mA.
> (I can't make any sense of the table in the spec so I have no idea.)
>=20
> Also the spec says that if the guest selects an invalid function then
> this value should be 0.
>=20
> > +
> > +    data_p =3D &sd->data[2];
> > +    for (fn_grp =3D SD_FG_COUNT - 1; fn_grp >=3D SD_FG_MIN; fn_grp--) =
{
> > +        uint16_t supported_fns =3D SD_FN_NO_INFLUENCE;
> > +        for (i =3D 0; i < SD_FN_COUNT; ++i) {
> > +            const sd_fn_support *def =3D &sd_fn_support_defs[fn_grp][i=
];
> > +
> > +            if (def->name && !def->unimp &&
> > +                    !(def->uhs_only && !sd->uhs_enabled)) {
> > +                supported_fns |=3D 1 << i;
> > +            }
> > +        }
> > +        stw_be_p(data_p, supported_fns);
> > +        data_p +=3D 2;
> > +    }
> > +
> > +    assert(data_p =3D=3D &sd->data[14]);
> > +    for (fn_grp =3D SD_FG_COUNT - 1; fn_grp >=3D SD_FG_MIN; fn_grp--) =
{
> > +        new_func =3D (arg >> ((fn_grp - 1) * 4)) & 0x0f;
> > +        if (new_func =3D=3D 0xf) {
>=20
> /* Guest requested no influence, so this function group stays the same */
>=20
> > +            new_func =3D sd->function_group[fn_grp - 1];
> > +        } else {
> > +            const sd_fn_support *def =3D &sd_fn_support_defs[fn_grp][n=
ew_func];
> > +            if (mode) {
> > +                if (!def->name) {
> > +                    qemu_log_mask(LOG_GUEST_ERROR,
> > +                                  "Function %d not a valid for "
>=20
> "not valid for"
>=20
> > +                                  "function group %d\n",
> > +                                  new_func, fn_grp);
> > +                    new_func =3D 0xf;
> > +                } else if (def->unimp) {
> > +                    qemu_log_mask(LOG_UNIMP,
> > +                                  "Function %s (fn grp %d) not impleme=
nted\n",
> > +                                  def->name, fn_grp);
> > +                    new_func =3D 0xf;
> > +                } else if (def->uhs_only && !sd->uhs_enabled) {
> > +                    qemu_log_mask(LOG_GUEST_ERROR,
> > +                                  "Function %s (fn grp %d) only "
> > +                                  "valid in UHS mode\n",
> > +                                  def->name, fn_grp);
> > +                    new_func =3D 0xf;
> > +                } else {
> > +                    sd->function_group[fn_grp - 1] =3D new_func;
>=20
> I think the spec says that if the guest makes an invalid selection
> for one function in the group then we must ignore all the set values,
> not just the one that was wrong, so we need to check everything
> first before we start writing the new values back.
>=20
> > +                }
> > +            }
> > +            trace_sdcard_function_select(def->name, sd_fn_grp_name[fn_=
grp],
> > +                                         mode);
> > +        }
> > +        if (!(fn_grp & 0x1)) { /* evens go in high nibble */
> > +            *data_p =3D new_func << 4;
> > +        } else { /* odds go in low nibble */
> > +            *(data_p++) |=3D new_func;
> > +        }
> >      }
> >      memset(&sd->data[17], 0, 47);
> >      stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
> > diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> > index 2059ace61f..c106541a47 100644
> > --- a/hw/sd/trace-events
> > +++ b/hw/sd/trace-events
> > @@ -42,6 +42,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr=
 0x%" PRIx64 " size 0x%x"
> >  sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd=
, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
> >  sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd,=
 int length) "%s %20s/ CMD%02d len %d"
> >  sdcard_set_voltage(uint16_t millivolts) "%u mV"
> > +sdcard_function_select(const char *fn_name, const char *grp_name, bool=
 do_switch) "Function %s (group: %s, sw: %u)"
> >
> >  # hw/sd/milkymist-memcard.c
> >  milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%=
08x value 0x%08x"
> > --
> > 2.16.2
> >
>=20
> thanks
> -- PMM
