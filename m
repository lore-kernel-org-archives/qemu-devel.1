Received: from eggs.gnu.org ([2001:4830:134:3::10]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8HuC-0000gY-UN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 23:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8Hu7-0006IT-Qm
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 23:35:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:60386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8Hu7-0006HN-Er
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 23:35:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8Hu6-00024g-1g
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 03:35:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 09B852E80C0
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 03:35:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 03:24:59 -0000
From: Bug Watch Updater <551545@bugs.launchpad.net>
Reply-To: Bug 551545 <551545@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100330095419.20764.2684.malonedeb@potassium.ubuntu.com>
Message-Id: <150916110455.5464.15607367794936686342.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 551545] Re: PXE netboot not booting localboot
 from virtio-disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 37 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D472236.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2008-11-19T15:07:54+00:00 James wrote:

Description of problem:

All QA automated systems rely on PXE local booting for proper
provisioning and testing.  All systems are configured in the BIOS to
boot PXE first.

When we want to provision the systems, we modify the PXE target (using
RHTS or now cobbler).

When we want to boot locally to run tests, we set the default PXE target
to "local".

KVM guests do no honor the PXE "local" target.  It seems that once you
boot PXE, KVM doesn't attach the already installed disks.

Version-Release number of selected component (if applicable):

kernel-2.6.27.5-113.fc10.x86_64
libvirt-0.4.6-3.fc10.x86_64
kvm-74-5.fc10.x86_64

How reproducible:

Every time.

Steps to Reproduce:
1. Set KVM guest PXE target to "Network Boot" using virt-manager
2. Boot the KVM guest.
3. In the PXE menu, type "local"
  =

Actual results:

 * See attached screenshot, xml, and libvirt logfile.

Expected results:

The system should behave as a "real" system behaves and boot the local
disk.

Additional info:

 * This makes adding KVM guests into test automation a bit funky since
we'll need to do a workaround which involves:

When you want to reprovision a guest:
 1) virsh destroy $GUEST
 2) virsh undefine $GUEST
 3) Edit xml to boot off network
 4) virsh define $XMLFILE
 5) virsh start $GUEST

We'd then need to repeat to have it boot to local disk.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/0

------------------------------------------------------------------------
On 2008-11-19T15:08:23+00:00 James wrote:

Created attachment 324048
Screenshot

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/1

------------------------------------------------------------------------
On 2008-11-19T15:08:44+00:00 James wrote:

Created attachment 324049
Guest XML configuration

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/2

------------------------------------------------------------------------
On 2008-11-19T15:09:06+00:00 James wrote:

Created attachment 324050
/var/log/libvirt/qemu/vguest2.log

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/3

------------------------------------------------------------------------
On 2008-11-19T15:25:27+00:00 Michael wrote:

Being able to boot KVM-via-PXE statefully would be highly useful for my
testing in Cobbler land as well, and would help with virtual deployment
(and re-deployment) of non-Linux guests.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/4

------------------------------------------------------------------------
On 2008-11-19T15:33:38+00:00 Daniel wrote:

The XML only specifies a single device for booting. Can you try setting
multiple devices

    <boot dev=3D'network'/>
    <boot dev=3D'cdrom'/>
    <boot dev=3D'hd'/>

Which should tell the BIOS to try to boot network, then cdrom, then
harddisk in that order.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/5

------------------------------------------------------------------------
On 2008-11-19T15:47:41+00:00 James wrote:

Using ...

  <os>
    <type arch=3D'x86_64' machine=3D'pc'>hvm</type>
    <boot dev=3D'network'/>
    <boot dev=3D'cdrom'/>
    <boot dev=3D'hd'/>
  </os>

Results in ...

# cat /var/log/libvirt/qemu/vguest2.log =

/usr/bin/qemu-kvm -S -M pc -m 1024 -smp 2 -name vguest2 -monitor pty -boot =
ndc -drive file=3D/dev/VolGroup00/vguest2,if=3Dvirtio,index=3D0,boot=3Don -=
net nic,macaddr=3D54:52:00:29:89:e5,vlan=3D0,model=3Dvirtio -net tap,fd=3D1=
6,script=3D,vlan=3D0,ifname=3Dvnet0 -serial pty -parallel none -usb -vnc 12=
7.0.0.1:1 -k en-us =

char device redirected to /dev/pts/3
char device redirected to /dev/pts/4
Too many option ROMS

Amy I doing that right?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/6

------------------------------------------------------------------------
On 2008-11-19T15:50:57+00:00 Cole wrote:

Wow! I didn't know you could specify multiple boot devs. Using

    <boot dev=3D'network'/>
    <boot dev=3D'hd'/>

And then pressing 'q' to not boot from networking successfully boots
from disk. James, try just the above and see if it does the job for you.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/7

------------------------------------------------------------------------
On 2008-11-19T16:13:53+00:00 Michael wrote:

Cole, what we are looking for is when the bootloader is fed the
following PXE configuration it should boot from the local disk:

DEFAULT local
PROMPT 0
TIMEOUT 0
TOTALTIMEOUT 0
ONTIMEOUT local

LABEL local
        LOCALBOOT 0


This will enable us to create a KVM "empty shell" that we can assign what O=
S it is running just based on changing the PXE configuration.

Pressing "q" would be interactive and less useful -- you'd have to catch
it really really quickly or you'd be reinstalling.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/8

------------------------------------------------------------------------
On 2008-11-19T16:18:52+00:00 James wrote:

(In reply to comment #7)
> Wow! I didn't know you could specify multiple boot devs. Using
> =

>     <boot dev=3D'network'/>
>     <boot dev=3D'hd'/>
> =

> James, try just the above and see if it does the job for you.

With those options in my XML ... my guest fails to start.

# virsh dumpxml vguest2 | grep -C2 "<boot"
  <os>
    <type arch=3D'x86_64' machine=3D'pc'>hvm</type>
    <boot dev=3D'network'/>
    <boot dev=3D'hd'/>
  </os>
  <features>

# virsh start vguest2
libvir: QEMU error : internal error QEMU quit during monitor startup
error: Failed to start domain vguest2

# tail /var/log/libvirt/qemu/vguest2.log =

/usr/bin/qemu-kvm -S -M pc -m 1024 -smp 2 -name vguest2 -monitor pty -boot =
nc -drive file=3D/dev/VolGroup00/vguest2,if=3Dvirtio,index=3D0,boot=3Don -n=
et nic,macaddr=3D54:52:00:29:89:e5,vlan=3D0,model=3Dvirtio -net tap,fd=3D12=
,script=3D,vlan=3D0,ifname=3Dvnet0 -serial pty -parallel none -usb -vnc 127=
.0.0.1:1 -k en-us =

char device redirected to /dev/pts/3
char device redirected to /dev/pts/4
Too many option ROMS

What am I missing?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/9

------------------------------------------------------------------------
On 2008-11-19T16:26:01+00:00 Cole wrote:

jlaska: hmm, works on F9. sounds like a bug.

mdehaan: you may just have to test it and see what happens. I let the
guest boot to our pxe server which doesn't seem to have an explicit
'local' option. Hitting enter without a selection seems to imply local,
but qemu then prompts for the boot from (n)etwork or (q)uit.

Maybe qemu is smart enough to notice a 'boot from local' directive from
the PXE server, and won't prompt. You'll just have to test it since I'm
not sure how to go about it.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/10

------------------------------------------------------------------------
On 2008-11-19T16:29:08+00:00 Michael wrote:

Cole, that's what james was trying to do above when he filed the bug,
and I watched it happen.

"""
KVM guests do no honor the PXE "local" target.  It seems that once you boot
PXE, KVM doesn't attach the already installed disks.
"""

What specifically should I test?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/11

------------------------------------------------------------------------
On 2008-11-19T16:40:55+00:00 Cole wrote:

I just wasn't sure if:

not entering a selection on my pxe server & pressing enter =3D=3D
deliberately selecting 'boot from local' on another pxe server =3D=3D having
the pxe server tell the machine/VM 'hey, boot from local' (which is what
I understand RHTS does).

If those are all equivalent, then it sounds like qemu needs fixing to
not prompt based on the pxe request.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/12

------------------------------------------------------------------------
On 2008-11-19T16:47:41+00:00 James wrote:

My take on this bug is that the F10 kvm/libvirt doesn't let me specify
multiple <boot> options.  If that were fixed, I suspect it would open
the door for PXE "local" booting.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/13

------------------------------------------------------------------------
On 2008-11-19T17:05:05+00:00 Daniel wrote:

Yes, this is a bug in KVM. The trouble is the new -drive flag and its
boot=3Don syntax is broken wrt to normal -boot arg. We need to use boot=3Don
for VirtIO based disks, but when we do that, then this conflicts with
the option ROM for PXE boot. This is a big mess and I'm not sure how to
fix it, but it certainly needs addressing somehow, because this is a
valid use case

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/14

------------------------------------------------------------------------
On 2008-11-26T05:36:24+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
10 development cycle.
Changing version to '10'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/15

------------------------------------------------------------------------
On 2008-11-26T13:24:49+00:00 Glauber wrote:

James,

Do you still have this problem if you switch from virtio to e1000?

You should use this XML excerpt:
    <boot dev=3D'network'/>
    <boot dev=3D'hd'/>

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/16

------------------------------------------------------------------------
On 2008-11-26T14:29:52+00:00 James wrote:

Created attachment 324720
vguest1.xml (w/ multiple <boot> and dev=3D"virtio")

Glauber,

Yeah, I still seem to have this problem using virtio.

# virsh start vguest1
libvir: QEMU error : internal error QEMU quit during monitor startup
error: Failed to start domain vguest1

# cat /var/log/libvirt/qemu/vguest1.log =

/usr/bin/qemu-kvm -S -M pc -m 1024 -smp 2 -name vguest1 -monitor pty -boot =
nc -drive file=3D/dev/VolGroup00/vguest1,if=3Dide,index=3D0,boot=3Don -driv=
e file=3D,if=3Dide,media=3Dcdrom,index=3D2 -net nic,macaddr=3D54:52:00:55:c=
8:17,vlan=3D0,model=3Dvirtio -net tap,fd=3D14,script=3D,vlan=3D0,ifname=3Dv=
net2 -serial pty -parallel none -usb -vnc 127.0.0.1:3 -k en-us =

char device redirected to /dev/pts/8
char device redirected to /dev/pts/9
Too many option ROMS

# virsh dumpxml vguest1
 <!-- see attachment -->

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/17

------------------------------------------------------------------------
On 2008-11-26T14:32:04+00:00 James wrote:

Created attachment 324721
vguest1.xml (w/ multiple <boot> and dev=3D"e1000")

Now with dev=3D"e1000"

# virsh start vguest1
libvir: QEMU error : internal error QEMU quit during monitor startup
error: Failed to start domain vguest1

# cat /var/log/libvirt/qemu/vguest1.log =

/usr/bin/qemu-kvm -S -M pc -m 1024 -smp 2 -name vguest1 -monitor pty -boot =
nc -drive file=3D/dev/VolGroup00/vguest1,if=3Dide,index=3D0,boot=3Don -driv=
e file=3D,if=3Dide,media=3Dcdrom,index=3D2 -net nic,macaddr=3D54:52:00:55:c=
8:17,vlan=3D0,model=3De1000 -net tap,fd=3D19,script=3D,vlan=3D0,ifname=3Dvn=
et2 -serial pty -parallel none -usb -vnc 127.0.0.1:3 -k en-us =

char device redirected to /dev/pts/8
char device redirected to /dev/pts/9
Too many option ROMS

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/18

------------------------------------------------------------------------
On 2008-11-26T17:57:58+00:00 Glauber wrote:

I believe the problem itself is very simple (although I don't really
know a good solution without thinking a little bit...)

there's only 64k of memory available for option roms, and the virtio rom
that ships with our packages is... 64k in size!. So after loading the
virtio PXE option rom, we're unable to keep loading option roms, in
particular, the extboot option rom we need to kick out virtio boots. ;-(

James said he could boot with an older rom I handled to him, which is 32k i=
n size,
and the problem os "Too many option ROMS" went away.

However, he was still unable to boot from the local target, despite of
the fact that he could do a local boot by pressing "q"

So we really have two problems in here:

The first one is that we cannot boot from our current virtio ROM,
because it is too large. We can try to quick fix it by building smaller
images. This should be a new BZ agains the etherboot package.

And the other, the fact that roms do not honor the local target. For
that, I believe we can keep using this BZ.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/19

------------------------------------------------------------------------
On 2008-11-26T18:35:06+00:00 James wrote:

(In reply to comment #19)
> So we really have two problems in here:
> =

> The first one is that we cannot boot from our current virtio ROM, because=
 it is
> too large. We can try to quick fix it by building smaller images. This sh=
ould
> be a new BZ agains the etherboot package.

Filed this as bug#473137

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/20

------------------------------------------------------------------------
On 2009-10-13T06:40:37+00:00 Mark wrote:

Apparently this is still a problem with gPXE:

http://www.redhat.com/archives/fedora-virt/2009-October/msg00052.html

Glauber - please take a look

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/21

------------------------------------------------------------------------
On 2010-03-09T16:54:05+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/22

------------------------------------------------------------------------
On 2010-03-09T17:19:54+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/23

------------------------------------------------------------------------
On 2010-03-15T12:09:58+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
13 development cycle.
Changing version to '13'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/24

------------------------------------------------------------------------
On 2010-05-21T10:43:31+00:00 Jan wrote:

Still problem on Fedora 13 final + updates testing. Any change to fix
this?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/32

------------------------------------------------------------------------
On 2010-05-21T10:56:35+00:00 Jan wrote:

I have some success to boot using PXE by booting manually. May be there
is too short default timeout for dhcp request. Try this:

1. start virtual machine
2. when you are prompted to press CTRL-B do it
3. try to get dhcp address running this command: dhcp net0
4. repeat step 3 until you do not get address (reply "ok")
5. boot using command: autoboot

If you run "dhcp net0" command immediatelly, it will fail fist time, but
second run gets IP address. Then I am able to boot from PXE.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/33

------------------------------------------------------------------------
On 2010-08-18T18:53:20+00:00 Jan wrote:

I think local boot works well on current fedora 13 stable. Do you still
have this problem?

But another problem described here (timeout to boot from PXE) is still
present. Should I open a new bug for this? Looks like it's enough to
increase PXE network timeout by aprox. 3 seconds. Most simpler
workaround is to select "Send Key -> Ctrl-Alt-Del" from menu
immediatelly (or after 1-3 seconds) after guest start.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/34

------------------------------------------------------------------------
On 2010-09-29T19:18:05+00:00 Michael wrote:

I'm still having this dhcp timeout issue on f13.

Opened https://bugzilla.redhat.com/show_bug.cgi?id=3D638735 to track it.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/36

------------------------------------------------------------------------
On 2011-06-02T18:23:57+00:00 Bug wrote:


This message is a reminder that Fedora 13 is nearing its end of life.
Approximately 30 (thirty) days from now Fedora will stop maintaining
and issuing updates for Fedora 13.  It is Fedora's policy to close all
bug reports from releases that are no longer maintained.  At that time
this bug will be closed as WONTFIX if it remains open with a Fedora =

'version' of '13'.

Package Maintainer: If you wish for this bug to remain open because you
plan to fix it in a currently maintained version, simply change the 'versio=
n' =

to a later Fedora version prior to Fedora 13's end of life.

Bug Reporter: Thank you for reporting this issue and we are sorry that =

we may not be able to fix it before Fedora 13 is end of life.  If you =

would still like to see this bug fixed and are able to reproduce it =

against a later version of Fedora please change the 'version' of this =

bug to the applicable version.  If you are unable to change the version, =

please add a comment here and someone will do it for you.

Although we aim to fix as many bugs as possible during every release's =

lifetime, sometimes those efforts are overtaken by events.  Often a =

more recent Fedora release includes newer upstream software that fixes =

bugs or makes them obsolete.

The process we are following is described here: =

http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/39

------------------------------------------------------------------------
On 2011-06-27T14:02:15+00:00 Bug wrote:


Fedora 13 changed to end-of-life (EOL) status on 2011-06-25. Fedora 13 is =

no longer maintained, which means that it will not receive any further =

security or bug fix updates. As a result we are closing this bug.

If you can reproduce this bug against a currently maintained version of =

Fedora please feel free to reopen this bug against that version.

Thank you for reporting this bug and we are sorry it could not be fixed.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/40

------------------------------------------------------------------------
On 2011-06-27T23:30:42+00:00 Shawn wrote:

Reopen, bump to rawhide, I haven't been able to test this recently.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/41

------------------------------------------------------------------------
On 2012-03-15T17:58:18+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/43

------------------------------------------------------------------------
On 2012-07-10T12:12:06+00:00 Cole wrote:

With virt-manager on F17 this works for me, you just need to make sure
that both network and harddrive boot options are selected, otherwise the
disks aren't marked as bootable and things probably won't work.

Closing as WORKSFORME, please reopen if anyone still has issues on F17+

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/44

------------------------------------------------------------------------
On 2012-07-24T18:20:01+00:00 Renich wrote:

Created attachment 600144
no prompt

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/45

------------------------------------------------------------------------
On 2012-07-24T18:20:48+00:00 Renich wrote:

it seems it's not even prompting for ipxe now. I think something got
hardcoded into the rom by accident.

Can somebody verify?

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/46

------------------------------------------------------------------------
On 2012-07-24T19:15:23+00:00 Cole wrote:

Renich, given how old and long this bug report is, let's keep it closed.
If you are still experiencing a similar issue, please open a new bug
report with the following info:

Fedora version
qemu version
qemu command line (if using libvirt, /var/log/libvirt/qemu/$vmname.log)


At least on F17, PXE and boot from local is working fine for me.

Reply at: https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/551545/comments/47


** Changed in: qemu-kvm (Fedora)
       Status: Unknown =3D> Invalid

** Changed in: qemu-kvm (Fedora)
   Importance: Unknown =3D> Medium

** Bug watch added: Red Hat Bugzilla #638735
   https://bugzilla.redhat.com/show_bug.cgi?id=3D638735

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/551545

Title:
  PXE netboot not booting localboot from virtio-disk

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Fedora:
  Invalid

Bug description:
  Binary package hint: qemu-kvm

  lsb_release -rd
  Description:	Ubuntu lucid (development branch)
  Release:	10.04

  apt-cache policy qemu-kvm
  qemu-kvm:
    Installiert: 0.12.3+noroms-0ubuntu3
    Kandidat: 0.12.3+noroms-0ubuntu3
    Versions-Tabelle:
   *** 0.12.3+noroms-0ubuntu3 0
          500 http://intranet/ubuntu/ lucid/main Packages
          100 /var/lib/dpkg/status

  Description of the problem:

  Starting a guest like this:

  vdekvm \
    -m 256M \
    -cpu host \
    -smp 1 \
    -name karmic \
    -boot order=3Dnc \
    -drive file=3D/dev/vg01/test,if=3Dvirtio,boot=3Don,cache=3Dnone \
    -net nic,vlan=3D0,macaddr=3D00:2f:8d:b6:cf:d0,model=3Dvirtio \
    -net vde,vlan=3D0,sock=3D/var/run/vde2/vde0.ctl \
    -watchdog i6300esb \
    -vnc :0 \
    -serial telnet:localhost:23,server,nowait \
    -monitor tcp:127.0.0.1:12000,server,nowait \
    -runas kvmguest

  On "telnet localhost" you can see that the following boot-menu
  appears:

  - Boot Menu -
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  local
  rescue

  It is loaded from this pxelinux.cfg/default file:

  SERIAL 0 9600n8

  DISPLAY boot.txt

  TIMEOUT 120
  DEFAULT local
  PROMPT 1

  LABEL local
  	localboot 0

  LABEL rescue
  	kernel lucid
  	append initrd=3Dlucid-initrd.gz rescue/enable=3Dtrue -- quiet console=3D=
ttyS0,9600n8

  =

  After the timeout, the guest tries to boot, but fails and reloads the boo=
t menu. This is an endless loop, until I break it or choose the rescue menu=
 entry.

  I would expect that it boots from first virtio-disk

  ProblemType: Bug
  DistroRelease: Ubuntu 10.04
  Package: qemu-kvm 0.12.3+noroms-0ubuntu3
  ProcVersionSignature: Ubuntu 2.6.32-18.27-generic 2.6.32.10+drm33.1
  Uname: Linux 2.6.32-18-generic x86_64
  Architecture: amd64
  Date: Tue Mar 30 11:40:59 2010
  ExecutablePath: /usr/bin/qemu-system-x86_64
  MachineType: MICRO-STAR INTERANTIONAL CO.,LTD MS-7368
  ProcCmdLine: root=3DUUID=3D0d27271c-feaa-40d9-bbbd-baff4ca1d3cc rw init=
=3D/bin/bash
  ProcEnviron:
   LANG=3Dde_DE.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: qemu-kvm
  dmi.bios.date: 10/31/2007
  dmi.bios.vendor: American Megatrends Inc.
  dmi.bios.version: V1.5B2
  dmi.board.asset.tag: To Be Filled By O.E.M.
  dmi.board.name: MS-7368
  dmi.board.vendor: MICRO-STAR INTERANTIONAL CO.,LTD
  dmi.board.version: 1.0
  dmi.chassis.asset.tag: To Be Filled By O.E.M.
  dmi.chassis.type: 3
  dmi.chassis.vendor: To Be Filled By O.E.M.
  dmi.chassis.version: To Be Filled By O.E.M.
  dmi.modalias: dmi:bvnAmericanMegatrendsInc.:bvrV1.5B2:bd10/31/2007:svnMIC=
RO-STARINTERANTIONALCO.,LTD:pnMS-7368:pvr1.0:rvnMICRO-STARINTERANTIONALCO.,=
LTD:rnMS-7368:rvr1.0:cvnToBeFilledByO.E.M.:ct3:cvrToBeFilledByO.E.M.:
  dmi.product.name: MS-7368
  dmi.product.version: 1.0
  dmi.sys.vendor: MICRO-STAR INTERANTIONAL CO.,LTD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/551545/+subscriptions
