Received: from eggs.gnu.org ([2001:4830:134:3::10]:33929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7wpi-0006rK-Ko
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7wpf-0006nd-0b
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:05:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:42426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7wpe-0006li-MP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:05:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7wpd-00022b-6a
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 05:05:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2CF822E8033
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 05:05:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 04:53:56 -0000
From: Bug Watch Updater <905095@bugs.launchpad.net>
Reply-To: Bug 905095 <905095@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111216034019.820.57755.malonedeb@wampee.canonical.com>
Message-Id: <150908003764.6401.8123573446343191620.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 905095] Re: qemu-img can't convert vmdk file:
 Operation not permitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 15 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D548723.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2009-12-18T11:36:07+00:00 Richard wrote:

Description of problem:

qemu-img convert cannot convert a VMDK4 format file to (eg) raw (or
anything else).  It silently produces a large file that mostly
contains zero bytes, and is completely unusable.

Version-Release number of selected component (if applicable):

Tested with qemu-img 0.10.5, 0.11.0, and
git d9a50a366f2178 (2009-12-11).

How reproducible:

Always.

Steps to Reproduce:
1. Export to OVF from VMWare vSphere / ESX 4.0.0.
2. Copy the resultant disk image to a Fedora machine.
3. Check the SHA1 sums (from *.mf file) to make sure image was not
   corrupted during the copy.
4. Run:
     qemu-img convert -O raw TestLinux-disk1.vmdk TestLinux-disk1.raw
5. Try to mount / use the resulting raw file, eg. using guestfish.
  =

Actual results:

The raw file contains mostly zeroes, see below.  It contains zeroes
where there should be partition tables, superblocks etc. and so is
totally unusable.

Expected results:

A usable disk image.

Additional info:

Compare the entropy of the VMDK file with the resulting raw disk.
I would expect the entropy to be about the same, but you can see the
raw disk is mostly compressible (zeroes).

  $ ls -l TestLinux-disk1.vmdk
  -rw-rw-r--  1 rjones rjones  887312896 2009-12-18 10:35 TestLinux-disk1.v=
mdk
  $ gzip -c TestLinux-disk1.vmdk | wc -c
  860846320
  $ gzip -c TestLinux-disk1.raw | wc -c
  8744715

VMWare's OVF metadata says the following about the disk format:

  <References>
    <File ovf:href=3D"TestLinux-disk1.vmdk"
          ovf:id=3D"file1" ovf:size=3D"887312896" />
  </References>
  <DiskSection>
    <Info>Virtual disk information</Info>
    <Disk ovf:capacity=3D"8"
          ovf:capacityAllocationUnits=3D"byte * 2^30"
          ovf:diskId=3D"vmdisk1" ovf:fileRef=3D"file1"
          ovf:format=3D"http://www.vmware.com/interfaces/specifications/vmd=
k.html#streamOptimized" />
  </DiskSection>

qemu-img 0.10.5 fails in a different way.  It gives the error
message:

  qemu-img: error while reading

qemu-img >=3D 0.11.0 fail silently, no error message or error code.

I've tried this with several disk images exported from vSphere 4
and they have all failed to convert in the same way.

Test files (at time of writing these are STILL UPLOADING, with ETA
of 2009-12-19).

http://homes.merjis.com/~rich/TestLinux-disk1.vmdk
  SHA1: 2C81BAE89210B075ACC51DA9D025935470149D55
http://homes.merjis.com/~rich/TestLinux.ovf
  SHA1: 30831689B8C6F1B1A1FCBB728769B5F71056A580

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/0

------------------------------------------------------------------------
On 2010-03-09T16:53:51+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/1

------------------------------------------------------------------------
On 2010-03-09T17:19:45+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/2

------------------------------------------------------------------------
On 2010-03-11T19:25:48+00:00 Justin wrote:

You don't happen to know if this reproduces with qemu-img > 0.12.x or
have a test image I can convert to reproduce handy?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/3

------------------------------------------------------------------------
On 2010-03-11T22:04:16+00:00 Richard wrote:

Nothing much has changed in the qemu vmdk block
driver since I looked at it before (I just checked upstream
git), so it's very likely to be still broken.

I have some VMDK images, but I warn you that they
are very large!  If you have somewhere I can upload
them to, I can send some your way ...

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/4

------------------------------------------------------------------------
On 2010-03-15T13:36:49+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
13 development cycle.
Changing version to '13'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/5

------------------------------------------------------------------------
On 2011-03-23T12:40:49+00:00 Richard wrote:

I just checked upstream git for the driver again,
and apart from code cleanups the code is still the
same as ever.  Therefore moving the bug -> Rawhide.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/6

------------------------------------------------------------------------
On 2011-04-18T10:55:16+00:00 Richard wrote:

Updated links:
http://oirase.annexia.org/tmp/TestLinux-disk1.vmdk                         =
     =

  SHA1: 2c81bae89210b075acc51da9d025935470149d55                           =
     =

http://oirase.annexia.org/tmp/TestLinux.ovf                                =
     =

  SHA1: 30831689b8c6f1b1a1fcbb728769b5f71056a580

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/7

------------------------------------------------------------------------
On 2011-04-18T11:02:12+00:00 Richard wrote:

Latest qemu-img no longer silently converts to zeroes.  Instead
it gives a strange error:

$ qemu-img convert -f vmdk -O raw TestLinux-disk1.vmdk TestLinux-disk1.raw
qemu-img: Could not open 'TestLinux-disk1.vmdk': Operation not permitted
qemu-img: Could not open 'TestLinux-disk1.vmdk'

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/8

------------------------------------------------------------------------
On 2011-04-18T11:10:33+00:00 Daniel wrote:

> qemu-img: Could not open 'TestLinux-disk1.vmdk': Operation not
permitted

This is probably because qemu-img.c code expects  brdv_open() to return
an errno value

    ret =3D bdrv_open(bs, filename, flags, drv);
    if (ret < 0) {
        error_report("Could not open '%s': %s", filename, strerror(-ret));
        goto fail;
    }

while the vmdk_open function just returns -1 for everything:

   ...
    return 0;
 fail:
    qemu_free(s->l1_backup_table);
    qemu_free(s->l1_table);
    qemu_free(s->l2_cache);
    return -1;
}

and by coincidence, '1 =3D=3D EPERM'.  There are ~4 codepaths in vmdk_open
that could fail, the VMDK magic check and then a couple of reads of
metadata

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/9

------------------------------------------------------------------------
On 2011-06-14T22:01:16+00:00 Richard wrote:

There is hope:
http://lists.gnu.org/archive/html/qemu-devel/2011-05/msg03130.html
http://lists.gnu.org/archive/html/qemu-devel/2011-06/threads.html#00033

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/10

------------------------------------------------------------------------
On 2012-02-17T09:02:03+00:00 yuping wrote:

The vmdk from "Export as OVF..." doesn't work.
# qemu-img convert -O raw esx4.1-rhel5.7-i386-disk1.vmdk test-vmdk.raw
qemu-img: Could not open 'esx4.1-rhel5.7-i386-disk1.vmdk'
qemu-img: Could not open 'esx4.1-rhel5.7-i386-disk1.vmdk'

I copied a vmdk file from ESX storage directly,and then use qemu-img to con=
vert it to raw,it works.
# qemu-img convert -O raw esx4.1-rhel5.7-i386-flat.vmdk test-vmdk.raw
# ll test-vmdk.raw =

-rw-r--r--. 1 root root 8589934592 Feb 17 16:58 test-vmdk.raw

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/18

------------------------------------------------------------------------
On 2012-02-17T09:43:15+00:00 Richard wrote:

(In reply to comment #11)
> I copied a vmdk file from ESX storage directly,and then use qemu-img to c=
onvert
> it to raw,it works.
> # qemu-img convert -O raw esx4.1-rhel5.7-i386-flat.vmdk test-vmdk.raw
> # ll test-vmdk.raw =

> -rw-r--r--. 1 root root 8589934592 Feb 17 16:58 test-vmdk.raw

*-flat.vmdk files are not VMDK.  They are just raw files
which happen to have a .vmdk extension.  So this doesn't
really prove anything.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/19

------------------------------------------------------------------------
On 2012-03-15T17:58:28+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/20

------------------------------------------------------------------------
On 2012-12-14T23:30:18+00:00 Cole wrote:

This bug has lingered for forever, so I don't think tracking this in
Fedora is going to solve much.

Rich, if you can still reproduce this with qemu.git, I'd recommend
filing an upstream bug and publishing a reproducer image like you did
before.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/905095/comments/27


** Changed in: qemu-kvm (Fedora)
       Status: Unknown =3D> Won't Fix

** Changed in: qemu-kvm (Fedora)
   Importance: Unknown =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/905095

Title:
  qemu-img can't convert vmdk file: Operation not permitted

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Fedora:
  Won't Fix

Bug description:
  There is no reason why the vdmk image can't be converted. Even running
  it as root does not help.

  $ ls -lh
  insgesamt 60G
  -rw-rw-rw- 1 root   root   479M 2011-09-10 17:47 freetz-linux-1.2.1-disk1=
.vmdk

  $ sudo qemu-img convert freetz-linux-1.2.1-disk1.vmdk -O raw /tmp/freetz-=
linux-1.2.1-disk1.raw
  qemu-img: Could not open 'freetz-linux-1.2.1-disk1.vmdk': Operation not p=
ermitted
  qemu-img: Could not open 'freetz-linux-1.2.1-disk1.vmdk'

  I get a similar Error when I try to rum vmdk images directly. After addin=
g a new machine and adding vmdk disks with virt-manager, it tells me when I=
 start the virtual machine:
  Error starting domain: internal error process exited while connecting to =
monitor: char device redirected to /dev/pts/1
  kvm: -drive file=3D/var/lib/libvirt/images/freetz-linux-1.2.1-disk1.vmdk,=
if=3Dnone,id=3Ddrive-virtio-disk0,boot=3Don,format=3Dqcow2: could not open =
disk image /var/lib/libvirt/images/freetz-linux-1.2.1-disk1.vmdk: Invalid a=
rgument

  Runnung raw images works perfectly for me.

  Hint: i have a symlink set:
  /var/lib/libvirt$ ls -lh
  insgesamt 12K
  drwxr-xr-x 2 root         root 4,0K 2011-07-26 14:30 boot
  lrwxrwxrwx 1 root         root    9 2011-08-19 10:47 images -> /home/vms
  drwxr-xr-x 2 root         root 4,0K 2011-08-19 09:38 network
  drwxr-xr-x 5 libvirt-qemu kvm  4,0K 2011-12-16 04:34 qemu

  but this should not be the reason hopefully

  ProblemType: Bug
  DistroRelease: Ubuntu 11.04
  Package: qemu-kvm 0.14.0+noroms-0ubuntu4.4
  ProcVersionSignature: Ubuntu 2.6.38-13.52-generic 2.6.38.8
  Uname: Linux 2.6.38-13-generic x86_64
  Architecture: amd64
  CheckboxSubmission: 8f12e98536291f59719792d89958b124
  CheckboxSystem: d00f84de8a555815fa1c4660280da308
  Date: Fri Dec 16 04:24:10 2011
  InstallationMedia: Ubuntu 10.04.1 LTS "Lucid Lynx" - Release amd64 (20100=
816.1)
  KvmCmdLine: Error: command ['ps', '-C', 'kvm', '-F'] failed with exit cod=
e 1: UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
  MachineType: Dell Inc. Latitude E5510
  ProcEnviron:
   LANGUAGE=3Dde_DE:en
   PATH=3D(custom, user)
   LANG=3Dde_DE.UTF-8
   SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-2.6.38-13-generic root=3DUU=
ID=3D503213e4-5136-4e60-8a02-7cbd0123dca8 ro quiet splash vt.handoff=3D7
  SourcePackage: qemu-kvm
  UpgradeStatus: Upgraded to natty on 2011-08-18 (119 days ago)
  dmi.bios.date: 09/08/2011
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: A11
  dmi.board.name: 023HKR
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 9
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvrA11:bd09/08/2011:svnDellInc.:pnLatitudeE=
5510:pvr0001:rvnDellInc.:rn023HKR:rvrA00:cvnDellInc.:ct9:cvr:
  dmi.product.name: Latitude E5510
  dmi.product.version: 0001
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/905095/+subscriptions
