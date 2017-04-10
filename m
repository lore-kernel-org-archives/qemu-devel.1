Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cxbzD-0005eY-00
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cxbz6-0002xG-4p
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:16:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cxbz5-0002wE-L9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:16:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3AGDeuA041435
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:16:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29r5s5xu9d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:16:05 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 12:16:04 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<d74c2094-051e-bf1d-7c41-316b0e3651bc@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 12:15:59 -0400
MIME-Version: 1.0
In-Reply-To: <d74c2094-051e-bf1d-7c41-316b0e3651bc@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <597106d8-23bd-cc2c-3364-468ffd11e45d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, marcandre.lureau@gmail.com

On 04/10/2017 03:08 AM, Amarnath Valluri wrote:
>
>
> On 07.04.2017 17:41, Daniel P. Berrange wrote:
>> On Fri, Apr 07, 2017 at 05:30:31PM +0300, Amarnath Valluri wrote:
>>> This change introduces a new TPM backend driver that can communicate 
>>> with
>>> swtpm(software TPM emulator) using unix domain socket interface.
>>>
>>> Swtpm uses two unix sockets, one for plain TPM commands and 
>>> responses, and one
>>> for out-of-band control messages.
>>>
>>> The swtpm and associated tools can be found here:
>>>      https://github.com/stefanberger/swtpm
>>>
>>> Usage:
>>>      # setup TPM state directory
>>>      mkdir /tmp/mytpm
>>>      chown -R tss:root /tmp/mytpm
>>>      /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>>>
>>>      # Ask qemu to use TPM emulator with given tpm state directory
>>>      qemu-system-x86_64 \
>>>          [...] \
>>>          -tpmdev 
>>> emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
>>>          -device tpm-tis,tpmdev=tpm0 \
>>>          [...]
>>>
>>> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>>> ---
>>>   configure             |  15 +-
>>>   hmp.c                 |  21 ++
>>>   hw/tpm/Makefile.objs  |   1 +
>>>   hw/tpm/tpm_emulator.c | 927 
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   hw/tpm/tpm_ioctl.h    | 243 +++++++++++++
>>>   qapi-schema.json      |  36 +-
>>>   qemu-options.hx       |  53 ++-
>>>   tpm.c                 |   2 +-
>>>   8 files changed, 1289 insertions(+), 9 deletions(-)
>>>   create mode 100644 hw/tpm/tpm_emulator.c
>>>   create mode 100644 hw/tpm/tpm_ioctl.h
>>> +static int tpm_emulator_spawn_emulator(TPMEmulator *tpm_pt)
>>> +{
>>> +    int fds[2] = { -1, -1 };
>>> +    int ctrl_fds[2] = { -1, -1 };
>>> +    pid_t cpid;
>>> +
>>> +    if (!tpm_pt->ops->has_data_path) {
>>> +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>> +    if (!tpm_pt->ops->has_ctrl_path) {
>>> +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, ctrl_fds) < 0) {
>>> +            if (!tpm_pt->ops->has_data_path) {
>>> +                closesocket(fds[0]);
>>> +                closesocket(fds[1]);
>>> +            }
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>> +    cpid = qemu_fork(NULL);
>>> +    if (cpid < 0) {
>>> +        error_report("tpm-emulator: Fork failure: %s", 
>>> strerror(errno));
>>> +        if (!tpm_pt->ops->has_data_path) {
>>> +            closesocket(fds[0]);
>>> +            closesocket(fds[1]);
>>> +        }
>>> +        if (!tpm_pt->ops->has_ctrl_path) {
>>> +            closesocket(ctrl_fds[0]);
>>> +            closesocket(ctrl_fds[1]);
>>> +        }
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (cpid == 0) { /* CHILD */
>>> +        enum {
>>> +            PARAM_PATH,
>>> +            PARAM_IFACE,
>>> +            PARAM_SERVER,  PARAM_SERVER_ARGS,
>>> +            PARAM_CTRL,    PARAM_CTRL_ARGS,
>>> +            PARAM_STATE,   PARAM_STATE_ARGS,
>>> +            PARAM_PIDFILE, PARAM_PIDFILE_ARGS,
>>> +            PARAM_LOG,     PARAM_LOG_ARGS,
>>> +            PARAM_MAX
>>> +        };
>>> +
>>> +        int i;
>>> +        int data_fd = -1, ctrl_fd = -1;
>>> +        char *argv[PARAM_MAX+1];
>>> +
>>> +        /* close all unused inherited sockets */
>>> +        if (fds[0] >= 0)
>>> +            closesocket(fds[0]);
>>> +        if (ctrl_fds[0] >= 0)
>>> +            closesocket(ctrl_fds[0]);
>> The 'if' checks are pointless - its already guaranteed by the
>> fact you check socketpair() status.
> socketpairs might not be created in case of data-path & ctrl-path 
> provided, so i feel these checks are needed.
>>
>>> +        i = STDERR_FILENO + 1;
>>> +        if (fds[1] >= 0) {
>>> +            data_fd = dup2(fds[1], i++);
>>> +            if (data_fd < 0) {
>>> +                error_report("tpm-emulator: dup2() failure - %s",
>>> +                             strerror(errno));
>>> +                goto exit_child;
>>> +            }
>>> +        }
>>> +        if (ctrl_fds[1] >= 0) {
>>> +            ctrl_fd = dup2(ctrl_fds[1], i++);
>>> +            if (ctrl_fd < 0) {
>>> +                error_report("tpm-emulator: dup2() failure - %s",
>>> +                             strerror(errno));
>>> +                goto exit_child;
>>> +            }
>>> +        }
>>> +        for ( ; i < _SC_OPEN_MAX; i++) {
>> Errr, _SC_OPEN_MAX is not the maximum number of FDs - it is parameter to
>> use with sysconf() to query the number of files - you must call 
>> sysconf().
> Ya, thanks for educating me, i will change this.
>>
>>> +            closesocket(i);
>> close, not closesocket - you can't assume these are all sockets.
> Does this change makes any difference, as per 
> include/sysemu/os-posix.h,  closesocket() is define as close(), and 
> this backend is targeted only for "Linux" targets. Please let me know 
> if i am missing something.
>>
>>
>>> +        DPRINT("\n")
>>> +        if (execv(tpm_pt->ops->path, (char * const *)argv) < 0) {
>>> +            error_report("execv() failure : %s", strerror(errno));
>>> +        }
>>> +
>>> +exit_child:
>>> +        g_strfreev(argv);
>>> +        if (data_fd >= 0)
>>> +            closesocket(data_fd);
>>> +        if (ctrl_fd >= 0)
>>> +            closesocket(ctrl_fd);
>>> +
>>> +        exit(0);
>> You need _exit(), not exit() as you don't want to run atexit() handlers
>> here. You also want '1' not '0' since this is a failure scenario.
> Sure, i will change this.
>>
>>> +    } else { /* self */
>>> +        struct stat st;
>>> +        DPRINTF("child pid: %d", cpid);
>>> +        int rc;
>>> +        int timeout = 3; /* wait for max 3 seconds */
>>> +
>>> +        /* close unsed sockets */
>>> +        if (fds[1] >= 0)
>>> +            closesocket(fds[1]);
>>> +        if (ctrl_fds[1] >= 0)
>>> +            closesocket(ctrl_fds[1]);
>>> +
>>> +        while((rc = stat(TPM_EMULATOR_PIDFILE, &st)) < 0 && 
>>> timeout--) {
>>> +            sleep(1);
>>> +        }
>> A fixed 3 second timeout will inevitably cause failures on systems with
>> high load.
>>
>> Presumably you're trying to handle the scenario where the child process
>> exits without creating the pid file ?
> The check is mainly to know if the child setup is done and ready to 
> accept requests.
>>
>> In which case you can use 'kill(cpid, 0)' and if errno == ESRCH
>> then the child has exited.
>>
>>> +
>>> +        if (timeout == -1) {
>>> +            error_report("tpm-emulator: failed to find pid file: %s",
>>> +                         strerror(errno));
>>> +            goto err_kill_child;
>>> +        }
>>> +
>>> +        tpm_pt->data_ioc = _iochannel_new(tpm_pt->ops->data_path, 
>>> fds[0], NULL);
>>> +        if (!tpm_pt->data_ioc) {
>>> +            error_report("tpm-emulator: Unable to connect socket : 
>>> %s",
>>> +                          tpm_pt->ops->data_path);
>>> +            goto err_kill_child;
>>> +        }
>>> +
>>> +        tpm_pt->ctrl_ioc = _iochannel_new(tpm_pt->ops->ctrl_path, 
>>> ctrl_fds[0], NULL);
>>> +        if (!tpm_pt->ctrl_ioc) {
>>> +            error_report("tpm-emulator: Unable to connect socket : 
>>> %s",
>>> +                          tpm_pt->ops->ctrl_path);
>>> +            goto err_kill_child;
>>> +        }
>>> +
>>> +        tpm_pt->child_running = true;
>>> +
>>> +        qemu_add_child_watch(cpid);
>>> +
>>> +        qio_channel_add_watch(tpm_pt->data_ioc, G_IO_HUP|G_IO_ERR,
>>> +                              tpm_emulator_fd_handler, tpm_pt, NULL);
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err_kill_child:
>>> +    kill(cpid, SIGTERM);
>>> +    closesocket(fds[0]);
>>> +    closesocket(ctrl_fds[0]);
>> You can't assume the child has gone after a SIGTERM. You need to
>> check, and be prepared to SIGKILL after time reasonable time,
>> if needed.
> Ok, i will add this check.
>>
>>> +    tpm_pt->child_running = false;
>>> +
>>> +    return -1;
>>> +}
>>> +
>>> +static const QemuOptDesc tpm_emulator_cmdline_opts[] = {
>>> +    TPM_STANDARD_CMDLINE_OPTS,
>>> +    {
>>> +        .name = "tpmstatedir",
>>> +        .type = QEMU_OPT_STRING,
>>> +        .help = "TPM state directroy",
>>> +    },
>>> +    {
>>> +        .name = "spawn",
>>> +        .type = QEMU_OPT_BOOL,
>>> +        .help = "Wether to spwan given emlatory binary",
>>> +    },
>>> +    {
>>> +        .name = "path",
>>> +        .type = QEMU_OPT_STRING,
>>> +        .help = "Path to TPM emulator binary",
>>> +    },
>>> +    {
>>> +        .name = "data-path",
>>> +        .type = QEMU_OPT_STRING,
>>> +        .help = "Socket path to use for data exhange",
>>> +    },
>>> +    {
>>> +        .name = "ctrl-path",
>>> +        .type = QEMU_OPT_STRING,
>>> +        .help = "Socket path to use for out-of-band control messages",
>>> +    },
>> I'm still not convinced by the need for 2 separate UNIX sockets, unless
>> there's a performance reason, but that looks unlikely.
> I myself, is not expert of swtpm's interface, hence i cannot defend this.
> i am just trying to enable emulation support in qemu using swtpm. 
> Stefan Berger is the right person to comment on this.
>

I don't understand what the issue is with running the control and data 
channels over different file descriptors.
