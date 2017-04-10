Received: from eggs.gnu.org ([2001:4830:134:3::10]:47683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxUjE-0007VS-Nc
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxUjB-0005cW-JQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxUjB-0005bH-Aw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:31:13 -0400
Date: Mon, 10 Apr 2017 09:31:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410083105.GB3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<d74c2094-051e-bf1d-7c41-316b0e3651bc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d74c2094-051e-bf1d-7c41-316b0e3651bc@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com

On Mon, Apr 10, 2017 at 10:08:21AM +0300, Amarnath Valluri wrote:
> 
> 
> On 07.04.2017 17:41, Daniel P. Berrange wrote:
> > On Fri, Apr 07, 2017 at 05:30:31PM +0300, Amarnath Valluri wrote:
> > > This change introduces a new TPM backend driver that can communicate with
> > > swtpm(software TPM emulator) using unix domain socket interface.
> > > 
> > > Swtpm uses two unix sockets, one for plain TPM commands and responses, and one
> > > for out-of-band control messages.
> > > 
> > > The swtpm and associated tools can be found here:
> > >      https://github.com/stefanberger/swtpm
> > > 
> > > Usage:
> > >      # setup TPM state directory
> > >      mkdir /tmp/mytpm
> > >      chown -R tss:root /tmp/mytpm
> > >      /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
> > > 
> > >      # Ask qemu to use TPM emulator with given tpm state directory
> > >      qemu-system-x86_64 \
> > >          [...] \
> > >          -tpmdev emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
> > >          -device tpm-tis,tpmdev=tpm0 \
> > >          [...]
> > > 
> > > Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> > > ---
> > >   configure             |  15 +-
> > >   hmp.c                 |  21 ++
> > >   hw/tpm/Makefile.objs  |   1 +
> > >   hw/tpm/tpm_emulator.c | 927 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   hw/tpm/tpm_ioctl.h    | 243 +++++++++++++
> > >   qapi-schema.json      |  36 +-
> > >   qemu-options.hx       |  53 ++-
> > >   tpm.c                 |   2 +-
> > >   8 files changed, 1289 insertions(+), 9 deletions(-)
> > >   create mode 100644 hw/tpm/tpm_emulator.c
> > >   create mode 100644 hw/tpm/tpm_ioctl.h
> > > +static int tpm_emulator_spawn_emulator(TPMEmulator *tpm_pt)
> > > +{
> > > +    int fds[2] = { -1, -1 };
> > > +    int ctrl_fds[2] = { -1, -1 };
> > > +    pid_t cpid;
> > > +
> > > +    if (!tpm_pt->ops->has_data_path) {
> > > +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
> > > +            return -1;
> > > +        }
> > > +    }
> > > +
> > > +    if (!tpm_pt->ops->has_ctrl_path) {
> > > +        if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, ctrl_fds) < 0) {
> > > +            if (!tpm_pt->ops->has_data_path) {
> > > +                closesocket(fds[0]);
> > > +                closesocket(fds[1]);
> > > +            }
> > > +            return -1;
> > > +        }
> > > +    }
> > > +
> > > +    cpid = qemu_fork(NULL);
> > > +    if (cpid < 0) {
> > > +        error_report("tpm-emulator: Fork failure: %s", strerror(errno));
> > > +        if (!tpm_pt->ops->has_data_path) {
> > > +            closesocket(fds[0]);
> > > +            closesocket(fds[1]);
> > > +        }
> > > +        if (!tpm_pt->ops->has_ctrl_path) {
> > > +            closesocket(ctrl_fds[0]);
> > > +            closesocket(ctrl_fds[1]);
> > > +        }
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (cpid == 0) { /* CHILD */
> > > +        enum {
> > > +            PARAM_PATH,
> > > +            PARAM_IFACE,
> > > +            PARAM_SERVER,  PARAM_SERVER_ARGS,
> > > +            PARAM_CTRL,    PARAM_CTRL_ARGS,
> > > +            PARAM_STATE,   PARAM_STATE_ARGS,
> > > +            PARAM_PIDFILE, PARAM_PIDFILE_ARGS,
> > > +            PARAM_LOG,     PARAM_LOG_ARGS,
> > > +            PARAM_MAX
> > > +        };
> > > +
> > > +        int i;
> > > +        int data_fd = -1, ctrl_fd = -1;
> > > +        char *argv[PARAM_MAX+1];
> > > +
> > > +        /* close all unused inherited sockets */
> > > +        if (fds[0] >= 0)
> > > +            closesocket(fds[0]);
> > > +        if (ctrl_fds[0] >= 0)
> > > +            closesocket(ctrl_fds[0]);
> > The 'if' checks are pointless - its already guaranteed by the
> > fact you check socketpair() status.
> socketpairs might not be created in case of data-path & ctrl-path provided,
> so i feel these checks are needed.
> > 
> > > +        i = STDERR_FILENO + 1;
> > > +        if (fds[1] >= 0) {
> > > +            data_fd = dup2(fds[1], i++);
> > > +            if (data_fd < 0) {
> > > +                error_report("tpm-emulator: dup2() failure - %s",
> > > +                             strerror(errno));
> > > +                goto exit_child;
> > > +            }
> > > +        }
> > > +        if (ctrl_fds[1] >= 0) {
> > > +            ctrl_fd = dup2(ctrl_fds[1], i++);
> > > +            if (ctrl_fd < 0) {
> > > +                error_report("tpm-emulator: dup2() failure - %s",
> > > +                             strerror(errno));
> > > +                goto exit_child;
> > > +            }
> > > +        }
> > > +        for ( ; i < _SC_OPEN_MAX; i++) {
> > Errr, _SC_OPEN_MAX is not the maximum number of FDs - it is parameter to
> > use with sysconf() to query the number of files - you must call sysconf().
> Ya, thanks for educating me, i will change this.
> > 
> > > +            closesocket(i);
> > close, not closesocket - you can't assume these are all sockets.
> Does this change makes any difference, as per include/sysemu/os-posix.h,
> closesocket() is define as close(), and this backend is targeted only for
> "Linux" targets. Please let me know if i am missing something.

Using closesocket() is misleading even if it does happen to call close()
on Linux.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
