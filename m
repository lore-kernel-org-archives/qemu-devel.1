Received: from eggs.gnu.org ([2001:4830:134:3::10]:37913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvmtb-0003vy-6p
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvmtY-0006wC-2f
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvmtX-0006vC-R7
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:30:52 -0400
Date: Wed, 5 Apr 2017 16:30:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170405153044.GA17970@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-9-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490965817-16913-9-git-send-email-amarnath.valluri@intel.com>
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
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

On Fri, Mar 31, 2017 at 04:10:17PM +0300, Amarnath Valluri wrote:
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
> +    cpid = fork();

You must use  qemu_fork() to ensure signals are put into a sane state
and also to avoid signal handler races which can hit between fork & exec.

> +    if (cpid < 0) {
> +        error_report("tpm-emulator: Fork failure: %s", strerror(errno));
> +        closesocket(fds[0]); closesocket(fds[1]);
> +        closesocket(ctrl_fds[0]); closesocket(ctrl_fds[1]);
> +        return -1;
> +    }
> +
> +    if (cpid == 0) { /* CHILD */
> +        int i;
> +        char fd_str[128] = "";
> +        char ctrl_fd_str[128] = "";
> +        char tpmstate_str[1024] = "";
> +        char log_str[1024] = "";
> +        const char *params[] = {
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
> +        for (i = STDERR_FILENO + 1; i < fds[1]; i++) {
> +            closesocket(i);
> +        }

So you're assuming that fds[1] is the most highest open file descriptor
in QEMU, since you opened it a few lines earlier. Unfortunately this is not
valid, as QEMU is multi-threaded and so other threads may have opened FDs
in this time window. In addition there may be previously opened FDs with
high numbers. If you want to close all open FDs, you need to use sysconf
to query _SC_OPEN_MAX and iterate upto that value.

> +
> +        sprintf(fd_str, "%d", fds[1]);
> +        sprintf(ctrl_fd_str, "type=unixio,clientfd=%d", ctrl_fds[1]);
> +        sprintf(tpmstate_str, "dir=%s", tpm_pt->ops.tpmstatedir);

All these unchecked sprintfs into fixed buffers are bad and the directory
based ones are in fact buffer overflows if the user gives a tpmstatedir
path longer than 1020 characters. Use g_strdup_printf() to malloc strings
on the stack and free them when done.

> +        if (tpm_pt->ops.has_logfile) {
> +            sprintf(log_str, "file=%s,level=%d", tpm_pt->ops.logfile,
> +                    (int)tpm_pt->ops.loglevel);
> +        } else {
> +            /* truncate logs */
> +            params[8] = NULL;
> +        }
> +        DPRINT("Running cmd: ")
> +        for (i = 0; params[i]; i++) {
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
> +
> +        tpm_pt->tpm_fd = fds[0];
> +        tpm_pt->tpm_ctrl_fd = ctrl_fds[0];

Unless you switch over to using QEMU Chardevs backends as the I/O mechanism,
you should uses QIOChannelSocket for I/O and event handlers, rather than using
raw sockets directly.

ie, create one with qio_channel_socket_new_fd(fds[0]);

....

> +        tpm_pt->child_running = true;
> +
> +        qemu_add_child_watch(cpid);
> +
> +        fcntl(tpm_pt->tpm_fd, F_SETFL, O_NONBLOCK);


..then

qio_channel_set_blocking

> +        qemu_set_fd_handler(tpm_pt->tpm_fd, tpm_emulator_fd_handler, NULL,
> +                            tpm_pt);

and use qio_channel_add_watch,

etc, likewise in the places where you do actual I/O

> +
> +        /* close unsed sockets */
> +        closesocket(fds[1]);
> +        closesocket(ctrl_fds[1]);
> +    }
> +
> +    return 0;
> +}

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
