Received: from [2001:4830:134:3::10] (port=60756 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1z-0007Ks-P7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1s-0002oT-6R
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpd1r-0002lv-Sw
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpbyx-00045S-IJ
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 16:15:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 835572E851B
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 16:15:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 16:02:40 -0000
From: Thomas Huth <1488901@bugs.launchpad.net>
Reply-To: Bug 1488901 <1488901@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150826101824.19252.42990.malonedeb@wampee.canonical.com>
Message-Id: <153426256028.24411.7071091514200133339.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1488901] Re: KVM guest crashes when doing a block
 commit command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to the previous comment

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1488901

Title:
  KVM guest crashes when doing a block commit command

Status in QEMU:
  Fix Released

Bug description:
  I scripted a simple backup procedure that works like this:

  1. Create snapshot

          virsh snapshot-create-as ${VM} "backup-${VM}" \
              --diskspec vda,file=3D${SNAP}/backup-snapshot-${VM}.qcow2 \
              --disk-only \
              --atomic \
              --quiesce \
              --no-metadata

  2. Copy disk image to different location

      cp -f --sparse=3Dalways /var/lib/libvirt/images/${VM}.img ${DST}/

  3. Merge snapshot back to base image

      virsh blockcommit ${VM} vda --wait --active --verbose
      virsh blockjob ${VM} ${SNAP}/backup-snapshot-${VM}.qcow2 --pivot

  4. Copy XML liver file

      cp -f /etc/libvirt/qemu/${VM}.xml ${DST}/

  5. Remove old snapshot file

          rm -f ${SNAP}/backup-snapshot-${VM}.qcow2

  When it comes to the blockcommit operation, the guest receives a
  SIGABRT.

  (gdb) bt
  #0  0x00007f4b6e6ccb8e in raise () from /lib64/libc.so.6
  #1  0x00007f4b6e6ce391 in abort () from /lib64/libc.so.6
  #2  0x0000555a316a8c39 in qemu_coroutine_enter (co=3D0x555a34651a50, opaq=
ue=3D0x0)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/qemu-cor=
outine.c:111
  #3  0x0000555a316a8eda in qemu_co_queue_run_restart (co=3Dco@entry=3D0x55=
5a33d271b0)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/qemu-cor=
outine-lock.c:59
  #4  0x0000555a316a8b53 in qemu_coroutine_enter (co=3D0x555a33d271b0, opaq=
ue=3D<optimized out>)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/qemu-cor=
outine.c:118
  #5  0x0000555a316e3adf in bdrv_co_aio_rw_vector (bs=3Dbs@entry=3D0x555a33=
6a6be0,
      sector_num=3Dsector_num@entry=3D113551488, qiov=3Dqiov@entry=3D0x555a=
3367d2c8,
      nb_sectors=3Dnb_sectors@entry=3D15360, flags=3Dflags@entry=3D(unknown=
: 0),
      cb=3Dcb@entry=3D0x555a316e1fe0 <mirror_read_complete>, opaque=3D0x555=
a3367d2c0, is_write=3Dis_write@entry=3Dfalse)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/block/io=
.c:2142
  #6  0x0000555a316e4b1e in bdrv_aio_readv (bs=3Dbs@entry=3D0x555a336a6be0,
      sector_num=3Dsector_num@entry=3D113551488, qiov=3Dqiov@entry=3D0x555a=
3367d2c8,
      nb_sectors=3Dnb_sectors@entry=3D15360, cb=3Dcb@entry=3D0x555a316e1fe0=
 <mirror_read_complete>,
      opaque=3Dopaque@entry=3D0x555a3367d2c0)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/block/io=
.c:1744
  #7  0x0000555a316e2ccf in mirror_iteration (s=3D0x555a34a0c250)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/block/mi=
rror.c:302
  #8  mirror_run (opaque=3D0x555a34a0c250)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/block/mi=
rror.c:512
  #9  0x0000555a316a9a5a in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>)
      at /var/tmp/portage/app-emulation/qemu-2.4.0/work/qemu-2.4.0/coroutin=
e-ucontext.c:80
  #10 0x00007f4b6e6df4a0 in ?? () from /lib64/libc.so.6
  #11 0x00007ffe67b71840 in ?? ()
  #12 0x0000000000000000 in ?? ()
  (gdb)

  There is one very interesting aspect:

  After the guest died, I can restart it and if I do the exact same
  blockcommit and blockjob as shown above, everything succeeds without
  errors. That's strange.

  This is from my libvirt log. So you can see how the guest was started
  and the C-routine error message:

  2015-08-24 18:38:13.077+0000: starting up libvirt version: 1.2.18, qemu v=
ersion: 2.4.0
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name mx.roessner-n=
et.de-TESTING -S -machine pc-i440fx-2.1,accel=3Dkvm,usb=3Doff -cpu qemu64,+=
kvm_pv_eoi -m 4096 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threa=
ds=3D1 -uuid d86b82d5-153f-4dd9-aa66-d98c2e65db8c -no-user-config -nodefaul=
ts -device sga -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qem=
u/mx.roessner-net.de-TESTING.monitor,server,nowait -mon chardev=3Dcharmonit=
or,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-=
pit.lost_tick_policy=3Ddiscard -no-shutdown -boot order=3Dcd,menu=3Don,stri=
ct=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device =
virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x8 -drive file=3D=
/var/lib/libvirt/images/mx.roessner-net.de-TESTING.img,if=3Dnone,id=3Ddrive=
-virtio-disk0,format=3Draw,cache=3Dwriteback -device virtio-blk-pci,scsi=3D=
off,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 -dr=
ive if=3Dnone,id=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw -device ide-cd=
,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev tap,fd=
=3D34,id=3Dhostnet0,vhost=3Don,vhostfd=3D35 -device virtio-net-pci,netdev=
=3Dhostnet0,id=3Dnet0,mac=3D54:52:00:27:ac:8d,bus=3Dpci.0,addr=3D0x3 -chard=
ev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dseria=
l0 -chardev socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/t=
arget/mx.roessner-net.de-TESTING.org.qemu.guest_agent.0,server,nowait -devi=
ce virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=
=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -vnc 127.0.0.1:7 -device cirrus-v=
ga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device i6300esb,id=3Dwatchdog0,bus=
=3Dpci.0,addr=3D0x7 -watchdog-action reset -device virtio-balloon-pci,id=3D=
balloon0,bus=3Dpci.0,addr=3D0x5 -object rng-random,id=3Dobjrng0,filename=3D=
/dev/random -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=
=3D0x6 -msg timestamp=3Don
  char device redirected to /dev/pts/8 (label charserial0)
  Formatting '/var/backups/snapshots/backup-snapshot-mx.roessner-net.de-TES=
TING.qcow2', fmt=3Dqcow2 size=3D107374182400 backing_file=3D'/var/lib/libvi=
rt/images/mx.roessner-net.de-TESTING.img' backing_fmt=3D'raw' encryption=3D=
off cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
  Formatting '/var/backups/snapshots/backup-snapshot-mx.roessner-net.de-TES=
TING.qcow2', fmt=3Dqcow2 size=3D107374182400 backing_file=3D'/var/lib/libvi=
rt/images/mx.roessner-net.de-TESTING.img' backing_fmt=3D'raw' encryption=3D=
off cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
  Co-routine re-entered recursively
  2015-08-24 19:43:17.700+0000: shutting down

  Here is my envirmornment information:

  emerge --info qemu
  Portage 2.2.20.1 (python 2.7.9-final-0, hardened/linux/amd64/no-multilib,=
 gcc-4.8.4, glibc-2.20-r2, 4.1.6-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                           System Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  System uname: Linux-4.1.6-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_L5520_@_2.27=
GHz-with-gentoo-2.2
  KiB Mem:    49454932 total,   7729532 free
  KiB Swap:    2097148 total,   2097148 free
  Timestamp of repository gentoo: Tue, 25 Aug 2015 21:15:01 +0000
  sh bash 4.3_p39
  ld GNU ld (Gentoo 2.24 p1.4) 2.24
  ccache version 3.1.9 [enabled]
  app-shells/bash:          4.3_p39::gentoo
  dev-lang/perl:            5.20.2::gentoo
  dev-lang/python:          2.7.9-r1::gentoo, 3.4.1::gentoo
  dev-util/ccache:          3.1.9-r4::gentoo
  dev-util/cmake:           3.2.2::gentoo
  dev-util/pkgconfig:       0.28-r2::gentoo
  sys-apps/baselayout:      2.2::gentoo
  sys-apps/openrc:          0.17::gentoo
  sys-apps/sandbox:         2.6-r1::gentoo
  sys-devel/autoconf:       2.69::gentoo
  sys-devel/automake:       1.14.1::gentoo, 1.15::gentoo
  sys-devel/binutils:       2.24-r3::gentoo
  sys-devel/gcc:            4.8.4::gentoo
  sys-devel/gcc-config:     1.7.3::gentoo
  sys-devel/libtool:        2.4.6::gentoo
  sys-devel/make:           4.1-r1::gentoo
  sys-kernel/linux-headers: 3.18::gentoo (virtual/os-headers)
  sys-libs/glibc:           2.20-r2::gentoo
  Repositories:

  gentoo
      location: /usr/portage
      sync-type: rsync
      sync-uri: rsync://rsync.europe.gentoo.org/gentoo-portage
      priority: -1000

  x-portage
      location: /usr/local/portage
      masters: gentoo
      priority: 0

  ACCEPT_KEYWORDS=3D"amd64"
  ACCEPT_LICENSE=3D"* -@EULA"
  CBUILD=3D"x86_64-pc-linux-gnu"
  CFLAGS=3D"-O2 -pipe"
  CHOST=3D"x86_64-pc-linux-gnu"
  CONFIG_PROTECT=3D"/etc /usr/share/easy-rsa /usr/share/gnupg/qualified.txt"
  CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/env.d /etc/fonts/fo=
nts.conf /etc/gconf /etc/gentoo-release /etc/php/apache2-php5.6/ext-active/=
 /etc/php/cgi-php5.6/ext-active/ /etc/php/cli-php5.6/ext-active/ /etc/revde=
p-rebuild /etc/sandbox.d /etc/terminfo"
  CXXFLAGS=3D"-O2 -pipe"
  DISTDIR=3D"/usr/portage/distfiles"
  EMERGE_DEFAULT_OPTS=3D"--keep-going --with-bdeps=3Dy --binpkg-respect-use=
=3Dy --binpkg-changed-deps=3Dy --usepkg=3Dy --rebuilt-binaries=3Dy --rebuil=
t-binaries-timestamp=3D20140405050000"
  FCFLAGS=3D"-O2 -pipe"
  FEATURES=3D"assume-digests binpkg-logs ccache compressdebug config-protec=
t-if-modified distlocks ebuild-locks fixlafiles merge-sync news parallel-fe=
tch preserve-libs protect-owned sandbox sfperms strict unknown-features-war=
n unmerge-logs unmerge-orphans userfetch userpriv usersandbox usersync xatt=
r"
  FFLAGS=3D"-O2 -pipe"
  GENTOO_MIRRORS=3D"http://de-mirror.org/gentoo/ rsync://de-mirror.org/gent=
oo/"
  LANG=3D"en_US.utf8"
  LC_ALL=3D"en_US.UTF-8"
  LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed"
  MAKEOPTS=3D"-j17"
  PKGDIR=3D"/export/packages"
  PORTAGE_CONFIGROOT=3D"/"
  PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --=
omit-dir-times --compress --force --whole-file --delete --stats --human-rea=
dable --timeout=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=
=3D/packages"
  PORTAGE_TMPDIR=3D"/var/tmp"
  USE=3D"acl adns aio amd64 bacula-clientonly bacula-console bash-completio=
n berkdb bindist btrfs bzip2 caps cli cracklib crypt curl cxx device-mapper=
 dri gdbm hardened iconv ipv6 justify logrotate loop-aes lzo mmap mmx mmxex=
t modules ncurses nls nptl nscd ntp openmp openssl pam pax_kernel pcre pie =
readline seccomp session sse sse2 ssl ssp systemd tcpd threads unicode uran=
dom vim-syntax xattr xtpax zlib" ABI_X86=3D"64" ALSA_CARDS=3D"ali5451 als40=
00 atiixp atiixp-modem bt87x ca0106 cmipci emu10k1x ens1370 ens1371 es1938 =
es1968 fm801 hda-intel intel8x0 intel8x0m maestro3 trident usb-audio via82x=
x via82xx-modem ymfpci" APACHE2_MODULES=3D"authn_core authz_core socache_sh=
mcb unixd actions alias auth_basic authn_alias authn_anon authn_dbm authn_d=
efault authn_file authz_dbm authz_default authz_groupfile authz_host authz_=
owner authz_user autoindex cache cgi cgid dav dav_fs dav_lock deflate dir d=
isk_cache env expires ext_filter file_cache filter headers include info log=
_config logio mem_cache mime mime_magic negotiation rewrite setenvif spelin=
g status unique_id userdir usertrack vhost_alias" CALLIGRA_FEATURES=3D"kexi=
 words flow plan sheets stage tables krita karbon braindump author" CAMERAS=
=3D"ptp2" COLLECTD_PLUGINS=3D"df interface irq load memory rrdtool swap sys=
log aggregation cgroups contextswitch cpu cpufreq curl curl_json curl_xml d=
isk email entropy ethstat exec filecount fscache hddtemp ipmi iptables logf=
ile multimeter netlink network nfs nginx ntpd numa openvpn ping postgresql =
processes protocols python sensors snmp uptime users uuid" CPU_FLAGS_X86=3D=
"mmx sse sse2" ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate ev=
ermore fv18 garmin garmintxt gpsclock itrax mtk3301 nmea ntrip navcom ocean=
server oldstyle oncore rtcm104v2 rtcm104v3 sirf superstar2 timing tsip trip=
mate tnt ublox ubx" INPUT_DEVICES=3D"keyboard mouse evdev" KERNEL=3D"linux"=
 LCD_DEVICES=3D"bayrad cfontz cfontz633 glk hd44780 lb216 lcdm001 mtxorb nc=
urses text" LIBREOFFICE_EXTENSIONS=3D"presenter-console presenter-minimizer=
" LINGUAS=3D"de en" NGINX_MODULES_HTTP=3D"access auth_basic autoindex brows=
er charset dav empty_gif fastcgi geo gzip headers_more limit_conn limit_req=
 map memcached proxy referer rewrite scgi spdy split_clients ssi upstream_i=
p_hash userid uwsgi" OFFICE_IMPLEMENTATION=3D"libreoffice" PHP_TARGETS=3D"p=
hp5-6" PYTHON_SINGLE_TARGET=3D"python2_7" PYTHON_TARGETS=3D"python2_7 pytho=
n3_4" QEMU_SOFTMMU_TARGETS=3D"x86_64 i386" QEMU_USER_TARGETS=3D"x86_64 i386=
" RUBY_TARGETS=3D"ruby19 ruby20" USERLAND=3D"GNU" VIDEO_CARDS=3D"fbdev glin=
t intel mach64 mga nouveau nv r128 radeon savage sis tdfx trident vesa via =
vmware dummy v4l" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 ipv4opt=
ions ipset ipp2p iface geoip fuzzy condition tee tarpit sysrq steal rawnat =
logmark ipmark dhcpmac delude chaos account"
  Unset:  CC, CPPFLAGS, CTARGET, CXX, INSTALL_MASK, PORTAGE_BUNZIP2_COMMAND=
, PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS, PORTAGE_RSYNC_EXTRA_OPTS, USE_P=
YTHON

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                          Package Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  app-emulation/qemu-2.4.0::gentoo was built with the following:
  USE=3D"aio caps curl debug fdt filecaps iscsi jpeg lzo ncurses nfs nls pi=
n-upstream-blobs png python sasl seccomp snappy spice ssh systemtap threads=
 tls usb usbredir uuid vhost-net virtfs vnc xattr xfs -accessibility -alsa =
-bluetooth -glusterfs -gtk -gtk2 -infiniband -numa -opengl -pulseaudio -rbd=
 -sdl -sdl2 (-selinux) -smartcard -static -static-softmmu -static-user -tci=
 -test -vde -vte -xen" PYTHON_TARGETS=3D"python2_7" QEMU_SOFTMMU_TARGETS=3D=
"i386 x86_64 -aarch64 (-alpha) (-arm) -cris -lm32 (-m68k) -microblaze -micr=
oblazeel (-mips) -mips64 -mips64el -mipsel -moxie -or32 (-ppc) (-ppc64) -pp=
cemb -s390x -sh4 -sh4eb (-sparc) -sparc64 -unicore32 -xtensa -xtensaeb" QEM=
U_USER_TARGETS=3D"i386 x86_64 -aarch64 (-alpha) (-arm) -armeb -cris (-m68k)=
 -microblaze -microblazeel (-mips) -mips64 -mips64el -mipsel -mipsn32 -mips=
n32el -or32 (-ppc) (-ppc64) -ppc64abi32 -s390x -sh4 -sh4eb (-sparc) -sparc3=
2plus -sparc64 -unicore32"

  >>> Attempting to run pkg_info() for 'app-emulation/qemu-2.4.0'
  Using:
    app-emulation/spice-protocol-0.12.3
    sys-firmware/ipxe-1.0.0_p20130925
    sys-firmware/seabios-1.7.5
      USE=3Dbinary
    sys-firmware/vgabios-0.7a

  The server hardware is a HP ProLiant SE316M1-R2 (also known as DL160
  G6) with 48GB RAM and a RAID1+0 with 15k SAS disks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1488901/+subscriptions
