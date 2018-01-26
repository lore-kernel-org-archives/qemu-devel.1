Received: from eggs.gnu.org ([2001:4830:134:3::10]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ef5VG-0003cs-2V
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ef5VA-0005VB-N5
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:18 -0500
Received: from indium.canonical.com ([91.189.90.7]:58606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ef5VA-0005UO-Ff
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:01:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ef5V9-0006Z9-DB
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 15:01:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54B812E8550
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 15:01:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jan 2018 14:51:34 -0000
From: David Lindsay <asmqb7@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
Message-Id: <151697829435.7573.12786947158980567417.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot from
 qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi John & others:

(3 separate things.)

1: Image formats

Regarding qcow, unfortunately there is no change if I use this format.

- Windows 3.1 initially hung at "Starting MS-DOS..."; upon restart it
crashed when it decided it couldn't find COMMAND.COM (a frequent failure
mode I forgot to mention).

- NT initially crashed with one of its famous disk read errors. Of
course.

- After the initial NT crash, repeated QEMU reloads began showing the
boot menu rather consistently, so I pointed my test harness to the qcow
image. Of course, it crashed on the first try in the test harness :),
then launched successfully 42 times before crashing again. This sort of
behavior is pretty consistent with what happened with raw images.

I just did 77 runs with commit 306ec6c and the qcow image worked just as
well as the raw image did.

One thing. I converted my raw disk images to qcow so I could test and
reply somewhat more quickly. (Just stumbled on the new activity in the
thread after manually checking a couple hours ago, glad I did!. I'm
actually subscribed now :) )

It could be strongly argued that I should create _new_ disk images. But
my three counter-arguments are that

 a) the storage format shouldn't influence the guest.
 b) I exhaustively tested the bisection point I found, and the "before" sta=
te is absolutely rock solid. I'd say I've tested 450+ consecutive good runs=
 without any hitches at this point - the 350 runs I documented, and a hundr=
ed or so more that I did before that.
 c) it could be very well argued that QEMU-level errors have left corruptio=
n in the disk image. My argument here is to reiterate (b).

If anyone wants to strongly argue for creating new images, I can try
that. *resigned grumble*

Also... is qcow working stably for you, with no issues? If it is I'm
very fascinated to hear that.

And - you're using `-M isapc`, right? I find that if I don't, NT will
hit a STOP error pretty much instantaneously (within the first few
fractions of a second after it's obvious the kernel has initialized).

---

2: Bitness

The few error messages I saw in your build failure hinted at 64-bit
incompatibility.

Well... I was able, at length, to get QEMU to build for 32-bit. It
mostly boiled down to careful analysis of config-host.mak, removing -m64
and substituting -m32, and poking {C,LD}FLAGS until it compiled.

As I noted in the other thread, the built QEMU had a 100% broken TCG and
required some form of hardware acceleration to even start correctly. In
my case this was KVM.

Oh, also, on the subject of compilation - this isn't bitness-related,
but QEMU's Makefiles accept the standard `V=3D2` for verbose build that
shows the compilation commands. I'd imagine the result would probably be
best attached as a file. I have no idea if this information will be
useful to the QEMU developers.

---

3: Bisection

I initially thought to cram this info somewhere in the I/O report but
decided against it due to that post's final length. But it could be
relevant here.

Here's the approach I used to rapidly bounce back and forth and in
search of the before-and-after "edges". I used this for the I/O issues
discussed here and also for another issue
(https://bugs.launchpad.net/qemu/+bug/1745316), and if you feel like it,
you could use this to track down why the older QEMU versions are not
building on OS X.

This could be worth it - the fixes could be minimal and a hacky "good
enough" backport could be viable, or this may just end up confirming
that the breakage was major.

I'll just document the exact workflow I used.

First, I created a new base directory somewhere, to hold all the subdirs
with branches I'd be testing.

Next, I switched to the dir with the qemu git checkout, and:

$ git rev-list 306ec6c3cece7004429c79c1ac93d49919f1f1cc..master | tac |
nl -n ln > /path/to/basedir/branchlist.txt

$ Now for the wince part:

$ wc -l branchlist.txt
28734

Wooooo!
(...not.)

[Note: I'm using a fractionally old local clone. That number, and all
the numbers below, are likely going to be slightly bigger.]

Now, define this function (my interactive sessions use bash, this may
work with zsh/others):

$ z() { n=3D"$1"; b=3D"$(grep "^$n[^0-9]" /path/to/basedir/branchlist.txt |
cut -d$'\t' -f2)"; sb=3D"${b:0:7}"; d=3D"/path/to/basedir/$n-$sb/"; mkdir
"$d"; git archive "$b" | tar xC "$d"; }

Now, you can just do something like

$ z 14367

and then, in a separate terminal, you can cd over to the newly-created
/path/to/basedir/14367-1bfa316/, and configure and build it.

The function just lets you refer to the commits by number as you work,
which makes it much easier (indeed, possible at all) to select which
commit to build, and also keep track of where you're up to.

NOTE: The `tac` in the line that generated branchlist.txt means that
commit 1 will be older than commit 28734. Smaller numbers go back in
time, which makes sense to me. For opposite behavior remove the `tac`.

The number in the `z` line above is 28734/2, ie, this jumps straight
into the middle of the list. (Of (obvious) note is that the generated
list does not represent _all_ the commits.) If that commit fails to
build, you might jump back by half, eg 7184. If that one works, you
might jump forward by half, or 21550.

It's kind of meditative... but it does get irritating toward the end
when you're jumping forward by 30... then back by 7... then forward by
3... (like an annoying padlock!)

(I can strongly recommend keeping notes of which builds worked and which
didn't. I totally didn't jump in the wrong direction a few times...)

If you're so inclined, you could probably wrap all of this into a bit of
automation. `make`'s return code is admittedly much much easier to
script off of than hooking up a test harness to do a bunch of automated
runs and deciding for itself whether it produced a fail or pass. Or (in
the case of the other bug I found), testing mouse movements. For these
reasons it was much easier for me to use this workflow manually.

Even with a starting list of nearly 30k commits, this works
exponentially at best, and better-than-exponentially if you decide to
arbitrarily jump back or forward by more than half. So while this isn't
a 10-minute job, it _shouldn't_ take all day, either.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737194

Title:
  Windows NT 4.0 fails to boot from qcow2 installation

Status in QEMU:
  New

Bug description:
  Windows NT 4.0 will not boot from an installation more than once if
  installed in a qcow2 image file. A quick fix to this problem is to use
  the qcow format instead.

  Steps to reproduce this issue:

  Create the image file:
  qemu-img create -f qcow2 winnt4.qcow2 1G

  Boot from a Windows NT 4.0 Workstation CD:
  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu =
pentium -vga cirrus

  During the installation process you have the choise between FAT and
  NTFS. You can pick anyone.

  After finishing the installation the guest will reboot to install
  additional items. Once this is done the guest will be bootable. Eject
  any CD media from QEMU and reboot. You will then see Windows NT 4.0
  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
  when Windows is ready quit QEMU.

  Now try to boot using this command:
  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirru=
s =

   =

  The BIOS screen will display an error message:

  For NTFS: =

  Booting from Hard Disk...
  A disk read error occurred.
  Insert a system diskette and restart
  the system.

  For FAT:
  No bootable device.

  Additional information:
  qemu-system-i386 version: 2.10.1
  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

  If you don't have a Windows NT 4.0 Workstation installation CD, you may d=
ownload one from here:
  https://winworldpc.com/product/windows-nt-40/40

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions
