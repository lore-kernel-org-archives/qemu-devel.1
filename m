Received: from eggs.gnu.org ([2001:4830:134:3::10]:35944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9OxR-0007v7-Vc
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9OxO-0002Ba-27
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:19:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9OxM-00029R-Ul
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:19:21 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 31 Oct 2017 05:19:08 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C319B8@dggemm509-mbs.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Bug] virtio-blk: qemu will crash if hotplug
 virtio-blk device failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I found that hotplug virtio-blk device will lead to qemu crash.

Re-production steps:

1.       Run VM named vm001

2.       Create a virtio-blk.xml which contains wrong configurations:
<disk device=3D"lun" rawio=3D"yes" type=3D"block">
  <driver cache=3D"none" io=3D"native" name=3D"qemu" type=3D"raw" />
  <source dev=3D"/dev/mapper/11-dm" />
  <target bus=3D"virtio" dev=3D"vdx" />
</disk>

3.       Run command : virsh attach-device vm001 vm001

Libvirt will return err msg:

error: Failed to attach device from blk-scsi.xml

error: internal error: unable to execute QEMU command 'device_add': Please =
set scsi=3Doff for virtio-blk devices in order to use virtio 1.0

it means hotplug virtio-blk device failed.

4.       Suspend or shutdown VM will leads to qemu crash



from gdb:


(gdb) bt
#0  object_get_class (obj=3Dobj@entry=3D0x0) at qom/object.c:750
#1  0x00007f9a72582e01 in virtio_vmstate_change (opaque=3D0x7f9a73d10960, r=
unning=3D0, state=3D<optimized out>) at /mnt/sdb/lzc/code/open/qemu/hw/virt=
io/virtio.c:2203
#2  0x00007f9a7261ef52 in vm_state_notify (running=3Drunning@entry=3D0, sta=
te=3Dstate@entry=3DRUN_STATE_PAUSED) at vl.c:1685
#3  0x00007f9a7252603a in do_vm_stop (state=3DRUN_STATE_PAUSED) at /mnt/sdb=
/lzc/code/open/qemu/cpus.c:941
#4  vm_stop (state=3Dstate@entry=3DRUN_STATE_PAUSED) at /mnt/sdb/lzc/code/o=
pen/qemu/cpus.c:1807
#5  0x00007f9a7262eb1b in qmp_stop (errp=3Derrp@entry=3D0x7ffe63e25590) at =
qmp.c:102
#6  0x00007f9a7262c70a in qmp_marshal_stop (args=3D<optimized out>, ret=3D<=
optimized out>, errp=3D0x7ffe63e255d8) at qmp-marshal.c:5854
#7  0x00007f9a72897e79 in do_qmp_dispatch (errp=3D0x7ffe63e255d0, request=
=3D0x7f9a76510120, cmds=3D0x7f9a72ee7980 <qmp_commands>) at qapi/qmp-dispat=
ch.c:104
#8  qmp_dispatch (cmds=3D0x7f9a72ee7980 <qmp_commands>, request=3Drequest@e=
ntry=3D0x7f9a76510120) at qapi/qmp-dispatch.c:131
#9  0x00007f9a725288d5 in handle_qmp_command (parser=3D<optimized out>, tok=
ens=3D<optimized out>) at /mnt/sdb/lzc/code/open/qemu/monitor.c:3852
#10 0x00007f9a7289d514 in json_message_process_token (lexer=3D0x7f9a73ce449=
8, input=3D0x7f9a73cc6880, type=3DJSON_RCURLY, x=3D36, y=3D17) at qobject/j=
son-streamer.c:105
#11 0x00007f9a728bb69b in json_lexer_feed_char (lexer=3Dlexer@entry=3D0x7f9=
a73ce4498, ch=3D125 '}', flush=3Dflush@entry=3Dfalse) at qobject/json-lexer=
.c:323
#12 0x00007f9a728bb75e in json_lexer_feed (lexer=3D0x7f9a73ce4498, buffer=
=3D<optimized out>, size=3D<optimized out>) at qobject/json-lexer.c:373
#13 0x00007f9a7289d5d9 in json_message_parser_feed (parser=3D<optimized out=
>, buffer=3D<optimized out>, size=3D<optimized out>) at qobject/json-stream=
er.c:124
#14 0x00007f9a7252722e in monitor_qmp_read (opaque=3D<optimized out>, buf=
=3D<optimized out>, size=3D<optimized out>) at /mnt/sdb/lzc/code/open/qemu/=
monitor.c:3894
#15 0x00007f9a7284ee1b in tcp_chr_read (chan=3D<optimized out>, cond=3D<opt=
imized out>, opaque=3D<optimized out>) at chardev/char-socket.c:441
#16 0x00007f9a6e03e99a in g_main_context_dispatch () from /usr/lib64/libgli=
b-2.0.so.0
#17 0x00007f9a728a342c in glib_pollfds_poll () at util/main-loop.c:214
#18 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loop.c:=
261
#19 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-loop.=
c:515
#20 0x00007f9a724e7547 in main_loop () at vl.c:1999
#21 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimized=
 out>) at vl.c:4877

Problem happens in virtio_vmstate_change which is called by vm_state_notify=
,
static void virtio_vmstate_change(void *opaque, int running, RunState state=
)
{
    VirtIODevice *vdev =3D opaque;
    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
    bool backend_run =3D running && (vdev->status & VIRTIO_CONFIG_S_DRIVER_=
OK);
    vdev->vm_running =3D running;

    if (backend_run) {
        virtio_set_status(vdev, vdev->status);
    }

    if (k->vmstate_change) {
        k->vmstate_change(qbus->parent, backend_run);
    }

    if (!backend_run) {
        virtio_set_status(vdev, vdev->status);
    }
}

Vdev's parent_bus is NULL, so qdev_get_parent_bus(DEVICE(vdev)) will crash.
virtio_vmstate_change is added to the list vm_change_state_head at virtio_b=
lk_device_realize(virtio_init),
but after hotplug virtio-blk failed, virtio_vmstate_change will not be remo=
ved from vm_change_state_head.


I apply a patch as follews:

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5884ce3..ea532dc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2491,6 +2491,7 @@ static void virtio_device_realize(DeviceState *dev, E=
rror **errp)
     virtio_bus_device_plugged(vdev, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
+        vdc->unrealize(dev, NULL);
         return;
     }
