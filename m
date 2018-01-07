Received: from eggs.gnu.org ([2001:4830:134:3::10]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eYCJj-0003RD-52
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eYCJe-0008Lk-SS
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:52:55 -0500
Received: from mail.nanotek.info ([188.166.13.56]:40771)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shiftag@nanotek.info>) id 1eYCJe-0008L6-Fs
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:52:50 -0500
Mime-Version: 1.0
Date: Sun, 07 Jan 2018 14:52:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <e59e94af916704f36b0d37c9227efcbf@webmail.nanotek.info>
From: shiftag@nanotek.info
In-Reply-To: <CAFEAcA-r0OEtPHYH27CcB=S7h4SppLUD04C8FuQ1vJfRrAV=Cw@mail.gmail.com>
References: <CAFEAcA-r0OEtPHYH27CcB=S7h4SppLUD04C8FuQ1vJfRrAV=Cw@mail.gmail.com>
	<658f9066c2e35c4dab0343c3ce22a347@webmail.nanotek.info>
Subject: Re: [Qemu-devel] Building QEMU natively from ARM CPU statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

January 7, 2018 6:30 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote=
:=0A=0A> On 7 January 2018 at 06:55, <shiftag@nanotek.info> wrote:=0A> =
=0A>> Hi,=0A>> =0A>> I'm trying to build QEMU statically from ARM CPU (wi=
thout cross-compiling). But at "configure" step=0A>> I have the following=
 issue :=0A>> =0A>> ERROR: User requested feature sdl=0A>> configure was =
not able to find it.=0A>> Install SDL devel=0A>> However, from config.log=
, it seems that issue is not related to SDL.=0A>> =0A>> --------- long pa=
ste ---------=0A>> =0A>> I'm compiling version 2.11.0 so the SDL patch ha=
s already been applied. Also, some libraries errors=0A>> are strange as I=
 can find them on my system, see :=0A>> =0A>> $ pkg-config --cflags --lib=
s p11-kit-1 gnutls hogweed nettle dbus-1=0A>> -I/usr/include/p11-kit-1 -I=
/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -lp11-kit -lgnutls=0A>>=
 -lhogweed -lnettle -ldbus-1=0A> =0A> You forgot --static on the pkg-conf=
ig command line.=0A> But in any case pkg-config is just reporting info fr=
om=0A> a data file, which doesn't necessarily correspond to=0A> what libr=
ary .a and .so files are actually on the system.=0A> (It's your distro's =
packaging and dependency info that's=0A> responsible for making sure that=
 all the dependent=0A> library files are actually installed.)=0A> =0A>> A=
lso, I tried building a shared version (without --static) of qemu-2.11.0 =
and it works fine.=0A> =0A> Problems with trying to build a statically li=
nked=0A> QEMU usually mean:=0A> =0A> * QEMU needs and links against stati=
c library X=0A> * static library X depends on static library Y=0A> * but =
either you don't have the static version of Y=0A> installed (a bug in you=
r distro's library packaging=0A> or dependencies, possibly)=0A> * or the =
pkg-config information that your distro ships=0A> with library X does not=
 correctly declare that it=0A> depends on Y and so Y doesn't go on the li=
st of=0A> libraries QEMU links with=0A> =0A> In this case all the "could =
not find -lfoo" errors=0A> suggests that it's the "you don't have the sta=
tic=0A> library installed" case, and you should be able to fix=0A> this b=
y installing the right static libs from your distro.=0A> =0A> In general,=
 we provide --static for the benefit mostly=0A> of the user-mode emulatio=
n binaries, which have a very=0A> small list of library dependencies. Bui=
lding the system=0A> emulation binaries with --static is rather chancier.=
=0A> =0A> The underlying reason for this kind of problem is that=0A> very=
 few people try to statically link anything, and so=0A> bugs in distro pa=
ckaging of statically linked libraries=0A> very rarely get reported or fi=
xed. Sometimes distros=0A> don't provide static versions of some librarie=
s at all.=0A> As usual, if you wander away from the beaten path you=0A> c=
an run into thornbushes.=0A> =0A=0AOk got it. I will check for static lib=
rairies.=0A=0A> I notice that your configure arguments are rather=0A> odd=
, which might be why you're running into trouble.=0A> =0A> (1) you pass -=
-cpu=3Darm -- this is almost never a good=0A> idea. Let configure autodet=
ect the host CPU for you.=0A> =0A> (2) you pass --target-list=3Dmips-linu=
x-user, which suggest=0A> you just want to build the mips user mode emula=
tor, but=0A> then you also pass a lot of arguments which are only=0A> rel=
evant for system emulation:=0A> --enable-system=0A> --enable-kvm=0A> --en=
able-gtk=0A> --enable-virtfs=0A> --enable-sdl=0A> --disable-vnc=0A> =0A> =
Some of these are going to cause configure to try to=0A> probe for things=
 that mips-linux-user won't even use,=0A> and then complain that it can't=
 find them. If all you=0A> want is mips-linux-user, drop all those other =
arguments.=0A> =0A=0AThank you Peter. I think I can figure out myself how=
 to solve=0Athis issue.=0A=0ACheers.
