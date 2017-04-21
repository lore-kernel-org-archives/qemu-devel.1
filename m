Received: from eggs.gnu.org ([2001:4830:134:3::10]:35766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d1qcl-0006j1-Lu
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d1qcf-0006Kw-Ui
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:42:31 -0400
Date: Fri, 21 Apr 2017 22:41:23 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170421204123.bdftoeuko6lwox3x@eukaryote>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y4bj7kkphpiih5ns"
Content-Disposition: inline
Subject: [Qemu-devel] [QEMU-2.8] Source QEMU crashes with: "bdrv_co_pwritev:
 Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org


--y4bj7kkphpiih5ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have seen a bunch of reports about this assertion error (on source
QEMU).  [At least I recall Greg Kurz mentioning this a week or so ago on
#qemu, OFTC.]

I just noticed this crash in upstream OpenStack CI environment.  This
seems to occur (only intermittently, though) during live migration
without shared-storage.

[I've attached the complete source and destination QEMU command-line in
a separate plain text file.]

But here are the errors from source and destination QEMU:

Source QEMU:
-----------------------------------------------------------------------
[...]
2017-04-21 13:54:08.505+0000: initiating migration
qemu-system-x86_64: /build/qemu-5OJ39u/qemu-2.8+dfsg/block/io.c:1514: bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
2017-04-21 13:54:08.791+0000: shutting down, reason=crashed
-----------------------------------------------------------------------

Destination QEMU:
-----------------------------------------------------------------------
[...]
/build/qemu-5OJ39u/qemu-2.8+dfsg/nbd/server.c:nbd_receive_request():L710: read failed
2017-04-21 13:54:08.792+0000: shutting down, reason=failed
2017-04-21T13:54:08.793259Z qemu-system-x86_64: terminating on signal 15 from pid 12160 (/usr/sbin/libvirtd)
-----------------------------------------------------------------------

Any hints as how to how to deal with this in QEMU 2.8?

FWIW, the upstream OpenStack CI only very recently moved to QEMU 2.8, so
it is unlikely that the CI env will move to the just-released 2.9
anytime soon.  (But there's work in progress to create a CI job that
tests with QEMU 2.9.)

-- 
/kashyap

--y4bj7kkphpiih5ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="QEMU-command-line-for-source-and-dest-bdrv_co_pwritev.txt"
Content-Transfer-Encoding: quoted-printable

Source QEMU:
-----------------------------------------------------------------------

2017-04-21 13:54:03.632+0000: starting up libvirt version: 2.5.0, package: =
3ubuntu5~cloud0 (Openstack Ubuntu Testing Bot <openstack-testing-bot@ubuntu=
=2Ecom> Tue, 21 Mar 2017 21:54:49 +0000), qemu version: 2.8.0(Debian 1:2.8+=
dfsg-3ubuntu2~cloud0), hostname: ubuntu-xenial-2-node-osic-cloud1-s3500-852=
7282-539390
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/=
bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name guest=3Dinstanc=
e-00000001,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=3Dra=
w,file=3D/var/lib/libvirt/qemu/domain-1-instance-00000001/master-key.aes -m=
achine pc-i440fx-zesty,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff -m 64 -r=
ealtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid 9bf9f268=
-5242-4b1d-8fe6-ee348b2b8d3e -smbios 'type=3D1,manufacturer=3DOpenStack Fou=
ndation,product=3DOpenStack Nova,version=3D15.0.4,serial=3D84d813aa-3d3e-42=
50-bcac-cb0c61adf1ef,uuid=3D9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e,family=3DV=
irtual Machine' -display none -no-user-config -nodefaults -chardev socket,i=
d=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1-instance-00000001/mon=
itor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcont=
rol -rtc base=3Dutc -no-shutdown -boot strict=3Don -kernel /opt/stack/data/=
nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/kernel -initrd /opt/sta=
ck/data/nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/ramdisk -append=
 'root=3D/dev/vda console=3Dtty0 console=3DttyS0 no_timer_check' -device pi=
ix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/opt/stack/d=
ata/nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/disk,format=3Dqcow2=
,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone -device virtio-blk-pci,scsi=
=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,=
bootindex=3D1 -add-fd set=3D0,fd=3D29 -chardev pty,id=3Dcharserial0,logfile=
=3D/dev/fdset/0,logappend=3Don -device isa-serial,chardev=3Dcharserial0,id=
=3Dserial0 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 =
-msg timestamp=3Don
char device redirected to /dev/pts/0 (label charserial0)
warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
2017-04-21 13:54:08.505+0000: initiating migration
qemu-system-x86_64: /build/qemu-5OJ39u/qemu-2.8+dfsg/block/io.c:1514: bdrv_=
co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
2017-04-21 13:54:08.791+0000: shutting down, reason=3Dcrashed

-----------------------------------------------------------------------

Destination QEMU:
-----------------------------------------------------------------------
2017-04-21 13:54:08.142+0000: starting up libvirt version: 2.5.0, package: =
3ubuntu5~cloud0 (Openstack Ubuntu Testing Bot <openstack-testing-bot@ubuntu=
=2Ecom> Tue, 21 Mar 2017 21:54:49 +0000), qemu version: 2.8.0(Debian 1:2.8+=
dfsg-3ubuntu2~cloud0), hostname: ubuntu-xenial-2-node-osic-cloud1-s3500-852=
7282
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/=
bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name guest=3Dinstanc=
e-00000001,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=3Dra=
w,file=3D/var/lib/libvirt/qemu/domain-2-instance-00000001/master-key.aes -m=
achine pc-i440fx-zesty,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff -m 64 -r=
ealtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid 9bf9f268=
-5242-4b1d-8fe6-ee348b2b8d3e -smbios 'type=3D1,manufacturer=3DOpenStack Fou=
ndation,product=3DOpenStack Nova,version=3D15.0.4,serial=3D84d813aa-3d3e-42=
50-bcac-cb0c61adf1ef,uuid=3D9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e,family=3DV=
irtual Machine' -display none -no-user-config -nodefaults -chardev socket,i=
d=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-2-instance-00000001/mon=
itor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcont=
rol -rtc base=3Dutc -no-shutdown -boot strict=3Don -kernel /opt/stack/data/=
nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/kernel -initrd /opt/sta=
ck/data/nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/ramdisk -append=
 'root=3D/dev/vda console=3Dtty0 console=3DttyS0 no_timer_check' -device pi=
ix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/opt/stack/d=
ata/nova/instances/9bf9f268-5242-4b1d-8fe6-ee348b2b8d3e/disk,format=3Dqcow2=
,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone -device virtio-blk-pci,scsi=
=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,=
bootindex=3D1 -add-fd set=3D0,fd=3D35 -chardev pty,id=3Dcharserial0,logfile=
=3D/dev/fdset/0,logappend=3Don -device isa-serial,chardev=3Dcharserial0,id=
=3Dserial0 -incoming defer -device virtio-balloon-pci,id=3Dballoon0,bus=3Dp=
ci.0,addr=3D0x3 -msg timestamp=3Don
char device redirected to /dev/pts/1 (label charserial0)
warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
/build/qemu-5OJ39u/qemu-2.8+dfsg/nbd/server.c:nbd_receive_request():L710: r=
ead failed
2017-04-21 13:54:08.792+0000: shutting down, reason=3Dfailed
2017-04-21T13:54:08.793259Z qemu-system-x86_64: terminating on signal 15 fr=
om pid 12160 (/usr/sbin/libvirtd)
-----------------------------------------------------------------------


--y4bj7kkphpiih5ns--
