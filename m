Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dwHNa-0007fC-Gk
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 20:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dwHNX-0005KU-9w
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 20:36:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dwHNW-0005KA-Sz
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 20:36:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P0Y9LV139946
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 20:36:01 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6dn924yb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 20:36:01 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 24 Sep 2017 20:35:59 -0400
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
	<1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun, 24 Sep 2017 20:35:55 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <30e3f38b-2a3f-fb6c-91c7-fc740766d755@linux.vnet.ibm.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 09/24/2017 02:52 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> Thanks for the nice update, removing the exec() code, using chardev
> and a private socketpair. Some comments below:
>
> On Fri, Sep 22, 2017 at 2:33 PM, Amarnath Valluri
> <amarnath.valluri@intel.com> wrote:
>> This change introduces a new TPM backend driver that can communicate w=
ith
>> swtpm(software TPM emulator) using unix domain socket interface. QEMU =
talks to
>> TPM emulator using socket based chardev backend device.
>>
>> Swtpm uses two Unix sockets for communications, one for plain TPM comm=
ands and
>> responses, and one for out-of-band control messages. QEMU passes data =
socket
>> been used over the control channel.
>>
>> The swtpm and associated tools can be found here:
>>      https://github.com/stefanberger/swtpm
>>
>> The swtpm's control channel protocol specification can be found here:
>>      https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specif=
ication
>>
>> Usage:
>>      # setup TPM state directory
>>      mkdir /tmp/mytpm
>>      chown -R tss:root /tmp/mytpm
>>      /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>>
>>      # Ask qemu to use TPM emulator with given tpm state directory
>>      qemu-system-x86_64 \
>>          [...] \
>>          -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
>>          -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>>          -device tpm-tis,tpmdev=3Dtpm0 \
>>          [...]
>>
>> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>> ---
>>   configure             |  15 +-
>>   hmp.c                 |   5 +
>>   hw/tpm/Makefile.objs  |   1 +
>>   hw/tpm/tpm_emulator.c | 649 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   hw/tpm/tpm_ioctl.h    | 246 +++++++++++++++++++
>>   qapi/tpm.json         |  21 +-
>>   qemu-options.hx       |  22 +-
>>   7 files changed, 950 insertions(+), 9 deletions(-)
>>   create mode 100644 hw/tpm/tpm_emulator.c
>>   create mode 100644 hw/tpm/tpm_ioctl.h
>>
>> diff --git a/configure b/configure
>> index cb0f7ed..ce2df2d 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3461,10 +3461,15 @@ fi
>>   ##########################################
>>   # TPM passthrough is only on x86 Linux
>>
>> -if test "$targetos" =3D Linux && test "$cpu" =3D i386 -o "$cpu" =3D x=
86_64; then
>> -  tpm_passthrough=3D$tpm
>> +if test "$targetos" =3D Linux; then
>> +  tpm_emulator=3D$tpm
>> +  if test "$cpu" =3D i386 -o "$cpu" =3D x86_64; then
>> +    tpm_passthrough=3D$tpm
>> +  else
>> +    tpm_passthrough=3Dno
>> +  fi
>>   else
>> -  tpm_passthrough=3Dno
>> +  tpm_emulator=3Dno
>>   fi
>>
>>   ##########################################
>> @@ -5359,6 +5364,7 @@ echo "gcov enabled      $gcov"
>>   echo "TPM support       $tpm"
>>   echo "libssh2 support   $libssh2"
>>   echo "TPM passthrough   $tpm_passthrough"
>> +echo "TPM emulator      $tpm_emulator"
>>   echo "QOM debugging     $qom_cast_debug"
>>   echo "Live block migration $live_block_migration"
>>   echo "lzo support       $lzo"
>> @@ -5943,6 +5949,9 @@ if test "$tpm" =3D "yes"; then
>>     if test "$tpm_passthrough" =3D "yes"; then
>>       echo "CONFIG_TPM_PASSTHROUGH=3Dy" >> $config_host_mak
>>     fi
>> +  if test "$tpm_emulator" =3D "yes"; then
>> +    echo "CONFIG_TPM_EMULATOR=3Dy" >> $config_host_mak
> It shouldn't require Linux, but posix (and I assume a port to other
> systems isn't impossible). same for build-sys / help / comments.
>
>> +  fi
>>   fi
>>
>>   echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak
>> diff --git a/hmp.c b/hmp.c
>> index cf62b2e..7e69eca 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -995,6 +995,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict=
)
>>       Error *err =3D NULL;
>>       unsigned int c =3D 0;
>>       TPMPassthroughOptions *tpo;
>> +    TPMEmulatorOptions *teo;
>>
>>       info_list =3D qmp_query_tpm(&err);
>>       if (err) {
>> @@ -1024,6 +1025,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qd=
ict)
>>                              tpo->has_cancel_path ? ",cancel-path=3D" =
: "",
>>                              tpo->has_cancel_path ? tpo->cancel_path :=
 "");
>>               break;
>> +        case TPM_TYPE_EMULATOR:
>> +            teo =3D ti->options->u.emulator.data;
>> +            monitor_printf(mon, ",chardev=3D%s", teo->chardev);
>> +            break;
>>           case TPM_TYPE__MAX:
>>               break;
>>           }
>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>> index 64cecc3..41f0b7a 100644
>> --- a/hw/tpm/Makefile.objs
>> +++ b/hw/tpm/Makefile.objs
>> @@ -1,2 +1,3 @@
>>   common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>>   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tpm_util=
.o
>> +common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> new file mode 100644
>> index 0000000..c02bbe2
>> --- /dev/null
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -0,0 +1,649 @@
>> +/*
>> + *  emulator TPM driver
>> + *
>> + *  Copyright (c) 2017 Intel Corporation
>> + *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
>> + *
>> + *  Copyright (c) 2010 - 2013 IBM Corporation
>> + *  Authors:
>> + *    Stefan Berger <stefanb@us.ibm.com>
>> + *
>> + *  Copyright (C) 2011 IAIK, Graz University of Technology
>> + *    Author: Andreas Niederl
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/l=
icenses/>
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/sockets.h"
>> +#include "io/channel-socket.h"
>> +#include "sysemu/tpm_backend.h"
>> +#include "tpm_int.h"
>> +#include "hw/hw.h"
>> +#include "hw/i386/pc.h"
>> +#include "tpm_util.h"
>> +#include "tpm_ioctl.h"
>> +#include "migration/blocker.h"
>> +#include "qapi/error.h"
>> +#include "chardev/char-fe.h"
>> +
>> +#include <fcntl.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <stdio.h>
>> +
>> +#define DEBUG_TPM 0
>> +
>> +#define DPRINT(fmt, ...) do { \
>> +    if (DEBUG_TPM) { \
>> +        fprintf(stderr, fmt, ## __VA_ARGS__); \
>> +    } \
>> +} while (0);
>> +
>> +#define DPRINTF(fmt, ...) DPRINT("tpm-emulator: "fmt"\n", __VA_ARGS__=
)
> I would define a single DPRINTF() (& drop DPRINT usage below)
>
>
>> +
>> +#define TYPE_TPM_EMULATOR "tpm-emulator"
>> +#define TPM_EMULATOR(obj) \
>> +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
>> +
>> +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap))=
 =3D=3D (cap))
>> +
>> +static const TPMDriverOps tpm_emulator_driver;
>> +
>> +/* data structures */
>> +typedef struct TPMEmulator {
>> +    TPMBackend parent;
>> +
>> +    TPMEmulatorOptions *options;
> Contrary to my comment on previous patch, I realize it is convenient
> to have a qapi pointer here, so you can use the free visitor later.
>
>> +    CharBackend ctrl_dev;
> ctrl_chr perhaps? or just chr or be (the most common name in other devi=
ces).
>
>> +    QIOChannel *data_ioc;
>> +    bool op_executing;
>> +    bool op_canceled;
> I think those 2 fields can be dropped, see below.

I agree. It's not necessary for the emulator driver to keep track of=20
these states.


>
>> +    bool had_startup_error;
> I think some little refactoring could remove the whole
> had_startup_error() backend & callback before or after the series.
> tpm_backend_startup_tpm() already returns an error code.  device or
> common backend code could handle & remember that.
>
>> +    TPMVersion tpm_version;
> This is probably worth to consider in common code instead, but let's
> not worry about it.
>
>> +    ptm_cap caps; /* capabilities of the TPM */
>> +    uint8_t cur_locty_number; /* last set locality */
>> +    QemuMutex state_lock;
>> +    Error *migration_blocker;
>> +} TPMEmulator;
>> +
>> +
>> +static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd, =
void *msg,
>> +                                size_t msg_len_in, size_t msg_len_out=
)
>> +{
>> +    uint32_t cmd_no =3D cpu_to_be32(cmd);
>> +    ssize_t n =3D sizeof(uint32_t) + msg_len_in;
>> +    uint8_t *buf =3D NULL;
>> +
>> +    buf =3D (uint8_t *)malloc(n);
> could be g_alloca() instead. Alternatively, why not call 2 write() inst=
ead?

I think for swtpm the commands should arrive in one chunk.


>
> none of the casts in this function are necessary, please remove them.
>
>> +    memcpy(buf, &cmd_no, sizeof(cmd_no));
>> +    memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
>> +
>> +    n +=3D qemu_chr_fe_write_all(dev, (const uint8_t *)buf, n);
> weird
>
>> +    free(buf);
>> +
>> +    if (n > 0) {
> with the n +=3D above, you'll get interesting behaviour :)
>
> You probably want to check if any write above failed, and return early
> for the error case.
>
> Please improve the error handling in this function
>
>> +        if (msg_len_out > 0) {
>> +            n =3D qemu_chr_fe_read_all(dev, (uint8_t *)msg, msg_len_o=
ut);
>> +            /* simulate ioctl return value */
>> +            if (n > 0) {
>> +                n =3D 0;
>> +            }
>> +        } else {
>> +            n =3D 0;
>> +        }
>> +    }
>> +    return n;
>> +}
>> +
>> +static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_pt,
> tpm_pt was tpm_passthrough I suppose.
>
> Please rename tpm_pt tpm_emu (or I would suggest "self", but this
> isn't common name in qemu code - it's actually common in a close
> c-object world., and it is quite convenient...)
>
>> +                                     const uint8_t *in, uint32_t in_l=
en,
>> +                                     uint8_t *out, uint32_t out_len,
>> +                                     bool *selftest_done)
>> +{
>> +    ssize_t ret;
>> +    bool is_selftest =3D false;
>> +    const struct tpm_resp_hdr *hdr =3D NULL;
>> +    Error *err =3D NULL;
>> +
>> +    tpm_pt->op_canceled =3D false;
>> +    tpm_pt->op_executing =3D true;
>> +    if (selftest_done) {
>> +        *selftest_done =3D false;
>> +        is_selftest =3D tpm_util_is_selftest(in, in_len);
>> +    }
>> +
>> +    ret =3D qio_channel_write(tpm_pt->data_ioc, (char *)in, in_len, &=
err);
> hmm, too bad qio_channel_write() doesn't take a void *
>
> why not write_all()?
>
>> +    if (ret !=3D in_len || err) {
>> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
> I don't think ECANCELED make sense for emulator code.
>
>> +            error_report("tpm-emulator: error while transmitting data=
 "
>> +                         "to TPM: %s", err ? error_get_pretty(err) : =
"");
>> +            error_free(err);
>> +        }
>> +        goto err_exit;
>> +    }
>> +
>> +    tpm_pt->op_executing =3D false;
>> +
>> +    ret =3D qio_channel_read(tpm_pt->data_ioc, (char *)out, out_len, =
&err);
>> +    if (ret < 0 || err) {
> read_all() ?
>
>> +        if (!tpm_pt->op_canceled || errno !=3D ECANCELED) {
>> +            error_report("tpm-emulator: error while reading data from=
 "
>> +                         "TPM: %s", err ? error_get_pretty(err) : "")=
;
>> +            error_free(err);
>> +        }
>> +    } else if (ret >=3D sizeof(*hdr)) {
>> +        hdr =3D (struct tpm_resp_hdr *)out;
>> +    }
>> +
>> +    if (!hdr || be32_to_cpu(hdr->len) !=3D ret) {
>> +        error_report("tpm-emulator: received invalid response "
>> +                     "packet from TPM with length :%ld", ret);
>> +        ret =3D -1;
>> +        goto err_exit;
>> +    }
>> +
>> +    if (is_selftest) {
>> +        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
>> +    }
>> +
>> +    return 0;
>> +
>> +err_exit:
>> +    if (ret < 0) {
>> +        tpm_util_write_fatal_error_response(out, out_len);
>> +    }
>> +
>> +    tpm_pt->op_executing =3D false;
>> +
>> +    return ret;
>> +}
>> +
>> +static int tpm_emulator_set_locality(TPMEmulator *tpm_pt, uint8_t loc=
ty_number)
>> +{
>> +    ptm_loc loc;
>> +
>> +    DPRINTF("%s : locality: 0x%x", __func__, locty_number);
>> +
>> +    if (tpm_pt->cur_locty_number !=3D locty_number) {
> return early instead if =3D=3D, to avoid code indent etc
>
>> +        DPRINTF("setting locality : 0x%x", locty_number);
>> +        loc.u.req.loc =3D locty_number;
> This number isn't set in be like the rest of the protocol?
>
>> +        if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SET_LOCALITY,=
 &loc,
>> +                             sizeof(loc), sizeof(loc)) < 0) {
>> +            error_report("tpm-emulator: could not set locality : %s",
>> +                         strerror(errno));
>> +            return -1;
>> +        }
>> +        loc.u.resp.tpm_result =3D be32_to_cpu(loc.u.resp.tpm_result);
>> +        if (loc.u.resp.tpm_result !=3D 0) {
>> +            error_report("tpm-emulator: TPM result for set locality :=
 0x%x",
>> +                         loc.u.resp.tpm_result);
>> +            return -1;
>> +        }
>> +        tpm_pt->cur_locty_number =3D locty_number;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd=
 cmd)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    TPMLocality *locty =3D NULL;
>> +    bool selftest_done =3D false;
>> +
>> +    DPRINTF("processing command type %d", cmd);
>> +
>> +    switch (cmd) {
>> +    case TPM_BACKEND_CMD_PROCESS_CMD:
>> +        qemu_mutex_lock(&tpm_pt->state_lock);
>> +        locty =3D tb->tpm_state->locty_data;
>> +        if (tpm_emulator_set_locality(tpm_pt,
>> +                                      tb->tpm_state->locty_number) < =
0) {
>> +            tpm_util_write_fatal_error_response(locty->r_buffer.buffe=
r,
>> +                                           locty->r_buffer.size);
> return / goto here instead of else.
>
>> +        } else {
>> +            tpm_emulator_unix_tx_bufs(tpm_pt, locty->w_buffer.buffer,
>> +                                              locty->w_offset,
>> +                                              locty->r_buffer.buffer,
>> +                                              locty->r_buffer.size,
>> +                                              &selftest_done);
> no error handling?
>
>> +        }
>> +
>> +        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_nu=
mber,
>> +                               selftest_done);
>> +        qemu_mutex_unlock(&tpm_pt->state_lock);
>> +
>> +        break;
>> +    case TPM_BACKEND_CMD_INIT:
>> +    case TPM_BACKEND_CMD_END:
>> +    case TPM_BACKEND_CMD_TPM_RESET:
>> +        /* nothing to do */
>> +        break;
>> +    }
>> +}
>> +
>> +/*
>> + * Gracefully shut down the external unixio TPM
>> + */
>> +static void tpm_emulator_shutdown(TPMEmulator *tpm_pt)
>> +{
>> +    ptm_res res;
>> +
>> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SHUTDOWN, &res, 0=
,
>> +                         sizeof(res)) < 0) {
>> +        error_report("tpm-emulator: Could not cleanly shutdown the TP=
M: %s",
>> +                     strerror(errno));
>> +    } else if (res !=3D 0) {
>> +        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
>> +                     be32_to_cpu(res));
>> +    }
>> +}
>> +
>> +static int tpm_emulator_probe_caps(TPMEmulator *tpm_pt)
>> +{
>> +    DPRINTF("%s", __func__);
>> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_GET_CAPABILITY,
>> +                         &tpm_pt->caps, 0, sizeof(tpm_pt->caps)) < 0)=
 {
>> +        error_report("tpm-emulator: probing failed : %s", strerror(er=
rno));
>> +        return -1;
>> +    }
>> +
>> +    tpm_pt->caps =3D be64_to_cpu(tpm_pt->caps);
>> +
>> +    DPRINTF("capbilities : 0x%lx", tpm_pt->caps);
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_emulator_check_caps(TPMEmulator *tpm_pt)
>> +{
>> +    ptm_cap caps =3D 0;
>> +    const char *tpm =3D NULL;
>> +
>> +    /* check for min. required capabilities */
>> +    switch (tpm_pt->tpm_version) {
>> +    case TPM_VERSION_1_2:
>> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMEST=
ABLISHED |
>> +               PTM_CAP_SET_LOCALITY;
>> +        tpm =3D "1.2";
>> +        break;
>> +    case TPM_VERSION_2_0:
>> +        caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMEST=
ABLISHED |
>> +               PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED;
>> +        tpm =3D "2";
>> +        break;
>> +    case TPM_VERSION_UNSPEC:
>> +        error_report("tpm-emulator: TPM version has not been set");
>> +        return -1;
>> +    }
>> +
>> +    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, caps)) {
>> +        error_report("tpm-emulator: TPM does not implement minimum se=
t of "
>> +                     "required capabilities for TPM %s (0x%x)", tpm, =
(int)caps);
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_emulator_startup_tpm(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    ptm_init init;
>> +    ptm_res res;
>> +
>> +    DPRINTF("%s", __func__);
>> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_INIT, &init, size=
of(init),
>> +                         sizeof(init)) < 0) {
>> +        error_report("tpm-emulator: could not send INIT: %s",
>> +                     strerror(errno));
>> +        goto err_exit;
>> +    }
>> +
>> +    res =3D be32_to_cpu(init.u.resp.tpm_result);
>> +    if (res) {
>> +        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", r=
es);
>> +        goto err_exit;
>> +    }
>> +    return 0;
>> +
>> +err_exit:
>> +    tpm_pt->had_startup_error =3D true;
>> +    return -1;
>> +}
>> +
>> +static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    ptm_est est;
>> +
>> +    DPRINTF("%s", __func__);
>> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_GET_TPMESTABLISHE=
D, &est, 0,
>> +                         sizeof(est)) < 0) {
>> +        error_report("tpm-emulator: Could not get the TPM established=
 flag: %s",
>> +                     strerror(errno));
>> +        return false;
>> +    }
>> +    DPRINTF("established flag: %0x", est.u.resp.bit);
>> +
>> +    return (est.u.resp.bit !=3D 0);
>> +}
>> +
>> +static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>> +                                                   uint8_t locty)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    ptm_reset_est reset_est;
>> +    ptm_res res;
>> +
>> +    /* only a TPM 2.0 will support this */
>> +    if (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0) {
>> +        reset_est.u.req.loc =3D tpm_pt->cur_locty_number;
>> +
>> +        if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_RESET_TPMESTA=
BLISHED,
>> +                                 &reset_est, sizeof(reset_est),
>> +                                 sizeof(reset_est)) < 0) {
>> +            error_report("tpm-emulator: Could not reset the establish=
ment bit: "
>> +                          "%s", strerror(errno));
>> +            return -1;
>> +        }
>> +
>> +        res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
>> +        if (res) {
>> +            error_report("tpm-emulator: TPM result for rest establixh=
ed flag: "
>> +                         "0x%x", res);
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool tpm_emulator_had_startup_error(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +
>> +    return tpm_pt->had_startup_error;
>> +}
>> +
>> +static void tpm_emulator_cancel_cmd(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    ptm_res res;
>> +
>> +    /*
>> +     * As of Linux 3.7 the tpm_tis driver does not properly cancel
>> +     * commands on all TPM manufacturers' TPMs.
>> +     * Only cancel if we're busy so we don't cancel someone else's
>> +     * command, e.g., a command executed on the host.
>> +     */
>> +    if (tpm_pt->op_executing) {
> The field is set in the worker thread. This is racy. Fortunately this
> is not relevant for emulator, I think you can simply drop that check
> and the variable. Stefan should confirm though.
>
>> +        if (TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_pt, PTM_CAP_CANCEL_T=
PM_CMD)) {
>> +            if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_CANCEL_TP=
M_CMD,
>> +                                     &res, 0, sizeof(res)) < 0) {
>> +                error_report("tpm-emulator: Could not cancel command:=
 %s",
>> +                             strerror(errno));
>> +            } else if (res !=3D 0) {
>> +                error_report("tpm-emulator: Failed to cancel TPM: 0x%=
x",
>> +                             be32_to_cpu(res));
>> +            } else {
>> +                tpm_pt->op_canceled =3D true;
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +static void tpm_emulator_reset(TPMBackend *tb)
>> +{
>> +    DPRINTF("%s", __func__);
>> +
>> +    tpm_emulator_cancel_cmd(tb);
>> +}
>> +
>> +static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +
>> +    return tpm_pt->tpm_version;
>> +}
>> +
>> +static void tpm_emulator_block_migration(TPMEmulator *tpm_pt)
>> +{
>> +    Error *err =3D NULL;
>> +
>> +    error_setg(&tpm_pt->migration_blocker,
>> +               "Migration disabled: TPM emulator not yet migratable")=
;
>> +    migrate_add_blocker(tpm_pt->migration_blocker, &err);
>> +    if (err) {
>> +        error_free(err);
> probably better to report_err it instead
>
>> +        error_free(tpm_pt->migration_blocker);
>> +        tpm_pt->migration_blocker =3D NULL;
> and return an error code.
>
>> +    }
>> +}
>> +
>> +static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_pt)
>> +{
>> +    ptm_res res;
>> +    Error *err =3D NULL;
>> +    int fds[2] =3D { -1, -1 };
>> +
>> +    if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
>> +        error_report("tpm-emulator: Failed to create socketpair");
>> +        return -1;
>> +    }
>> +
>> +    qemu_chr_fe_set_msgfds(&tpm_pt->ctrl_dev, fds + 1, 1);
>> +
>> +    if (tpm_emulator_ctrlcmd(&tpm_pt->ctrl_dev, CMD_SET_DATAFD, &res,=
 0,
>> +                    sizeof(res)) || res !=3D 0) {
> Yay! for making life easier and hiding a protocol detail.
>
>> +        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s=
",
>> +                     strerror(errno));
>> +        goto err_exit;
>> +    }
>> +
>> +    tpm_pt->data_ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(fds[0]=
, &err));
>> +    if (err) {
>> +        error_report("tpm-emulator: Failed to create io channel : %s"=
,
>> +                       error_get_pretty(err));
> error_prepend()?
>
>> +        error_free(err);
>> +        goto err_exit;
>> +    }
> close fds[1] ?
>
>> +
>> +    return 0;
>> +
>> +err_exit:
>> +    closesocket(fds[0]);
>> +    closesocket(fds[1]);
>> +    return -1;
>> +}
>> +
>> +static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_pt, QemuO=
pts *opts)
>> +{
>> +    const char *value;
>> +
>> +    value =3D qemu_opt_get(opts, "chardev");
>> +    if (value) {
>> +        Error *err =3D NULL;
>> +        Chardev *dev =3D qemu_chr_find(value);
>> +
>> +        tpm_pt->options->chardev =3D g_strdup(value);
>> +
>> +        if (!dev || !qemu_chr_fe_init(&tpm_pt->ctrl_dev, dev, &err)) =
{
>> +            error_report("tpm-emulator: No valid chardev found at '%s=
': %s",
>> +                         value, err ? error_get_pretty(err) : "");
>> +            error_free(err);
> error_prepend
>
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    if (tpm_emulator_prepare_data_fd(tpm_pt) < 0) {
>> +        goto err;
>> +    }
>> +
>> +    /* FIXME: tpm_util_test_tpmdev() accepts only on socket fd, as it=
 also used
>> +     * by passthrough driver, which not yet using GIOChannel.
>> +     */
>> +    if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_pt->data_ioc)->fd=
,
>> +                             &tpm_pt->tpm_version)) {
>> +        error_report("'%s' is not emulating TPM device. Error: %s",
>> +                      tpm_pt->options->chardev, strerror(errno));
>> +        goto err;
>> +    }
>> +
>> +    DPRINTF("TPM Version %s", tpm_pt->tpm_version =3D=3D TPM_VERSION_=
1_2 ? "1.2" :
>> +             (tpm_pt->tpm_version =3D=3D TPM_VERSION_2_0 ?  "2.0" : "=
Unspecified"));
>> +
>> +    if (tpm_emulator_probe_caps(tpm_pt) ||
>> +        tpm_emulator_check_caps(tpm_pt)) {
>> +        goto err;
>> +    }
>> +
>> +    tpm_emulator_block_migration(tpm_pt);
>> +
>> +    return 0;
>> +
>> +err:
>> +    DPRINT("Startup error\n");
>> +    return -1;
>> +}
>> +
>> +static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id=
)
>> +{
>> +    TPMBackend *tb =3D TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
>> +
>> +    tb->id =3D g_strdup(id);
>> +
>> +    if (tpm_emulator_handle_device_opts(TPM_EMULATOR(tb), opts)) {
>> +        goto err_exit;
>> +    }
>> +
>> +    return tb;
>> +
>> +err_exit:
>> +    object_unref(OBJECT(tb));
>> +
>> +    return NULL;
>> +}
>> +
>> +static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(tb);
>> +    TpmTypeOptions *options =3D NULL;
>> +    TPMEmulatorOptions *eoptions =3D NULL;
>> +
>> +    eoptions =3D g_new0(TPMEmulatorOptions, 1);
>> +    if (!eoptions) {
>> +        return NULL;
>> +    }
>> +    DPRINTF("%s", __func__);
>> +
>> +    eoptions->chardev =3D g_strdup(tpm_pt->options->chardev);
>> +    options =3D g_new0(TpmTypeOptions, 1);
>> +    if (!options) {
>> +        qapi_free_TPMEmulatorOptions(eoptions);
>> +        return NULL;
>> +    }
>> +
>> +    options->type =3D TPM_TYPE_EMULATOR;
>> +    options->u.emulator.data =3D eoptions;
> I think this is a job for QAPI_CLONE.
>
>> +
>> +    return options;
>> +}
>> +
>> +static const QemuOptDesc tpm_emulator_cmdline_opts[] =3D {
>> +    TPM_STANDARD_CMDLINE_OPTS,
>> +    {
>> +        .name =3D "chardev",
>> +        .type =3D QEMU_OPT_STRING,
>> +        .help =3D "Character device to use for out-of-band control me=
ssages",
>> +    },
>> +    { /* end of list */ },
>> +};
>> +
>> +static const TPMDriverOps tpm_emulator_driver =3D {
>> +    .type                     =3D TPM_TYPE_EMULATOR,
>> +    .opts                     =3D tpm_emulator_cmdline_opts,
>> +    .desc                     =3D "TPM emulator backend driver",
>> +
>> +    .create                   =3D tpm_emulator_create,
>> +    .startup_tpm              =3D tpm_emulator_startup_tpm,
>> +    .reset                    =3D tpm_emulator_reset,
>> +    .had_startup_error        =3D tpm_emulator_had_startup_error,
>> +    .cancel_cmd               =3D tpm_emulator_cancel_cmd,
>> +    .get_tpm_established_flag =3D tpm_emulator_get_tpm_established_fl=
ag,
>> +    .reset_tpm_established_flag =3D tpm_emulator_reset_tpm_establishe=
d_flag,
>> +    .get_tpm_version          =3D tpm_emulator_get_tpm_version,
>> +    .get_tpm_options          =3D tpm_emulator_get_tpm_options,
>> +};
>> +
>> +static void tpm_emulator_inst_init(Object *obj)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(obj);
>> +
>> +    DPRINTF("%s", __func__);
>> +    tpm_pt->options =3D g_new0(TPMEmulatorOptions, 1);
>> +    tpm_pt->op_executing =3D tpm_pt->op_canceled =3D false;
>> +    tpm_pt->had_startup_error =3D false;
>> +    tpm_pt->cur_locty_number =3D ~0;
>> +    qemu_mutex_init(&tpm_pt->state_lock);
>> +}
>> +
>> +static void tpm_emulator_inst_finalize(Object *obj)
>> +{
>> +    TPMEmulator *tpm_pt =3D TPM_EMULATOR(obj);
>> +
>> +    tpm_emulator_cancel_cmd(TPM_BACKEND(obj));
>> +    tpm_emulator_shutdown(tpm_pt);
>> +
>> +    if (tpm_pt->data_ioc) {
>> +        qio_channel_close(tpm_pt->data_ioc, NULL);
>> +    }
>> +
>> +    qemu_chr_fe_deinit(&tpm_pt->ctrl_dev, false);
>> +
>> +    if (tpm_pt->options) {
>> +        qapi_free_TPMEmulatorOptions(tpm_pt->options);
>> +    }
>> +
>> +    if (tpm_pt->migration_blocker) {
>> +        migrate_del_blocker(tpm_pt->migration_blocker);
>> +        error_free(tpm_pt->migration_blocker);
>> +    }
>> +}
>> +
>> +static void tpm_emulator_class_init(ObjectClass *klass, void *data)
>> +{
>> +    TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
>> +    tbc->ops =3D &tpm_emulator_driver;
>> +    tbc->handle_request =3D tpm_emulator_handle_request;
>> +}
>> +
>> +static const TypeInfo tpm_emulator_info =3D {
>> +    .name =3D TYPE_TPM_EMULATOR,
>> +    .parent =3D TYPE_TPM_BACKEND,
>> +    .instance_size =3D sizeof(TPMEmulator),
>> +    .class_init =3D tpm_emulator_class_init,
>> +    .instance_init =3D tpm_emulator_inst_init,
>> +    .instance_finalize =3D tpm_emulator_inst_finalize,
>> +};
>> +
>> +static void tpm_emulator_register(void)
>> +{
>> +    type_register_static(&tpm_emulator_info);
>> +    tpm_register_driver(&tpm_emulator_driver);
>> +}
>> +
>> +type_init(tpm_emulator_register)
>> diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
>> new file mode 100644
>> index 0000000..33564b1
>> --- /dev/null
>> +++ b/hw/tpm/tpm_ioctl.h
> This file is copied from swtpm project. Could swtpm have it installed
> on system instead?


I think we'll have to carry this file here for a while until swtpm is=20
packaged and distros provide it.

    Stefan
