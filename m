Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwC1I-0001bD-SJ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwC1E-0007cj-FJ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:52:48 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:54259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dwC1E-0007bz-4y
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:52:44 -0400
Received: by mail-oi0-x22c.google.com with SMTP id j126so4310687oia.10
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 11:52:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
	<1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 24 Sep 2017 20:52:40 +0200
Message-ID: <CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

Thanks for the nice update, removing the exec() code, using chardev
and a private socketpair. Some comments below:

On Fri, Sep 22, 2017 at 2:33 PM, Amarnath Valluri
<amarnath.valluri@intel.com> wrote:
> This change introduces a new TPM backend driver that can communicate with
> swtpm(software TPM emulator) using unix domain socket interface. QEMU tal=
ks to
> TPM emulator using socket based chardev backend device.
>
> Swtpm uses two Unix sockets for communications, one for plain TPM command=
s and
> responses, and one for out-of-band control messages. QEMU passes data soc=
ket
> been used over the control channel.
>
> The swtpm and associated tools can be found here:
>     https://github.com/stefanberger/swtpm
>
> The swtpm's control channel protocol specification can be found here:
>     https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specificat=
ion
>
> Usage:
>     # setup TPM state directory
>     mkdir /tmp/mytpm
>     chown -R tss:root /tmp/mytpm
>     /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>
>     # Ask qemu to use TPM emulator with given tpm state directory
>     qemu-system-x86_64 \
>         [...] \
>         -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
>         -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>         -device tpm-tis,tpmdev=3Dtpm0 \
>         [...]
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  configure             |  15 +-
>  hmp.c                 |   5 +
>  hw/tpm/Makefile.objs  |   1 +
>  hw/tpm/tpm_emulator.c | 649 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/tpm/tpm_ioctl.h    | 246 +++++++++++++++++++
>  qapi/tpm.json         |  21 +-
>  qemu-options.hx       |  22 +-
>  7 files changed, 950 insertions(+), 9 deletions(-)
>  create mode 100644 hw/tpm/tpm_emulator.c
>  create mode 100644 hw/tpm/tpm_ioctl.h
>
> diff --git a/configure b/configure
> index cb0f7ed..ce2df2d 100755
> --- a/configure
> +++ b/configure
> @@ -3461,10 +3461,15 @@ fi
>  ##########################################
>  # TPM passthrough is only on x86 Linux
>
> -if test "$targetos" =3D Linux && test "$cpu" =3D i386 -o "$cpu" =3D x86_=
64; then
> -  tpm_passthrough=3D$tpm
> +if test "$targetos" =3D Linux; then
> +  tpm_emulator=3D$tpm
> +  if test "$cpu" =3D i386 -o "$cpu" =3D x86_64; then
> +    tpm_passthrough=3D$tpm
> +  else
> +    tpm_passthrough=3Dno
> +  fi
>  else
> -  tpm_passthrough=3Dno
> +  tpm_emulator=3Dno
>  fi
>
>  ##########################################
> @@ -5359,6 +5364,7 @@ echo "gcov enabled      $gcov"
>  echo "TPM support       $tpm"
>  echo "libssh2 support   $libssh2"
>  echo "TPM passthrough   $tpm_passthrough"
> +echo "TPM emulator      $tpm_emulator"
>  echo "QOM debugging     $qom_cast_debug"
>  echo "Live block migration $live_block_migration"
>  echo "lzo support       $lzo"
> @@ -5943,6 +5949,9 @@ if test "$tpm" =3D "yes"; then
>    if test "$tpm_passthrough" =3D "yes"; then
>      echo "CONFIG_TPM_PASSTHROUGH=3Dy" >> $config_host_mak
>    fi
> +  if test "$tpm_emulator" =3D "yes"; then
> +    echo "CONFIG_TPM_EMULATOR=3Dy" >> $config_host_mak

It shouldn't require Linux, but posix (and I assume a port to other
systems isn't impossible). same for build-sys / help / comments.

> +  fi
>  fi
>
>  echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak
> diff --git a/hmp.c b/hmp.c
> index cf62b2e..7e69eca 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -995,6 +995,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>      Error *err =3D NULL;
>      unsigned int c =3D 0;
>      TPMPassthroughOptions *tpo;
> +    TPMEmulatorOptions *teo;
>
>      info_list =3D qmp_query_tpm(&err);
>      if (err) {
> @@ -1024,6 +1025,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict=
)
>                             tpo->has_cancel_path ? ",cancel-path=3D" : ""=
,
>                             tpo->has_cancel_path ? tpo->cancel_path : "")=
;
>              break;
> +        case TPM_TYPE_EMULATOR:
> +            teo =3D ti->options->u.emulator.data;
> +            monitor_printf(mon, ",chardev=3D%s", teo->chardev);
> +            break;
>          case TPM_TYPE__MAX:
>              break;
>          }
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 64cecc3..41f0b7a 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,2 +1,3 @@
>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tpm_util.o
> +common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> new file mode 100644
> index 0000000..c02bbe2
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,649 @@
> +/*
> + *  emulator TPM driver
> + *
> + *  Copyright (c) 2017 Intel Corporation
> + *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
> + *
> + *  Copyright (c) 2010 - 2013 IBM Corporation
> + *  Authors:
> + *    Stefan Berger <stefanb@us.ibm.com>
> + *
> + *  Copyright (C) 2011 IAIK, Graz University of Technology
> + *    Author: Andreas Niederl
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/sockets.h"
> +#include "io/channel-socket.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
> +#include "hw/hw.h"
> +#include "hw/i386/pc.h"
> +#include "tpm_util.h"
> +#include "tpm_ioctl.h"
> +#include "migration/blocker.h"
> +#include "qapi/error.h"
> +#include "chardev/char-fe.h"
> +
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <stdio.h>
> +
> +#define DEBUG_TPM 0
> +
> +#define DPRINT(fmt, ...) do { \
> +    if (DEBUG_TPM) { \
> +        fprintf(stderr, fmt, ## __VA_ARGS__); \
> +    } \
> +} while (0);
> +
> +#define DPRINTF(fmt, ...) DPRINT("tpm-emulator: "fmt"\n", __VA_ARGS__)

I would define a single DPRINTF() (& drop DPRINT usage below)


> +
> +#define TYPE_TPM_EMULATOR "tpm-emulator"
> +#define TPM_EMULATOR(obj) \
> +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
> +
> +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) =
=3D=3D (cap))
> +
> +static const TPMDriverOps tpm_emulator_driver;
> +
> +/* data structures */
> +typedef struct TPMEmulator {
> +    TPMBackend parent;
> +
> +    TPMEmulatorOptions *options;

Contrary to my comment on previous patch, I realize it is convenient
to have a qapi pointer here, so you can use the free visitor later.

> +    CharBackend ctrl_dev;

ctrl_chr perhaps? or just chr or be (the most common name in other devices)=
.

> +    QIOChannel *data_ioc;
> +    bool op_executing;
> +    bool op_canceled;

I think those 2 fields can be dropped, see below.

> +    bool had_startup_error;

I think some little refactoring could remove the whole
had_startup_error() backend & callback before or after the series.
tpm_backend_startup_tpm() already returns an error code.  device or
common backend code could handle & remember that.

> +    TPMVersion tpm_version;

This is probably worth to consider in common code instead, but let's
not worry about it.

> +    ptm_cap caps; /* capabilities of the TPM */
> +    uint8_t cur_locty_number; /* last set locality */
> +    QemuMutex state_lock;
> +    Error *migration_blocker;
> +} TPMEmulator;
> +
> +
> +static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd, voi=
d *msg,
> +                                size_t msg_len_in, size_t msg_len_out)
> +{
> +    uint32_t cmd_no =3D cpu_to_be32(cmd);
> +    ssize_t n =3D sizeof(uint32_t) + msg_len_in;
> +    uint8_t *buf =3D NULL;
> +
> +    buf =3D (uint8_t *)malloc(n);

could be g_alloca() instead. Alternatively, why not call 2 write() instead?

none of the casts in this function are necessary, please remove them.

> +    memcpy(buf, &cmd_no, sizeof(cmd_no));
> +    memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
> +
> +    n +=3D qemu_chr_fe_write_all(dev, (const uint8_t *)buf, n);

weird

> +    free(buf);
> +
> +    if (n > 0) {

with the n +=3D above, you'll get interesting behaviour :)

You probably want to check if any write above failed, and return early
for the error case.

Please improve the error handling in this function

> +        if (msg_len_out > 0) {
> +            n =3D qemu_chr_fe_read_all(dev, (uint8_t *)msg, msg_len_out)=
;
> +            /* simulate ioctl return value */
> +            if (n > 0) {
> +                n =3D 0;
> +            }
> +        } else {
> +            n =3D 0;
> +        }
> +    }
> +    return n;
> +}
> +
> +static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_pt,

tpm_pt was tpm_passthrough I suppose.

Please rename tpm_pt tpm_emu (or I would suggest "self", but this
isn't common name in qemu code - it's actually common in a close
c-object world., and it is quite convenient...)

> +                                     const uint8_t *in, uint32_t in_len,
> +                                     uint8_t *out, uint32_t out_len,
> +                                     bool *selftest_done)
> +{
> +    ssize_t ret;
> +    bool is_selftest =3D false;
> +    const struct tpm_resp_hdr *hdr =3D NULL;
> +    Error *err =3D NULL;
> +
> +    tpm_pt->op_canceled =3D false;
> +    tpm_pt->op_executing =3D true;
> +    if (selftest_done) {
> +        *selftest_done =3D false;
> +        is_selftest =3D tpm_util_is_selftest(in, in_len);
> +    }
> +
> +    ret =3D qio_channel_write(tpm_pt->data_ioc, (char *)in, in_len, &err=
);

hmm, too bad qio_channel_write() doesn't take a void *

why not write_all()?

> +    if (ret !=3D in_len || err) {
> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {

I don't think ECANCELED make sense for emulator code.

> +            error_report("tpm-emulator: error while transmitting data "
> +                         "to TPM: %s", err ? error_get_pretty(err) : "")=
;
> +            error_free(err);
> +        }
> +        goto err_exit;
> +    }
> +
> +    tpm_pt->op_executing =3D false;
> +
> +    ret =3D qio_channel_read(tpm_pt->data_ioc, (char *)out, out_len, &er=
r);
> +    if (ret < 0 || err) {

read_all() ?

> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> +            error_report("tpm-emulator: error while reading data from "
> +                         "TPM: %s", err ? error_get_pretty(err) : "");
> +            error_free(err);
> +        }
> +    } else if (ret >=3D sizeof(*hdr)) {
> +        hdr =3D (struct tpm_resp_hdr *)out;
> +    }
> +
> +    if (!hdr || be32_to_cpu(hdr->len) !=3D ret) {
> +        error_report("tpm-emulator: received invalid response "
> +                     "packet from TPM with length :%ld", ret);
> +        ret =3D -1;
> +        goto err_exit;
> +    }
> +
> +    if (is_selftest) {
> +        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
> +    }
> +
> +    return 0;
> +
> +err_exit:
> +    if (ret < 0) {
> +        tpm_util_write_fatal_error_response(out, out_len);
> +    }
> +
> +    tpm_pt->op_executing =3D false;
> +
> +    return ret;
> +}
> +
> +static int tpm_emulator_set_locality(TPMEmulator *tpm_pt, uint8_t locty_=
number)
> +{
> +    ptm_loc loc;
> +
> +    DPRINTF("%s : locality: 0x%x", __func__, locty_number);
> +
> +    if (tpm_pt->cur_locty_number !=3D locty_number) {

return early instead if =3D=3D, to avoid code indent etc

> +        DPRINTF("setting locality : 0x%x", locty_number);
> +        loc.u.req.loc =3D locty_number;

This number isn't set in be like the rest of the protocol?

> +        if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SET_LOCALITY, &l=
oc,
> +                             sizeof(loc), sizeof(loc)) < 0) {
> +            error_report("tpm-emulator: could not set locality : %s",
> +                         strerror(errno));
> +            return -1;
> +        }
> +        loc.u.resp.tpm_result =3D be32_to_cpu(loc.u.resp.tpm_result);
> +        if (loc.u.resp.tpm_result !=3D 0) {
> +            error_report("tpm-emulator: TPM result for set locality : 0x=
%x",
> +                         loc.u.resp.tpm_result);
> +            return -1;
> +        }
> +        tpm_pt->cur_locty_number =3D locty_number;
> +    }
> +    return 0;
> +}
> +
> +static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd cm=
d)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    TPMLocality *locty =3D NULL;
> +    bool selftest_done =3D false;
> +
> +    DPRINTF("processing command type %d", cmd);
> +
> +    switch (cmd) {
> +    case TPM_BACKEND_CMD_PROCESS_CMD:
> +        qemu_mutex_lock(&tpm_pt->state_lock);
> +        locty =3D tb->tpm_state->locty_data;
> +        if (tpm_emulator_set_locality(tpm_pt,
> +                                      tb->tpm_state->locty_number) < 0) =
{
> +            tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
> +                                           locty->r_buffer.size);

return / goto here instead of else.

> +        } else {
> +            tpm_emulator_unix_tx_bufs(tpm_pt, locty->w_buffer.buffer,
> +                                              locty->w_offset,
> +                                              locty->r_buffer.buffer,
> +                                              locty->r_buffer.size,
> +                                              &selftest_done);

no error handling?

> +        }
> +
> +        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_numbe=
r,
> +                               selftest_done);
> +        qemu_mutex_unlock(&tpm_pt->state_lock);
> +
> +        break;
> +    case TPM_BACKEND_CMD_INIT:
> +    case TPM_BACKEND_CMD_END:
> +    case TPM_BACKEND_CMD_TPM_RESET:
> +        /* nothing to do */
> +        break;
> +    }
> +}
> +
> +/*
> + * Gracefully shut down the external unixio TPM
> + */
> +static void tpm_emulator_shutdown(TPMEmulator *tpm_pt)
> +{
> +    ptm_res res;
> +
> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SHUTDOWN, &res, 0,
> +                         sizeof(res)) < 0) {
> +        error_report("tpm-emulator: Could not cleanly shutdown the TPM: =
%s",
> +                     strerror(errno));
> +    } else if (res !=3D 0) {
> +        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
> +                     be32_to_cpu(res));
> +    }
> +}
> +
> +static int tpm_emulator_probe_caps(TPMEmulator *tpm_pt)
> +{
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_GET_CAPABILITY,
> +                         &tpm_pt->caps, 0, sizeof(tpm_pt->caps)) < 0) {
> +        error_report("tpm-emulator: probing failed : %s", strerror(errno=
));
> +        return -1;
> +    }
> +
> +    tpm_pt->caps =3D be64_to_cpu(tpm_pt->caps);
> +
> +    DPRINTF("capbilities : 0x%lx", tpm_pt->caps);
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_check_caps(TPMEmulator *tpm_pt)
> +{
> +    ptm_cap caps =3D 0;
> +    const char *tpm =3D NULL;
> +
> +    /* check for min. required capabilities */
> +    switch (tpm_pt->tpm_version) {
> +    case TPM_VERSION_1_2:
> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABL=
ISHED |
> +               PTM_CAP_SET_LOCALITY;
> +        tpm =3D "1.2";
> +        break;
> +    case TPM_VERSION_2_0:
> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABL=
ISHED |
> +               PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED;
> +        tpm =3D "2";
> +        break;
> +    case TPM_VERSION_UNSPEC:
> +        error_report("tpm-emulator: TPM version has not been set");
> +        return -1;
> +    }
> +
> +    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, caps)) {
> +        error_report("tpm-emulator: TPM does not implement minimum set o=
f "
> +                     "required capabilities for TPM %s (0x%x)", tpm, (in=
t)caps);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_init init;
> +    ptm_res res;
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_INIT, &init, sizeof(=
init),
> +                         sizeof(init)) < 0) {
> +        error_report("tpm-emulator: could not send INIT: %s",
> +                     strerror(errno));
> +        goto err_exit;
> +    }
> +
> +    res =3D be32_to_cpu(init.u.resp.tpm_result);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res)=
;
> +        goto err_exit;
> +    }
> +    return 0;
> +
> +err_exit:
> +    tpm_pt->had_startup_error =3D true;
> +    return -1;
> +}
> +
> +static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_est est;
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_GET_TPMESTABLISHED, =
&est, 0,
> +                         sizeof(est)) < 0) {
> +        error_report("tpm-emulator: Could not get the TPM established fl=
ag: %s",
> +                     strerror(errno));
> +        return false;
> +    }
> +    DPRINTF("established flag: %0x", est.u.resp.bit);
> +
> +    return (est.u.resp.bit !=3D 0);
> +}
> +
> +static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
> +                                                   uint8_t locty)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_reset_est reset_est;
> +    ptm_res res;
> +
> +    /* only a TPM 2.0 will support this */
> +    if (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0) {
> +        reset_est.u.req.loc =3D tpm_pt->cur_locty_number;
> +
> +        if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_RESET_TPMESTABLI=
SHED,
> +                                 &reset_est, sizeof(reset_est),
> +                                 sizeof(reset_est)) < 0) {
> +            error_report("tpm-emulator: Could not reset the establishmen=
t bit: "
> +                          "%s", strerror(errno));
> +            return -1;
> +        }
> +
> +        res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
> +        if (res) {
> +            error_report("tpm-emulator: TPM result for rest establixhed =
flag: "
> +                         "0x%x", res);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static bool tpm_emulator_had_startup_error(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    return tpm_pt->had_startup_error;
> +}
> +
> +static void tpm_emulator_cancel_cmd(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_res res;
> +
> +    /*
> +     * As of Linux 3.7 the tpm_tis driver does not properly cancel
> +     * commands on all TPM manufacturers' TPMs.
> +     * Only cancel if we're busy so we don't cancel someone else's
> +     * command, e.g., a command executed on the host.
> +     */
> +    if (tpm_pt->op_executing) {

The field is set in the worker thread. This is racy. Fortunately this
is not relevant for emulator, I think you can simply drop that check
and the variable. Stefan should confirm though.

> +        if (TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, PTM_CAP_CANCEL_TPM_=
CMD)) {
> +            if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_CANCEL_TPM_C=
MD,
> +                                     &res, 0, sizeof(res)) < 0) {
> +                error_report("tpm-emulator: Could not cancel command: %s=
",
> +                             strerror(errno));
> +            } else if (res !=3D 0) {
> +                error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
> +                             be32_to_cpu(res));
> +            } else {
> +                tpm_pt->op_canceled =3D true;
> +            }
> +        }
> +    }
> +}
> +
> +static void tpm_emulator_reset(TPMBackend *tb)
> +{
> +    DPRINTF("%s", __func__);
> +
> +    tpm_emulator_cancel_cmd(tb);
> +}
> +
> +static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    return tpm_pt->tpm_version;
> +}
> +
> +static void tpm_emulator_block_migration(TPMEmulator *tpm_pt)
> +{
> +    Error *err =3D NULL;
> +
> +    error_setg(&tpm_pt->migration_blocker,
> +               "Migration disabled: TPM emulator not yet migratable");
> +    migrate_add_blocker(tpm_pt->migration_blocker, &err);
> +    if (err) {
> +        error_free(err);

probably better to report_err it instead

> +        error_free(tpm_pt->migration_blocker);
> +        tpm_pt->migration_blocker =3D NULL;

and return an error code.

> +    }
> +}
> +
> +static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_pt)
> +{
> +    ptm_res res;
> +    Error *err =3D NULL;
> +    int fds[2] =3D { -1, -1 };
> +
> +    if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
> +        error_report("tpm-emulator: Failed to create socketpair");
> +        return -1;
> +    }
> +
> +    qemu_chr_fe_set_msgfds(&tpm_pt->ctrl_dev, fds + 1, 1);
> +
> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SET_DATAFD, &res, 0,
> +                    sizeof(res)) || res !=3D 0) {

Yay! for making life easier and hiding a protocol detail.

> +        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
> +                     strerror(errno));
> +        goto err_exit;
> +    }
> +
> +    tpm_pt->data_ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(fds[0], &=
err));
> +    if (err) {
> +        error_report("tpm-emulator: Failed to create io channel : %s",
> +                       error_get_pretty(err));

error_prepend()?

> +        error_free(err);
> +        goto err_exit;
> +    }

close fds[1] ?

> +
> +    return 0;
> +
> +err_exit:
> +    closesocket(fds[0]);
> +    closesocket(fds[1]);
> +    return -1;
> +}
> +
> +static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_pt, QemuOpts=
 *opts)
> +{
> +    const char *value;
> +
> +    value =3D qemu_opt_get(opts, "chardev");
> +    if (value) {
> +        Error *err =3D NULL;
> +        Chardev *dev =3D qemu_chr_find(value);
> +
> +        tpm_pt->options->chardev =3D g_strdup(value);
> +
> +        if (!dev || !qemu_chr_fe_init(&tpm_pt->ctrl_dev, dev, &err)) {
> +            error_report("tpm-emulator: No valid chardev found at '%s': =
%s",
> +                         value, err ? error_get_pretty(err) : "");
> +            error_free(err);

error_prepend

> +            goto err;
> +        }
> +    }
> +
> +    if (tpm_emulator_prepare_data_fd(tpm_pt) < 0) {
> +        goto err;
> +    }
> +
> +    /* FIXME: tpm_util_test_tpmdev() accepts only on socket fd, as it al=
so used
> +     * by passthrough driver, which not yet using GIOChannel.
> +     */
> +    if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_pt->data_ioc)->fd,
> +                             &tpm_pt->tpm_version)) {
> +        error_report("'%s' is not emulating TPM device. Error: %s",
> +                      tpm_pt->options->chardev, strerror(errno));
> +        goto err;
> +    }
> +
> +    DPRINTF("TPM Version %s", tpm_pt->tpm_version =3D=3D TPM_VERSION_1_2=
 ? "1.2" :
> +             (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0 ?  "2.0" : "Uns=
pecified"));
> +
> +    if (tpm_emulator_probe_caps(tpm_pt) ||
> +        tpm_emulator_check_caps(tpm_pt)) {
> +        goto err;
> +    }
> +
> +    tpm_emulator_block_migration(tpm_pt);
> +
> +    return 0;
> +
> +err:
> +    DPRINT("Startup error\n");
> +    return -1;
> +}
> +
> +static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id)
> +{
> +    TPMBackend *tb =3D TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
> +
> +    tb->id =3D g_strdup(id);
> +
> +    if (tpm_emulator_handle_device_opts(TPM_EMULATOR(tb), opts)) {
> +        goto err_exit;
> +    }
> +
> +    return tb;
> +
> +err_exit:
> +    object_unref(OBJECT(tb));
> +
> +    return NULL;
> +}
> +
> +static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    TpmTypeOptions *options =3D NULL;
> +    TPMEmulatorOptions *eoptions =3D NULL;
> +
> +    eoptions =3D g_new0(TPMEmulatorOptions, 1);
> +    if (!eoptions) {
> +        return NULL;
> +    }
> +    DPRINTF("%s", __func__);
> +
> +    eoptions->chardev =3D g_strdup(tpm_pt->options->chardev);
> +    options =3D g_new0(TpmTypeOptions, 1);
> +    if (!options) {
> +        qapi_free_TPMEmulatorOptions(eoptions);
> +        return NULL;
> +    }
> +
> +    options->type =3D TPM_TYPE_EMULATOR;
> +    options->u.emulator.data =3D eoptions;

I think this is a job for QAPI_CLONE.

> +
> +    return options;
> +}
> +
> +static const QemuOptDesc tpm_emulator_cmdline_opts[] =3D {
> +    TPM_STANDARD_CMDLINE_OPTS,
> +    {
> +        .name =3D "chardev",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Character device to use for out-of-band control messa=
ges",
> +    },
> +    { /* end of list */ },
> +};
> +
> +static const TPMDriverOps tpm_emulator_driver =3D {
> +    .type                     =3D TPM_TYPE_EMULATOR,
> +    .opts                     =3D tpm_emulator_cmdline_opts,
> +    .desc                     =3D "TPM emulator backend driver",
> +
> +    .create                   =3D tpm_emulator_create,
> +    .startup_tpm              =3D tpm_emulator_startup_tpm,
> +    .reset                    =3D tpm_emulator_reset,
> +    .had_startup_error        =3D tpm_emulator_had_startup_error,
> +    .cancel_cmd               =3D tpm_emulator_cancel_cmd,
> +    .get_tpm_established_flag =3D tpm_emulator_get_tpm_established_flag,
> +    .reset_tpm_established_flag =3D tpm_emulator_reset_tpm_established_f=
lag,
> +    .get_tpm_version          =3D tpm_emulator_get_tpm_version,
> +    .get_tpm_options          =3D tpm_emulator_get_tpm_options,
> +};
> +
> +static void tpm_emulator_inst_init(Object *obj)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(obj);
> +
> +    DPRINTF("%s", __func__);
> +    tpm_pt->options =3D g_new0(TPMEmulatorOptions, 1);
> +    tpm_pt->op_executing =3D tpm_pt->op_canceled =3D false;
> +    tpm_pt->had_startup_error =3D false;
> +    tpm_pt->cur_locty_number =3D ~0;
> +    qemu_mutex_init(&tpm_pt->state_lock);
> +}
> +
> +static void tpm_emulator_inst_finalize(Object *obj)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(obj);
> +
> +    tpm_emulator_cancel_cmd(TPM_BACKEND(obj));
> +    tpm_emulator_shutdown(tpm_pt);
> +
> +    if (tpm_pt->data_ioc) {
> +        qio_channel_close(tpm_pt->data_ioc, NULL);
> +    }
> +
> +    qemu_chr_fe_deinit(&tpm_pt->ctrl_dev, false);
> +
> +    if (tpm_pt->options) {
> +        qapi_free_TPMEmulatorOptions(tpm_pt->options);
> +    }
> +
> +    if (tpm_pt->migration_blocker) {
> +        migrate_del_blocker(tpm_pt->migration_blocker);
> +        error_free(tpm_pt->migration_blocker);
> +    }
> +}
> +
> +static void tpm_emulator_class_init(ObjectClass *klass, void *data)
> +{
> +    TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
> +    tbc->ops =3D &tpm_emulator_driver;
> +    tbc->handle_request =3D tpm_emulator_handle_request;
> +}
> +
> +static const TypeInfo tpm_emulator_info =3D {
> +    .name =3D TYPE_TPM_EMULATOR,
> +    .parent =3D TYPE_TPM_BACKEND,
> +    .instance_size =3D sizeof(TPMEmulator),
> +    .class_init =3D tpm_emulator_class_init,
> +    .instance_init =3D tpm_emulator_inst_init,
> +    .instance_finalize =3D tpm_emulator_inst_finalize,
> +};
> +
> +static void tpm_emulator_register(void)
> +{
> +    type_register_static(&tpm_emulator_info);
> +    tpm_register_driver(&tpm_emulator_driver);
> +}
> +
> +type_init(tpm_emulator_register)
> diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
> new file mode 100644
> index 0000000..33564b1
> --- /dev/null
> +++ b/hw/tpm/tpm_ioctl.h

This file is copied from swtpm project. Could swtpm have it installed
on system instead?

> @@ -0,0 +1,246 @@
> +/*
> + * tpm_ioctl.h
> + *
> + * (c) Copyright IBM Corporation 2014, 2015.
> + *
> + * This file is licensed under the terms of the 3-clause BSD license
> + */
> +#ifndef _TPM_IOCTL_H_
> +#define _TPM_IOCTL_H_
> +
> +#include <stdint.h>
> +#include <sys/uio.h>
> +#include <sys/types.h>
> +#include <sys/ioctl.h>
> +
> +/*
> + * Every response from a command involving a TPM command execution must =
hold
> + * the ptm_res as the first element.
> + * ptm_res corresponds to the error code of a command executed by the TP=
M.
> + */
> +
> +typedef uint32_t ptm_res;
> +
> +/* PTM_GET_TPMESTABLISHED: get the establishment bit */
> +struct ptm_est {
> +    union {
> +        struct {
> +            ptm_res tpm_result;
> +            unsigned char bit; /* TPM established bit */
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/* PTM_RESET_TPMESTABLISHED: reset establishment bit */
> +struct ptm_reset_est {
> +    union {
> +        struct {
> +            uint8_t loc; /* locality to use */
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/* PTM_INIT */
> +struct ptm_init {
> +    union {
> +        struct {
> +            uint32_t init_flags; /* see definitions below */
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/* above init_flags */
> +#define PTM_INIT_FLAG_DELETE_VOLATILE (1 << 0)
> +    /* delete volatile state file after reading it */
> +
> +/* PTM_SET_LOCALITY */
> +struct ptm_loc {
> +    union {
> +        struct {
> +            uint8_t loc; /* locality to set */
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/* PTM_HASH_DATA: hash given data */
> +struct ptm_hdata {
> +    union {
> +        struct {
> +            uint32_t length;
> +            uint8_t data[4096];
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/*
> + * size of the TPM state blob to transfer; x86_64 can handle 8k,
> + * ppc64le only ~7k; keep the response below a 4k page size
> + */
> +#define PTM_STATE_BLOB_SIZE (3 * 1024)
> +
> +/*
> + * The following is the data structure to get state blobs from the TPM.
> + * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multip=
le reads
> + * with this ioctl and with adjusted offset are necessary. All bytes
> + * must be transferred and the transfer is done once the last byte has b=
een
> + * returned.
> + * It is possible to use the read() interface for reading the data; howe=
ver, the
> + * first bytes of the state blob will be part of the response to the ioc=
tl(); a
> + * subsequent read() is only necessary if the total length (totlength) e=
xceeds
> + * the number of received bytes. seek() is not supported.
> + */
> +struct ptm_getstate {
> +    union {
> +        struct {
> +            uint32_t state_flags; /* may be: PTM_STATE_FLAG_DECRYPTED */
> +            uint32_t type;        /* which blob to pull */
> +            uint32_t offset;      /* offset from where to read */
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +            uint32_t state_flags; /* may be: PTM_STATE_FLAG_ENCRYPTED */
> +            uint32_t totlength;   /* total length that will be transferr=
ed */
> +            uint32_t length;      /* number of bytes in following buffer=
 */
> +            uint8_t  data[PTM_STATE_BLOB_SIZE];
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/* TPM state blob types */
> +#define PTM_BLOB_TYPE_PERMANENT  1
> +#define PTM_BLOB_TYPE_VOLATILE   2
> +#define PTM_BLOB_TYPE_SAVESTATE  3
> +
> +/* state_flags above : */
> +#define PTM_STATE_FLAG_DECRYPTED     1 /* on input:  get decrypted state=
 */
> +#define PTM_STATE_FLAG_ENCRYPTED     2 /* on output: state is encrypted =
*/
> +
> +/*
> + * The following is the data structure to set state blobs in the TPM.
> + * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multip=
le
> + * 'writes' using this ioctl are necessary. The last packet is indicated
> + * by the length being smaller than the PTM_STATE_BLOB_SIZE.
> + * The very first packet may have a length indicator of '0' enabling
> + * a write() with all the bytes from a buffer. If the write() interface
> + * is used, a final ioctl with a non-full buffer must be made to indicat=
e
> + * that all data were transferred (a write with 0 bytes would not work).
> + */
> +struct ptm_setstate {
> +    union {
> +        struct {
> +            uint32_t state_flags; /* may be PTM_STATE_FLAG_ENCRYPTED */
> +            uint32_t type;        /* which blob to set */
> +            uint32_t length;      /* length of the data;
> +                                     use 0 on the first packet to
> +                                     transfer using write() */
> +            uint8_t data[PTM_STATE_BLOB_SIZE];
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +/*
> + * PTM_GET_CONFIG: Data structure to get runtime configuration informati=
on
> + * such as which keys are applied.
> + */
> +struct ptm_getconfig {
> +    union {
> +        struct {
> +            ptm_res tpm_result;
> +            uint32_t flags;
> +        } resp; /* response */
> +    } u;
> +};
> +
> +#define PTM_CONFIG_FLAG_FILE_KEY        0x1
> +#define PTM_CONFIG_FLAG_MIGRATION_KEY   0x2
> +
> +
> +typedef uint64_t ptm_cap;
> +typedef struct ptm_est ptm_est;
> +typedef struct ptm_reset_est ptm_reset_est;
> +typedef struct ptm_loc ptm_loc;
> +typedef struct ptm_hdata ptm_hdata;
> +typedef struct ptm_init ptm_init;
> +typedef struct ptm_getstate ptm_getstate;
> +typedef struct ptm_setstate ptm_setstate;
> +typedef struct ptm_getconfig ptm_getconfig;
> +
> +/* capability flags returned by PTM_GET_CAPABILITY */
> +#define PTM_CAP_INIT               (1)
> +#define PTM_CAP_SHUTDOWN           (1 << 1)
> +#define PTM_CAP_GET_TPMESTABLISHED (1 << 2)
> +#define PTM_CAP_SET_LOCALITY       (1 << 3)
> +#define PTM_CAP_HASHING            (1 << 4)
> +#define PTM_CAP_CANCEL_TPM_CMD     (1 << 5)
> +#define PTM_CAP_STORE_VOLATILE     (1 << 6)
> +#define PTM_CAP_RESET_TPMESTABLISHED (1 << 7)
> +#define PTM_CAP_GET_STATEBLOB      (1 << 8)
> +#define PTM_CAP_SET_STATEBLOB      (1 << 9)
> +#define PTM_CAP_STOP               (1 << 10)
> +#define PTM_CAP_GET_CONFIG         (1 << 11)
> +#define PTM_CAP_SET_DATAFD         (1 << 12)
> +
> +enum {
> +    PTM_GET_CAPABILITY     =3D _IOR('P', 0, ptm_cap),
> +    PTM_INIT               =3D _IOWR('P', 1, ptm_init),
> +    PTM_SHUTDOWN           =3D _IOR('P', 2, ptm_res),
> +    PTM_GET_TPMESTABLISHED =3D _IOR('P', 3, ptm_est),
> +    PTM_SET_LOCALITY       =3D _IOWR('P', 4, ptm_loc),
> +    PTM_HASH_START         =3D _IOR('P', 5, ptm_res),
> +    PTM_HASH_DATA          =3D _IOWR('P', 6, ptm_hdata),
> +    PTM_HASH_END           =3D _IOR('P', 7, ptm_res),
> +    PTM_CANCEL_TPM_CMD     =3D _IOR('P', 8, ptm_res),
> +    PTM_STORE_VOLATILE     =3D _IOR('P', 9, ptm_res),
> +    PTM_RESET_TPMESTABLISHED =3D _IOWR('P', 10, ptm_reset_est),
> +    PTM_GET_STATEBLOB      =3D _IOWR('P', 11, ptm_getstate),
> +    PTM_SET_STATEBLOB      =3D _IOWR('P', 12, ptm_setstate),
> +    PTM_STOP               =3D _IOR('P', 13, ptm_res),
> +    PTM_GET_CONFIG         =3D _IOR('P', 14, ptm_getconfig),
> +    PTM_SET_DATAFD         =3D _IOR('P', 15, ptm_res),
> +};
> +
> +/*
> + * Commands used by the non-CUSE TPMs
> + *
> + * All messages container big-endian data.
> + *
> + * The return messages only contain the 'resp' part of the unions
> + * in the data structures above. Besides that the limits in the
> + * buffers above (ptm_hdata:u.req.data and ptm_get_state:u.resp.data
> + * and ptm_set_state:u.req.data) are 0xffffffff.
> + */
> +enum {
> +    CMD_GET_CAPABILITY =3D 1,
> +    CMD_INIT,
> +    CMD_SHUTDOWN,
> +    CMD_GET_TPMESTABLISHED,
> +    CMD_SET_LOCALITY,
> +    CMD_HASH_START,
> +    CMD_HASH_DATA,
> +    CMD_HASH_END,
> +    CMD_CANCEL_TPM_CMD,
> +    CMD_STORE_VOLATILE,
> +    CMD_RESET_TPMESTABLISHED,
> +    CMD_GET_STATEBLOB,
> +    CMD_SET_STATEBLOB,
> +    CMD_STOP,
> +    CMD_GET_CONFIG,
> +    CMD_SET_DATAFD
> +};
> +
> +#endif /* _TPM_IOCTL_H */
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index e8b2d8d..7093f26 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -39,10 +39,12 @@
>  # An enumeration of TPM types
>  #
>  # @passthrough: TPM passthrough type
> +# @emulator: Software Emulator TPM type
> +#            Since: 2.11
>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
>
>  ##
>  # @query-tpm-types:
> @@ -56,7 +58,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-tpm-types" }
> -# <- { "return": [ "passthrough" ] }
> +# <- { "return": [ "passthrough", "emulator" ] }
>  #
>  ##
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
> @@ -77,16 +79,29 @@
>                                               '*cancel-path' : 'str'} }
>
>  ##
> +# @TPMEmulatorOptions:
> +#
> +# Information about the TPM emulator type
> +#
> +# @chardev: Name of a unix socket chardev
> +#
> +# Since: 2.11
> +##
> +{ 'struct': 'TPMEmulatorOptions', 'data': { 'chardev' : 'str' } }
> +
> +##
>  # @TpmTypeOptions:
>  #
>  # A union referencing different TPM backend types' configuration options
>  #
>  # @type: 'passthrough' The configuration options for the TPM passthrough=
 type
> +#        'emulator' The configuration options for TPM emulator backend t=
ype
>  #
>  # Since: 1.5
>  ##
>  { 'union': 'TpmTypeOptions',
> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
> +   'data': { 'passthrough' : 'TPMPassthroughOptions',
> +             'emulator': 'TPMEmulatorOptions' } }
>
>  ##
>  # @TPMInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 77859a2..1e93e53 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3121,7 +3121,9 @@ DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
>      "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
>      "                use path to provide path to a character device; def=
ault is /dev/tpm0\n"
>      "                use cancel-path to provide path to TPM's cancel sys=
fs entry; if\n"
> -    "                not provided it will be searched for in /sys/class/=
misc/tpm?/device\n",
> +    "                not provided it will be searched for in /sys/class/=
misc/tpm?/device\n"
> +    "-tpmdev emulator,id=3Did,chardev=3Ddev\n"
> +    "                configure the TPM device using chardev backend\n",
>      QEMU_ARCH_ALL)
>  STEXI
>
> @@ -3130,8 +3132,8 @@ The general form of a TPM device option is:
>
>  @item -tpmdev @var{backend} ,id=3D@var{id} [,@var{options}]
>  @findex -tpmdev
> -Backend type must be:
> -@option{passthrough}.
> +Backend type must be either one of the following:
> +@option{passthrough}, @option{emulator}.
>
>  The specific backend type will determine the applicable options.
>  The @code{-tpmdev} option creates the TPM backend and requires a
> @@ -3181,6 +3183,20 @@ To create a passthrough TPM use the following two =
options:
>  Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
>  @code{tpmdev=3Dtpm0} in the device option.
>
> +@item -tpmdev emulator, id=3D@var{id}, chardev=3D@var{dev}
> +
> +(Linux-host only) Enable access to a TPM emulator using Unix domain sock=
et based
> +chardev backend.
> +
> +@option{chardev} specifies the unique ID of a character device backend t=
hat provides connection to the software TPM server.
> +
> +To create a TPM emulator backend device with chardev socket backend:
> +@example
> +
> +-chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-ctrl -tpmdev emulator,id=
=3Dtpm0,chardev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0
> +
> +@end example
> +
>  @end table
>
>  ETEXI
> --
> 2.7.4
>



--=20
Marc-Andr=C3=A9 Lureau
