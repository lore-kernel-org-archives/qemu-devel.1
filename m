Received: from eggs.gnu.org ([2001:4830:134:3::10]:42438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d36FY-0001ct-E2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d36FU-0001Nr-AX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:35:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40647
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d36FU-0001NP-3i
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:35:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PJXp8f051738
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 15:35:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a26s5ah3w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 15:35:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 13:35:41 -0600
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 15:35:36 -0400
MIME-Version: 1.0
In-Reply-To: <1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <192af627-0ead-913f-01a5-55966e2f6454@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com

On 04/07/2017 10:30 AM, Amarnath Valluri wrote:
> This change introduces a new TPM backend driver that can communicate with
> swtpm(software TPM emulator) using unix domain socket interface.
>
> Swtpm uses two unix sockets, one for plain TPM commands and responses, and one
> for out-of-band control messages.

I intend to add an option '--locality prepended' to 'swtpm', which I am 
using to read the locality a command is supposed to be executing in. I 
have a  pending driver extension for the Linux vtpm proxy driver that 
prepends this byte. Either the same byte or a more elaborate 
swtpm-specific header {CMD_WRAPPED_CMD, locality, sizeof tpm-command, 
tpm-command} could be used in every command sent from QEMU to pass along 
the locality and could be activated via command line using 'swtpm ... 
--locality wrapped-command'. That may not change much in regards to 
setting the locality via the control channel, though.

Regarding this driver: There's the comment about the control channel and 
data channel and them being separated. I still don't see why we need to 
merge them or why they couldn't be passed via two fd's.


>
> The swtpm and associated tools can be found here:
>      https://github.com/stefanberger/swtpm
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
>   hw/tpm/tpm_emulator.c | 927 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/tpm_ioctl.h    | 243 +++++++++++++
>   qapi-schema.json      |  36 +-
>   qemu-options.hx       |  53 ++-
>   tpm.c                 |   2 +-
>   8 files changed, 1289 insertions(+), 9 deletions(-)
>   create mode 100644 hw/tpm/tpm_emulator.c
>   create mode 100644 hw/tpm/tpm_ioctl.h
>
> diff --git a/configure b/configure
> index 4901b9a..bef41f3 100755
> --- a/configure
> +++ b/configure
> @@ -3347,10 +3347,15 @@ fi
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
> @@ -5125,6 +5130,7 @@ echo "gcov enabled      $gcov"
>   echo "TPM support       $tpm"
>   echo "libssh2 support   $libssh2"
>   echo "TPM passthrough   $tpm_passthrough"
> +echo "TPM emulator      $tpm_emulator"
>   echo "QOM debugging     $qom_cast_debug"
>   echo "lzo support       $lzo"
>   echo "snappy support    $snappy"
> @@ -5704,6 +5710,9 @@ if test "$tpm" = "yes"; then
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
> index 9caf7c8..e7fd426 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -937,6 +937,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>       Error *err = NULL;
>       unsigned int c = 0;
>       TPMPassthroughOptions *tpo;
> +    TPMEmulatorOptions *teo;
>
>       info_list = qmp_query_tpm(&err);
>       if (err) {
> @@ -966,6 +967,26 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                              tpo->has_cancel_path ? ",cancel-path=" : "",
>                              tpo->has_cancel_path ? tpo->cancel_path : "");
>               break;
> +        case TPM_TYPE_EMULATOR:
> +            teo = (TPMEmulatorOptions *)(ti->options);
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
> +                monitor_printf(mon, ",loglevel=%ld", teo->loglevel);
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
> index 0000000..d001ed9
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,927 @@
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
> +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) == (cap))
> +#define TPM_EMULATOR_IOCTL_TO_CMD(ioctlnum) \
> +    ((ioctlnum >> _IOC_NRSHIFT) & _IOC_NRMASK) + 1

You shouldn't need this part here. You could be using the CMD_-prefixed 
commands instead of the ioctl codes.

> +
> +static int tpm_emulator_ctrlcmd(QIOChannel *ioc, unsigned long cmd, void *msg,
> +                                size_t msg_len_in, size_t msg_len_out)
> +{
> +    ssize_t n;
> +
> +    uint32_t cmd_no = cpu_to_be32(TPM_EMULATOR_IOCTL_TO_CMD(cmd));
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
> +    ret = qio_channel_read(tpm_pt->data_ioc, (char *)out, (size_t)out_len, NULL);
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
> +        loc.u.req.loc = cpu_to_be32(locty_number);

locality is just a byte!


> +        if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, PTM_SET_LOCALITY, &loc,
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
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, PTM_SHUTDOWN, &res, 0,
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
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, PTM_GET_CAPABILITY,
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
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, PTM_INIT, &init, sizeof(init),
> +                         sizeof(init)) < 0) {
> +        error_report("tpm-emulator: could not send INIT: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    res = be32_to_cpu(init.u.resp.tpm_result);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for PTM_INIT: 0x%x", res);
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
> +    if (tpm_emulator_ctrlcmd(tpm_pt->ctrl_ioc, PTM_GET_TPMESTABLISHED, &est, 0,
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
> +        reset_est.u.req.loc = cpu_to_be32(tpm_pt->cur_locty_number);

locality is just a byte.

This is as far as I got today.

    Stefan
