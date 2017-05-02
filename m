Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5aIm-0003HL-1P
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5aIc-0005Q6-1K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:05:23 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5aIb-0005Nw-8m
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:05:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id z129so5716040wmb.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 16:05:00 +0000
Message-ID: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, berrange@redhat.com

Hi

On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri <amarnath.valluri@intel.com=
>
wrote:

> This change introduces a new TPM backend driver that can communicate with
> swtpm(software TPM emulator) using unix domain socket interface.
>
> Swtpm uses two unix sockets, one for plain TPM commands and responses, an=
d
> one
> for out-of-band control messages.
>
>
Let's not forget to mention the external protocol this backend rely on:
https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification

The protocol documentation is quite limited.

(I still question the need to rely on a public protocol, and a seperate
helper process project. If we had a qemu-swtpm, we could more easily evolve
the protocol in the future)

The swtpm and associated tools can be found here:
>     https://github.com/stefanberger/swtpm
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
>         -tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/mytpm,logfile=3D/tmp/swtpm.log \
>         -device tpm-tis,tpmdev=3Dtpm0 \
>         [...]
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  configure             |  15 +-
>  hmp.c                 |  21 ++
>  hw/tpm/Makefile.objs  |   1 +
>  hw/tpm/tpm_emulator.c | 943
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_ioctl.h    | 243 +++++++++++++
>  qapi-schema.json      |  36 +-
>  qemu-options.hx       |  53 ++-
>  tpm.c                 |   2 +-
>  8 files changed, 1305 insertions(+), 9 deletions(-)
>  create mode 100644 hw/tpm/tpm_emulator.c
>  create mode 100644 hw/tpm/tpm_ioctl.h
>
> diff --git a/configure b/configure
> index be4d326..a933ec7 100755
> --- a/configure
> +++ b/configure
> @@ -3359,10 +3359,15 @@ fi
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
> @@ -5137,6 +5142,7 @@ echo "gcov enabled      $gcov"
>  echo "TPM support       $tpm"
>  echo "libssh2 support   $libssh2"
>  echo "TPM passthrough   $tpm_passthrough"
> +echo "TPM emulator      $tpm_emulator"
>  echo "QOM debugging     $qom_cast_debug"
>  echo "lzo support       $lzo"
>  echo "snappy support    $snappy"
> @@ -5716,6 +5722,9 @@ if test "$tpm" =3D "yes"; then
>    if test "$tpm_passthrough" =3D "yes"; then
>      echo "CONFIG_TPM_PASSTHROUGH=3Dy" >> $config_host_mak
>    fi
> +  if test "$tpm_emulator" =3D "yes"; then
> +    echo "CONFIG_TPM_EMULATOR=3Dy" >> $config_host_mak
> +  fi
>  fi
>
>  echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak
> diff --git a/hmp.c b/hmp.c
> index 9caf7c8..e7fd426 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -937,6 +937,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>      Error *err =3D NULL;
>      unsigned int c =3D 0;
>      TPMPassthroughOptions *tpo;
> +    TPMEmulatorOptions *teo;
>
>      info_list =3D qmp_query_tpm(&err);
>      if (err) {
> @@ -966,6 +967,26 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                             tpo->has_cancel_path ? ",cancel-path=3D" : ""=
,
>                             tpo->has_cancel_path ? tpo->cancel_path : "")=
;
>              break;
> +        case TPM_TYPE_EMULATOR:
> +            teo =3D (TPMEmulatorOptions *)(ti->options);
> +            monitor_printf(mon, ",tmpstatedir=3D%s", teo->tpmstatedir);
> +            monitor_printf(mon, ",spawn=3D%s", teo->spawn ? "on" : "off"=
);
> +            if (teo->has_path) {
> +                monitor_printf(mon, ",path=3D%s", teo->path);
> +            }
> +            if (teo->has_data_path) {
> +                monitor_printf(mon, ",data-path=3D%s", teo->data_path);
> +            }
> +            if (teo->has_ctrl_path) {
> +                monitor_printf(mon, ",ctrl-path=3D%s", teo->ctrl_path);
> +            }
> +            if (teo->has_logfile) {
> +                monitor_printf(mon, ",logfile=3D%s", teo->logfile);
> +            }
> +            if (teo->has_loglevel) {
> +                monitor_printf(mon, ",loglevel=3D%ld", teo->loglevel);
> +            }
> +            break;
>          default:
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
> index 0000000..b480a53
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,943 @@
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
> + * License along with this library; if not, see <
> http://www.gnu.org/licenses/>
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
> +#include "qapi/error.h"
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
> +
> +#define TYPE_TPM_EMULATOR "tpm-emulator"
> +#define TPM_EMULATOR(obj) \
> +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
> +
> +static const TPMDriverOps tpm_emulator_driver;
> +
> +/* data structures */
> +typedef struct TPMEmulator {
> +    TPMBackend parent;
> +
> +    TPMEmulatorOptions *ops;
> +    QIOChannel *data_ioc;
> +    QIOChannel *ctrl_ioc;
> +    bool op_executing;
> +    bool op_canceled;
> +    bool child_running;
> +    TPMVersion tpm_version;
> +    ptm_cap caps; /* capabilities of the TPM */
> +    uint8_t cur_locty_number; /* last set locality */
> +    QemuMutex state_lock;
> +} TPMEmulator;
> +
> +#define TPM_DEFAULT_EMULATOR "swtpm"
> +#define TPM_DEFAULT_LOGLEVEL 5
> +#define TPM_EMULATOR_PIDFILE "/tmp/qemu-tpm.pid"
> +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) =
=3D=3D
> (cap))
> +
> +static int tpm_emulator_ctrlcmd(QIOChannel *ioc, unsigned long cmd, void
> *msg,
> +                                size_t msg_len_in, size_t msg_len_out)
> +{
> +    ssize_t n;
> +
> +    uint32_t cmd_no =3D cpu_to_be32(cmd);
> +    struct iovec iov[2] =3D {
> +        { .iov_base =3D &cmd_no, .iov_len =3D sizeof(cmd_no), },
> +        { .iov_base =3D msg, .iov_len =3D msg_len_in, },
> +    };
> +
> +    n =3D qio_channel_writev(ioc, iov, 2, NULL);
> +    if (n > 0) {
> +        if (msg_len_out > 0) {
> +            n =3D qio_channel_read(ioc, (char *)msg, msg_len_out, NULL);
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
> +                                     const uint8_t *in, uint32_t in_len,
> +                                     uint8_t *out, uint32_t out_len,
> +                                     bool *selftest_done)
> +{
> +    ssize_t ret;
> +    bool is_selftest;
> +    const struct tpm_resp_hdr *hdr;
> +
> +    if (!tpm_pt->child_running) {
> +        return -1;
> +    }
> +
> +    tpm_pt->op_canceled =3D false;
> +    tpm_pt->op_executing =3D true;
> +    *selftest_done =3D false;
> +
> +    is_selftest =3D tpm_util_is_selftest(in, in_len);
> +
> +    ret =3D qio_channel_write(tpm_pt->data_ioc, (const char *)in,
> (size_t)in_len,
> +                            NULL);
> +    if (ret !=3D in_len) {
> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> +            error_report("tpm-emulator: error while transmitting data "
> +                         "to TPM: %s (%i)", strerror(errno), errno);
> +        }
> +        goto err_exit;
> +    }
> +
> +    tpm_pt->op_executing =3D false;
> +
> +    ret =3D qio_channel_read(tpm_pt->data_ioc, (char *)out, (size_t)out_=
len,
> +                           NULL);
> +    if (ret < 0) {
> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> +            error_report("tpm-emulator: error while reading data from "
> +                         "TPM: %s (%i)", strerror(errno), errno);
> +        }
> +    } else if (ret < sizeof(struct tpm_resp_hdr) ||
> +               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
> +        ret =3D -1;
> +        error_report("tpm-emulator: received invalid response "
> +                     "packet from TPM");
> +    }
> +
> +    if (is_selftest && (ret >=3D sizeof(struct tpm_resp_hdr))) {
> +        hdr =3D (struct tpm_resp_hdr *)out;
> +        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
> +    }
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
> +static int tpm_emulator_set_locality(TPMEmulator *tpm_pt,
> +                                     uint8_t locty_number)
> +{
> +    ptm_loc loc;
> +
> +    if (!tpm_pt->child_running) {
> +        return -1;
> +    }
> +
> +    DPRINTF("%s : locality: 0x%x", __func__, locty_number);
> +
> +    if (tpm_pt->cur_locty_number !=3D locty_number) {
> +        DPRINTF("setting locality : 0x%x", locty_number);
> +        loc.u.req.loc =3D locty_number;
> +        if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_SET_LOCALITY, &lo=
c,
> +                             sizeof(loc), sizeof(loc)) < 0) {
> +            error_report("tpm-emulator: could not set locality : %s",
> +                         strerror(errno));
> +            return -1;
> +        }
> +        loc.u.resp.tpm_result =3D be32_to_cpu(loc.u.resp.tpm_result);
> +        if (loc.u.resp.tpm_result !=3D 0) {
> +            error_report("tpm-emulator: TPM result for set locality :
> 0x%x",
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
> +        } else {
> +            tpm_emulator_unix_tx_bufs(tpm_pt, locty->w_buffer.buffer,
> +                                  locty->w_offset, locty->r_buffer.buffe=
r,
> +                                  locty->r_buffer.size, &selftest_done);
> +        }
> +        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_numbe=
r,
> +                               selftest_done);
> +        qemu_mutex_unlock(&tpm_pt->state_lock);
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
> +    if (!tpm_pt->child_running) {
> +        return;
> +    }
> +
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_SHUTDOWN, &res, 0,
> +                         sizeof(res)) < 0) {
> +        error_report("tpm-emulator: Could not cleanly shutdown the TPM:
> %s",
> +                     strerror(errno));
> +    } else if (res !=3D 0) {
> +        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
> +                     be32_to_cpu(res));
> +    }
> +}
> +
> +static int tpm_emulator_probe_caps(TPMEmulator *tpm_pt)
> +{
> +    if (!tpm_pt->child_running) {
> +        return -1;
> +    }
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_GET_CAPABILITY,
> +                         &tpm_pt->caps, 0, sizeof(tpm_pt->caps)) < 0) {
> +        error_report("tpm-emulator: probing failed : %s",
> strerror(errno));
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
> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN |
> PTM_CAP_GET_TPMESTABLISHED |
> +               PTM_CAP_SET_LOCALITY;
> +        tpm =3D "1.2";
> +        break;
> +    case TPM_VERSION_2_0:
> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN |
> PTM_CAP_GET_TPMESTABLISHED |
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
f
> "
> +                     "required capabilities for TPM %s (0x%x)", tpm,
> (int)caps);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_init_tpm(TPMEmulator *tpm_pt)
> +{
> +    ptm_init init;
> +    ptm_res res;
> +
> +    if (!tpm_pt->child_running) {
> +        return -1;
> +    }
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_INIT, &init,
> sizeof(init),
> +                         sizeof(init)) < 0) {
> +        error_report("tpm-emulator: could not send INIT: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    res =3D be32_to_cpu(init.u.resp.tpm_result);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res)=
;
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    DPRINTF("%s", __func__);
> +
> +    tpm_emulator_init_tpm(tpm_pt) ;
> +
> +    return 0;
> +}
> +
> +static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_est est;
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_GET_TPMESTABLISHED,
> &est, 0,
> +                         sizeof(est)) < 0) {
> +        error_report("tpm-emulator: Could not get the TPM established
> flag: %s",
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
> +        if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc,
> CMD_RESET_TPMESTABLISHED,
> +                                 &reset_est, sizeof(reset_est),
> +                                 sizeof(reset_est)) < 0) {
> +            error_report("tpm-emulator: Could not reset the establishmen=
t
> bit: "
> +                          "%s", strerror(errno));
> +            return -1;
> +        }
> +
> +        res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
> +        if (res) {
> +            error_report("tpm-emulator: TPM result for rest establixhed
> flag: "
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
> +    return !tpm_pt->child_running;
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
> +        if (TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt,
> PTM_CAP_CANCEL_TPM_CMD)) {
> +            if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc,
> CMD_CANCEL_TPM_CMD, &res,
> +                                 0, sizeof(res)) < 0) {
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
> +static const char *tpm_emulator_desc(void)
> +{
> +    return "TPM emulator backend driver";
> +}
> +
> +static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    return tpm_pt->tpm_version;
> +}
> +
> +static gboolean tpm_emulator_fd_handler(QIOChannel *ioc, GIOCondition cn=
d,
> +                                        void *opaque)
> +{
> +    TPMEmulator *tpm_pt =3D opaque;
> +
> +    if (cnd & G_IO_ERR || cnd & G_IO_HUP) {
> +        error_report("TPM backend disappeared");
> +        tpm_pt->child_running =3D false;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static QIOChannel *_iochannel_new(const char *path, int fd, Error **err)
> +{
> +    int socket =3D path ?  unix_connect(path, err) : fd;
> +    if (socket < 0) {
> +        return NULL;
> +    }
> +
> +    return QIO_CHANNEL(qio_channel_socket_new_fd(socket, err));
> +}
> +
> +static int tpm_emulator_spawn_emulator(TPMEmulator *tpm_pt)
> +{
> +    int fds[2] =3D { -1, -1 };
> +    int ctrl_fds[2] =3D { -1, -1 };
> +    pid_t cpid;
> +
> +    if (!tpm_pt->ops->has_data_path) {
> +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
> +            return -1;
> +        }
> +    }
> +
> +    if (!tpm_pt->ops->has_ctrl_path) {
> +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, ctrl_fds) < 0) {
> +            if (!tpm_pt->ops->has_data_path) {
> +                closesocket(fds[0]);
> +                closesocket(fds[1]);
> +            }
> +            return -1;
> +        }
> +    }
> +
> +    cpid =3D qemu_fork(NULL);
> +    if (cpid < 0) {
> +        error_report("tpm-emulator: Fork failure: %s", strerror(errno));
> +        if (!tpm_pt->ops->has_data_path) {
> +            closesocket(fds[0]);
> +            closesocket(fds[1]);
> +        }
> +        if (!tpm_pt->ops->has_ctrl_path) {
> +            closesocket(ctrl_fds[0]);
> +            closesocket(ctrl_fds[1]);
> +        }
> +        return -1;
> +    }
> +
> +    unlink(TPM_EMULATOR_PIDFILE);
> +
> +    if (cpid =3D=3D 0) { /* CHILD */
> +        enum {
> +            PARAM_PATH,
> +            PARAM_IFACE,
> +            PARAM_SERVER,  PARAM_SERVER_ARGS,
> +            PARAM_CTRL,    PARAM_CTRL_ARGS,
> +            PARAM_STATE,   PARAM_STATE_ARGS,
> +            PARAM_PIDFILE, PARAM_PIDFILE_ARGS,
> +            PARAM_LOG,     PARAM_LOG_ARGS,
> +            PARAM_MAX
> +        };
> +
> +        int i;
> +        int data_fd =3D -1, ctrl_fd =3D -1;
> +        char *argv[PARAM_MAX + 1];
> +
> +        /* close all unused inherited sockets */
> +        if (fds[0] >=3D 0) {
> +            closesocket(fds[0]);
> +        }
> +        if (ctrl_fds[0] >=3D 0) {
> +            closesocket(ctrl_fds[0]);
> +        }
> +
> +        i =3D STDERR_FILENO + 1;
> +        if (fds[1] >=3D 0) {
> +            data_fd =3D dup2(fds[1], i++);
> +            if (data_fd < 0) {
> +                error_report("tpm-emulator: dup2() failure - %s",
> +                             strerror(errno));
> +                goto exit_child;
> +            }
> +        }
> +        if (ctrl_fds[1] >=3D 0) {
> +            ctrl_fd =3D dup2(ctrl_fds[1], i++);
> +            if (ctrl_fd < 0) {
> +                error_report("tpm-emulator: dup2() failure - %s",
> +                             strerror(errno));
> +                goto exit_child;
> +            }
> +        }
> +        for ( ; i < sysconf(_SC_OPEN_MAX); i++) {
> +            close(i);
> +        }
> +
> +        argv[PARAM_MAX] =3D NULL;
> +        argv[PARAM_PATH] =3D g_strdup(tpm_pt->ops->path);
> +        argv[PARAM_IFACE] =3D g_strdup("socket");
> +        if (tpm_pt->ops->has_data_path) {
> +            argv[PARAM_SERVER] =3D g_strdup("--server");
> +            argv[PARAM_SERVER_ARGS] =3D
> g_strdup_printf("type=3Dunixio,path=3D%s",
> +                                               tpm_pt->ops->data_path);
> +        } else {
> +            argv[PARAM_SERVER] =3D g_strdup("--fd");
> +            argv[PARAM_SERVER_ARGS] =3D g_strdup_printf("%d", data_fd);
> +        }
> +
> +        argv[PARAM_CTRL] =3D g_strdup("--ctrl");
> +        if (tpm_pt->ops->has_ctrl_path) {
> +            argv[PARAM_CTRL_ARGS] =3D g_strdup_printf("type=3Dunixio,pat=
h=3D%s",
> +
> tpm_pt->ops->ctrl_path);
> +        } else {
> +            argv[PARAM_CTRL_ARGS] =3D
> g_strdup_printf("type=3Dunixio,clientfd=3D%d",
> +                                                    ctrl_fd);
> +        }
> +
> +        argv[PARAM_STATE] =3D g_strdup("--tpmstate");
> +        argv[PARAM_STATE_ARGS] =3D g_strdup_printf("dir=3D%s",
> +                                        tpm_pt->ops->tpmstatedir);
> +        argv[PARAM_PIDFILE] =3D g_strdup("--pid");
> +        argv[PARAM_PIDFILE_ARGS] =3D g_strdup_printf("file=3D%s",
> +                                            TPM_EMULATOR_PIDFILE);
> +        if (tpm_pt->ops->has_logfile) {
> +            argv[PARAM_LOG] =3D g_strdup("--log");
> +            argv[PARAM_LOG_ARGS] =3D g_strdup_printf("file=3D%s,level=3D=
%d",
> +                    tpm_pt->ops->logfile, (int)tpm_pt->ops->loglevel);
> +        } else {
> +            /* truncate logs */
> +            argv[PARAM_LOG] =3D NULL;
> +        }
> +        DPRINTF("%s", "Running cmd: ")
> +        for (i =3D 0; argv[i]; i++) {
> +            DPRINT(" %s", argv[i])
> +        }
> +        DPRINT("\n")
> +        if (execv(tpm_pt->ops->path, (char * const *)argv) < 0) {
> +            error_report("execv() failure : %s", strerror(errno));
> +        }
> +
> +exit_child:
> +        g_strfreev(argv);
> +        if (data_fd >=3D 0) {
> +            closesocket(data_fd);
> +        }
> +        if (ctrl_fd >=3D 0) {
> +            closesocket(ctrl_fd);
> +        }
> +
> +        _exit(1);
> +    } else { /* self */
> +        struct stat st;
> +        DPRINTF("child pid: %d", cpid);
> +        int rc;
> +        useconds_t usec =3D 100 * 1000L; /* wait for 100 milliseconds */
> +        useconds_t timeout =3D 10; /* max 1 second */
> +
> +        /* close unused sockets */
> +        if (fds[1] >=3D 0) {
> +            closesocket(fds[1]);
> +        }
> +        if (ctrl_fds[1] >=3D 0) {
> +            closesocket(ctrl_fds[1]);
> +        }
> +
> +        tpm_pt->data_ioc =3D _iochannel_new(tpm_pt->ops->data_path, fds[=
0],
> NULL);
> +        if (!tpm_pt->data_ioc) {
> +            error_report("tpm-emulator: Unable to connect socket : %s",
> +                          tpm_pt->ops->data_path);
> +            goto err_kill_child;
> +        }
> +
> +        tpm_pt->ctrl_ioc =3D _iochannel_new(tpm_pt->ops->ctrl_path,
> ctrl_fds[0],
> +                                          NULL);
> +        if (!tpm_pt->ctrl_ioc) {
> +            error_report("tpm-emulator: Unable to connect socket : %s",
> +                          tpm_pt->ops->ctrl_path);
> +            goto err_kill_child;
> +        }
> +
> +        qemu_add_child_watch(cpid);
> +
> +        qio_channel_add_watch(tpm_pt->data_ioc, G_IO_HUP | G_IO_ERR,
> +                              tpm_emulator_fd_handler, tpm_pt, NULL);
> +
> +        while ((rc =3D stat(TPM_EMULATOR_PIDFILE, &st)) < 0 && timeout--=
) {
> +            usleep(usec);
> +        }
> +
> +        if (timeout =3D=3D -1) {
> +            error_report("tpm-emulator: pid file not ready: %s",
> +                         strerror(errno));
> +            goto err_kill_child;
> +        }
> +
> +        /* check if child really running */
> +        if (kill(cpid, 0) < 0 && errno =3D=3D ESRCH) {
> +            goto err_no_child;
> +        }
> +
> +        tpm_pt->child_running =3D true;
> +    }
> +
> +    return 0;
> +
> +err_kill_child:
> +    kill(cpid, SIGTERM);
> +    /* wait for 10 mill-seconds */
> +    usleep(10 * 1000);
> +    /* force kill if still reachable */
> +    if (kill(cpid, 0) =3D=3D 0) {
> +        kill(cpid, SIGKILL);
> +    }
> +
> +err_no_child:
> +    tpm_pt->child_running =3D false;
> +
> +    return -1;
> +}
> +
> +static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_pt, QemuOpts
> *opts)
> +{
> +    const char *value;
> +
> +    value =3D qemu_opt_get(opts, "tpmstatedir");
> +    if (!value) {
> +        error_report("tpm-emulator: Missing tpm state directory");
> +        return -1;
> +    }
> +    tpm_pt->ops->tpmstatedir =3D g_strdup(value);
> +
> +    tpm_pt->ops->spawn =3D qemu_opt_get_bool(opts, "spawn", false);
> +
> +    value =3D qemu_opt_get(opts, "path");
> +    if (!value) {
> +        value =3D TPM_DEFAULT_EMULATOR;
> +        tpm_pt->ops->has_path =3D false;
> +    } else {
> +        tpm_pt->ops->has_path =3D true;
> +        if (value[0] =3D=3D '/') {
> +            struct stat st;
> +            if (stat(value, &st) < 0 || !(S_ISREG(st.st_mode)
> +                || S_ISLNK(st.st_mode))) {
> +                error_report("tpm-emulator: Invalid emulator path: %s",
> value);
> +                return -1;
> +            }
> +        }
> +    }
> +    tpm_pt->ops->path =3D g_strdup(value);
> +
> +    value =3D qemu_opt_get(opts, "data-path");
> +    if (value) {
> +        tpm_pt->ops->has_data_path =3D true;
> +        tpm_pt->ops->data_path =3D g_strdup(value);
> +    } else {
> +        tpm_pt->ops->has_data_path =3D false;
> +        if (!tpm_pt->ops->spawn) {
> +            error_report("tpm-emulator: missing mandatory data-path");
> +            return -1;
> +        }
> +    }
> +
> +    value =3D qemu_opt_get(opts, "ctrl-path");
> +    if (value) {
> +        tpm_pt->ops->has_ctrl_path =3D true;
> +        tpm_pt->ops->ctrl_path =3D g_strdup(value);
> +    } else {
> +        tpm_pt->ops->has_ctrl_path =3D false;
> +        if (!tpm_pt->ops->spawn) {
> +            error_report("tpm-emulator: missing mandatory ctrl-path");
> +            return -1;
> +        }
> +    }
> +
> +    value =3D qemu_opt_get(opts, "logfile");
> +    if (value) {
> +        tpm_pt->ops->has_logfile =3D true;
> +        tpm_pt->ops->logfile =3D g_strdup(value);
> +        tpm_pt->ops->loglevel =3D qemu_opt_get_number(opts, "loglevel",
> +                                                   TPM_DEFAULT_LOGLEVEL)=
;
> +        tpm_pt->ops->has_loglevel =3D tpm_pt->ops->loglevel !=3D
> +                                     TPM_DEFAULT_LOGLEVEL;
> +    }
> +
> +    if (tpm_pt->ops->spawn) {
> +        if (tpm_emulator_spawn_emulator(tpm_pt) < 0) {
> +            goto err_close_dev;
> +        }
> +    } else {
> +        tpm_pt->data_ioc =3D _iochannel_new(tpm_pt->ops->data_path, -1,
> NULL);
> +        if (tpm_pt->data_ioc  =3D=3D NULL) {
> +            error_report("tpm-emulator: Failed to connect data socket:
> %s",
> +                         tpm_pt->ops->data_path);
> +            goto err_close_dev;
> +        }
> +        tpm_pt->ctrl_ioc =3D _iochannel_new(tpm_pt->ops->ctrl_path, -1,
> NULL);
> +        if (tpm_pt->ctrl_ioc =3D=3D NULL) {
> +            DPRINTF("Failed to connect control socket: %s",
> +                    strerror(errno));
> +            goto err_close_dev;
> +        }
> +        tpm_pt->child_running =3D true;
> +    }
> +
> +    /* FIXME: tpm_util_test_tpmdev() accepts only on socket fd, as it
> also used
> +     * by passthrough driver, which not yet using GIOChannel.
> +     */
> +    if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_pt->data_ioc)->fd,
> +                             &tpm_pt->tpm_version)) {
> +        error_report("'%s' is not emulating TPM device.",
> tpm_pt->ops->path);
> +        goto err_close_dev;
> +    }
> +
> +    DPRINTF("TPM Version %s", tpm_pt->tpm_version =3D=3D TPM_VERSION_1_2=
 ?
> "1.2" :
> +             (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0 ?  "2.0" :
> "Unspecified"));
> +
> +    if (tpm_emulator_probe_caps(tpm_pt) ||
> +        tpm_emulator_check_caps(tpm_pt)) {
> +        goto err_close_dev;
> +    }
> +
> +    return 0;
> +
> +err_close_dev:
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
> +static TPMOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    TPMEmulatorOptions *ops =3D g_new0(TPMEmulatorOptions, 1);
> +
> +    if (!ops) {
> +        return NULL;
> +    }
> +    DPRINTF("%s", __func__);
> +
> +    ops->tpmstatedir =3D g_strdup(tpm_pt->ops->tpmstatedir);
> +    ops->spawn =3D tpm_pt->ops->spawn;
> +    if (tpm_pt->ops->has_path) {
> +        ops->has_path =3D true;
> +        ops->path =3D g_strdup(tpm_pt->ops->path);
> +    }
> +    if (tpm_pt->ops->has_data_path) {
> +        ops->has_data_path =3D true;
> +        ops->data_path =3D g_strdup(tpm_pt->ops->data_path);
> +    }
> +    if (tpm_pt->ops->has_ctrl_path) {
> +        ops->has_ctrl_path =3D true;
> +        ops->ctrl_path =3D g_strdup(tpm_pt->ops->ctrl_path);
> +    }
> +    if (tpm_pt->ops->has_logfile) {
> +        ops->has_logfile =3D true;
> +        ops->logfile =3D g_strdup(tpm_pt->ops->logfile);
> +    }
> +    if (tpm_pt->ops->has_loglevel) {
> +        ops->has_loglevel =3D true;
> +        ops->loglevel =3D tpm_pt->ops->loglevel;
> +    }
> +
> +    return (TPMOptions *)ops;
> +}
> +
> +static const QemuOptDesc tpm_emulator_cmdline_opts[] =3D {
> +    TPM_STANDARD_CMDLINE_OPTS,
> +    {
> +        .name =3D "tpmstatedir",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "TPM state directroy",
> +    },
> +    {
> +        .name =3D "spawn",
> +        .type =3D QEMU_OPT_BOOL,
> +        .help =3D "Wether to spwan given emlatory binary",
> +    },
> +    {
> +        .name =3D "path",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Path to TPM emulator binary",
> +    },
> +    {
> +        .name =3D "data-path",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Socket path to use for data exhange",
> +    },
> +    {
> +        .name =3D "ctrl-path",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Socket path to use for out-of-band control messages",
> +    },
> +    {
> +        .name =3D "logfile",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Path to log file",
> +    },
> +    {
> +        .name =3D "level",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Log level number",
> +    },
> +    { /* end of list */ },
> +};
> +
> +static const TPMDriverOps tpm_emulator_driver =3D {
> +    .type                     =3D TPM_TYPE_EMULATOR,
> +    .opts                     =3D tpm_emulator_cmdline_opts,
> +    .desc                     =3D tpm_emulator_desc,
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
> +    tpm_pt->ops =3D g_new0(TPMEmulatorOptions, 1);
> +    tpm_pt->data_ioc =3D tpm_pt->ctrl_ioc =3D NULL;
> +    tpm_pt->op_executing =3D tpm_pt->op_canceled =3D false;
> +    tpm_pt->child_running =3D false;
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
> +    if (tpm_pt->ctrl_ioc) {
> +        qio_channel_close(tpm_pt->ctrl_ioc, NULL);
> +    }
> +    if (tpm_pt->ops) {
> +        qapi_free_TPMEmulatorOptions(tpm_pt->ops);
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
> index 0000000..af49708
> --- /dev/null
> +++ b/hw/tpm/tpm_ioctl.h
> @@ -0,0 +1,243 @@
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
> + * Every response from a command involving a TPM command execution must
> hold
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
> + * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE,
> multiple reads
> + * with this ioctl and with adjusted offset are necessary. All bytes
> + * must be transferred and the transfer is done once the last byte has
> been
> + * returned.
> + * It is possible to use the read() interface for reading the data;
> however, the
> + * first bytes of the state blob will be part of the response to the
> ioctl(); a
> + * subsequent read() is only necessary if the total length (totlength)
> exceeds
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
> +            uint32_t totlength;   /* total length that will be
> transferred */
> +            uint32_t length;      /* number of bytes in following buffer
> */
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
> +#define PTM_STATE_FLAG_DECRYPTED     1 /* on input:  get decrypted state
> */
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
> +};
> +
> +#endif /* _TPM_IOCTL_H */
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 764f731..17c2ae9 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5114,10 +5114,12 @@
>  # An enumeration of TPM types
>  #
>  # @passthrough: TPM passthrough type
> +# @emulator: Software Emulator TPM type
> +#            Since: 2.10
>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
>
>  ##
>  # @query-tpm-types:
> @@ -5131,7 +5133,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-tpm-types" }
> -# <- { "return": [ "passthrough" ] }
> +# <- { "return": [ "passthrough", "emulator" ] }
>  #
>  ##
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
> @@ -5161,6 +5163,36 @@
>  { 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
>    'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>
> +##
> +# @TPMEmulatorOptions:
> +#
> +# Information about the TPM emulator
> +#
> +# @tpmstatedir: TPM emulator state directory
> +# @spawn: true if, qemu has to spawn a new emulator process with given
> @path,
> +#         otherwise it connects to already rinning emulator with given
> @data-path
> +#         and @ctrl-path sockets. (default: 'false')
> +# @path: TPM emulator binary path to spawn.(default: 'swtpm')
> +# @data-path: path of the unix socket to use for exchanging data
> messages, if
> +#             not provided socket pairs are used when @sapwn is true.
> +# @ctrl-path: path of the unix socket file to use for exchagning
> out-of-band
> +#             control messages, if not provided socket pairs are used wh=
en
> +#             @spawn is true.
> +# @logfile: file to use to place TPM emulator logs, if not provided
> logging is
> +#           disabled.
> +# @loglevel: optional log level number, loglevel is ignored if no logfil=
e
> +#            provided. (default: 5)
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'TPMEmulatorOptions', 'base': 'TPMOptions',
> +  'data': { 'tpmstatedir' : 'str',
> +            'spawn': 'bool',
> +            '*path': 'str',
> +            '*data-path': 'str',
> +            '*ctrl-path': 'str',
> +            '*logfile': 'str',
> +            '*loglevel': 'int' } }
>
>  ##
>  # @TPMInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 99af8ed..aae0de0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2846,7 +2846,15 @@ DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
>      "-tpmdev passthrough,id=3Did[,path=3Dpath][,cancel-path=3Dpath]\n"
>      "                use path to provide path to a character device;
> default is /dev/tpm0\n"
>      "                use cancel-path to provide path to TPM's cancel
> sysfs entry; if\n"
> -    "                not provided it will be searched for in
> /sys/class/misc/tpm?/device\n",
> +    "                not provided it will be searched for in
> /sys/class/misc/tpm?/device\n"
> +    "-tpmdev
> emulator,id=3Did,spawn=3Don|off,tpmstatedir=3Ddir[,path=3Demulator-path,d=
ata-path=3Dpath,ctrl-path=3Dpath,logfile=3Dpath,loglevel=3Dlevel]\n"
> +    "                spawn=3Don|off controls spawning support\n"
> +    "                use tpmstatedir to provide path to the tpm state
> dirctory\n"
> +    "                use path to provide the emulator binary to launch;
> default is 'swtpm'\n"
> +    "                use data-path to provide the socket path for
> exchanging data messages\n"
> +    "                use ctrl-path to provide the socket path for sendin=
g
> control messages to software emulator\n"
> +    "                use logfile to provide where to place the swtpm
> logs\n"
> +    "                use loglevel to controls the swtpm log level\n",
>      QEMU_ARCH_ALL)
>  STEXI
>
> @@ -2855,8 +2863,8 @@ The general form of a TPM device option is:
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
> @@ -2906,6 +2914,45 @@ To create a passthrough TPM use the following two
> options:
>  Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
>  @code{tpmdev=3Dtpm0} in the device option.
>
> +@item -tpmdev emulator, id=3D@var{id}, tpmstatedir=3D@var{path},
> spawn=3D@var{on|off}, path=3D@var{emulator-binary-path}, data-path=3D@var=
{path},
> ctrl-path=3D@var{path}, logfile=3D@var{path}, loglevel=3D@var{level}
> +
> +(Linux-host only) Enable access to a TPM emulator using unix domain
> sockets.
> +
> +@option{tpmstatedir} specifies the tpm state directory
> +
> +@option{spawn} specifies if qemu should spawn new emulator process with
> given @option{path}
> +
> +@option{path} specifies the emulator binary path to use for spawning
> +
> +@option{data-path} optional socket path to use for exchanging TPM data
> with emulator
> +
> +@option{ctrl-path} optional socket path to use for sending control data
> to emulator
> +
> +@option{logfile} optional log file to use to place log messages
> +
> +@option{loglevel} specifies the log level to use
> +
> +To create TPM emulator backend device that spawns new swtpm binary and
> communicate with socket pairs:
> +@example
> +
> +-tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/my-tpm,spawn=3Don,path=3D/usr/local=
/bin/swtpm,logfile=3D/tmp/qemu-tpm.log,loglevel=3D5
> -device tpm-tis,tpmdev=3Dtpm0
> +
> +@end example
> +
> +To create TPM emulator backend device that spawns new swtpm binary and
> communicate using unix file system sockets:
> +@example
> +
> +-tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/my-tpm,spawn=3Don,path=3D/usr/local=
/bin/swtpm,data-path=3D/tmp/swtpm-data.socket,ctrl-path=3D/tmp/swtpm-ctrl.s=
ocket,logfile=3D/tmp/qemu-tpm.log,loglevel=3D5
> -device tpm-tis,tpmdev=3Dtpm0
> +
> +@end example
> +
> +To create a TOM emulator backend device that connects to already running
> swtpm binary using file system sockets:
> +@example
> +
> +-tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/my-tpm,spawn=3Doff,data-path=3D/tmp=
/swtpm-data.socket,ctrl-path=3D/tmp/swtpm-ctrl.socket,logfile=3D/tmp/qemu-t=
pm.log,loglevel=3D5
> -device tpm-tis,tpmdev=3Dtpm0
> +
> +@end example
> +
>  @end table
>
>  ETEXI
> diff --git a/tpm.c b/tpm.c
> index 43d980e..ce07c40 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -25,7 +25,7 @@ static QLIST_HEAD(, TPMBackend) tpm_backends =3D
>
>
>  #define TPM_MAX_MODELS      1
> -#define TPM_MAX_DRIVERS     1
> +#define TPM_MAX_DRIVERS     2
>
>  static TPMDriverOps const *be_drivers[TPM_MAX_DRIVERS] =3D {
>      NULL,
> --
> 2.7.4
>
> --
Marc-Andr=C3=A9 Lureau
