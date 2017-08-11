Received: from eggs.gnu.org ([2001:4830:134:3::10]:37884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dg7nN-00068h-2y
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dg7nK-0007P2-76
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:01 -0400
Received: from mail-yw0-x22e.google.com ([2607:f8b0:4002:c05::22e]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dg7nJ-0007Nc-TV
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:07:58 -0400
Received: by mail-yw0-x22e.google.com with SMTP id s143so20272187ywg.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 04:07:55 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 11 Aug 2017 13:07:24 +0200
Message-ID: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] migration issue with qemu 2.10-rc2: QEMU command
 'nbd-server-add': Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

Hi,
testing on 2.10-rc2 I ran into an issue around:
  unable to execute QEMU command 'nbd-server-add': Block node is read-only

### TL;DR ###
- triggered by livbirt driven live migration with --copy-storage-all
- buils down to nbd_server_add failing
- can be reproduced on a single system without libvirt
- last known working (so far) was qemu 2.8

Simple repro:
$ qemu-img create -f qcow2 /tmp/test.qcow2 100M
$ qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor
stdio -drive
file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 -incoming
defer
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
[bit 5]
nbd_server_start 0.0.0.0:49153
(qemu) nbd_server_add -w drive-virtio-disk0
Block node is read-only

### Details ###

Trigger:
virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh://
10.22.69.61/system

Setup:
- Two systems without shared storage
- An equal image is synced before the test, so it would only migrate
minimal remaining changes
=> Only the --copy-storage-all case triggers this, other migrations work as
far as I tested.
=> No related apparmor denials

The last combination I knew to be successful was libvirt 3.5 and qemu 2.8.
So I Downgraded libvirt (but kept qemu) and retest.
=> Still an issue
=> So it is a qemu 2.10 issue and not libvirt 3.6
Continuing with libvirt 3.6 to have latest updates.

On the migration target I see the following in the log:
libvirtd[11829]: 2017-08-11 08:51:49.283+0000: 11842: warning :
qemuDomainObjTaint:4545 : Domain id=2 name='kvmguest-artful-normal'
uuid=b6f4cdab-77b0-43b1-933d-9683567f3a89 is tainted: high-privileges
libvirtd[11829]: 2017-08-11 08:51:49.386+0000: 11842: error :
qemuMonitorJSONCheckError:389 : internal error: unable to execute QEMU
command 'nbd-server-add': Block node is read-only

I checked the images on source (active since the guest is runngin) and
target (inactive and out of sync copies)
source $ virsh domblklist kvmguest-artful-normal
Target     Source
------------------------------------------------
vda        /var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow
vdb        /var/lib/uvtool/libvirt/images/kvmguest-artful-normal-ds.qcow

But when checking details on the source I didn't get any being blocked:
qemu-img info --backing-chain
/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow
qemu-img: Could not open
'/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow': Failed to get
shared "write" lock
Is another process using the image?

On the target these are inactive, so the inquiry works (content is the same
anyway).
All files are there and the backing chain looks correct.

I'm not sure if being unable to qemu-img while running is considered an
issue of its own, but this could be related to:
(qemu) commit 244a5668106297378391b768e7288eb157616f64
Author: Fam Zheng <famz@redhat.com>
    file-posix: Add image locking to perm operations


The add should be from libvirt
 - the chain here should be
   qemuMigrationPrepareAny -> qemuMigrationStartNBDServer ->
qemuMonitorNBDServerAdd -> qemuMonitorJSONNBDServerAdd
 - there is a debug statement in qemuMonitorNBDServerAdd
VIR_DEBUG("deviceID=%s", deviceID);
   This shows it is the nbd sevrer for the first disk
 - seems libvirt adding a nbd server for the copy-storage-all
 - that qmp fails in qemu
 - afterwards all else in the logs is libvirt cleaning up and killing the
qemu that was prepped (with -S) on
   the target

With virt debug and gdb I catched the device for the qmp command and stop
it while doing so.
debug : qemuMonitorNBDServerStart:3993 : host=:: port=49153
debug : qemuMonitorNBDServerStart:3995 : mon:0x7f6d4c016500
vm:0x7f6d4c011580 json:1 fd:27
debug : qemuMonitorNBDServerAdd:4006 : deviceID=drive-virtio-disk0
debug : qemuMonitorNBDServerAdd:4008 : mon:0x7f6d4c016500 vm:0x7f6d4c011580
json:1 fd:27
[...]
debug : qemuMonitorJSONCheckError:378 : unable to execute QEMU command
{"execute":"nbd-server-add","arguments":{"device":"drive-virtio-disk0","writable":true},"id":"libvirt-24"}:
{"id":"libvirt-24","error":{"class":"GenericError","desc":"Block node is
read-only"}}


Reducing the qemu call libvirt does to some basiscs that don't need libvirt
I tried to reproduce.
At the -S starting point that the migration uses just as well the devices
are already there, going on in monitor from there:
(qemu) info block
drive-virtio-disk0 (#block164):
/var/lib/uvtool/libvirt/images/kvmguest-artful-normal.qcow (qcow2)
    Attached to:      /machine/peripheral/virtio-disk0/virtio-backend
    Cache mode:       writeback
    Backing file:
/var/lib/uvtool/libvirt/images/x-uvt-b64-Y29tLnVidW50dS5jbG91ZC5kYWlseTpzZXJ2ZXI6MTcuMTA6YW1kNjQgMjAxNzA4MTA=
(chain depth: 1)

drive-virtio-disk1 (#block507):
/var/lib/uvtool/libvirt/images/kvmguest-artful-normal-ds.qcow (qcow2)
    Attached to:      /machine/peripheral/virtio-disk1/virtio-backend
    Cache mode:       writeback

# starting the server
(qemu) nbd_server_start 0.0.0.0:49153
# This gave me a valid server
tcp        0      0 0.0.0.0:49153           0.0.0.0:*               LISTEN
     0          2328989    13593/qemu-system-x

# adding the disk
(qemu) nbd_server_add -w drive-virtio-disk0
Block node is read-only

Ok, so reproducible without libvirt on the receiving side.
Simplifying that to a smaller test:

$ qemu-img create -f qcow2 /tmp/test.qcow2 100M
$ qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor
stdio -drive
file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 -incoming
defer
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
[bit 5]
nbd_server_start 0.0.0.0:49153
(qemu) nbd_server_add -w drive-virtio-disk0
Block node is read-only
(qemu) quit

It might be reasonable to keep the -device section to specify how it is
included.
Finally dropping -incoming defer makes a difference in the error message:

qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor stdio
-drive file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0
-device
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
[bit 5]
info block
drive-virtio-disk0 (#block163): /tmp/test.qcow2 (qcow2)
    Attached to:      /machine/peripheral/virtio-disk0/virtio-backend
    Cache mode:       writeback
(qemu) nbd_server_start 0.0.0.0:49153
(qemu) nbd_server_add -w drive-virtio-disk0
Conflicts with use by drive-virtio-disk0 as 'root', which does not allow
'write' on #block163

Without -incoming defer in strace I see:
[pid 13720] fcntl(14, F_OFD_SETLK, {l_type=F_RDLCK, l_whence=SEEK_SET,
l_start=203, l_len=1}) = 0
[pid 13720] fcntl(14, F_OFD_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET,
l_start=204, l_len=1}) = 0
[pid 13720] writev(1, [{iov_base="Conflicts with use by drive-virt"...,
iov_len=95}], 1) = 95
Which makes me even more suspicious about the patch initially mentioned.

With -incoming defer set it seems to check things via a signalfd and then
give up on the "Block node is read-only"
[pid 13750] readv(0, [{iov_base="\33", iov_len=1}], 1) = 1
[pid 13750] ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7,
events=POLLIN}, {fd=10, events=POLLIN}, {fd=11, events=POLLIN}, {fd=15,
events=POLLIN}], 6, {tv_sec=47226, tv_nsec=197570000}, NULL, 8) = 1
([{fd=0, revents=POLLIN}], left {tv_sec=47226, tv_nsec=197566613})
[pid 13750] readv(0, [{iov_base="[", iov_len=1}], 1) = 1
[pid 13750] ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7,
events=POLLIN}, {fd=10, events=POLLIN}, {fd=11, events=POLLIN}, {fd=15,
events=POLLIN}], 6, {tv_sec=47226, tv_nsec=197134000}, NULL, 8) = 1
([{fd=0, revents=POLLIN}], left {tv_sec=47226, tv_nsec=197130643})
[pid 13750] readv(0, [{iov_base="A", iov_len=1}], 1) = 1
[pid 13750] writev(1, [{iov_base="nbd_server_add -w drive-virtio-d"...,
iov_len=39}], 1) = 39
[pid 13750] ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7,
events=POLLIN}, {fd=10, events=POLLIN}, {fd=11, events=POLLIN}, {fd=15,
events=POLLIN}], 6, {tv_sec=47226, tv_nsec=196721000}, NULL, 8) = 1
([{fd=0, revents=POLLIN}], left {tv_sec=47225, tv_nsec=589631744})
[pid 13750] readv(0, [{iov_base="\r", iov_len=1}], 1) = 1
[pid 13750] writev(1, [{iov_base="\r\n", iov_len=2}], 1) = 2
[pid 13750] writev(1, [{iov_base="Block node is read-only\r\n",
iov_len=25}], 1) = 25

The last qemu I had around was a 2.8 where this works still fine.
If needed I might go bisecting but I have the feeling that I provided
enough data for the experts to easily "spot" it - so holding back the
bisect effort until needed.


-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
