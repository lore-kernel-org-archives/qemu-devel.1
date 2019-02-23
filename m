Received: from eggs.gnu.org ([209.51.188.92]:50909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gxN0V-00014g-HG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gxN0T-0004AY-I7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:25:39 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gxN0S-00042D-Sj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:25:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id m10so1876988plt.10
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:25:29 -0800 (PST)
Received: from [192.168.1.103] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	a19sm3441866pfo.52.2019.02.22.18.25.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Feb 2019 18:25:26 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sat, 23 Feb 2019 05:22:17 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z5KcctzWOv/ckPo"
Message-Id: <201902230522.17828.randrianasulu@gmail.com>
Subject: [Qemu-devel] Possible ppc64le regression in master?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--Boundary-00=_Z5KcctzWOv/ckPo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again.

I was trying to set up virtual ppc64le machine with some linux inside. First 
tried with qemu-3.1 on 32-bit host. It worked, but was slow-ish.

next I tred to compile latest qemu git (up to commit 
8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116) on 64-bit Slackware, to get MTTCG 
acceleration.

qemu was successfully compiled with those CFLAGS:


CFLAGS=-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g -O3 -march=native -mtune=native -Wno-maybe-uninitialized

but then when I tried to run it - console was fine, but X inside Alpine Linux 
was all striped!

Going back to 2.12+ compiled last year fixed this issue to me, X is back to 
normal.

I was using this guide:
https://buggy.link/2018/01/31/ppc64le-on-x86_64-qemu-full-system-emulation.html

Command lines tried:

root@slax:~/src/qemu# ppc64-softmmu/qemu-system-ppc64 -m 1024 -display 
sdl,gl=on -smp 3 -hda /mnt/alpine_disk.img -> corruption in X, console ok.

ppc64-softmmu/qemu-system-ppc64 -m 1024 -display sdl,gl=on -vga virtio -smp 3 -M 
pseries-3.1 -hda /mnt/alpine_disk.img -> even console is blue!

root@slax:~/src/qemu# ppc64-softmmu/qemu-system-ppc64 -m 1024 -display 
sdl,gl=on -vga cirrus -smp 1 -M pseries-3.1 -hda /mnt/alpine_disk.img -> same 
blue screen even on console

root@slax:~/src/qemu# ppc64-softmmu/qemu-system-ppc64 -m 1024 -smp 4 -M 
pseries-3.1 -hda /mnt/alpine_disk.img - this defaulted to gtk UI, and  X was 
corrupted anyway :/

root@slax:~/src/qemu# ppc64-softmmu/qemu-system-ppc64 -m 1024 -display 
sdl,gl=on -smp 1 -M pseries-3.1 -hda /mnt/alpine_disk.img -g 1024x768x32 - nice 
big console with correct colors, but X still corrupt!

root@slax:~/src/qemu# qemu-system-ppc64 -m 1024 -display sdl,gl=on -smp 
3  -hda /mnt/alpine_disk.img -g 1024x768x32 -> old qemu still works OK, booted 
right now and compiling stuff.

Attached are files I modified on Alpine install - custom xorg.conf, .xinitrc and 
ash_history (so you can install same set of packages as I)

My host CPU is:
cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 21
model           : 2
model name      : AMD FX(tm)-4300 Quad-Core Processor
stepping        : 0
microcode       : 0x6000852
cpu MHz         : 3222.725
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 16
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb 
rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf 
pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c 
lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch 
osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core 
perfctr_nb cpb hw_pstate ssbd vmmcall bmi1 arat npt lbrv svm_lock nrip_save 
tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass
bogomips        : 7599.87
TLB size        : 1536 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

so, with avx.

I'll try to recompile with less agressive optimizations, and if this will not 
help - bisect .

Thanks for attention.

--Boundary-00=_Z5KcctzWOv/ckPo
Content-Type: text/plain;
  charset="iso 8859-1";
  name=".ash_history"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".ash_history"

apk update
apk upgrade
mc
apk ?
apk --help
apk lsit mc
apk list mc
apk add mc
apk list xorg
apk list xserver
apk list 
apk list perl
apk add perl pythong gcc git svn 
apk add perl python gcc git svn 
apk add perl python gcc git 
top
setup-xorg=base
setup-xorg-base
setup-udev
ps axv
killall -9 apk
apk lsit subversion
apk list subversion
apk add subversion
setup-xorg-base
apk list xfce
apk list fluxbox
apk app fluxbox
apk add fluxbox
apk list xterm
apk list term
apk list *term
apk list | grep term
apk add lxterminal
apk list | grep ffmpeg
apk add ffmpeg
startx
mcedit /etc/X11/xorg.conf
startx
mcedit /etc/X11/xorg.conf
startx
startx -depth 8
lspci
dmesg 
dmesg | grep drm
dmesg | grep boch
dmesg | grep bonch
dmesg | grep fb
apk add mplayer
apk add mpg123
apk add ogg123
apk add ogg321
apk add vorbis-tools
apk add vorbis
apk list | grep vorbis
apk add libvorbis-dev
apk list | grep fbset
apk add fbset
mcedit /etc/X11/xorg.conf
startx
X -configure
apk list | grep fbdev
apk add xf86-video-fbdev
X -configure
startx
apk list | grep xinit
mcedit .xinitrc
startx
apk list | grep xterm
apk list | grep menu
apk add dmenu
apk list | grep xfce
apk add xfce4
startx
mcedit .xinitrc 
startx
uptime
apk add xrandr
xrandr 
xdpyinfo
apk add xdpyinfo
apk list *-dev
apk add *-dev
apk --help
apk add libx11-dev-1.6.6-r0
apk add libx11-dev
apk add ffmpeg-dev
apk list firefox
apk list links
apk add links
apk add imlib2-dev
apk add libxml2-dev
mkdir src
apk add a52dec-dev
ls
cd src
links cinelerra-gg.com
git clone git://git.cinelerra-gg.org/goodguy/cinelerra.git
cd cinelerra/
cd ./cinelerra-5.1/
./autogen.sh 
apk add automake
./autogen.sh 
apk add autoconf m4 flex bison
./autogen.sh 
top
free
apk add gkrellm
apk add xmms
./configure --help
apk add openxr
apk add openexr
./configure 
mcedit config.log
gcc
g++
apk add g++
./configure 
arch
apk add arch
apk add gtk+-2.0-dev
apk add gtk2.0-dev
apk add gtk2-dev
apk list gtk2
apk list gtk-2
apk list gtk+-2
apk list gtk+-2.0
apk list gtk*
apk add gtk+2.0-dev
apk add ccache
apk add nasm yasm
apk add lzma fftw3
apk add xz xz-dev
apk add opus-dev lame-dev
apk add x265-dev x264-dev openjpeg-dev
apk add libasound-dev
apk add asound-dev
apk add alsa
apk add asound
apk add asound-lib
apk list alsa-lib
apk add alsa-dev
apk list alsa*
apk add alsa-lib-dev-1.1.4.1 alsa-utils alsaconf
apk add alsa-lib-dev alsa-utils alsaconf
apk list fftw
make
apk list make
apk add make
apk list patch
apk add patch
apk list tiff*
apk add tiff-dev
apk add cmake
apk list bash
apk list coreutils
apk add coreutils
arch
/usr/bin/arch
ls /bin/arch
ls /sbin/arch
apk info a coreutils
apk info -a coreutils
uname -a
top
free
apk list twolame
uname -a
uname -p
man uname
apk add man
uname -p
whereis uname
apk add whereis
ls /bin/uname
ls -la /bin/uname
uname -h
uname --help
uname -m
uname -p
uname -i
uname -o
uname -a
gcc --version
cat /proc/cpuinfo 
ls /usr/share/autoconf/
ls /usr/share/automake-1.15/config.guess 
 /usr/share/automake-1.15/config.guess 
mc
precmd() { if [ ! "${PWD##$HOME}" ]; then MC_PWD="~"; else [ "${PWD##$HOME/}" = "$PWD" ] && MC_PWD="$PWD" || MC_PWD="~/${PWD##$HOME/}"; fi; echo "$USER@$(hostname -s):$MC_PWD"; pwd>&6; kill -STOP $$; }; PRECMD=precmd; PS1='$($PRECMD)$ '
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057build'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057autotools'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057autotools'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra'`"
 cd "`printf '%b' '\0057root\0057src'`"
 cd "`printf '%b' '\0057root'`"
 cd "`printf '%b' '\0057'`"
 cd "`printf '%b' '\0057usr'`"
 cd "`printf '%b' '\0057usr\0057share'`"
 cd "`printf '%b' '\0057usr\0057share\0057automake\00551\005615'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057autotools'`"
 cd "`printf '%b' '\0057usr\0057share\0057automake\00551\005615'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057autotools'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057twolame\00550\00563\005613'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057twolame\00550\00563\005613\0057build\0055scripts'`"
 cd "`printf '%b' '\0057usr\0057share\0057automake\00551\005615'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057twolame\00550\00563\005613\0057build\0055scripts'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057twolame\00550\00563\005613'`"
apk add diffutils
apk list headers
apk list kernel
apk list kernel*
apk list *header*
apk add linux-headers
free -m
apk add lftp
free -m
apk add gdb
startx
cd src/cinelerra/cinelerra-5.1/
cat /proc/cpuinfo 
make -j 3
poweroff
startx
poweroff
cat /proc/cpuinfo 
lspci
poweroff
cat /proc/cpuinfo 
startx
poweroff
startx
poweroff
startx
poweroff
cat /proc/cpuinfo 
startx
cd src/cinelerra/cinelerra-5.1/
make
mc
precmd() { if [ ! "${PWD##$HOME}" ]; then MC_PWD="~"; else [ "${PWD##$HOME/}" = "$PWD" ] && MC_PWD="$PWD" || MC_PWD="~/${PWD##$HOME/}"; fi; echo "$USER@$(hostname -s):$MC_PWD"; pwd>&6; kill -STOP $$; }; PRECMD=precmd; PS1='$($PRECMD)$ '
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libtheora\00551\00561\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra'`"
 cd "`printf '%b' '\0057root\0057src'`"
 cd "`printf '%b' '\0057root'`"
 cd "`printf '%b' '\0057'`"
 cd "`printf '%b' '\0057rules\0056d'`"
 cd "`printf '%b' '\0057'`"
 cd "`printf '%b' '\0057usr'`"
 cd "`printf '%b' '\0057usr\0057share'`"
 cd "`printf '%b' '\0057usr\0057share\0057automake\00551\005615'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libtheora\00551\00561\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libuuid\00551\00560\00563'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libvorbis\00551\00563\00566'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libvorbis\00551\00563\00566\0057lib'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057libvorbis\00551\00563\00566'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057liba52'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057libao'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057libao'`"
make
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057liba52'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057liba52\0057\0056libs'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564\0057liba52'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057a52dec\00550\00567\00564'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057build'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty\0057flac\00551\00563\00562'`"
 cd "`printf '%b' '\0057root\0057src\0057cinelerra\0057cinelerra\00555\00561\0057thirdparty'`"
lftp 10.0.2.2
man apk
apk list apk*
apk list doc*
apk list *doc*
apk list *doc
apk list doc
apk --help
cat ~/.ash_history 
lftp 10.0.2.2

--Boundary-00=_Z5KcctzWOv/ckPo
Content-Type: text/plain;
  charset="iso 8859-1";
  name=".xinitrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".xinitrc"

startxfce4
#startfluxbox
--Boundary-00=_Z5KcctzWOv/ckPo
Content-Type: text/plain;
  charset="iso 8859-1";
  name="xorg.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xorg.conf"

Section  "Device"
    Identifier "Device0"
    Driver "fbdev" 
EndSection
--Boundary-00=_Z5KcctzWOv/ckPo--
