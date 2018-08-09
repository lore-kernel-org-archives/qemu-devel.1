Received: from eggs.gnu.org ([2001:4830:134:3::10]:55552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMp-0001rp-2l
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMm-00068t-EA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:35 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  9 Aug 2018 13:44:17 +0200
Message-Id: <20180809114417.28718-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180809114417.28718-1-marcandre.lureau@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] RFC: fix megasas leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

tests/cdrom-test -p /x86_64/cdrom/boot/megasas

Produces the following ASAN leak.

=3D=3D25700=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f06f8faac48 in malloc (/lib64/libasan.so.5+0xeec48)
    #1 0x7f06f87a73c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
    #2 0x55a729f17738 in pci_dma_sglist_init /home/elmarco/src/qq/include=
/hw/pci/pci.h:818
    #3 0x55a729f2a706 in megasas_map_dcmd /home/elmarco/src/qq/hw/scsi/me=
gasas.c:698
    #4 0x55a729f39421 in megasas_handle_dcmd /home/elmarco/src/qq/hw/scsi=
/megasas.c:1574
    #5 0x55a729f3f70d in megasas_handle_frame /home/elmarco/src/qq/hw/scs=
i/megasas.c:1955
    #6 0x55a729f40939 in megasas_mmio_write /home/elmarco/src/qq/hw/scsi/=
megasas.c:2119
    #7 0x55a729f41102 in megasas_port_write /home/elmarco/src/qq/hw/scsi/=
megasas.c:2170
    #8 0x55a729220e60 in memory_region_write_accessor /home/elmarco/src/q=
q/memory.c:527
    #9 0x55a7292212b3 in access_with_adjusted_size /home/elmarco/src/qq/m=
emory.c:594
    #10 0x55a72922cf70 in memory_region_dispatch_write /home/elmarco/src/=
qq/memory.c:1473
    #11 0x55a7290f5907 in flatview_write_continue /home/elmarco/src/qq/ex=
ec.c:3255
    #12 0x55a7290f5ceb in flatview_write /home/elmarco/src/qq/exec.c:3294
    #13 0x55a7290f6457 in address_space_write /home/elmarco/src/qq/exec.c=
:3384
    #14 0x55a7290f64a8 in address_space_rw /home/elmarco/src/qq/exec.c:33=
95
    #15 0x55a72929ecb0 in kvm_handle_io /home/elmarco/src/qq/accel/kvm/kv=
m-all.c:1729
    #16 0x55a7292a0db5 in kvm_cpu_exec /home/elmarco/src/qq/accel/kvm/kvm=
-all.c:1969
    #17 0x55a7291c4212 in qemu_kvm_cpu_thread_fn /home/elmarco/src/qq/cpu=
s.c:1215
    #18 0x55a72a966a6c in qemu_thread_start /home/elmarco/src/qq/util/qem=
u-thread-posix.c:504
    #19 0x7f06ed486593 in start_thread (/lib64/libpthread.so.0+0x7593)

I suppose megasas_complete_command() should take care of destroying
the sglist instead, so I leave that patch as RFC for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/scsi/megasas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index ba1afa3c1e..2a16397b3b 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -465,6 +465,7 @@ static void megasas_unmap_frame(MegasasState *s, Mega=
sasCmd *cmd)
     cmd->pa =3D 0;
     cmd->pa_size =3D 0;
     clear_bit(cmd->index, s->frame_map);
+    qemu_sglist_destroy(&cmd->qsg);
 }
=20
 /*
--=20
2.18.0.547.g1d89318c48
