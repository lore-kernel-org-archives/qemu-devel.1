Received: from eggs.gnu.org ([2001:4830:134:3::10]:53528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvRFU-0001Ng-Ae
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvRFL-00044E-Sk
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:24:04 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvRFL-00043A-0Q
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:23:55 -0400
Received: by mail-lf0-x242.google.com with SMTP id v2so15953518lfi.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-9-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-9-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Apr 2017 16:23:42 +0000
Message-ID: <CAJ+F1C+FJffHtxP4VDyhc9e=eR+fvv=uJ7u6SvnqS3Do80GktA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] tpm: New backend driver to support TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

Hi

(just a quick review, there will be more once the design discussion is over=
)

On Fri, Mar 31, 2017 at 5:03 PM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

> This change introduces a new TPM backend driver that can communicates wit=
h
>

communicate


> swtpm(software TPM emulator) using unix domain socket interface.
>
> Swtpm uses two unix sockets, one for plain TPM commands and responses, an=
d
> one
> for out-of-band control messages.
>
>
Is the protocol documented? what's the reason to use 2 sockets?


> The swtpm and associated tools can be found here:
>     https://github.com/stefanberger/swtpm
>
> Usage:
>     # setup TPM state directory
>     mkdir /tmp/mytpm
>     chown -R tss:root /tmp/mytpm
>     /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>
>     # Ask qeum to use TPM emulator with given tpm state directory
>

qemu


>     qemu-system-x86_64 \
>         [...] \
>         -tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/mytpm,logfile=3D/tmp/swtpm.log \
>         -device tpm-tis,tpmdev=3Dtpm0 \
>         [...]
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  configure             |   6 +
>  hmp.c                 |  14 +
>  hw/tpm/Makefile.objs  |   1 +
>  hw/tpm/tpm_emulator.c | 740
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_ioctl.h    | 243 +++++++++++++++++
>  hw/tpm/tpm_util.c     |  34 +++
>  hw/tpm/tpm_util.h     |   3 +
>  qapi-schema.json      |  22 +-
>  qemu-options.hx       |  25 +-
>  tpm.c                 |   7 +-
>  10 files changed, 1089 insertions(+), 6 deletions(-)
>  create mode 100644 hw/tpm/tpm_emulator.c
>  create mode 100644 hw/tpm/tpm_ioctl.h
>
> diff --git a/configure b/configure
> index 4901b9a..9089546 100755
> --- a/configure
> +++ b/configure
> @@ -3349,8 +3349,10 @@ fi
>
>  if test "$targetos" =3D Linux && test "$cpu" =3D i386 -o "$cpu" =3D x86_=
64; then
>    tpm_passthrough=3D$tpm
> +  tpm_emulator=3D$tpm
>

What is the restriction to x86 & linux? I suppose it should work on various
unix.


>  else
>    tpm_passthrough=3Dno
> +  tpm_emulator=3Dno
>  fi
>
>  ##########################################
> @@ -5125,6 +5127,7 @@ echo "gcov enabled      $gcov"
>  echo "TPM support       $tpm"
>  echo "libssh2 support   $libssh2"
>  echo "TPM passthrough   $tpm_passthrough"
> +echo "TPM emulator      $tpm_emulator"
>  echo "QOM debugging     $qom_cast_debug"
>  echo "lzo support       $lzo"
>  echo "snappy support    $snappy"
> @@ -5704,6 +5707,9 @@ if test "$tpm" =3D "yes"; then
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
> index edb8970..03a47e2 100644
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
> @@ -966,6 +967,19 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                             tpo->has_cancel_path ? ",cancel-path=3D" : ""=
,
>                             tpo->has_cancel_path ? tpo->cancel_path : "")=
;
>              break;
> +        case TPM_TYPE_OPTIONS_KIND_EMULATOR:
> +            teo =3D ti->options->u.emulator.data;
> +            monitor_printf(mon, ",tmpstatedir=3D%s", teo->tpmstatedir);
> +            if (teo->has_path) {
> +                monitor_printf(mon, ",path=3D%s", teo->path);
> +            }
> +            if (teo->has_logfile) {
> +                monitor_printf(mon, ",logfile=3D%s", teo->logfile);
> +            }
> +            if (teo->has_loglevel) {
> +                monitor_printf(mon, ",loglevel=3D%ld", teo->loglevel);
> +            }
> +            break;
>          case TPM_TYPE_OPTIONS_KIND__MAX:
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
> index 0000000..5b1dcfa
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,740 @@
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
> + * The origin of the code is from CUSE driver posed by Stefan Berger:
> + *    https://github.com/stefanberger/qemu-tpm


I wonder if it makes sense to leave that only in commit message instead,
URL often break..


>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
> +#include "hw/hw.h"
> +#include "hw/i386/pc.h"
> +#include "sysemu/tpm_backend_int.h"
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
> +#define DPRINTF(fmt, ...) DPRINT(fmt"\n", __VA_ARGS__)
> +
> +#define TYPE_TPM_EMULATOR "emulator"
>

please keep the tpm- prefix (object typename is global)

+#define TPM_EMULATOR(obj) \
> +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
> +
> +static const TPMDriverOps tpm_emulator_driver;
> +
> +/* data structures */
> +typedef struct TPMEmulator {
> +    TPMBackend parent;
> +
> +    TPMEmulatorOptions ops;
> +    int tpm_fd;
> +    int tpm_ctrl_fd;
> +    bool op_executing;
> +    bool op_canceled;
> +    bool child_running;
> +    TPMVersion tpm_version;
> +    ptm_cap caps; /* capabilities of the TPM */
> +    uint8_t cur_locty_number; /* last set locality */
> +} TPMEmulator;
> +
> +#define TPM_DEFAULT_EMULATOR "swtpm"
> +#define TPM_DEFAULT_LOGLEVEL 5
> +#define TPM_EUMLATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) =
=3D=3D
> (cap))
>

EUMLATOR: typo


> +
> +static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_pt,
> +                                     const uint8_t *in, uint32_t in_len,
> +                                     uint8_t *out, uint32_t out_len,
> +                                     bool *selftest_done)
> +{
> +    int ret;
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
> +    ret =3D tpm_util_unix_write(tpm_pt->tpm_fd, in, in_len);
> +    if (ret !=3D in_len) {
> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> +            error_report("tpm_emulator: error while transmitting data "
> +                         "to TPM: %s (%i)", strerror(errno), errno);
> +        }
> +        goto err_exit;
> +    }
> +
> +    tpm_pt->op_executing =3D false;
> +
> +    ret =3D tpm_util_unix_read(tpm_pt->tpm_fd, out, out_len);
> +    if (ret < 0) {
> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> +            error_report("tpm_emulator: error while reading data from "
> +                         "TPM: %s (%i)", strerror(errno), errno);
> +        }
> +    } else if (ret < sizeof(struct tpm_resp_hdr) ||
> +               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
> +        ret =3D -1;
> +        error_report("tpm_emulator: received invalid response "
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
> +    DPRINTF("tpm_emulator: %s : locality: 0x%x", __func__, locty_number)=
;
> +
> +    if (tpm_pt->cur_locty_number !=3D locty_number) {
> +        DPRINTF("tpm-emulator: setting locality : 0x%x", locty_number);
> +        loc.u.req.loc =3D cpu_to_be32(locty_number);
> +        if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_SET_LOCALITY, &loc=
,
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
>

you used "tpm_emulator:" above, you may want to have consistency


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
> +    DPRINTF("tpm_emulator: processing command type %d", cmd);
> +
> +    switch (cmd) {
> +    case TPM_BACKEND_CMD_PROCESS_CMD:
> +        locty =3D tb->tpm_state->locty_data;
>

tbh, I wonder why there is no lock to protect against concurrent usage of
tpm state. It seems it would be possible to have the worker thread doing a
read/write concurrently with the main thread (though another callback). It
may not happen, but it doesn't look safe. Should we add locks? this may be
true for passthrough as well, but it is more obvious with this code.


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
> +    if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_SHUTDOWN, &res, 0,
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
> +    DPRINTF("tpm_emulator: %s", __func__);
> +    if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_GET_CAPABILITY,
> +                         &tpm_pt->caps, 0, sizeof(tpm_pt->caps)) < 0) {
> +        error_report("tpm-emulator: probing failed : %s",
> strerror(errno));
> +        return -1;
> +    }
> +
> +    tpm_pt->caps =3D be64_to_cpu(tpm_pt->caps);
> +
> +    DPRINTF("tpm-emulator: capbilities : 0x%lx", tpm_pt->caps);
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
> +    if (!TPM_EUMLATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, caps)) {
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
> +static int tpm_emulator_init_tpm(TPMEmulator *tpm_pt, bool is_resume)
> +{
> +    ptm_init init;
> +    ptm_res res;
> +
> +    if (!tpm_pt->child_running) {
> +        return -1;
> +    }
> +
> +    DPRINTF("tpm_emulator: %s", __func__);
> +    if (is_resume) {
> +        init.u.req.init_flags =3D
> cpu_to_be32(PTM_INIT_FLAG_DELETE_VOLATILE);
> +    }
>

is_resume is always false, remove it?


> +
> +    if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_INIT, &init,
> sizeof(init),
> +                         sizeof(init)) < 0) {
> +        error_report("tpm-emulator: could not send INIT: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    res =3D be32_to_cpu(init.u.resp.tpm_result);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for PTM_INIT: 0x%x", res)=
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
> +    DPRINTF("tpm_emulator: %s", __func__);
> +
> +    tpm_emulator_init_tpm(tpm_pt, false) ;
> +
> +    return 0;
> +}
> +
> +static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    ptm_est est;
> +
> +    DPRINTF("tpm_emulator: %s", __func__);
> +    if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_GET_TPMESTABLISHED,
> &est, 0,
> +                         sizeof(est)) < 0) {
> +        error_report("tpm-emulator: Could not get the TPM established
> flag: %s",
> +                     strerror(errno));
> +        return false;
> +    }
> +    DPRINTF("tpm_emulator: established flag: %0x", est.u.resp.bit);
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
> +        reset_est.u.req.loc =3D cpu_to_be32(tpm_pt->cur_locty_number);
> +
> +        if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd,
> PTM_RESET_TPMESTABLISHED,
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
> +static bool tpm_emulator_get_startup_error(TPMBackend *tb)
>

I prefer to name the function after the callback if possible to avoid
confusions (had_startup_error)


> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    return !tpm_pt->child_running;
> +}
> +
> +static size_t tpm_emulator_realloc_buffer(TPMSizedBuffer *sb)
> +{
> +    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
> +
> +    if (sb->size !=3D wanted_size) {
> +        sb->buffer =3D g_realloc(sb->buffer, wanted_size);
> +        sb->size =3D wanted_size;
> +    }
> +    return sb->size;
> +}
>

Same as tpm_passthrough.. Move it to base class?


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
> +        if (TPM_EUMLATOR_IMPLEMENTS_ALL_CAPS(tpm_pt,
> PTM_CAP_CANCEL_TPM_CMD)) {
> +            if (tpm_util_ctrlcmd(tpm_pt->tpm_ctrl_fd, PTM_CANCEL_TPM_CMD=
,
> &res,
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
> +    DPRINTF("tpm_emulator: %s", __func__);
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
> +static void tpm_emulator_fd_handler(void *opaque)
> +{
> +    TPMEmulator *tpm_pt =3D opaque;
> +    char val =3D 0;
> +    ssize_t size;
> +
> +    qemu_set_fd_handler(tpm_pt->tpm_fd, NULL, NULL, NULL);
> +
> +    size =3D qemu_recv(tpm_pt->tpm_fd, &val, 1, MSG_PEEK);
> +    if (!size) {
> +        error_report("TPM backend disappeared");
> +        tpm_pt->child_running =3D false;
> +    } else {
> +        DPRINT("tpm-emulator: unexpected data on TPM\n");
> +    }
> +}
> +
> +static int tpm_emulator_spawn_emulator(TPMEmulator *tpm_pt)
> +{
> +    int fds[2];
> +    int ctrl_fds[2];
> +    pid_t cpid;
> +
> +    if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
> +        return -1;
> +    }
> +
> +    if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, ctrl_fds) < 0) {
> +        closesocket(fds[0]);
> +        closesocket(fds[1]);
> +        return -1;
> +    }
> +
> +    cpid =3D fork();
> +    if (cpid < 0) {
> +        error_report("tpm-emulator: Fork failure: %s", strerror(errno));
> +        closesocket(fds[0]); closesocket(fds[1]);
> +        closesocket(ctrl_fds[0]); closesocket(ctrl_fds[1]);
> +        return -1;
> +    }
> +
> +    if (cpid =3D=3D 0) { /* CHILD */
> +        int i;
> +        char fd_str[128] =3D "";
> +        char ctrl_fd_str[128] =3D "";
> +        char tpmstate_str[1024] =3D "";
> +        char log_str[1024] =3D "";
> +        const char *params[] =3D {
> +            tpm_pt->ops.path, "socket",
> +            "--fd", fd_str,
> +            "--ctrl", ctrl_fd_str,
> +            "--tpmstate", tpmstate_str,
> +            "--log", log_str,
> +            NULL /* End */
> +        };
> +
> +        /* close all unused inherited sockets */
> +        closesocket(fds[0]);
> +        closesocket(ctrl_fds[0]);
> +        for (i =3D STDERR_FILENO + 1; i < fds[1]; i++) {
> +            closesocket(i);
>

what is this closing? I guess you should close all until
sysconf(_SC_OPEN_MAX) . I would dup2() the needed sockets to fixed values
after stderr.

+        }
> +
> +        sprintf(fd_str, "%d", fds[1]);
> +        sprintf(ctrl_fd_str, "type=3Dunixio,clientfd=3D%d", ctrl_fds[1])=
;
> +        sprintf(tpmstate_str, "dir=3D%s", tpm_pt->ops.tpmstatedir);
>

Or snprintf, better safe than sorry (for very long statedir path for ex)


> +        if (tpm_pt->ops.has_logfile) {
> +            sprintf(log_str, "file=3D%s,level=3D%d", tpm_pt->ops.logfile=
,
> +                    (int)tpm_pt->ops.loglevel);
> +        } else {
> +            /* truncate logs */
> +            params[8] =3D NULL;
> +        }
> +        DPRINT("Running cmd: ")
> +        for (i =3D 0; params[i]; i++) {
> +            DPRINT(" %s", params[i])
> +        }
> +        DPRINT("\n")
> +        if (execv(tpm_pt->ops.path, (char * const *)params) < 0) {
> +            error_report("execv() failure : %s", strerror(errno));
> +        }
> +        closesocket(fds[1]);
> +        closesocket(ctrl_fds[1]);
> +        exit(0);
> +    } else { /* self */
> +        DPRINTF("tpm-emulator: child pid: %d", cpid);
> +        /* FIXME: find better way of finding swtpm ready
> +                  maybe write 'ready'bit on socket ?
> +           give some time to child to get ready */
> +        sleep(1);
>

what happens without the sleep?

> +
> +        tpm_pt->tpm_fd =3D fds[0];
> +        tpm_pt->tpm_ctrl_fd =3D ctrl_fds[0];
> +        tpm_pt->child_running =3D true;
> +
> +        qemu_add_child_watch(cpid);
> +
> +        fcntl(tpm_pt->tpm_fd, F_SETFL, O_NONBLOCK);
> +        qemu_set_fd_handler(tpm_pt->tpm_fd, tpm_emulator_fd_handler, NUL=
L,
> +                            tpm_pt);
> +
> +        /* close unsed sockets */
> +        closesocket(fds[1]);
> +        closesocket(ctrl_fds[1]);
> +    }
> +
> +    return 0;
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
> +    tpm_pt->ops.tpmstatedir =3D g_strdup(value);
> +
> +    value =3D qemu_opt_get(opts, "path");
> +    if (!value) {
> +        value =3D TPM_DEFAULT_EMULATOR;
> +        tpm_pt->ops.has_path =3D false;
> +    } else {
> +        tpm_pt->ops.has_path =3D true;
> +        if (value[0] =3D=3D '/') {
> +            struct stat st;
> +            if (stat(value, &st) < 0 || !(S_ISREG(st.st_mode)
> +                || S_ISLNK(st.st_mode))) {
> +                error_report("tpm-emulator: Invalid emulator path: %s",
> value);
>

probably not worth the racy check in qemu

+                return -1;
> +            }
> +        }
> +    }
> +    tpm_pt->ops.path =3D g_strdup(value);
> +
> +    value =3D qemu_opt_get(opts, "logfile");
> +    if (value) {
> +        DPRINTF("tpm-emulator: LogFile: %s", value);
> +        tpm_pt->ops.has_logfile =3D true;
> +        tpm_pt->ops.logfile =3D g_strdup(value);
> +        tpm_pt->ops.loglevel =3D qemu_opt_get_number(opts, "loglevel",
> +                                                   TPM_DEFAULT_LOGLEVEL)=
;
> +        tpm_pt->ops.has_loglevel =3D tpm_pt->ops.loglevel !=3D
> +                                     TPM_DEFAULT_LOGLEVEL;
> +    }
> +
> +    if (tpm_emulator_spawn_emulator(tpm_pt) < 0) {
> +        goto err_close_dev;
> +    }
> +
> +    tpm_pt->cur_locty_number =3D ~0;
> +
> +    if (tpm_emulator_probe_caps(tpm_pt) ||
> +        tpm_emulator_init_tpm(tpm_pt, false)) {
> +        goto err_close_dev;
> +    }
> +
> +    if (tpm_util_test_tpmdev(tpm_pt->tpm_fd, &tpm_pt->tpm_version)) {
> +        error_report("'%s' is not emulating TPM device.",
> tpm_pt->ops.path);
> +        goto err_close_dev;
> +    }
> +
> +    DPRINTF("tpm_emulator: TPM Version %s",
> +             tpm_pt->tpm_version =3D=3D TPM_VERSION_1_2 ? "1.2" :
> +             (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0 ?  "2.0" :
> "Unspecified"));
> +
> +    if (tpm_emulator_check_caps(tpm_pt)) {
> +        goto err_close_dev;
> +    }
> +
> +    return 0;
> +
> +err_close_dev:
> +    tpm_emulator_shutdown(tpm_pt);
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
> +static void tpm_emulator_destroy(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +
> +    DPRINTF("tpm_emulator: %s", __func__);
> +
> +    tpm_emulator_cancel_cmd(tb);
> +    tpm_emulator_shutdown(tpm_pt);
> +
> +    closesocket(tpm_pt->tpm_fd);
> +    closesocket(tpm_pt->tpm_ctrl_fd);
> +    g_free(tpm_pt->ops.tpmstatedir);
> +    g_free(tpm_pt->ops.path);
> +    g_free(tpm_pt->ops.logfile);
> +}
> +
> +static TPMOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
> +    TPMEmulatorOptions *ops =3D g_new(TPMEmulatorOptions, 1);
> +
> +    if (!ops) {
> +        return NULL;
> +    }
> +    DPRINTF("tpm_emulator: %s", __func__);
> +
> +    ops->tpmstatedir =3D g_strdup(tpm_pt->ops.tpmstatedir);
> +    if (tpm_pt->ops.has_path) {
> +        ops->has_path =3D true;
> +        ops->path =3D g_strdup(tpm_pt->ops.path);
> +    }
> +    if (tpm_pt->ops.has_logfile) {
> +        ops->has_logfile =3D true;
> +        ops->logfile =3D g_strdup(tpm_pt->ops.logfile);
> +    }
> +    if (tpm_pt->ops.has_loglevel) {
> +        ops->has_loglevel =3D true;
> +        ops->loglevel =3D tpm_pt->ops.loglevel;
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
> +        .name =3D "path",
> +        .type =3D QEMU_OPT_STRING,
> +        .help =3D "Path to TPM emulator binary",
>

I wonder if it's wise to let qemu exec any path. Maybe this should be
restricted to a known location?


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
> +    .destroy                  =3D tpm_emulator_destroy,
> +    .startup_tpm              =3D tpm_emulator_startup_tpm,
> +    .realloc_buffer           =3D tpm_emulator_realloc_buffer,
> +    .reset                    =3D tpm_emulator_reset,
> +    .had_startup_error        =3D tpm_emulator_get_startup_error,
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
> +    DPRINTF("tpm_emulator: %s", __func__);
> +    tpm_pt->tpm_fd =3D tpm_pt->tpm_ctrl_fd =3D -1;
> +    tpm_pt->op_executing =3D tpm_pt->op_canceled =3D false;
> +    tpm_pt->child_running =3D false;
> +    tpm_pt->cur_locty_number =3D ~0;
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
>

any reason why all the commands have PTM prefix instead of TPM ?
(presumably to avoid some conflict?)


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
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 5475acf..34b1d59 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "tpm_util.h"
>  #include "tpm_int.h"
> +#include "tpm_ioctl.h"
>
>  int tpm_util_unix_write(int fd, const uint8_t *buf, uint32_t len)
>  {
> @@ -185,3 +186,36 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion
> *tpm_version)
>
>      return 1;
>  }
> +
> +static unsigned long ioctl_to_cmd(unsigned long ioctlnum)
> +{
> +    /* the ioctl number contains the command number - 1 */
> +    return ((ioctlnum >> _IOC_NRSHIFT) & _IOC_NRMASK) + 1;
> +}
> +
> +int tpm_util_ctrlcmd(int fd, unsigned long cmd, void *msg, size_t
> msg_len_in,
> +                   size_t msg_len_out)
> +{
> +    int n;
> +
> +    uint32_t cmd_no =3D cpu_to_be32(ioctl_to_cmd(cmd));
> +    struct iovec iov[2] =3D {
> +        { .iov_base =3D &cmd_no, .iov_len =3D sizeof(cmd_no), },
> +        { .iov_base =3D msg, .iov_len =3D msg_len_in, },
> +    };
> +
> +    n =3D writev(fd, iov, 2);
> +    if (n > 0) {
> +        if (msg_len_out > 0) {
> +            n =3D read(fd, msg, msg_len_out);
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
>

This helper could be kept in tpm_emulator.c


> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index c2feca7..b93d484 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -34,4 +34,7 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t
> in_len);
>
>  int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
>
> +int tpm_util_ctrlcmd(int fd, unsigned long cmd, void *msg,
> +                     size_t msg_len_in, size_t msg_len_out);
> +
>  #endif /* TPM_TPM_UTIL_H */
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5faf1ac..e8ddbc6 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5117,10 +5117,11 @@
>  # An enumeration of TPM types
>  #
>  # @passthrough: TPM passthrough type
> +# @emulator: Software Emulator TPM type
>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
>
>  ##
>  # @query-tpm-types:
> @@ -5163,6 +5164,22 @@
>    'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>
>  ##
> +# @TPMEmulatorOptions:
> +#
> +# Information about the TPM emulator
> +#
> +# @tpmstatedir: TPM emilator state dir
> +# @path: TPM emulator binary path to use
> +# @logfile: file to use to place TPM emulator logs
> +# @loglevel: log level number
> +#
> +# Since: 2.6
> +##
> +{ 'struct': 'TPMEmulatorOptions', 'base': 'TPMOptions',
> +  'data': { 'tpmstatedir' : 'str', '*path': 'str',
> +            '*logfile' : 'str', '*loglevel' : 'int' } }
> +
> +##
>  # @TpmTypeOptions:
>  #
>  # A union referencing different TPM backend types' configuration options
> @@ -5172,7 +5189,8 @@
>  # Since: 1.5
>  ##
>  { 'union': 'TpmTypeOptions',
> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
> +  'data': { 'passthrough' : 'TPMPassthroughOptions',
> +            'emulator' : 'TPMEmulatorOptions' } }
>
>  ##
>  # @TPMInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 99af8ed..5bbf187 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2846,7 +2846,12 @@ DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
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
> emulator,id=3Did,tpmstatedir=3Ddir[,path=3Demulator-path,logfile=3Dpath,l=
oglevel=3Dlevel]\n"
> +    "                use tpmstatedir to provide path to the tpm state
> dirctory\n"
> +    "                use path to provide the emulator binary to launch;
> default is 'swtpm'\n"
> +    "                use logfile to provide where to place the swtpm
> logs\n"
> +    "                use loglevel to controls the swtpm log level\n",
>      QEMU_ARCH_ALL)
>  STEXI
>
> @@ -2855,8 +2860,8 @@ The general form of a TPM device option is:
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
> @@ -2906,6 +2911,20 @@ To create a passthrough TPM use the following two
> options:
>  Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
>  @code{tpmdev=3Dtpm0} in the device option.
>
> +@item -tpmdev emulator, id=3D@var{id}, tpmstatedir=3D@var{path},
> path=3D@var{emulator-binary-path}, logfile=3D@var{path}, logevel=3D@var{l=
evel}
> +
> +(Linux-host only) Enable access to a TPM emulator.
> +
> +@option{tpmstatedir} specifies the tpm state directory
> +@option{path} specifies the emulator binary path to use
> +@option{logfile} optional log file to use to place log messages
> +@option{loglevel} specifies the log level to use
> +
> +To create a TPM emulator backend device:
> +@example
> +-tpmdev
> emulator,id=3Dtpm0,tpmstatedir=3D/tmp/my-tpm,path=3D/usr/local/bin/swtpm,=
logfile=3D/tmp/qemu-tpm.log,logevel=3D5
> -device tpm-tis,tpmdev=3Dtpm0
> +@end example
> +
>  @end table
>
>  ETEXI
> diff --git a/tpm.c b/tpm.c
> index c221000..ed110d2 100644
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
> @@ -263,6 +263,11 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
>          res->options->u.passthrough.data =3D
>              (TPMPassthroughOptions *)tpm_backend_get_tpm_options(drv);
>          break;
> +    case TPM_TYPE_EMULATOR:
> +        res->options->type =3D TPM_TYPE_OPTIONS_KIND_EMULATOR;
> +        res->options->u.emulator.data =3D
> +            (TPMEmulatorOptions *) tpm_backend_get_tpm_options(drv);
> +        break;
>      case TPM_TYPE__MAX:
>          break;
>      }
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
