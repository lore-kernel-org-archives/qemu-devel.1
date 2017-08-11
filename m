Received: from eggs.gnu.org ([2001:4830:134:3::10]:52703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg8gU-00068o-NW
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg8gN-0003PM-R8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:04:58 -0400
Date: Fri, 11 Aug 2017 20:04:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170811120435.GB23309@lemon.lan>
References: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
Subject: Re: [Qemu-devel] migration issue with qemu 2.10-rc2: QEMU command
 'nbd-server-add': Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, 08/11 13:07, Christian Ehrhardt wrote:
> Hi,
> testing on 2.10-rc2 I ran into an issue around:
>   unable to execute QEMU command 'nbd-server-add': Block node is read-only
> 
> ### TL;DR ###
> - triggered by livbirt driven live migration with --copy-storage-all
> - buils down to nbd_server_add failing
> - can be reproduced on a single system without libvirt
> - last known working (so far) was qemu 2.8
> 
> Simple repro:
> $ qemu-img create -f qcow2 /tmp/test.qcow2 100M
> $ qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor
> stdio -drive
> file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 -incoming
> defer
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
> [bit 5]
> nbd_server_start 0.0.0.0:49153
> (qemu) nbd_server_add -w drive-virtio-disk0
> Block node is read-only
> 
> ### Details ###
> 
> Trigger:
> virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh://
> 10.22.69.61/system
> 
> Setup:
> - Two systems without shared storage
> - An equal image is synced before the test, so it would only migrate
> minimal remaining changes
> => Only the --copy-storage-all case triggers this, other migrations work as
> far as I tested.
> => No related apparmor denials
> 
> The last combination I knew to be successful was libvirt 3.5 and qemu 2.8.
> So I Downgraded libvirt (but kept qemu) and retest.
> => Still an issue
> => So it is a qemu 2.10 issue and not libvirt 3.6
> Continuing with libvirt 3.6 to have latest updates.
> 
> On the migration target I see the following in the log:
> libvirtd[11829]: 2017-08-11 08:51:49.283+0000: 11842: warning :
> qemuDomainObjTaint:4545 : Domain id=2 name='kvmguest-artful-normal'
> uuid=b6f4cdab-77b0-43b1-933d-9683567f3a89 is tainted: high-privileges
> libvirtd[11829]: 2017-08-11 08:51:49.386+0000: 11842: error :
> qemuMonitorJSONCheckError:389 : internal error: unable to execute QEMU
> command 'nbd-server-add': Block node is read-only
> 
> I checked the images on source (active since the guest is runngin) and
> target (inactive and out of sync copies)
> source $ virsh domblklist kvmguest-artful-normal
> Target     Source
> ------------------------------------------------
> vda        /var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow
> vdb        /var/lib/uvtool/libvirt/images/kvmguest-artful-normal-ds.qcow
> 
> But when checking details on the source I didn't get any being blocked:
> qemu-img info --backing-chain
> /var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow
> qemu-img: Could not open
> '/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow': Failed to get
> shared "write" lock
> Is another process using the image?
> 
> On the target these are inactive, so the inquiry works (content is the same
> anyway).
> All files are there and the backing chain looks correct.
> 
> I'm not sure if being unable to qemu-img while running is considered an
> issue of its own, but this could be related to:
> (qemu) commit 244a5668106297378391b768e7288eb157616f64
> Author: Fam Zheng <famz@redhat.com>
>     file-posix: Add image locking to perm operations
> 
> 
> The add should be from libvirt
>  - the chain here should be
>    qemuMigrationPrepareAny -> qemuMigrationStartNBDServer ->
> qemuMonitorNBDServerAdd -> qemuMonitorJSONNBDServerAdd
>  - there is a debug statement in qemuMonitorNBDServerAdd
> VIR_DEBUG("deviceID=%s", deviceID);
>    This shows it is the nbd sevrer for the first disk
>  - seems libvirt adding a nbd server for the copy-storage-all
>  - that qmp fails in qemu
>  - afterwards all else in the logs is libvirt cleaning up and killing the
> qemu that was prepped (with -S) on
>    the target
> 
> With virt debug and gdb I catched the device for the qmp command and stop
> it while doing so.
> debug : qemuMonitorNBDServerStart:3993 : host=:: port=49153
> debug : qemuMonitorNBDServerStart:3995 : mon:0x7f6d4c016500
> vm:0x7f6d4c011580 json:1 fd:27
> debug : qemuMonitorNBDServerAdd:4006 : deviceID=drive-virtio-disk0
> debug : qemuMonitorNBDServerAdd:4008 : mon:0x7f6d4c016500 vm:0x7f6d4c011580
> json:1 fd:27
> [...]
> debug : qemuMonitorJSONCheckError:378 : unable to execute QEMU command
> {"execute":"nbd-server-add","arguments":{"device":"drive-virtio-disk0","writable":true},"id":"libvirt-24"}:
> {"id":"libvirt-24","error":{"class":"GenericError","desc":"Block node is
> read-only"}}
> 
> 
> Reducing the qemu call libvirt does to some basiscs that don't need libvirt
> I tried to reproduce.
> At the -S starting point that the migration uses just as well the devices
> are already there, going on in monitor from there:
> (qemu) info block
> drive-virtio-disk0 (#block164):
> /var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow (qcow2)
>     Attached to:      /machine/peripheral/virtio-disk0/virtio-backend
>     Cache mode:       writeback
>     Backing file:
> /var/lib/uvtool/libvirt/images/x-uvt-b64-Y29tLnVidW50dS5jbG91ZC5kYWlseTpzZXJ2ZXI6MTcuMTA6YW1kNjQgMjAxNzA4MTA=
> (chain depth: 1)
> 
> drive-virtio-disk1 (#block507):
> /var/lib/uvtool/libvirt/images/kvmguest-artful-normal-ds.qcow (qcow2)
>     Attached to:      /machine/peripheral/virtio-disk1/virtio-backend
>     Cache mode:       writeback
> 
> # starting the server
> (qemu) nbd_server_start 0.0.0.0:49153
> # This gave me a valid server
> tcp        0      0 0.0.0.0:49153           0.0.0.0:*               LISTEN
>      0          2328989    13593/qemu-system-x
> 
> # adding the disk
> (qemu) nbd_server_add -w drive-virtio-disk0
> Block node is read-only
> 
> Ok, so reproducible without libvirt on the receiving side.
> Simplifying that to a smaller test:
> 
> $ qemu-img create -f qcow2 /tmp/test.qcow2 100M
> $ qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor
> stdio -drive
> file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 -incoming
> defer
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
> [bit 5]
> nbd_server_start 0.0.0.0:49153
> (qemu) nbd_server_add -w drive-virtio-disk0
> Block node is read-only
> (qemu) quit
> 
> It might be reasonable to keep the -device section to specify how it is
> included.

This is actually caused by

commit 9c5e6594f15b7364624a3ad40306c396c93a2145
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Thu May 4 18:52:40 2017 +0200

    block: Fix write/resize permissions for inactive images

which forbids "nbd_server_add -w" in the "inactive" state set by -incoming.

But I'm not sure what is a proper fix. Maybe revert the bdrv_is_writable() part
of the commit? Kevin?

Fam
