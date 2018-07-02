Received: from eggs.gnu.org ([2001:4830:134:3::10]:51939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTV-0002EW-MF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTU-0004ku-Fm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZqTU-0004kS-8g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZqTT-0001QF-Fq
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 04:30:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 749E32E8075
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 04:30:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 04:17:30 -0000
From: Launchpad Bug Tracker <1305400@bugs.launchpad.net>
Reply-To: Bug 1305400 <1305400@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140410040455.9081.84232.malonedeb@gac.canonical.com>
Message-Id: <153050505031.6988.13769319891228084616.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1305400] Re: qmp-version of memsave makes a zero
 filled dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1305400

Title:
  qmp-version of memsave makes a zero filled dump

Status in QEMU:
  Expired

Bug description:
  calling the memsave function through hmp and qmp makes a different
  results. it happened because hmp_memsave calls synchronization of cpu,
  but qmp_marshal_input_memsave does not. so virDomainMemoryPeek
  (libvirt api) does not work correctly

  1) hmp:
  void hmp_memsave(Monitor *mon, const QDict *qdict)
  {
      uint32_t size =3D qdict_get_int(qdict, "size");
      const char *filename =3D qdict_get_str(qdict, "filename");
      uint64_t addr =3D qdict_get_int(qdict, "val");
      Error *errp =3D NULL;

      qmp_memsave(addr, size, filename, true, <<<< monitor_get_cpu_index() =
>>>, &errp);
      hmp_handle_error(mon, &errp);
  }
  int monitor_get_cpu_index(void)
  {
      CPUState *cpu =3D ENV_GET_CPU(<<< mon_get_cpu >>>());
      return cpu->cpu_index;
  }
  static CPUArchState *mon_get_cpu(void)
  {
      if (!cur_mon->mon_cpu) {
          monitor_set_cpu(0);
      }
      <<< cpu_synchronize_state(cur_mon->mon_cpu); >>>
      return cur_mon->mon_cpu->env_ptr;
  }

  2) qmp
  int qmp_marshal_input_memsave(Monitor *mon, const QDict *qdict, QObject *=
*ret)
  {
      Error *local_err =3D NULL;
      Error **errp =3D &local_err;
      QDict *args =3D (QDict *)qdict;
      QmpInputVisitor *mi;
      QapiDeallocVisitor *md;
      Visitor *v;
      int64_t val;
      int64_t size;
      char * filename =3D NULL;
      bool has_cpu_index =3D false;
      int64_t cpu_index;

      mi =3D qmp_input_visitor_new_strict(QOBJECT(args));
      v =3D qmp_input_get_visitor(mi);
      visit_type_int(v, &val, "val", errp);
      visit_type_int(v, &size, "size", errp);
      visit_type_str(v, &filename, "filename", errp);
      visit_start_optional(v, &has_cpu_index, "cpu-index", errp);
      if (has_cpu_index) {
          visit_type_int(v, &cpu_index, "cpu-index", errp);
      }
      visit_end_optional(v, errp);
      qmp_input_visitor_cleanup(mi);

      if (error_is_set(errp)) {
          goto out;
      }
      <<< qmp_memsave(val, size, filename, has_cpu_index, cpu_index, errp);=
 >>>

  out:
      md =3D qapi_dealloc_visitor_new();
      v =3D qapi_dealloc_get_visitor(md);
      visit_type_int(v, &val, "val", NULL);
      visit_type_int(v, &size, "size", NULL);
      visit_type_str(v, &filename, "filename", NULL);
      visit_start_optional(v, &has_cpu_index, "cpu-index", NULL);
      if (has_cpu_index) {
          visit_type_int(v, &cpu_index, "cpu-index", NULL);
      }
      visit_end_optional(v, NULL);
      qapi_dealloc_visitor_cleanup(md);

      if (local_err) {
          qerror_report_err(local_err);
          error_free(local_err);
          return -1;
      }
      return 0;
  }

  how to reproduce:

  1) run qemu as it makes a libvirtd
  ./qemu-system-x86_64 -name gentoo -machine pc-i440fx-1.7,accel=3Dkvm,usb=
=3Doff -m 1024 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=
=3D1 -uuid 135b3e47-43ca-bc68-e23b-354a2f62a023 -no-user-config -nodefaults=
 -chardev socket,id=3Dcharmonitor,path=3D./gentoo.monitor,server,nowait -mo=
n chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shu=
tdown -boot menu=3Doff,strict=3Don -kernel ./bzImage -append root=3D"/dev/v=
da2 vga=3D38f" -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -=
drive file=3D./gentoo.img,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Draw -d=
evice virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio=
-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D./install-amd64-minima=
l-20140320.iso,if=3Dnone,id=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw -de=
vice ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0,booti=
ndex=3D2 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharser=
ial0,id=3Dserial0 -vnc 127.0.0.1:0 -device qxl-vga,id=3Dvideo0,ram_size=3D6=
7108864,vram_size=3D67108864,bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-=
pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -vnc 127.0.0.1:2 -monitor stdio

  2) attach to qemu through qmp-shell (taken from qemu sources)
  python ./qmp-shell ./gentoo.monitor

  3) make some commands in sequence
  (qmp-shell) memsave memsave val=3D-2130706432 size=3D100 filename=3D./tes=
t01
  (stdio monitor) memsave 0xffffffff81000000 100 ./test02
  (qmp-shell) memsave memsave val=3D-2130706432 size=3D100 filename=3D./tes=
t03

  result:
  test01 - zero filled
  test02 - right
  test03 - right

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1305400/+subscriptions
