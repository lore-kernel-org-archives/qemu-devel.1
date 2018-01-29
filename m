Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9d5-0004Nb-R9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9cz-00036d-N2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:37:47 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:50831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9cz-00035L-0t
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:37:41 -0500
Received: by mail-wm0-x233.google.com with SMTP id f71so14297352wmf.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:37:40 -0800 (PST)
Date: Mon, 29 Jan 2018 13:37:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129133735.GH20446@stefanha-x1.localdomain>
References: <151686473236.19954.12493487729804470001.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <151686473236.19954.12493487729804470001.malonedeb@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1745312] [NEW] Regression report: Disk
 subsystem I/O failures/issues surfacing in DOS/early Windows [two separate
 issues: one bisected, one root-caused]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1745312 <1745312@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 07:18:52AM -0000, i336_ wrote:
> Public bug reported:
>=20
> [Headsup: This report is long-ish due to the amount of detail I've
> stumbled on along the way that I think is relevant to include. I can't
> speak as to the complexity of the actual bugs, but the size of this
> report should not suggest that the reproduction process is particularly
> headache-inducing.]

I've CCed people who may be able to help.

I don't have time to read through everything you've posted.

> Hi!
>=20
> I recently needed to fire up some ancient software for research purposes
> and got very distracted discovering and playing with old versions of
> Windows :). In the process I've discovered some glitches with disk I/O.
>=20
> I believe I've stumbled on two completely separate issues that
> coincidentally surfaced at the same time. It's possible that components
> of this report will be re-filed as more specific new bugs, but I'm not
> an authority on QEMU internals or how to narrow down/categorize what
> I've found.
>=20
> - The first bug only surfaces when the "isapc" machine type is used. It
> intermittently produces "General failure {read,writ}ing drive _" under
> MS-DOS 6.22, and also somehow interferes with early bootstrap of Windows
> NT 4 (in NTLDR). Enabling or disabling KVM (I'm on Linux) appears to
> make no difference whatsoever, which may help with debugging.

Is this using the IDE disk controller?  In that case John Snow can help
you debug what's going on at the IDE level.

> - The second issue involves
>   - a WinNT4 disk image
>   - created by running through a bog-standard NT4 install inside QEMU 2.9=
=2E0
>   - which will now fail to boot in any version of QEMU - even version 1.0
>     - but which VirtualBox will boot fine
>       - but only if I point VirtualBox at QEMU's raw disk image via a
>         hacked-together VMDK file
>       - if the raw image is converted to VHD(X), VirtualBox will also fail
>         to boot the image with exactly the same error as QEMU
>       - this state of affairs is not affected by image sparseness (which =
makes
>         sense)

VMDK stores the disk geometry (cylinders, heads, sectors), which may
affect guest software.  I've CCed Fam Zheng.

>=20
> I'm confident I've bisected the first issue.
>=20
> I wasn't able to bisect the second issue (as all tested versions of QEMU
> behaved identically), but I've figured out a working repro testcase and
> I believe I've managed to pin down a solid root cause.
>=20
>=20
> =3D=3D #1: Intermittent I/O issues when `-M isapc` is used =3D=3D=3D=3D=3D
>=20
> These symptoms sometimes take a small amount of time and fiddling to
> trigger, but I AM able to consistently surface them on my machine after
> a short while. (I am very very interested to hear if others cannot
> reproduce them.)
>=20
> So, first of all:
>=20
> https://github.com/qemu/qemu/commit/306ec6c3cece7004429c79c1ac93d49919f1f=
1cc
>   (Jul 30 2013): the last version that works
>=20
> https://github.com/qemu/qemu/commit/e689f7c668cbd9d08f330e17c3dd3a059c955=
3d3
>   (Oct 30 2013): the first version that intermittently fails
>=20
> Maybe lift out and build these branches while reading. *shrug*
> (How to do this can be found at the end of this report - along with a tim=
e-saving ./configure line, FWIW)
>=20
> Here are the changelists between these two revisions:
>=20
> https://github.com/qemu/qemu/compare/306ec6c...e689f7c
> (Compare direction: OLD to NEW) (Commits: 166  Files changed: 192)
>=20
> https://github.com/qemu/qemu/compare/e689f7c...306ec6c
> (Compare direction: NEW to OLD) (Commits: 30   Files changed: 22)
>=20
> (Someone else more familiar with Git might know why GitHub returns
> results for both compare directions, and/or if the 2nd link is useful
> information. The first link returns a lot more results than the 2nd one,
> at least. Does comparing new>old return deletions?)
>=20
> ---
>=20
> Now on to the symptoms. In a moment I'll describe reproduction.
>=20
> # MS-DOS 6.22
>=20
> The first symptom I discovered was that trivial read and write
> operations under MS-DOS would sometimes fail:
>=20
>   C:\>echo test > hi
>=20
>   General failure writing drive C
>   Abort, Retry, Fail?
>=20
> Anything else that exercises the disk behaves similarly:
>=20
>   C:\>dir /s > nul
>=20
>   General failure reading drive C
>   Abort, Retry, Fail?
>=20
> (Note that the above demonstrates both write and read failures)
>=20
> (Also, FWIW, `dir /s` =3D=3D `ls -R`)
>=20
> The behavior of the I/O errors is not possible to characterise as it
> fluctuates so much. For example something as simple as DIR can produce
> wildly differing results: in one run, poking around with DIR ended with
> DOS deciding C:\ was empty at one point; at another point in a different
> run C:\ mysteriously dropped 50% of its contents only to magically gain
> it all back moments later after some poking around in one of the
> subdirectories that was still visible.
>=20
> The time it takes to trigger these errors is also highly variable. QEMU
> may fall over as early as hanging forever at "Starting MS-DOS...", or I
> might get all the way into Windows 3.1 before it triggers (in which case
> Win3.1 reports vague memory errors - of all things).
>=20
> Very occasionally I've seen _SeaBIOS itself_ report "Booting from Hard
> Disk..." "Boot failed: could not read the boot disk" ... "No bootable
> device.", and on one occasion I even got "Non-System disk or disk error"
> "Replace and strike any key when ready"!
>=20
>=20
> # WinNT 4 Terminal Server
>=20
> Most of the time, NTLDR will fire up normally. But every so often...
>=20
>   SeaBIOS (version rel-1.7.3-117-g31b8b4e-
> 20131206_080705-nilsson.home.kraxel.org)
>=20
>   Booting from Hard Disk...
>   A disk read error occurred.
>   Insert a system diskette and restart
>   the system.
>=20
> (NB. You're seeing the old SeaBIOS version included with e689f7c, which
> was the first buggy commit.)
>=20
> If NT gets past this point without erroring out (ie, it makes it to the
> boot menu), the rest of the system is 100% fine and there are no other
> disk I/O issues whatsoever. For example, on QEMU 2.9.0 I was able to
> enable disk compression, answer "Yes" to "Compress entire disk now?" and
> have the process fully complete. No hitches.
>=20
> This makes me vaguely recall/wonder that perhaps this could be somehow
> related to LBA and/or Int 13h, or something floating around near that
> bunch of functionality. (I'm woefully ignorant about such low-level
> details.) Perhaps DOS/Win3.1 are stuck using a disk mode that QEMU has a
> buggy implementation of, while NT 4 (once NTOSKRNL is up and running) is
> able to use a different disk mode or access mechanism.
>=20
> I'm really interested to get some understanding of what the root issue
> is here, when this is fixed. (I wonder if it's a timing thing?)
>=20
> I've observed some unusual behavior with repeated restarts. In one case,
> I attempted to start NT4 multiple times, and QEMU consistently failed
> with "No bootable device" each time. So, I removed `-M isapc`, promptly
> got a boot menu, hit ^C, readded `-M isapc` - and continued to get a
> boot menu. Yep. I'll accept "really really big coincidence" but I do
> very much wonder if something else is going on here. I've observed many
> similar incidents. It makes me wonder whether the contents of memory or
> some other system state is an influence. Very probably not, but still...
>=20
>=20
> -- Reproduction --------------------------------------------
>=20
> First of all, there was unfortunately no way for me to avoid having to
> post entire disk images, but I've managed to compress everything down to
> 174MB total download size.
>=20
> FWIW, WinWorld and many other sites seem to have no operational issues
> providing clear pointers to CD keys; I consider my distribution of my
> installed HDD images an extension of the apparent status quo.
>=20
> That being said, I've put everything on Google Drive so nobody has to
> headscratch about Launchpad/Canonical/etc's stance on hosting this data.
>=20
> So, this folder contains the disk images:
> https://drive.google.com/drive/folders/1WdZVBh5Trs9HLC186-nHyKeqaSxfyM2c
> ("Download all" at the top-right will create a ZIP file, but FWIW
> downloading the individual files simultaneously would implement a rough
> form of download acceleration)
>=20
> File meta info:
>=20
> Compressed
> |
> |      Apparent
> |      |    Actual
> |      |    |
> 38M -> 200M (103M)  win31.img.xz
> 82M -> 1G   (289M)  wnt4ts-broken.img.xz
> 55M -> 350M (146M)  wnt4ts-intermittent.img.xz
>=20
> SHA-256s:
>=20
> win31:        8179b8180a2ab40bd472e8a2f3fb89fc331651e56923f94ceb9e52a78ee=
220d2
> broken:       a2af5f0bc49a063b75f534b6ffe5b82e32ecc706a64a425b6626feccf6e=
3fdfa =20
> intermittent: 77ae8c458829ebcdd64c71042012f45d5a2788e6ebd22db9d53de9ef1a5=
74784
>=20
> (Wanted to keep the checksum lines within 80 columns)
>=20
> And, since I can't figure out where else in this report to put this,
> wnt4ts-broken.img's password is "admin" but something seems to have
> happened to the disk and NT doesn't actually boot properly :(, and
> wnt4ts-intermittent.img's password is "1234". (These were set up as test
> images. Now I'm _really_ glad I used simple passwords! :) )
>=20
> ---
>=20
>=20
> I have two testcases: DOS 6.22 (+ Windows 3.1), and Windows NT 4.
>=20
>=20
> # MS-DOS
>=20
> DOS is the simplest. It basically consists of
>=20
> $ qemu-system-i386 -drive file=3Dwin31.img,format=3Draw -M isapc -enable-=
kvm
>=20
> And then literally just playing around. Things to try include creating
> files (`echo blah > file`), repeatedly seeking across the entire FAT
> (`dir /s > nul` or `dir /s`), and launching Windows (`win`).
>=20
> win31.img is not special (as far as I can tell) and merely consists of
> the result of installing DOS 6.22 and Windows 3.1 from WinWorldPC. I've
> basically just included the image for convenience.
>=20
> Generally no single "run" is immune to starting Win3.1 and then
> launching File Manager; if that doesn't generate an error, something is
> definitely up.
>=20
> The second best trigger is creating new files. That very very frequently
> produces "General Failure ...", but not always.
>=20
>=20
> # WinNT 4
>=20
> Windows NT 4 is a bit more complicated. Because this error only occurs
> at presumably a single small point very early in boot, the window of
> opportunity for the glitch to surface within is much much narrower and
> thus often requires a larger number of tries.
>=20
> Anecdotally I've had QEMU hit the boot error at the first try/run, and
> after as many as 63 "successful" boots.
>=20
> I made a small test harness that automates the launch process. It
> consists of two shell scripts and requires tmux (and netcat).
> (*Potential epilepsy warning*: if you use a light-colored terminal
> background, the terminal QEMU is repeatedly invoked from will
> continuously flash rapidly from white to black.)
>=20
> One of the scripts is run inside a tmux session in one terminal, while
> the other script is run in its own terminal (without any tmux).
>=20
>=20
> I named this one `run-qemu-loop`:
>=20
> --8<--------------------------------------------------------
>=20
> #!/bin/bash
>=20
> # ---
>=20
> qemu=3D/path/to/qemu-system-i386
> #or, alternatively: (I used the following line myself so I
> #could tab-complete my way to different qemu executables)
> #qemu=3D"$1"
>=20
> disk=3D/path/to/wnt4ts-intermittent.img
>=20
> # ---
>=20
> port=3D4444
>=20
> rm -f STOP itercount
>=20
> itercount=3D0
>=20
> while :; do
> =09
> 	[ -f STOP ] && break
> =09
> 	((itercount++))
> 	echo $itercount > itercount
> =09
> 	$qemu \
> 		-enable-kvm -vga cirrus -curses -M isapc \
> 		-drive file=3D"$disk",format=3Draw \
> 		-chardev socket,id=3Dmon0,host=3Dlocalhost,port=3D$port,server,nowait \
> 		-mon chardev=3Dmon0,mode=3Dreadline
> =09
> 	#point to an otherwise-unused terminal if you like (see also: `tty`)
> 	#echo "$itercount run(s)" > /dev/pts/__
> =09
> done
>=20
> ------------------------------------------------------------
>=20
> Not much logic above; this just repeatedly runs QEMU for as long as
> the file `STOP` does not exist in the current directory.
>=20
> The key "magic" bit is that QEMU is launched in -curses mode.
>=20
> The other key bit is that the above script is run inside tmux.
>=20
>=20
> Here's `tmux-ctl-loop`:
>=20
> --8<--------------------------------------------------------
>=20
> #!/bin/bash
>=20
> port=3D4444
>=20
> tmux=3D./tmux
>=20
> printf -v l '%0.0s-' {0..25}
> h1=3D"$l/ buffer dump begin \\$l"
> h2=3D"$l-\\ buffer dump end /-$l"
>=20
> while :; do
> =09
> 	while :; do
> 		echo | nc localhost $port -q0 -w1 > /dev/null && break
> 		echo 'Start qemu!'
> 	done
> =09
> 	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
> =09
> 	echo "$h1"
> 	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty * =
)'
> 	echo "$h2"
> =09
> 	if echo "$buffer" | grep -q 'A disk read error occurred.'; then
> 	=09
> 		s=3D"<Crashed after $(< itercount) runs.>"
> 		echo "$s"
> 		echo "$s" >> stats
> 	=09
> 		touch STOP
> 	=09
> 		#echo q | nc localhost $port -q0 > /dev/null
> 	=09
> 		exit
> 	=09
> 	elif echo "$buffer" | grep -q 'OS Loader V4.00'; then
> 		=09
> 		echo '<Booted successfully, trying again>'
> 	=09
> 		echo q | nc localhost $port -q0 > /dev/null
> 	=09
> 	else
> 	=09
> 		echo '<Waiting for boot>'
> 	=09
> 	fi
> 		=09
> done
>=20
> ------------------------------------------------------------
>=20
> Nothing particularly amazing going on here either.
>=20
> While `qemu-run-loop` is running inside tmux in the first terminal, this
> is running in the 2nd one.
>=20
> The small infinite loop at the top only breaks when it can successfully
> ping QEMU and it knows it's running.
>=20
> Then, a screendump of the contents of the terminal QEMU is in is fetched
> from tmux, and the buffer's content is analyzed.
>=20
> - If NTLDR fails, the script creates `STOP` to halt qemu-run-loop,
>   sends `q` to QEMU through netcat, and then the script exits.
>=20
> - If NTLDR loads successfully, the script sends `q` to QEMU and continues
>   looping. (qemu-run-loop will not find the `STOP` file, and so restart q=
emu.)
>=20
> The scripts run very quickly, with 2-3 iterations per second on my i3
> box.
>=20
>=20
> # Usage
>=20
> Save the two scripts above to the same directory as wnt4ts-intermittent.i=
mg,
> then:
>=20
> - (If port 4444 doesn't work, the value needs to be changed in both
> scripts.)
>=20
> - In the first terminal, run `tmux -S <file>`, where <file> names the soc=
ket
>   tmux will use. This needs to match "tmux=3D" at the top of `tmux-ctl-lo=
op`.
>   (with `tmux=3D./tmux`, the command would be `tmux -S tmux`)
>=20
> - Still in the first terminal (and now also inside tmux), enter
>   `./qemu-run-loop`, passing the path to qemu if you're using that approa=
ch
>   (refer to the first few lines of the script). Don't hit enter yet.
>=20
> - Now, in the 2nd terminal, type `./tmux-ctl-loop`
>=20
> - Hit enter in both terminals.
> =20
>=20
> Rationale for timing of Enter key:
>=20
> - Running qemu-run-loop first will start QEMU, and if NTLDR starts
>   successfully it will immediately begin counting down from 30. If NT act=
ually
>   starts to boot and is then hard-shut-down this /may/ affect the disk im=
age
>=20
> - tmux-ctl-loop will annoyingly spam a continuous stream of 'Start qemu!'=
 until
>   qemu-run-loop is running.
>=20
> - Starting both scripts at "more or less" the same time (no rush) works o=
ut
>   well.
>=20
>=20
> Hopefully potential script modifications are obvious; for example
>=20
> - changing tmux-ctl-loop to not send 'q' to qemu so you can connect to th=
e HMP
>   yourself
>   (NB, if `STOP` is not created, when qemu finally exits it will of course
>   promptly be relaunched)
>=20
> - pointing run-qemu-loop to a modified qemu binary
>=20
>=20
> =3D=3D #2: QEMU-vs-VirtualBox image issue =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I was initially completely stumped by this issue, perhaps unsurprisingly
> so. :)
>=20
> wnt4ts-broken.img is a perfectly ordinary NT 4 installation that was
> created in QEMU 2.9.0. I created a 1GB disk with `truncate`, picked NTFS
> and installed everything (which took a while).
>=20
> NT setup reboots a number of times during the boot process, and IIRC
> those all went just fine. However, at some point, the image began to
> consistently bomb out with "A disk read error occurred. ...", and
> stubbornly refused to boot, regardless of the number of boot attempts I
> tried.
>=20
> QEMU 2.0.0, 1.5.0, and 1.0 (the earliest version I was able to build on
> my system) all consistently hit "disk read error occurred".
>=20
> I tried compiling QEMU 1.0 using clang so I could build for 32-bit on my
> 64-bit system (GCC 7 died with "Frame pointer required, but reserved").
> The resulting qemu completely crashed if I didn't enable KVM (ie, TCG
> was (understandably) broken); with KVM enabled qemu didn't crash, but
> NTLDR halted with the same error as on 64-bit qemu. (TL;DR, no
> difference whatsoever.)
>=20
> My initial reaction at this point was to try the image on another
> virtualization platform. My first pick was VirtualBox.
>=20
> So, I followed the official instructions for pointing VirtualBox to
> physical disk images, except I substituted a /dev/loopN device I'd
> pointed to the image file via losetup.
>=20
> And... VirtualBox picked the image up fine and Just Worked(TM). Yay! -
> but not yay. What gives?!
>=20
> Confused, I then tried to convert the disk image to VHD format.
> Unfortunately, for some reason, if I try `qemu-image convert ... -O vhdx
> ...`, VirtualBox chokes on the result:
>=20
> -----
>=20
> VD: error VERR_NOT_SUPPORTED opening image file
> '/.../wnt4ts-broken-qemuconv.vhd' (VERR_NOT_SUPPORTED).
>=20
> Result Code: NS_ERROR_FAILURE (0x80004005)
> Component: MediumWrap
> Interface: IMedium {4afe423b-43e0-e9d0-82e8-ceb307940dda}
> Callee: IVirtualBox {0169423f-46b4-cde9-91af-1e9d5b6cd945}
> Callee RC: VBOX_E_OBJECT_NOT_FOUND (0x80BB0001)
>=20
> -----
>=20
> Welp.
>=20
> Well, a bit more digging later, and I found I could do
>=20
> $ VBoxManage convertfromraw wnt4ts-broken.img wnt4ts-broken.vhd
>=20
> but... as soon as I pointed VirtualBox to this, it too began to choke
> with "A disk read error occurred".
>=20
> And yet, the VMDK->raw image setup worked just fine.
>=20
> I found I could even replace the loop device with the path of the .img
> file itself and that worked just fine too.
>=20
> At my wits' end, I followed some online instructions to learn about
> manual CHS configuration so I could try and get the image working in
> Bochs. "A disk read error occurred". I wasn't surprised.
>=20
> It was at this point I began to give up, but I decided to try One Last
> Thing(TM) before properly throwing in the towel.
>=20
> :)
>=20
> I decided to learn a bit more about how `VBoxManage internalcommands
> createrawvmdk` worked, and try one thing in particular: I can edit the
> .vmdk file, but can I point `createrawvmdk` at the .img file directly
> too?
>=20
> Turns out, yes you can.
>=20
> It also turns out that this promptly caused VirtualBox to bomb out.
>=20
> Interesting.
>=20
> For reference, here's the VMDK file I initially created (by pointing
> `createrawvmdk` at /dev/loopN) and then later edited to point straight
> to the .img file, with both approaches resulting in successful boot.
>=20
> --8<--------------------------------------------------------
>=20
> # Disk DescriptorFile
> version=3D1
> CID=3De35b9a45
> parentCID=3Dffffffff
> createType=3D"fullDevice"
>=20
> # Extent description
> RW 1536000 FLAT "/absolute/full/path/to/wnt4ts-broken.img" 0
>=20
> # The disk Data Base=20
> #DDB
>=20
> ddb.virtualHWVersion =3D "4"
> ddb.adapterType=3D"ide"
> ddb.geometry.cylinders=3D"1523"
> ddb.geometry.heads=3D"16"
> ddb.geometry.sectors=3D"63"
> ddb.uuid.image=3D"871a6044-c8ca-48ed-b7aa-e6fc49da3db4"
> ddb.uuid.parent=3D"00000000-0000-0000-0000-000000000000"
> ddb.uuid.modification=3D"3661715c-3906-4e4a-ab65-486d140e03b8"
> ddb.uuid.parentmodification=3D"00000000-0000-0000-0000-000000000000"
> ddb.geometry.biosCylinders=3D"761"
> ddb.geometry.biosHeads=3D"32"
> ddb.geometry.biosSectors=3D"63"
>=20
> ------------------------------------------------------------
>=20
>=20
> Here's the _diff_ of what happens if I point `createrawvmdk` at wnt4ts-br=
oken.img directly:
>=20
> --8<--------------------------------------------------------
>=20
> ddb.geometry.cylinders=3D"2080"
> ddb.geometry.heads=3D"16"
> ddb.geometry.sectors=3D"63"
>=20
> ------------------------------------------------------------
>=20
> :D
>=20
> Naturally,
>=20
> $ qemu-system-i386 -drive file=3Dwnt4ts-
> broken.img,format=3Draw,cyls=3D1523,heads=3D16,secs=3D63 -M isapc -sdl
>=20
> will boot happily on 2.9.0 (notwithstanding the occasional "disk read
> error occurred" documented above).
>=20
> It will also boot in 1.6.0.
>=20
> (POTENTIAL BUG HEADSUP: 1.0 and 1.5.0 both lock up with a blank 640x480
> window and use 0% CPU if I specify `-M isapc`.)
>=20
> And, of course, using these CHS values in Bochs also results in
> successful boot as well (after setting the CPU type to pentium).
>=20
> Unfortunately, I have no idea what sequence of events caused the
> creation of the VMDK file above. No invocation of `createrawvmdk` is
> producing a VMDK file with the CHS settings above.
>=20
> I've only just begun to learn about the intricacies of CHS. Am I to
> understand that these values are stored amongst the first 512 bytes of
> the disk? If this is the case, then I wonder what changed the data, and
> why. I was initially only using QEMU 2.9.0, and didn't move the image to
> different VMs or QEMU versions. Perhaps Windows NT got confused about
> the disk CHS and rewrote it?
>=20
>=20
> =3D=3D Sporadic BIOS-level boot failure =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I have multiple screenshots of SeaBIOS in QEMU 2.9.0 halting with "No
> bootable device" (et al), even with the above manually-applied CHS
> settings.
>=20
> Commit e689f7c also presents such errors.
>=20
> Commit 306ec6c does not suffer from intermittent breakage of any kind:
>=20
> - No SeaBIOS flake-outs
> - No "Non-system disk or disk error"
> - No "A disk error has occurred"
> - No "General failure ..."
>=20
> While most of my confidence in commit 306ec6c is based on anecdotal
> evidence, I modified `tmux-ctl-loop` a little to soak-test BIOS-level
> I/O stability and left this modified version running for a few minutes.
>=20
> --8<--------------------------------------------------------
>=20
> #!/bin/bash
>=20
> port=3D4444
>=20
> tmux=3D./tmux
>=20
> printf -v l '%0.0s-' {0..25}
> h1=3D"$l/ buffer dump begin \\$l"
> h2=3D"$l-\\ buffer dump end /-$l"
>=20
> while :; do
> =09
> 	while :; do
> 		echo | nc localhost $port -q0 -w1 > /dev/null && break
> 		echo 'Start qemu!'
> 	done
> =09
> 	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
> =09
> 	echo "$h1"
> 	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty * =
)'
> 	echo "$h2"
> =09
> 	if echo "$buffer" | grep -q 'Non-system disk' || echo "$buffer" | \
> 		grep -q 'No bootable device'
> 	then
> 	=09
> 		s=3D"<Hit error after $(< itercount) runs.>"
> 		echo "$s"
> 		echo "$s" >> stats
> 	=09
> 		touch STOP
> 	=09
> 		#echo q | nc localhost $port -q0 > /dev/null
> 	=09
> 		exit
> 	=09
> 	elif echo "$buffer" | grep -q 'OS Loader V4.00' || echo "$buffer" | \
> 		grep -q 'A disk read error'
> 	then
> =09
> 		echo '<Boot did not hang at BIOS, trying again>'
> 	=09
> 		echo q | nc localhost $port -q0 > /dev/null
> 	=09
> 	else
> 	=09
> 		echo '<Waiting for boot>'
> 	=09
> 	fi
> 		=09
> done
>=20
> ------------------------------------------------------------
>=20
> For the above to work, the top of run-qemu-loop must also be modified to
> read something along the lines of
>=20
> disk=3D/path/to/wnt4ts-broken.img,format=3Draw,cyls=3D1523,heads=3D16,sec=
s=3D63
>=20
> (Suggestion: modify copies of both scripts)
>=20
> One small terminal-flicker-headache (and a 57=B0C CPU) later, I was able
> to carefully observe just over 350 successful runs in which QEMU commit
> 306ec6c only ever produced a boot menu. No other hitches.
>=20
> ** Important: **
>=20
> However, commit 306ec6c will fail to boot, ever, if the cylinders and
> geometry are not set to the values VirtualBox "discovered". (Of note is
> the fact that QEMU (2.9.0) was what initially created this image. I must
> admit that I don't remember what sequence of QEMU versions I fed the
> image to - and I maybe, possibly, didn't think to back the file up
> (sorry), so maybe something mangled something somewhere. But VirtualBox
> figured it out nonetheless!)
>=20
> Furthermore, feeding /dev/loopN to any QEMU version will NOT result in
> correct CHS discovery (and successful boot).
>=20
> This is what leads me to conclude that I've discovered two separate
> issues.
>=20
>=20
> =3D=3D Appendix: How to build the branches =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> It's very simple.
>=20
> First, `git clone https://github.com/qemu/qemu` somewhere if you don't
> already have a local copy. If you have an old git checkout that's from
> 2014 or later, you can use that old checkout instead. (If you want to
> test an old checkout you have, the commands below will either work
> perfectly or completely bomb out with no side effects.)
>=20
> A full checkout is a ~183MB download. Sorry.
>=20
> Next, create two new directories somewhere. Name them what you like, eg
> `qemu-working` and `qemu-broken`.
>=20
> Now, cd into the checkout directory, and run:
>=20
> $ git archive 306ec6c3cece7004429c79c1ac93d49919f1f1cc | tar xC /path/to
> /qemu-working/
>=20
> $ git archive e689f7c668cbd9d08f330e17c3dd3a059c9553d3 | tar xC /path/to
> /qemu-broken/
>=20
> The paths can be relative.
>=20
> Now, run this in both of the new directories:
>=20
> $ ./configure --python=3Dpython2.7 --disable-libssh2 --disable-seccomp
> --disable-usb-redir --disable-guest-agent --disable-libiscsi --disable-
> spice --disable-smartcard-nss --disable-vhost-net --disable-docs
> --disable-attr --disable-cap-ng --disable-vde --disable-user --disable-
> bluez --disable-vnc-ws --disable-xen --disable-brlapi --enable-debug
> --target-list=3Di386-softmmu --disable-fdt
>=20
> $ make -j64
>=20
> You can open two terminals and configure and build both simultaneously
> if you like.
>=20
> On my decent but very basic (2-core+HT) i3 box, -j64 actually works out -=
 make doesn't actually launch too many gcc processes. You *will* see your s=
ystem load spike to ~20 though :)
> (NB. Do. not. use. -j64. with. the. linux. kernel.)
>=20
> On my system, a single build with -j64 takes only about 35 seconds. C
> FTW. (Although this has increased to 1min20sec for more recent builds.)
>=20
> Most of the configure arguments remove functionality I'll never use (in
> this situation) and which will only slow down the build.
>=20
> Once QEMU is built, run qemu-system-i386 directly from where it has been
> built.
>=20
> $ /path/to/qemu-working/i386-softmmu/qemu-system-i386 ...
> $ /path/to/qemu-broken/i386-softmmu/qemu-system-i386 ...
>=20
> Again, the paths can be relative.
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
>=20
> ** Tags: disk io qemu
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1745312
>=20
> Title:
>   Regression report: Disk subsystem I/O failures/issues surfacing in
>   DOS/early Windows [two separate issues: one bisected, one root-caused]
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   [Headsup: This report is long-ish due to the amount of detail I've
>   stumbled on along the way that I think is relevant to include. I can't
>   speak as to the complexity of the actual bugs, but the size of this
>   report should not suggest that the reproduction process is
>   particularly headache-inducing.]
>=20
>   Hi!
>=20
>   I recently needed to fire up some ancient software for research
>   purposes and got very distracted discovering and playing with old
>   versions of Windows :). In the process I've discovered some glitches
>   with disk I/O.
>=20
>   I believe I've stumbled on two completely separate issues that
>   coincidentally surfaced at the same time. It's possible that
>   components of this report will be re-filed as more specific new bugs,
>   but I'm not an authority on QEMU internals or how to narrow
>   down/categorize what I've found.
>=20
>   - The first bug only surfaces when the "isapc" machine type is used.
>   It intermittently produces "General failure {read,writ}ing drive _"
>   under MS-DOS 6.22, and also somehow interferes with early bootstrap of
>   Windows NT 4 (in NTLDR). Enabling or disabling KVM (I'm on Linux)
>   appears to make no difference whatsoever, which may help with
>   debugging.
>=20
>   - The second issue involves
>     - a WinNT4 disk image
>     - created by running through a bog-standard NT4 install inside QEMU 2=
=2E9.0
>     - which will now fail to boot in any version of QEMU - even version 1=
=2E0
>       - but which VirtualBox will boot fine
>         - but only if I point VirtualBox at QEMU's raw disk image via a
>           hacked-together VMDK file
>         - if the raw image is converted to VHD(X), VirtualBox will also f=
ail
>           to boot the image with exactly the same error as QEMU
>         - this state of affairs is not affected by image sparseness (whic=
h makes
>           sense)
>=20
>   I'm confident I've bisected the first issue.
>=20
>   I wasn't able to bisect the second issue (as all tested versions of
>   QEMU behaved identically), but I've figured out a working repro
>   testcase and I believe I've managed to pin down a solid root cause.
>=20
>=20
>   =3D=3D #1: Intermittent I/O issues when `-M isapc` is used =3D=3D=3D=3D=
=3D
>=20
>   These symptoms sometimes take a small amount of time and fiddling to
>   trigger, but I AM able to consistently surface them on my machine
>   after a short while. (I am very very interested to hear if others
>   cannot reproduce them.)
>=20
>   So, first of all:
>=20
>   https://github.com/qemu/qemu/commit/306ec6c3cece7004429c79c1ac93d49919f=
1f1cc
>     (Jul 30 2013): the last version that works
>=20
>   https://github.com/qemu/qemu/commit/e689f7c668cbd9d08f330e17c3dd3a059c9=
553d3
>     (Oct 30 2013): the first version that intermittently fails
>=20
>   Maybe lift out and build these branches while reading. *shrug*
>   (How to do this can be found at the end of this report - along with a t=
ime-saving ./configure line, FWIW)
>=20
>   Here are the changelists between these two revisions:
>=20
>   https://github.com/qemu/qemu/compare/306ec6c...e689f7c
>   (Compare direction: OLD to NEW) (Commits: 166  Files changed: 192)
>=20
>   https://github.com/qemu/qemu/compare/e689f7c...306ec6c
>   (Compare direction: NEW to OLD) (Commits: 30   Files changed: 22)
>=20
>   (Someone else more familiar with Git might know why GitHub returns
>   results for both compare directions, and/or if the 2nd link is useful
>   information. The first link returns a lot more results than the 2nd
>   one, at least. Does comparing new>old return deletions?)
>=20
>   ---
>=20
>   Now on to the symptoms. In a moment I'll describe reproduction.
>=20
>   # MS-DOS 6.22
>=20
>   The first symptom I discovered was that trivial read and write
>   operations under MS-DOS would sometimes fail:
>=20
>     C:\>echo test > hi
>=20
>     General failure writing drive C
>     Abort, Retry, Fail?
>=20
>   Anything else that exercises the disk behaves similarly:
>=20
>     C:\>dir /s > nul
>=20
>     General failure reading drive C
>     Abort, Retry, Fail?
>=20
>   (Note that the above demonstrates both write and read failures)
>=20
>   (Also, FWIW, `dir /s` =3D=3D `ls -R`)
>=20
>   The behavior of the I/O errors is not possible to characterise as it
>   fluctuates so much. For example something as simple as DIR can produce
>   wildly differing results: in one run, poking around with DIR ended
>   with DOS deciding C:\ was empty at one point; at another point in a
>   different run C:\ mysteriously dropped 50% of its contents only to
>   magically gain it all back moments later after some poking around in
>   one of the subdirectories that was still visible.
>=20
>   The time it takes to trigger these errors is also highly variable.
>   QEMU may fall over as early as hanging forever at "Starting MS-
>   DOS...", or I might get all the way into Windows 3.1 before it
>   triggers (in which case Win3.1 reports vague memory errors - of all
>   things).
>=20
>   Very occasionally I've seen _SeaBIOS itself_ report "Booting from Hard
>   Disk..." "Boot failed: could not read the boot disk" ... "No bootable
>   device.", and on one occasion I even got "Non-System disk or disk
>   error" "Replace and strike any key when ready"!
>=20
>  =20
>   # WinNT 4 Terminal Server
>=20
>   Most of the time, NTLDR will fire up normally. But every so often...
>=20
>     SeaBIOS (version rel-1.7.3-117-g31b8b4e-
>   20131206_080705-nilsson.home.kraxel.org)
>=20
>     Booting from Hard Disk...
>     A disk read error occurred.
>     Insert a system diskette and restart
>     the system.
>=20
>   (NB. You're seeing the old SeaBIOS version included with e689f7c,
>   which was the first buggy commit.)
>=20
>   If NT gets past this point without erroring out (ie, it makes it to
>   the boot menu), the rest of the system is 100% fine and there are no
>   other disk I/O issues whatsoever. For example, on QEMU 2.9.0 I was
>   able to enable disk compression, answer "Yes" to "Compress entire disk
>   now?" and have the process fully complete. No hitches.
>=20
>   This makes me vaguely recall/wonder that perhaps this could be somehow
>   related to LBA and/or Int 13h, or something floating around near that
>   bunch of functionality. (I'm woefully ignorant about such low-level
>   details.) Perhaps DOS/Win3.1 are stuck using a disk mode that QEMU has
>   a buggy implementation of, while NT 4 (once NTOSKRNL is up and
>   running) is able to use a different disk mode or access mechanism.
>=20
>   I'm really interested to get some understanding of what the root issue
>   is here, when this is fixed. (I wonder if it's a timing thing?)
>=20
>   I've observed some unusual behavior with repeated restarts. In one
>   case, I attempted to start NT4 multiple times, and QEMU consistently
>   failed with "No bootable device" each time. So, I removed `-M isapc`,
>   promptly got a boot menu, hit ^C, readded `-M isapc` - and continued
>   to get a boot menu. Yep. I'll accept "really really big coincidence"
>   but I do very much wonder if something else is going on here. I've
>   observed many similar incidents. It makes me wonder whether the
>   contents of memory or some other system state is an influence. Very
>   probably not, but still...
>=20
>=20
>   -- Reproduction --------------------------------------------
>=20
>   First of all, there was unfortunately no way for me to avoid having to
>   post entire disk images, but I've managed to compress everything down
>   to 174MB total download size.
>=20
>   FWIW, WinWorld and many other sites seem to have no operational issues
>   providing clear pointers to CD keys; I consider my distribution of my
>   installed HDD images an extension of the apparent status quo.
>=20
>   That being said, I've put everything on Google Drive so nobody has to
>   headscratch about Launchpad/Canonical/etc's stance on hosting this
>   data.
>=20
>   So, this folder contains the disk images:
>   https://drive.google.com/drive/folders/1WdZVBh5Trs9HLC186-nHyKeqaSxfyM2c
>   ("Download all" at the top-right will create a ZIP file, but FWIW
>   downloading the individual files simultaneously would implement a
>   rough form of download acceleration)
>=20
>   File meta info:
>=20
>   Compressed
>   |
>   |      Apparent
>   |      |    Actual
>   |      |    |
>   38M -> 200M (103M)  win31.img.xz
>   82M -> 1G   (289M)  wnt4ts-broken.img.xz
>   55M -> 350M (146M)  wnt4ts-intermittent.img.xz
>=20
>   SHA-256s:
>=20
>   win31:        8179b8180a2ab40bd472e8a2f3fb89fc331651e56923f94ceb9e52a78=
ee220d2
>   broken:       a2af5f0bc49a063b75f534b6ffe5b82e32ecc706a64a425b6626feccf=
6e3fdfa =20
>   intermittent: 77ae8c458829ebcdd64c71042012f45d5a2788e6ebd22db9d53de9ef1=
a574784
>=20
>   (Wanted to keep the checksum lines within 80 columns)
>=20
>   And, since I can't figure out where else in this report to put this,
>   wnt4ts-broken.img's password is "admin" but something seems to have
>   happened to the disk and NT doesn't actually boot properly :(, and
>   wnt4ts-intermittent.img's password is "1234". (These were set up as
>   test images. Now I'm _really_ glad I used simple passwords! :) )
>=20
>   ---
>=20
>  =20
>   I have two testcases: DOS 6.22 (+ Windows 3.1), and Windows NT 4.
>=20
>  =20
>   # MS-DOS
>=20
>   DOS is the simplest. It basically consists of
>=20
>   $ qemu-system-i386 -drive file=3Dwin31.img,format=3Draw -M isapc -enabl=
e-
>   kvm
>=20
>   And then literally just playing around. Things to try include creating
>   files (`echo blah > file`), repeatedly seeking across the entire FAT
>   (`dir /s > nul` or `dir /s`), and launching Windows (`win`).
>=20
>   win31.img is not special (as far as I can tell) and merely consists of
>   the result of installing DOS 6.22 and Windows 3.1 from WinWorldPC.
>   I've basically just included the image for convenience.
>=20
>   Generally no single "run" is immune to starting Win3.1 and then
>   launching File Manager; if that doesn't generate an error, something
>   is definitely up.
>=20
>   The second best trigger is creating new files. That very very
>   frequently produces "General Failure ...", but not always.
>=20
>  =20
>   # WinNT 4
>=20
>   Windows NT 4 is a bit more complicated. Because this error only occurs
>   at presumably a single small point very early in boot, the window of
>   opportunity for the glitch to surface within is much much narrower and
>   thus often requires a larger number of tries.
>=20
>   Anecdotally I've had QEMU hit the boot error at the first try/run, and
>   after as many as 63 "successful" boots.
>=20
>   I made a small test harness that automates the launch process. It
>   consists of two shell scripts and requires tmux (and netcat).
>   (*Potential epilepsy warning*: if you use a light-colored terminal
>   background, the terminal QEMU is repeatedly invoked from will
>   continuously flash rapidly from white to black.)
>=20
>   One of the scripts is run inside a tmux session in one terminal, while
>   the other script is run in its own terminal (without any tmux).
>=20
>  =20
>   I named this one `run-qemu-loop`:
>=20
>   --8<--------------------------------------------------------
>=20
>   #!/bin/bash
>=20
>   # ---
>=20
>   qemu=3D/path/to/qemu-system-i386
>   #or, alternatively: (I used the following line myself so I
>   #could tab-complete my way to different qemu executables)
>   #qemu=3D"$1"
>=20
>   disk=3D/path/to/wnt4ts-intermittent.img
>=20
>   # ---
>=20
>   port=3D4444
>=20
>   rm -f STOP itercount
>=20
>   itercount=3D0
>=20
>   while :; do
>   =09
>   	[ -f STOP ] && break
>   =09
>   	((itercount++))
>   	echo $itercount > itercount
>   =09
>   	$qemu \
>   		-enable-kvm -vga cirrus -curses -M isapc \
>   		-drive file=3D"$disk",format=3Draw \
>   		-chardev socket,id=3Dmon0,host=3Dlocalhost,port=3D$port,server,nowait=
 \
>   		-mon chardev=3Dmon0,mode=3Dreadline
>   =09
>   	#point to an otherwise-unused terminal if you like (see also: `tty`)
>   	#echo "$itercount run(s)" > /dev/pts/__
>   =09
>   done
>=20
>   ------------------------------------------------------------
>=20
>   Not much logic above; this just repeatedly runs QEMU for as long as
>   the file `STOP` does not exist in the current directory.
>=20
>   The key "magic" bit is that QEMU is launched in -curses mode.
>=20
>   The other key bit is that the above script is run inside tmux.
>=20
>  =20
>   Here's `tmux-ctl-loop`:
>=20
>   --8<--------------------------------------------------------
>=20
>   #!/bin/bash
>=20
>   port=3D4444
>=20
>   tmux=3D./tmux
>=20
>   printf -v l '%0.0s-' {0..25}
>   h1=3D"$l/ buffer dump begin \\$l"
>   h2=3D"$l-\\ buffer dump end /-$l"
>=20
>   while :; do
>   =09
>   	while :; do
>   		echo | nc localhost $port -q0 -w1 > /dev/null && break
>   		echo 'Start qemu!'
>   	done
>   =09
>   	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
>   =09
>   	echo "$h1"
>   	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty =
* )'
>   	echo "$h2"
>   =09
>   	if echo "$buffer" | grep -q 'A disk read error occurred.'; then
>   	=09
>   		s=3D"<Crashed after $(< itercount) runs.>"
>   		echo "$s"
>   		echo "$s" >> stats
>   	=09
>   		touch STOP
>   	=09
>   		#echo q | nc localhost $port -q0 > /dev/null
>   	=09
>   		exit
>   	=09
>   	elif echo "$buffer" | grep -q 'OS Loader V4.00'; then
>   		=09
>   		echo '<Booted successfully, trying again>'
>   	=09
>   		echo q | nc localhost $port -q0 > /dev/null
>   	=09
>   	else
>   	=09
>   		echo '<Waiting for boot>'
>   	=09
>   	fi
>   		=09
>   done
>=20
>   ------------------------------------------------------------
>=20
>   Nothing particularly amazing going on here either.
>=20
>   While `qemu-run-loop` is running inside tmux in the first terminal,
>   this is running in the 2nd one.
>=20
>   The small infinite loop at the top only breaks when it can
>   successfully ping QEMU and it knows it's running.
>=20
>   Then, a screendump of the contents of the terminal QEMU is in is
>   fetched from tmux, and the buffer's content is analyzed.
>=20
>   - If NTLDR fails, the script creates `STOP` to halt qemu-run-loop,
>     sends `q` to QEMU through netcat, and then the script exits.
>=20
>   - If NTLDR loads successfully, the script sends `q` to QEMU and continu=
es
>     looping. (qemu-run-loop will not find the `STOP` file, and so restart=
 qemu.)
>=20
>   The scripts run very quickly, with 2-3 iterations per second on my i3
>   box.
>=20
>=20
>   # Usage
>=20
>   Save the two scripts above to the same directory as wnt4ts-intermittent=
=2Eimg,
>   then:
>=20
>   - (If port 4444 doesn't work, the value needs to be changed in both
>   scripts.)
>=20
>   - In the first terminal, run `tmux -S <file>`, where <file> names the s=
ocket
>     tmux will use. This needs to match "tmux=3D" at the top of `tmux-ctl-=
loop`.
>     (with `tmux=3D./tmux`, the command would be `tmux -S tmux`)
>=20
>   - Still in the first terminal (and now also inside tmux), enter
>     `./qemu-run-loop`, passing the path to qemu if you're using that appr=
oach
>     (refer to the first few lines of the script). Don't hit enter yet.
>=20
>   - Now, in the 2nd terminal, type `./tmux-ctl-loop`
>=20
>   - Hit enter in both terminals.
>   =20
>=20
>   Rationale for timing of Enter key:
>=20
>   - Running qemu-run-loop first will start QEMU, and if NTLDR starts
>     successfully it will immediately begin counting down from 30. If NT a=
ctually
>     starts to boot and is then hard-shut-down this /may/ affect the disk =
image
>=20
>   - tmux-ctl-loop will annoyingly spam a continuous stream of 'Start qemu=
!' until
>     qemu-run-loop is running.
>=20
>   - Starting both scripts at "more or less" the same time (no rush) works=
 out
>     well.
>=20
>  =20
>   Hopefully potential script modifications are obvious; for example
>=20
>   - changing tmux-ctl-loop to not send 'q' to qemu so you can connect to =
the HMP
>     yourself
>     (NB, if `STOP` is not created, when qemu finally exits it will of cou=
rse
>     promptly be relaunched)
>=20
>   - pointing run-qemu-loop to a modified qemu binary
>=20
>=20
>   =3D=3D #2: QEMU-vs-VirtualBox image issue =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   I was initially completely stumped by this issue, perhaps
>   unsurprisingly so. :)
>=20
>   wnt4ts-broken.img is a perfectly ordinary NT 4 installation that was
>   created in QEMU 2.9.0. I created a 1GB disk with `truncate`, picked
>   NTFS and installed everything (which took a while).
>=20
>   NT setup reboots a number of times during the boot process, and IIRC
>   those all went just fine. However, at some point, the image began to
>   consistently bomb out with "A disk read error occurred. ...", and
>   stubbornly refused to boot, regardless of the number of boot attempts
>   I tried.
>=20
>   QEMU 2.0.0, 1.5.0, and 1.0 (the earliest version I was able to build
>   on my system) all consistently hit "disk read error occurred".
>=20
>   I tried compiling QEMU 1.0 using clang so I could build for 32-bit on
>   my 64-bit system (GCC 7 died with "Frame pointer required, but
>   reserved"). The resulting qemu completely crashed if I didn't enable
>   KVM (ie, TCG was (understandably) broken); with KVM enabled qemu
>   didn't crash, but NTLDR halted with the same error as on 64-bit qemu.
>   (TL;DR, no difference whatsoever.)
>=20
>   My initial reaction at this point was to try the image on another
>   virtualization platform. My first pick was VirtualBox.
>=20
>   So, I followed the official instructions for pointing VirtualBox to
>   physical disk images, except I substituted a /dev/loopN device I'd
>   pointed to the image file via losetup.
>=20
>   And... VirtualBox picked the image up fine and Just Worked(TM). Yay! -
>   but not yay. What gives?!
>=20
>   Confused, I then tried to convert the disk image to VHD format.
>   Unfortunately, for some reason, if I try `qemu-image convert ... -O
>   vhdx ...`, VirtualBox chokes on the result:
>=20
>   -----
>=20
>   VD: error VERR_NOT_SUPPORTED opening image file
>   '/.../wnt4ts-broken-qemuconv.vhd' (VERR_NOT_SUPPORTED).
>=20
>   Result Code: NS_ERROR_FAILURE (0x80004005)
>   Component: MediumWrap
>   Interface: IMedium {4afe423b-43e0-e9d0-82e8-ceb307940dda}
>   Callee: IVirtualBox {0169423f-46b4-cde9-91af-1e9d5b6cd945}
>   Callee RC: VBOX_E_OBJECT_NOT_FOUND (0x80BB0001)
>=20
>   -----
>=20
>   Welp.
>=20
>   Well, a bit more digging later, and I found I could do
>=20
>   $ VBoxManage convertfromraw wnt4ts-broken.img wnt4ts-broken.vhd
>=20
>   but... as soon as I pointed VirtualBox to this, it too began to choke
>   with "A disk read error occurred".
>=20
>   And yet, the VMDK->raw image setup worked just fine.
>=20
>   I found I could even replace the loop device with the path of the .img
>   file itself and that worked just fine too.
>=20
>   At my wits' end, I followed some online instructions to learn about
>   manual CHS configuration so I could try and get the image working in
>   Bochs. "A disk read error occurred". I wasn't surprised.
>=20
>   It was at this point I began to give up, but I decided to try One Last
>   Thing(TM) before properly throwing in the towel.
>=20
>   :)
>=20
>   I decided to learn a bit more about how `VBoxManage internalcommands
>   createrawvmdk` worked, and try one thing in particular: I can edit the
>   .vmdk file, but can I point `createrawvmdk` at the .img file directly
>   too?
>=20
>   Turns out, yes you can.
>=20
>   It also turns out that this promptly caused VirtualBox to bomb out.
>=20
>   Interesting.
>=20
>   For reference, here's the VMDK file I initially created (by pointing
>   `createrawvmdk` at /dev/loopN) and then later edited to point straight
>   to the .img file, with both approaches resulting in successful boot.
>=20
>   --8<--------------------------------------------------------
>=20
>   # Disk DescriptorFile
>   version=3D1
>   CID=3De35b9a45
>   parentCID=3Dffffffff
>   createType=3D"fullDevice"
>=20
>   # Extent description
>   RW 1536000 FLAT "/absolute/full/path/to/wnt4ts-broken.img" 0
>=20
>   # The disk Data Base=20
>   #DDB
>=20
>   ddb.virtualHWVersion =3D "4"
>   ddb.adapterType=3D"ide"
>   ddb.geometry.cylinders=3D"1523"
>   ddb.geometry.heads=3D"16"
>   ddb.geometry.sectors=3D"63"
>   ddb.uuid.image=3D"871a6044-c8ca-48ed-b7aa-e6fc49da3db4"
>   ddb.uuid.parent=3D"00000000-0000-0000-0000-000000000000"
>   ddb.uuid.modification=3D"3661715c-3906-4e4a-ab65-486d140e03b8"
>   ddb.uuid.parentmodification=3D"00000000-0000-0000-0000-000000000000"
>   ddb.geometry.biosCylinders=3D"761"
>   ddb.geometry.biosHeads=3D"32"
>   ddb.geometry.biosSectors=3D"63"
>=20
>   ------------------------------------------------------------
>=20
>  =20
>   Here's the _diff_ of what happens if I point `createrawvmdk` at wnt4ts-=
broken.img directly:
>=20
>   --8<--------------------------------------------------------
>=20
>   ddb.geometry.cylinders=3D"2080"
>   ddb.geometry.heads=3D"16"
>   ddb.geometry.sectors=3D"63"
>=20
>   ------------------------------------------------------------
>=20
>   :D
>=20
>   Naturally,
>=20
>   $ qemu-system-i386 -drive file=3Dwnt4ts-
>   broken.img,format=3Draw,cyls=3D1523,heads=3D16,secs=3D63 -M isapc -sdl
>=20
>   will boot happily on 2.9.0 (notwithstanding the occasional "disk read
>   error occurred" documented above).
>=20
>   It will also boot in 1.6.0.
>=20
>   (POTENTIAL BUG HEADSUP: 1.0 and 1.5.0 both lock up with a blank
>   640x480 window and use 0% CPU if I specify `-M isapc`.)
>=20
>   And, of course, using these CHS values in Bochs also results in
>   successful boot as well (after setting the CPU type to pentium).
>=20
>   Unfortunately, I have no idea what sequence of events caused the
>   creation of the VMDK file above. No invocation of `createrawvmdk` is
>   producing a VMDK file with the CHS settings above.
>=20
>   I've only just begun to learn about the intricacies of CHS. Am I to
>   understand that these values are stored amongst the first 512 bytes of
>   the disk? If this is the case, then I wonder what changed the data,
>   and why. I was initially only using QEMU 2.9.0, and didn't move the
>   image to different VMs or QEMU versions. Perhaps Windows NT got
>   confused about the disk CHS and rewrote it?
>=20
>  =20
>   =3D=3D Sporadic BIOS-level boot failure =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   I have multiple screenshots of SeaBIOS in QEMU 2.9.0 halting with "No
>   bootable device" (et al), even with the above manually-applied CHS
>   settings.
>=20
>   Commit e689f7c also presents such errors.
>=20
>   Commit 306ec6c does not suffer from intermittent breakage of any kind:
>=20
>   - No SeaBIOS flake-outs
>   - No "Non-system disk or disk error"
>   - No "A disk error has occurred"
>   - No "General failure ..."
>=20
>   While most of my confidence in commit 306ec6c is based on anecdotal
>   evidence, I modified `tmux-ctl-loop` a little to soak-test BIOS-level
>   I/O stability and left this modified version running for a few
>   minutes.
>=20
>   --8<--------------------------------------------------------
>=20
>   #!/bin/bash
>=20
>   port=3D4444
>=20
>   tmux=3D./tmux
>=20
>   printf -v l '%0.0s-' {0..25}
>   h1=3D"$l/ buffer dump begin \\$l"
>   h2=3D"$l-\\ buffer dump end /-$l"
>=20
>   while :; do
>   =09
>   	while :; do
>   		echo | nc localhost $port -q0 -w1 > /dev/null && break
>   		echo 'Start qemu!'
>   	done
>   =09
>   	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
>   =09
>   	echo "$h1"
>   	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty =
* )'
>   	echo "$h2"
>   =09
>   	if echo "$buffer" | grep -q 'Non-system disk' || echo "$buffer" | \
>   		grep -q 'No bootable device'
>   	then
>   	=09
>   		s=3D"<Hit error after $(< itercount) runs.>"
>   		echo "$s"
>   		echo "$s" >> stats
>   	=09
>   		touch STOP
>   	=09
>   		#echo q | nc localhost $port -q0 > /dev/null
>   	=09
>   		exit
>   	=09
>   	elif echo "$buffer" | grep -q 'OS Loader V4.00' || echo "$buffer" | \
>   		grep -q 'A disk read error'
>   	then
>   =09
>   		echo '<Boot did not hang at BIOS, trying again>'
>   	=09
>   		echo q | nc localhost $port -q0 > /dev/null
>   	=09
>   	else
>   	=09
>   		echo '<Waiting for boot>'
>   	=09
>   	fi
>   		=09
>   done
>=20
>   ------------------------------------------------------------
>=20
>   For the above to work, the top of run-qemu-loop must also be modified
>   to read something along the lines of
>=20
>   disk=3D/path/to/wnt4ts-broken.img,format=3Draw,cyls=3D1523,heads=3D16,s=
ecs=3D63
>=20
>   (Suggestion: modify copies of both scripts)
>=20
>   One small terminal-flicker-headache (and a 57=B0C CPU) later, I was able
>   to carefully observe just over 350 successful runs in which QEMU
>   commit 306ec6c only ever produced a boot menu. No other hitches.
>=20
>   ** Important: **
>=20
>   However, commit 306ec6c will fail to boot, ever, if the cylinders and
>   geometry are not set to the values VirtualBox "discovered". (Of note
>   is the fact that QEMU (2.9.0) was what initially created this image. I
>   must admit that I don't remember what sequence of QEMU versions I fed
>   the image to - and I maybe, possibly, didn't think to back the file up
>   (sorry), so maybe something mangled something somewhere. But
>   VirtualBox figured it out nonetheless!)
>=20
>   Furthermore, feeding /dev/loopN to any QEMU version will NOT result in
>   correct CHS discovery (and successful boot).
>=20
>   This is what leads me to conclude that I've discovered two separate
>   issues.
>=20
>=20
>   =3D=3D Appendix: How to build the branches =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   It's very simple.
>=20
>   First, `git clone https://github.com/qemu/qemu` somewhere if you don't
>   already have a local copy. If you have an old git checkout that's from
>   2014 or later, you can use that old checkout instead. (If you want to
>   test an old checkout you have, the commands below will either work
>   perfectly or completely bomb out with no side effects.)
>=20
>   A full checkout is a ~183MB download. Sorry.
>=20
>   Next, create two new directories somewhere. Name them what you like,
>   eg `qemu-working` and `qemu-broken`.
>=20
>   Now, cd into the checkout directory, and run:
>=20
>   $ git archive 306ec6c3cece7004429c79c1ac93d49919f1f1cc | tar xC
>   /path/to/qemu-working/
>=20
>   $ git archive e689f7c668cbd9d08f330e17c3dd3a059c9553d3 | tar xC
>   /path/to/qemu-broken/
>=20
>   The paths can be relative.
>=20
>   Now, run this in both of the new directories:
>=20
>   $ ./configure --python=3Dpython2.7 --disable-libssh2 --disable-seccomp
>   --disable-usb-redir --disable-guest-agent --disable-libiscsi
>   --disable-spice --disable-smartcard-nss --disable-vhost-net --disable-
>   docs --disable-attr --disable-cap-ng --disable-vde --disable-user
>   --disable-bluez --disable-vnc-ws --disable-xen --disable-brlapi
>   --enable-debug --target-list=3Di386-softmmu --disable-fdt
>=20
>   $ make -j64
>=20
>   You can open two terminals and configure and build both simultaneously
>   if you like.
>=20
>   On my decent but very basic (2-core+HT) i3 box, -j64 actually works out=
 - make doesn't actually launch too many gcc processes. You *will* see your=
 system load spike to ~20 though :)
>   (NB. Do. not. use. -j64. with. the. linux. kernel.)
>=20
>   On my system, a single build with -j64 takes only about 35 seconds. C
>   FTW. (Although this has increased to 1min20sec for more recent
>   builds.)
>=20
>   Most of the configure arguments remove functionality I'll never use
>   (in this situation) and which will only slow down the build.
>=20
>   Once QEMU is built, run qemu-system-i386 directly from where it has
>   been built.
>=20
>   $ /path/to/qemu-working/i386-softmmu/qemu-system-i386 ...
>   $ /path/to/qemu-broken/i386-softmmu/qemu-system-i386 ...
>=20
>   Again, the paths can be relative.
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1745312/+subscriptions
>=20

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyOfAAoJEJykq7OBq3PILwEH/3S6BlwGzEYSD4PjTlC2FW6X
Nyj2EA0oMwuGE/WeIlgKOLiOg9OxTtJziUmzhxIeb/r8iOdUxLZw3EfGQk0LmAqH
MqJHGW9B6IBsK4xtN5pSZTCGRYB6Q0LEs4Xt5C1ojvp96eTqx+akLla97sXmwNMm
VfET2qmCSjs5aAlcWL7a4SUJZINzG9SxHiTzdH0e0VU/FSOj6kddbPeA25EXCjTu
Yrvbe1wWSQeYcqmTA3ACPzwQMHQIYMBbiBoeuKJGFJ0pPiGRjojMYK6OfqQ6Bv95
AVqVW1gpbkjdnHT364jKTfYz1SI1860U6Jo9dFzANE5rMZSN2ZIg7FD3ple9ckY=
=Xhcj
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
