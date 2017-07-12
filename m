Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dVMJs-0007vF-FO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dVMJn-0007hz-Di
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:25:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dVMJm-0007gj-Vr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:24:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CINdnZ145417
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:24:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncjb76jx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:24:55 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 12:24:54 -0600
References: <1496666711-14630-1-git-send-email-amarnath.valluri@intel.com>
	<1496666711-14630-9-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 14:24:51 -0400
MIME-Version: 1.0
In-Reply-To: <1496666711-14630-9-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <bf0c76d1-2d03-6d07-49d5-08208a24882f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com

On 06/05/2017 08:45 AM, Amarnath Valluri wrote:
> This change introduces a new TPM backend driver that can communicate with
> swtpm(software TPM emulator) using unix domain socket interface.
>
> Swtpm uses two unix sockets, one for plain TPM commands and responses, and one
> for out-of-band control messages.
>
> The swtpm and associated tools can be found here:
>      https://github.com/stefanberger/swtpm
>
> The swtpm's control channel protocol specification can be found here:
>      https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification
>
> Usage:
>      # setup TPM state directory
>      mkdir /tmp/mytpm
>      chown -R tss:root /tmp/mytpm
>      /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>
>      # Ask qemu to use TPM emulator with given tpm state directory
>      qemu-system-x86_64 \
>          [...] \
>          -tpmdev emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
>          -device tpm-tis,tpmdev=tpm0 \
>          [...]
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>   configure             |  15 +-
>   hmp.c                 |  21 ++
>   hw/tpm/Makefile.objs  |   1 +
>   hw/tpm/tpm_emulator.c | 973 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/tpm_ioctl.h    | 243 +++++++++++++
>   qapi-schema.json      |  41 ++-
>   qemu-options.hx       |  53 ++-
>   tpm.c                 |   2 +-
>   8 files changed, 1339 insertions(+), 10 deletions(-)
>   create mode 100644 hw/tpm/tpm_emulator.c
>   create mode 100644 hw/tpm/tpm_ioctl.h
>
> diff --git a/configure b/configure
> index 39e727e..b010bfb 100755
> --- a/configure
> +++ b/configure
> @@ -3404,10 +3404,15 @@ fi
>   ##########################################
>   # TPM passthrough is only on x86 Linux
>
> -if test "$targetos" = Linux && test "$cpu" = i386 -o "$cpu" = x86_64; then
> -  tpm_passthrough=$tpm
> +if test "$targetos" = Linux; then
> +  tpm_emulator=$tpm
> +  if test "$cpu" = i386 -o "$cpu" = x86_64; then
> +    tpm_passthrough=$tpm
> +  else
> +    tpm_passthrough=no
> +  fi
>   else
> -  tpm_passthrough=no
> +  tpm_emulator=no
>   fi
>
>   ##########################################
> @@ -5214,6 +5219,7 @@ echo "gcov enabled      $gcov"
>   echo "TPM support       $tpm"
>   echo "libssh2 support   $libssh2"
>   echo "TPM passthrough   $tpm_passthrough"
> +echo "TPM emulator      $tpm_emulator"
>   echo "QOM debugging     $qom_cast_debug"
>   echo "lzo support       $lzo"
>   echo "snappy support    $snappy"
> @@ -5794,6 +5800,9 @@ if test "$tpm" = "yes"; then
>     if test "$tpm_passthrough" = "yes"; then
>       echo "CONFIG_TPM_PASSTHROUGH=y" >> $config_host_mak
>     fi
> +  if test "$tpm_emulator" = "yes"; then
> +    echo "CONFIG_TPM_EMULATOR=y" >> $config_host_mak
> +  fi
>   fi
>
>   echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
> diff --git a/hmp.c b/hmp.c
> index 9338938..073faef 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -938,6 +938,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>       Error *err = NULL;
>       unsigned int c = 0;
>       TPMPassthroughOptions *tpo;
> +    TPMEmulatorOptions *teo;
>
>       info_list = qmp_query_tpm(&err);
>       if (err) {
> @@ -967,6 +968,26 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                              tpo->has_cancel_path ? ",cancel-path=" : "",
>                              tpo->has_cancel_path ? tpo->cancel_path : "");
>               break;
> +        case TPM_TYPE_EMULATOR:
> +            teo = ti->options->u.emulator.data;
> +            monitor_printf(mon, ",tmpstatedir=%s", teo->tpmstatedir);
> +            monitor_printf(mon, ",spawn=%s", teo->spawn ? "on" : "off");
> +            if (teo->has_path) {
> +                monitor_printf(mon, ",path=%s", teo->path);
> +            }
> +            if (teo->has_data_path) {
> +                monitor_printf(mon, ",data-path=%s", teo->data_path);
> +            }
> +            if (teo->has_ctrl_path) {
> +                monitor_printf(mon, ",ctrl-path=%s", teo->ctrl_path);
> +            }
> +            if (teo->has_logfile) {
> +                monitor_printf(mon, ",logfile=%s", teo->logfile);
> +            }
> +            if (teo->has_loglevel) {
> +                monitor_printf(mon, ",loglevel=%u", teo->loglevel);
> +            }
> +            break;
>           default:
>               break;
>           }
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 64cecc3..41f0b7a 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,2 +1,3 @@
>   common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o tpm_util.o
> +common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o tpm_util.o
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> new file mode 100644
> index 0000000..c90914c
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,973 @@
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
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
> +#include "migration/migration.h"
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
> +    Error *migration_blocker;
> +} TPMEmulator;
> +
> +#define TPM_DEFAULT_EMULATOR "swtpm"
> +#define TPM_DEFAULT_LOGLEVEL 5
> +#define TPM_EMULATOR_PIDFILE "/tmp/qemu-tpm.pid"

Is this a single PID file used by all QEMUs running on the same system? 
I don't think this works when multiple QEMUs try to start TPMs 
concurrently. You may want to encode the pid of the QEMU process into it 
-> "/tmp/qemu-tpm.%u.pid", getpid() or something like that.

> +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) == (cap))
> +
> +static int tpm_emulator_ctrlcmd(QIOChannel *ioc, unsigned long cmd, void *msg,
> +                                size_t msg_len_in, size_t msg_len_out)
> +{
> +    ssize_t n;
> +
> +    uint32_t cmd_no = cpu_to_be32(cmd);
> +    struct iovec iov[2] = {
> +        { .iov_base = &cmd_no, .iov_len = sizeof(cmd_no), },
> +        { .iov_base = msg, .iov_len = msg_len_in, },
> +    };
> +
> +    n = qio_channel_writev(ioc, iov, 2, NULL);
> +    if (n > 0) {
> +        if (msg_len_out > 0) {
> +            n = qio_channel_read(ioc, (char *)msg, msg_len_out, NULL);
> +            /* simulate ioctl return value */
> +            if (n > 0) {
> +                n = 0;
> +            }
> +        } else {
> +            n = 0;
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
> +    tpm_pt->op_canceled = false;
> +    tpm_pt->op_executing = true;
> +    *selftest_done = false;
> +
> +    is_selftest = tpm_util_is_selftest(in, in_len);
> +
> +    ret = qio_channel_write(tpm_pt->data_ioc, (const char *)in, (size_t)in_len,
> +                            NULL);
> +    if (ret != in_len) {
> +        if (!tpm_pt->op_canceled || errno != ECANCELED) {
> +            error_report("tpm-emulator: error while transmitting data "
> +                         "to TPM: %s (%i)", strerror(errno), errno);
> +        }
> +        goto err_exit;
> +    }
> +
> +    tpm_pt->op_executing = false;
> +
> +    ret = qio_channel_read(tpm_pt->data_ioc, (char *)out, (size_t)out_len,
> +                           NULL);
> +    if (ret < 0) {
> +        if (!tpm_pt->op_canceled || errno != ECANCELED) {
> +            error_report("tpm-emulator: error while reading data from "
> +                         "TPM: %s (%i)", strerror(errno), errno);
> +        }
> +    } else if (ret < sizeof(struct tpm_resp_hdr) ||
> +               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) != ret) {
> +        ret = -1;
> +        error_report("tpm-emulator: received invalid response "
> +                     "packet from TPM");
> +    }
> +
> +    if (is_selftest && (ret >= sizeof(struct tpm_resp_hdr))) {
> +        hdr = (struct tpm_resp_hdr *)out;
> +        *selftest_done = (be32_to_cpu(hdr->errcode) == 0);
> +    }
> +
> +err_exit:
> +    if (ret < 0) {
> +        tpm_util_write_fatal_error_response(out, out_len);
> +    }
> +
> +    tpm_pt->op_executing = false;
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
> +    if (tpm_pt->cur_locty_number != locty_number) {
> +        DPRINTF("setting locality : 0x%x", locty_number);
> +        loc.u.req.loc = locty_number;
> +        if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_SET_LOCALITY, &loc,
> +                             sizeof(loc), sizeof(loc)) < 0) {
> +            error_report("tpm-emulator: could not set locality : %s",
> +                         strerror(errno));
> +            return -1;
> +        }
> +        loc.u.resp.tpm_result = be32_to_cpu(loc.u.resp.tpm_result);
> +        if (loc.u.resp.tpm_result != 0) {
> +            error_report("tpm-emulator: TPM result for set locality : 0x%x",
> +                         loc.u.resp.tpm_result);
> +            return -1;
> +        }
> +        tpm_pt->cur_locty_number = locty_number;
> +    }
> +    return 0;
> +}
> +
> +static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd cmd)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +    TPMLocality *locty = NULL;
> +    bool selftest_done = false;
> +
> +    DPRINTF("processing command type %d", cmd);
> +
> +    switch (cmd) {
> +    case TPM_BACKEND_CMD_PROCESS_CMD:
> +        qemu_mutex_lock(&tpm_pt->state_lock);
> +        locty = tb->tpm_state->locty_data;
> +        if (tpm_emulator_set_locality(tpm_pt,
> +                                      tb->tpm_state->locty_number) < 0) {
> +            tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
> +                                           locty->r_buffer.size);
> +        } else {
> +            tpm_emulator_unix_tx_bufs(tpm_pt, locty->w_buffer.buffer,
> +                                  locty->w_offset, locty->r_buffer.buffer,
> +                                  locty->r_buffer.size, &selftest_done);
> +        }
> +        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
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
> +        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
> +                     strerror(errno));
> +    } else if (res != 0) {
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
> +        error_report("tpm-emulator: probing failed : %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    tpm_pt->caps = be64_to_cpu(tpm_pt->caps);
> +
> +    DPRINTF("capbilities : 0x%lx", tpm_pt->caps);
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_check_caps(TPMEmulator *tpm_pt)
> +{
> +    ptm_cap caps = 0;
> +    const char *tpm = NULL;
> +
> +    /* check for min. required capabilities */
> +    switch (tpm_pt->tpm_version) {
> +    case TPM_VERSION_1_2:
> +        caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
> +               PTM_CAP_SET_LOCALITY;
> +        tpm = "1.2";
> +        break;
> +    case TPM_VERSION_2_0:
> +        caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
> +               PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED;
> +        tpm = "2";
> +        break;
> +    case TPM_VERSION_UNSPEC:
> +        error_report("tpm-emulator: TPM version has not been set");
> +        return -1;
> +    }
> +
> +    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, caps)) {
> +        error_report("tpm-emulator: TPM does not implement minimum set of "
> +                     "required capabilities for TPM %s (0x%x)", tpm, (int)caps);
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
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_INIT, &init, sizeof(init),
> +                         sizeof(init)) < 0) {
> +        error_report("tpm-emulator: could not send INIT: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    res = be32_to_cpu(init.u.resp.tpm_result);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
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
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +    ptm_est est;
> +
> +    DPRINTF("%s", __func__);
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_GET_TPMESTABLISHED, &est, 0,
> +                         sizeof(est)) < 0) {
> +        error_report("tpm-emulator: Could not get the TPM established flag: %s",
> +                     strerror(errno));
> +        return false;
> +    }
> +    DPRINTF("established flag: %0x", est.u.resp.bit);
> +
> +    return (est.u.resp.bit != 0);
> +}
> +
> +static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
> +                                                   uint8_t locty)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +    ptm_reset_est reset_est;
> +    ptm_res res;
> +
> +    /* only a TPM 2.0 will support this */
> +    if (tpm_pt->tpm_version == TPM_VERSION_2_0) {
> +        reset_est.u.req.loc = tpm_pt->cur_locty_number;
> +
> +        if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_RESET_TPMESTABLISHED,
> +                                 &reset_est, sizeof(reset_est),
> +                                 sizeof(reset_est)) < 0) {
> +            error_report("tpm-emulator: Could not reset the establishment bit: "
> +                          "%s", strerror(errno));
> +            return -1;
> +        }
> +
> +        res = be32_to_cpu(reset_est.u.resp.tpm_result);
> +        if (res) {
> +            error_report("tpm-emulator: TPM result for rest establixhed flag: "
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
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +
> +    return !tpm_pt->child_running;
> +}
> +
> +static void tpm_emulator_cancel_cmd(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +    ptm_res res;
> +
> +    /*
> +     * As of Linux 3.7 the tpm_tis driver does not properly cancel
> +     * commands on all TPM manufacturers' TPMs.
> +     * Only cancel if we're busy so we don't cancel someone else's
> +     * command, e.g., a command executed on the host.
> +     */
> +    if (tpm_pt->op_executing) {
> +        if (TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, PTM_CAP_CANCEL_TPM_CMD)) {
> +            if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, CMD_CANCEL_TPM_CMD, &res,
> +                                 0, sizeof(res)) < 0) {
> +                error_report("tpm-emulator: Could not cancel command: %s",
> +                             strerror(errno));
> +            } else if (res != 0) {
> +                error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
> +                             be32_to_cpu(res));
> +            } else {
> +                tpm_pt->op_canceled = true;
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
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +
> +    return tpm_pt->tpm_version;
> +}
> +
> +static gboolean tpm_emulator_fd_handler(QIOChannel *ioc, GIOCondition cnd,
> +                                        void *opaque)
> +{
> +    TPMEmulator *tpm_pt = opaque;
> +
> +    if (cnd & G_IO_ERR || cnd & G_IO_HUP) {
> +        error_report("TPM backend disappeared");
> +        tpm_pt->child_running = false;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static QIOChannel *_iochannel_new(const char *path, int fd, Error **err)
> +{
> +    int socket = path ?  unix_connect(path, err) : fd;
> +    if (socket < 0) {
> +        return NULL;
> +    }
> +
> +    return QIO_CHANNEL(qio_channel_socket_new_fd(socket, err));
> +}
> +
> +static int tpm_emulator_spawn_emulator(TPMEmulator *tpm_pt)
> +{
> +    int fds[2] = { -1, -1 };
> +    int ctrl_fds[2] = { -1, -1 };
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
> +    cpid = qemu_fork(NULL);
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
> +    if (cpid == 0) { /* CHILD */
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
> +        int data_fd = -1, ctrl_fd = -1;
> +        char *argv[PARAM_MAX + 1];
> +
> +        /* close all unused inherited sockets */
> +        if (fds[0] >= 0) {
> +            closesocket(fds[0]);
> +        }
> +        if (ctrl_fds[0] >= 0) {
> +            closesocket(ctrl_fds[0]);
> +        }
> +
> +        i = STDERR_FILENO + 1;
> +        if (fds[1] >= 0) {
> +            data_fd = dup2(fds[1], i++);
> +            if (data_fd < 0) {
> +                error_report("tpm-emulator: dup2() failure - %s",
> +                             strerror(errno));
> +                goto exit_child;
> +            }
> +        }
> +        if (ctrl_fds[1] >= 0) {
> +            ctrl_fd = dup2(ctrl_fds[1], i++);
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
> +        argv[PARAM_MAX] = NULL;
> +        argv[PARAM_PATH] = g_strdup(tpm_pt->ops->path);
> +        argv[PARAM_IFACE] = g_strdup("socket");
> +        if (tpm_pt->ops->has_data_path) {
> +            argv[PARAM_SERVER] = g_strdup("--server");
> +            argv[PARAM_SERVER_ARGS] = g_strdup_printf("type=unixio,path=%s",
> +                                               tpm_pt->ops->data_path);
> +        } else {
> +            argv[PARAM_SERVER] = g_strdup("--fd");
> +            argv[PARAM_SERVER_ARGS] = g_strdup_printf("%d", data_fd);
> +        }
> +
> +        argv[PARAM_CTRL] = g_strdup("--ctrl");
> +        if (tpm_pt->ops->has_ctrl_path) {
> +            argv[PARAM_CTRL_ARGS] = g_strdup_printf("type=unixio,path=%s",
> +                                                    tpm_pt->ops->ctrl_path);
> +        } else {
> +            argv[PARAM_CTRL_ARGS] = g_strdup_printf("type=unixio,clientfd=%d",
> +                                                    ctrl_fd);
> +        }
> +
> +        argv[PARAM_STATE] = g_strdup("--tpmstate");
> +        argv[PARAM_STATE_ARGS] = g_strdup_printf("dir=%s",
> +                                        tpm_pt->ops->tpmstatedir);
> +        argv[PARAM_PIDFILE] = g_strdup("--pid");
> +        argv[PARAM_PIDFILE_ARGS] = g_strdup_printf("file=%s",
> +                                            TPM_EMULATOR_PIDFILE);
> +        if (tpm_pt->ops->has_logfile) {
> +            argv[PARAM_LOG] = g_strdup("--log");
> +            argv[PARAM_LOG_ARGS] = g_strdup_printf("file=%s,level=%d",
> +                    tpm_pt->ops->logfile, (int)tpm_pt->ops->loglevel);
> +        } else {
> +            /* truncate logs */
> +            argv[PARAM_LOG] = NULL;
> +        }
> +        DPRINTF("%s", "Running cmd: ")
> +        for (i = 0; argv[i]; i++) {
> +            DPRINT(" %s", argv[i])
> +        }
> +        DPRINT("\n")
> +        if (execv(tpm_pt->ops->path, (char * const *)argv) < 0) {
> +            error_report("execv() failure : %s", strerror(errno));
> +        }
> +
> +exit_child:
> +        g_strfreev(argv);
> +        if (data_fd >= 0) {
> +            closesocket(data_fd);
> +        }
> +        if (ctrl_fd >= 0) {
> +            closesocket(ctrl_fd);
> +        }
> +
> +        _exit(1);
> +    } else { /* self */
> +        struct stat st;
> +        DPRINTF("child pid: %d", cpid);
> +        int rc;
> +        useconds_t usec = 100 * 1000L; /* wait for 100 milliseconds */
> +        useconds_t timeout = 10; /* max 1 second */
> +
> +        /* close unused sockets */
> +        if (fds[1] >= 0) {
> +            closesocket(fds[1]);
> +        }
> +        if (ctrl_fds[1] >= 0) {
> +            closesocket(ctrl_fds[1]);
> +        }
> +
> +        tpm_pt->data_ioc = _iochannel_new(tpm_pt->ops->data_path, fds[0], NULL);
> +        if (!tpm_pt->data_ioc) {
> +            error_report("tpm-emulator: Unable to connect socket : %s",
> +                          tpm_pt->ops->data_path);
> +            goto err_kill_child;
> +        }
> +
> +        tpm_pt->ctrl_ioc = _iochannel_new(tpm_pt->ops->ctrl_path, ctrl_fds[0],
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
> +        while ((rc = stat(TPM_EMULATOR_PIDFILE, &st)) < 0 && timeout--) {
> +            usleep(usec);
> +        }
> +
> +        if (timeout == -1) {
> +            error_report("tpm-emulator: pid file not ready: %s",
> +                         strerror(errno));
> +            goto err_kill_child;
> +        }
> +
> +        /* check if child really running */
> +        if (kill(cpid, 0) < 0 && errno == ESRCH) {
> +            goto err_no_child;
> +        }
> +
> +        tpm_pt->child_running = true;
> +    }
> +
> +    return 0;
> +
> +err_kill_child:
> +    kill(cpid, SIGTERM);
> +    /* wait for 10 mill-seconds */
> +    usleep(10 * 1000);
> +    /* force kill if still reachable */
> +    if (kill(cpid, 0) == 0) {
> +        kill(cpid, SIGKILL);
> +    }

You may want to loop on this as well checking whether it is still 
reachable. It will  terminate faster once it's gone.

timeout = 10;
while (kill(cpid, 0) == 0 && timeout--) {
     usleep(1000):
}
if (timeout == -1) {
     kill(cpid, SIGKILL);
}

> +
> +err_no_child:
> +    tpm_pt->child_running = false;
> +
> +    return -1;
> +}
> +
> +static void tpm_emulator_block_migration(TPMEmulator *tpm_pt)
> +{
> +   Error *err = NULL;
> +
> +   error_setg(&tpm_pt->migration_blocker,
> +              "Migration disabled: TPM emulator not yet migratable");

indentation

> +    migrate_add_blocker(tpm_pt->migration_blocker, &err);
> +    if (err) {
> +        error_free(err);
> +        error_free(tpm_pt->migration_blocker);
> +        tpm_pt->migration_blocker = NULL;
> +    }
> +}
> +
> +static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_pt, QemuOpts *opts)
> +{
> +    const char *value;
> +
> +    value = qemu_opt_get(opts, "tpmstatedir");
> +    if (!value) {
> +        error_report("tpm-emulator: Missing tpm state directory");
> +        return -1;
> +    }
> +    tpm_pt->ops->tpmstatedir = g_strdup(value);
> +
> +    tpm_pt->ops->spawn = qemu_opt_get_bool(opts, "spawn", false);
> +
> +    value = qemu_opt_get(opts, "path");
> +    if (!value) {
> +        value = TPM_DEFAULT_EMULATOR;
> +        tpm_pt->ops->has_path = false;
> +    } else {
> +        tpm_pt->ops->has_path = true;
> +        if (value[0] == '/') {
> +            struct stat st;
> +            if (stat(value, &st) < 0 || !(S_ISREG(st.st_mode)
> +                || S_ISLNK(st.st_mode))) {
> +                error_report("tpm-emulator: Invalid emulator path: %s", value);
> +                return -1;
> +            }
> +        }
> +    }
> +    tpm_pt->ops->path = g_strdup(value);
> +
> +    value = qemu_opt_get(opts, "data-path");
> +    if (value) {
> +        tpm_pt->ops->has_data_path = true;
> +        tpm_pt->ops->data_path = g_strdup(value);
> +    } else {
> +        tpm_pt->ops->has_data_path = false;
> +        if (!tpm_pt->ops->spawn) {
> +            error_report("tpm-emulator: missing mandatory data-path");
> +            return -1;
> +        }
> +    }
> +
> +    value = qemu_opt_get(opts, "ctrl-path");
> +    if (value) {
> +        tpm_pt->ops->has_ctrl_path = true;
> +        tpm_pt->ops->ctrl_path = g_strdup(value);
> +    } else {
> +        tpm_pt->ops->has_ctrl_path = false;
> +        if (!tpm_pt->ops->spawn) {
> +            error_report("tpm-emulator: missing mandatory ctrl-path");
> +            return -1;
> +        }
> +    }
> +
> +    value = qemu_opt_get(opts, "logfile");
> +    if (value) {
> +        tpm_pt->ops->has_logfile = true;
> +        tpm_pt->ops->logfile = g_strdup(value);
> +        tpm_pt->ops->loglevel = qemu_opt_get_number(opts, "loglevel",
> +                                                   TPM_DEFAULT_LOGLEVEL);
> +        tpm_pt->ops->has_loglevel = tpm_pt->ops->loglevel !=
> +                                     TPM_DEFAULT_LOGLEVEL;
> +    }
> +
> +    if (tpm_pt->ops->spawn) {
> +        if (tpm_emulator_spawn_emulator(tpm_pt) < 0) {
> +            goto err_close_dev;
> +        }
> +    } else {
> +        tpm_pt->data_ioc = _iochannel_new(tpm_pt->ops->data_path, -1, NULL);
> +        if (tpm_pt->data_ioc  == NULL) {
> +            error_report("tpm-emulator: Failed to connect data socket: %s",
> +                         tpm_pt->ops->data_path);
> +            goto err_close_dev;
> +        }
> +        tpm_pt->ctrl_ioc = _iochannel_new(tpm_pt->ops->ctrl_path, -1, NULL);
> +        if (tpm_pt->ctrl_ioc == NULL) {
> +            DPRINTF("Failed to connect control socket: %s",
> +                    strerror(errno));
> +            goto err_close_dev;
> +        }
> +        tpm_pt->child_running = true;
> +    }
> +
> +    /* FIXME: tpm_util_test_tpmdev() accepts only on socket fd, as it also used

on -> one

> +     * by passthrough driver, which not yet using GIOChannel.

-> which is not yet

> +     */
> +    if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_pt->data_ioc)->fd,
> +                             &tpm_pt->tpm_version)) {
> +        error_report("'%s' is not emulating TPM device.", tpm_pt->ops->path);
> +        goto err_close_dev;
> +    }
> +
> +    DPRINTF("TPM Version %s", tpm_pt->tpm_version == TPM_VERSION_1_2 ? "1.2" :
> +             (tpm_pt->tpm_version == TPM_VERSION_2_0 ?  "2.0" : "Unspecified"));
> +
> +    if (tpm_emulator_probe_caps(tpm_pt) ||
> +        tpm_emulator_check_caps(tpm_pt)) {
> +        goto err_close_dev;
> +    }
> +
> +    tpm_emulator_block_migration(tpm_pt);
> +
> +    return 0;
> +
> +err_close_dev:

'close_dev' seems a bit misleading here...

> +    DPRINT("Startup error\n");
> +    return -1;
> +}
> +
> +static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id)
> +{
> +    TPMBackend *tb = TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
> +
> +    tb->id = g_strdup(id);
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
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(tb);
> +    TpmTypeOptions *ops = NULL;
> +    TPMEmulatorOptions *eops = NULL;
> +
> +    eops = g_new0(TPMEmulatorOptions, 1);
> +    if (!eops) {
> +        return NULL;
> +    }
> +    DPRINTF("%s", __func__);
> +
> +    eops->tpmstatedir = g_strdup(tpm_pt->ops->tpmstatedir);
> +    eops->spawn = tpm_pt->ops->spawn;
> +    if (tpm_pt->ops->has_path) {
> +        eops->has_path = true;
> +        eops->path = g_strdup(tpm_pt->ops->path);
> +    }
> +    if (tpm_pt->ops->has_data_path) {
> +        eops->has_data_path = true;
> +        eops->data_path = g_strdup(tpm_pt->ops->data_path);
> +    }
> +    if (tpm_pt->ops->has_ctrl_path) {
> +        eops->has_ctrl_path = true;
> +        eops->ctrl_path = g_strdup(tpm_pt->ops->ctrl_path);
> +    }
> +    if (tpm_pt->ops->has_logfile) {
> +        eops->has_logfile = true;
> +        eops->logfile = g_strdup(tpm_pt->ops->logfile);
> +    }
> +    if (tpm_pt->ops->has_loglevel) {
> +        eops->has_loglevel = true;
> +        eops->loglevel = tpm_pt->ops->loglevel;
> +    }
> +
> +    ops = g_new0(TpmTypeOptions, 1);
> +    if (!ops) {
> +        qapi_free_TPMEmulatorOptions(eops);
> +        return NULL;
> +    }
> +
> +    ops->type = TPM_TYPE_EMULATOR;
> +    ops->u.emulator.data = eops;
> +
> +    return ops;
> +}
> +
> +static const QemuOptDesc tpm_emulator_cmdline_opts[] = {
> +    TPM_STANDARD_CMDLINE_OPTS,
> +    {
> +        .name = "tpmstatedir",
> +        .type = QEMU_OPT_STRING,
> +        .help = "TPM state directroy",

directroy -> directory

> +    },
> +    {
> +        .name = "spawn",
> +        .type = QEMU_OPT_BOOL,
> +        .help = "Wether to spwan given emlatory binary",

emlatory -> emulator

> +    },
> +    {
> +        .name = "path",
> +        .type = QEMU_OPT_STRING,
> +        .help = "Path to TPM emulator binary",
> +    },
> +    {
> +        .name = "data-path",
> +        .type = QEMU_OPT_STRING,
> +        .help = "Socket path to use for data exhange",

exhange -> exchange

> +    },
> +    {
> +        .name = "ctrl-path",
> +        .type = QEMU_OPT_STRING,
> +        .help = "Socket path to use for out-of-band control messages",
> +    },
> +    {
> +        .name = "logfile",
> +        .type = QEMU_OPT_STRING,
> +        .help = "Path to log file",
> +    },
> +    {
> +        .name = "loglevel",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "Log level number",
> +    },
> +    { /* end of list */ },
> +};
> +
> +static const TPMDriverOps tpm_emulator_driver = {
> +    .type                     = TPM_TYPE_EMULATOR,
> +    .opts                     = tpm_emulator_cmdline_opts,
> +    .desc                     = "TPM emulator backend driver",
> +
> +    .create                   = tpm_emulator_create,
> +    .startup_tpm              = tpm_emulator_startup_tpm,
> +    .reset                    = tpm_emulator_reset,
> +    .had_startup_error        = tpm_emulator_had_startup_error,
> +    .cancel_cmd               = tpm_emulator_cancel_cmd,
> +    .get_tpm_established_flag = tpm_emulator_get_tpm_established_flag,
> +    .reset_tpm_established_flag = tpm_emulator_reset_tpm_established_flag,
> +    .get_tpm_version          = tpm_emulator_get_tpm_version,
> +    .get_tpm_options          = tpm_emulator_get_tpm_options,
> +};
> +
> +static void tpm_emulator_inst_init(Object *obj)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(obj);
> +
> +    DPRINTF("%s", __func__);
> +    tpm_pt->ops = g_new0(TPMEmulatorOptions, 1);
> +    tpm_pt->data_ioc = tpm_pt->ctrl_ioc = NULL;
> +    tpm_pt->op_executing = tpm_pt->op_canceled = false;
> +    tpm_pt->child_running = false;
> +    tpm_pt->cur_locty_number = ~0;
> +    qemu_mutex_init(&tpm_pt->state_lock);
> +}
> +
> +static void tpm_emulator_inst_finalize(Object *obj)
> +{
> +    TPMEmulator *tpm_pt = TPM_EMULATOR(obj);
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
> +
> +    if (tpm_pt->migration_blocker) {
> +        migrate_del_blocker(tpm_pt->migration_blocker);
> +        error_free(tpm_pt->migration_blocker);
> +    }
> +}
> +
> +static void tpm_emulator_class_init(ObjectClass *klass, void *data)
> +{
> +    TPMBackendClass *tbc = TPM_BACKEND_CLASS(klass);
> +    tbc->ops = &tpm_emulator_driver;
> +    tbc->handle_request = tpm_emulator_handle_request;
> +}
> +
> +static const TypeInfo tpm_emulator_info = {
> +    .name = TYPE_TPM_EMULATOR,
> +    .parent = TYPE_TPM_BACKEND,
> +    .instance_size = sizeof(TPMEmulator),
> +    .class_init = tpm_emulator_class_init,
> +    .instance_init = tpm_emulator_inst_init,
> +    .instance_finalize = tpm_emulator_inst_finalize,
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
> + * Every response from a command involving a TPM command execution must hold
> + * the ptm_res as the first element.
> + * ptm_res corresponds to the error code of a command executed by the TPM.
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
> + * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multiple reads
> + * with this ioctl and with adjusted offset are necessary. All bytes
> + * must be transferred and the transfer is done once the last byte has been
> + * returned.
> + * It is possible to use the read() interface for reading the data; however, the
> + * first bytes of the state blob will be part of the response to the ioctl(); a
> + * subsequent read() is only necessary if the total length (totlength) exceeds
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
> +            uint32_t totlength;   /* total length that will be transferred */
> +            uint32_t length;      /* number of bytes in following buffer */
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
> +#define PTM_STATE_FLAG_DECRYPTED     1 /* on input:  get decrypted state */
> +#define PTM_STATE_FLAG_ENCRYPTED     2 /* on output: state is encrypted */
> +
> +/*
> + * The following is the data structure to set state blobs in the TPM.
> + * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multiple
> + * 'writes' using this ioctl are necessary. The last packet is indicated
> + * by the length being smaller than the PTM_STATE_BLOB_SIZE.
> + * The very first packet may have a length indicator of '0' enabling
> + * a write() with all the bytes from a buffer. If the write() interface
> + * is used, a final ioctl with a non-full buffer must be made to indicate
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
> + * PTM_GET_CONFIG: Data structure to get runtime configuration information
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
> +    PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
> +    PTM_INIT               = _IOWR('P', 1, ptm_init),
> +    PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),
> +    PTM_GET_TPMESTABLISHED = _IOR('P', 3, ptm_est),
> +    PTM_SET_LOCALITY       = _IOWR('P', 4, ptm_loc),
> +    PTM_HASH_START         = _IOR('P', 5, ptm_res),
> +    PTM_HASH_DATA          = _IOWR('P', 6, ptm_hdata),
> +    PTM_HASH_END           = _IOR('P', 7, ptm_res),
> +    PTM_CANCEL_TPM_CMD     = _IOR('P', 8, ptm_res),
> +    PTM_STORE_VOLATILE     = _IOR('P', 9, ptm_res),
> +    PTM_RESET_TPMESTABLISHED = _IOWR('P', 10, ptm_reset_est),
> +    PTM_GET_STATEBLOB      = _IOWR('P', 11, ptm_getstate),
> +    PTM_SET_STATEBLOB      = _IOWR('P', 12, ptm_setstate),
> +    PTM_STOP               = _IOR('P', 13, ptm_res),
> +    PTM_GET_CONFIG         = _IOR('P', 14, ptm_getconfig),
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
> +    CMD_GET_CAPABILITY = 1,
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
> index 5728b7f..cfe0c94 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5123,10 +5123,12 @@
>   # An enumeration of TPM types
>   #
>   # @passthrough: TPM passthrough type
> +# @emulator: Software Emulator TPM type
> +#            Since: 2.10
>   #
>   # Since: 1.5
>   ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
>
>   ##
>   # @query-tpm-types:
> @@ -5140,7 +5142,7 @@
>   # Example:
>   #
>   # -> { "execute": "query-tpm-types" }
> -# <- { "return": [ "passthrough" ] }
> +# <- { "return": [ "passthrough", "emulator" ] }
>   #
>   ##
>   { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
> @@ -5161,16 +5163,49 @@
>                                                '*cancel-path' : 'str'} }
>
>   ##
> +# @TPMEmulatorOptions:
> +#
> +# Information about the TPM emulator
> +#
> +# @tpmstatedir: TPM emulator state directory
> +# @spawn: true if, qemu has to spawn a new emulator process with given @path,

qemu -> QEMU

> +#         otherwise it connects to already rinning emulator with given @data-path

rinning -> running

> +#         and @ctrl-path sockets. (default: 'false')
> +# @path: TPM emulator binary path to spawn.(default: 'swtpm')
> +# @data-path: path of the unix socket to use for exchanging data messages, if

replace ',' with ';'

> +#             not provided socket pairs are used when @sapwn is true.

@sapwn -> @spawn

> +# @ctrl-path: path of the unix socket file to use for exchagning out-of-band

exchanging

> +#             control messages, if not provided socket pairs are used when

replace ',' with ';'

> +#             @spawn is true.
> +# @logfile: file to use to place TPM emulator logs, if not provided logging is

file to use for TPM emulator logs;

> +#           disabled.
> +# @loglevel: optional log level number, loglevel is ignored if no logfile

logfile is provided

> +#            provided. (default: 5)
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'TPMEmulatorOptions',
> +  'data': { 'tpmstatedir' : 'str',
> +            'spawn': 'bool',
> +            '*path': 'str',
> +            '*data-path': 'str',
> +            '*ctrl-path': 'str',
> +            '*logfile': 'str',
> +            '*loglevel': 'uint8' } }
> +
> +##
>   # @TpmTypeOptions:
>   #
>   # A union referencing different TPM backend types' configuration options
>   #
>   # @type: 'passthrough' The configuration options for the TPM passthrough type
> +#        'emulator' The configuration options for TPM emulator backend type
>   #
>   # Since: 1.5
>   ##
>   { 'union': 'TpmTypeOptions',
> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
> +  'data': { 'passthrough': 'TPMPassthroughOptions',
> +            'emulator': 'TPMEmulatorOptions' } }
>
>   ##
>   # @TPMInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f806af9..e4dbc33 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2883,7 +2883,15 @@ DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
>       "-tpmdev passthrough,id=id[,path=path][,cancel-path=path]\n"
>       "                use path to provide path to a character device; default is /dev/tpm0\n"
>       "                use cancel-path to provide path to TPM's cancel sysfs entry; if\n"
> -    "                not provided it will be searched for in /sys/class/misc/tpm?/device\n",
> +    "                not provided it will be searched for in /sys/class/misc/tpm?/device\n"
> +    "-tpmdev emulator,id=id,spawn=on|off,tpmstatedir=dir[,path=emulator-path,data-path=path,ctrl-path=path,logfile=path,loglevel=level]\n"
> +    "                spawn=on|off controls spawning support\n"
> +    "                use tpmstatedir to provide path to the tpm state dirctory\n"

-> TPM state directory

> +    "                use path to provide the emulator binary to launch; default is 'swtpm'\n"
> +    "                use data-path to provide the socket path for exchanging data messages\n"
> +    "                use ctrl-path to provide the socket path for sending control messages to software emulator\n"
> +    "                use logfile to provide where to place the swtpm logs\n"

use logfile to provide a file for the swtpm logs

> +    "                use loglevel to controls the swtpm log level\n",

to control

>       QEMU_ARCH_ALL)
>   STEXI
>
> @@ -2892,8 +2900,8 @@ The general form of a TPM device option is:
>
>   @item -tpmdev @var{backend} ,id=@var{id} [,@var{options}]
>   @findex -tpmdev
> -Backend type must be:
> -@option{passthrough}.
> +Backend type must be either one of the following:
> +@option{passthrough}, @option{emulator}.
>
>   The specific backend type will determine the applicable options.
>   The @code{-tpmdev} option creates the TPM backend and requires a
> @@ -2943,6 +2951,45 @@ To create a passthrough TPM use the following two options:
>   Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
>   @code{tpmdev=tpm0} in the device option.
>
> +@item -tpmdev emulator, id=@var{id}, tpmstatedir=@var{path}, spawn=@var{on|off}, path=@var{emulator-binary-path}, data-path=@var{path}, ctrl-path=@var{path}, logfile=@var{path}, loglevel=@var{level}
> +
> +(Linux-host only) Enable access to a TPM emulator using unix domain sockets.
> +

unix -> Unix

> +@option{tpmstatedir} specifies the tpm state directory
> +

tpm -> TPM

> +@option{spawn} specifies if qemu should spawn new emulator process with given @option{path}
> +

qemu -> QEMU

spawn a new

> +@option{path} specifies the emulator binary path to use for spawning

-> specifies the path to the emulator binary

> +
> +@option{data-path} optional socket path to use for exchanging TPM data with emulator
> +

socket path to use for exchanging TPM commands with emulator; required 
when @option{spawn} is false

> +@option{ctrl-path} optional socket path to use for sending control data to emulator

socket path to use for sending control message to emulator; required 
when @option{spawn} is false

> +
> +@option{logfile} optional log file to use to place log messages
> +

optional log file to use

> +@option{loglevel} specifies the log level to use
> +
> +To create TPM emulator backend device that spawns new swtpm binary and communicate with socket pairs:

To create a TPM emulator backend device that spawns a new swtpm binary 
and communicates using socket pairs:

> +@example
> +
> +-tpmdev emulator,id=tpm0,tpmstatedir=/tmp/my-tpm,spawn=on,path=/usr/local/bin/swtpm,logfile=/tmp/qemu-tpm.log,loglevel=5 -device tpm-tis,tpmdev=tpm0
> +
> +@end example
> +
> +To create TPM emulator backend device that spawns new swtpm binary and communicate using unix file system sockets:

To create a TPM emulator backend device that spawns a new swtpm binary 
and communicates using Unix domain sockets:

> +@example
> +
> +-tpmdev emulator,id=tpm0,tpmstatedir=/tmp/my-tpm,spawn=on,path=/usr/local/bin/swtpm,data-path=/tmp/swtpm-data.socket,ctrl-path=/tmp/swtpm-ctrl.socket,logfile=/tmp/qemu-tpm.log,loglevel=5 -device tpm-tis,tpmdev=tpm0
> +
> +@end example
> +
> +To create a TOM emulator backend device that connects to already running swtpm binary using file system sockets:

To create a TPM emulator backend device that connects to an already 
running swtpm using Unix domain sockets:

> +@example
> +
> +-tpmdev emulator,id=tpm0,tpmstatedir=/tmp/my-tpm,spawn=off,data-path=/tmp/swtpm-data.socket,ctrl-path=/tmp/swtpm-ctrl.socket,logfile=/tmp/qemu-tpm.log,loglevel=5 -device tpm-tis,tpmdev=tpm0
> +
> +@end example
> +
>   @end table
>
>   ETEXI
> diff --git a/tpm.c b/tpm.c
> index 84e9667..6d2513c 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -25,7 +25,7 @@ static QLIST_HEAD(, TPMBackend) tpm_backends =
>
>
>   #define TPM_MAX_MODELS      1
> -#define TPM_MAX_DRIVERS     1
> +#define TPM_MAX_DRIVERS     2
>
>   static TPMDriverOps const *be_drivers[TPM_MAX_DRIVERS] = {
>       NULL,
