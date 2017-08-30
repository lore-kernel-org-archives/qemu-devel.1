Received: from eggs.gnu.org ([2001:4830:134:3::10]:43424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn2b1-0005GU-Ox
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn2ay-0000WV-MH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:59:51 -0400
Date: Wed, 30 Aug 2017 13:59:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170830125931.GP18526@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:28PM +0200, Paolo Bonzini wrote:
> It is a common requirement for virtual machine to send persistent
> reservations, but this currently requires either running QEMU with
> CAP_SYS_RAWIO, or using out-of-tree patches that let an unprivileged
> QEMU bypass Linux's filter on SG_IO commands.
> 
> As an alternative mechanism, the next patches will introduce a
> privileged helper to run persistent reservation commands without
> expanding QEMU's attack surface unnecessarily.

FYI, libvirt should block this helper program as it sets up capabilities
in such a way that prevent QEMU evalating privileges via setuid binaries.

We would have to figure out a way for libvirt to run the daemon I guess.

> 
> The helper is invoked through a "pr-manager" QOM object, to which
> file-posix.c passes SG_IO requests for PERSISTENT RESERVE OUT and
> PERSISTENT RESERVE IN commands.  For example:
> 
>   $ qemu-system-x86_64
>       -device virtio-scsi \
>       -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
>       -drive if=none,id=hd,driver=raw,file.filename=/dev/sdb,file.pr-manager=helper0
>       -device scsi-block,drive=hd
> 
> or:
> 
>   $ qemu-system-x86_64
>       -device virtio-scsi \
>       -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
>       -blockdev node-name=hd,driver=raw,file.driver=host_device,file.filename=/dev/sdb,file.pr-manager=helper0
>       -device scsi-block,drive=hd
> 
> Multiple pr-manager implementations are conceivable and possible, though
> only one is implemented right now.  For example, a pr-manager could:
> 
> - talk directly to the multipath daemon from a privileged QEMU
>   (i.e. QEMU links to libmpathpersist); this makes reservation work
>   properly with multipath, but still requires CAP_SYS_RAWIO
> 
> - use the Linux IOC_PR_* ioctls (they require CAP_SYS_ADMIN though)
> 
> - more interestingly, implement reservations directly in QEMU
>   through file system locks or a shared database (e.g. sqlite)

IIUC This last thing is essentially what libvirt already provided via
its virtlockd daemon. For SCSI disks, we have a configuration option that
tells it to run the '/lib/udev/scsi_id' program, and then acquires a
fcntl() lock on a file  in /var/lib/libvirt/lockd/scsivolumes/ whose
name is based on the value reported by scsi_id.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
