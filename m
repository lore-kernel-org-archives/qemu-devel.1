Received: from eggs.gnu.org ([2001:4830:134:3::10]:57590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVgU-0004vn-SV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVgP-0006R9-GL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIVgP-0006R1-79
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 11:46:29 +0400
Message-Id: <20170607074632.13162-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-1-marcandre.lureau@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The coccinelle/round.cocci script doesn't catch hard coded values.

I used the following script over qemu code base:

(
- ((e1) + 3) / (4)
+ DIV_ROUND_UP(e1,4)
|
- ((e1) + (3)) / (4)
+ DIV_ROUND_UP(e1,4)
|
- ((e1) + 7) / (8)
+ DIV_ROUND_UP(e1,8)
|
- ((e1) + (7)) / (8)
+ DIV_ROUND_UP(e1,8)
|
- ((e1) + 15) / (16)
+ DIV_ROUND_UP(e1,16)
|
- ((e1) + (15)) / (16)
+ DIV_ROUND_UP(e1,16)
|
- ((e1) + 31) / (32)
+ DIV_ROUND_UP(e1,32)
|
- ((e1) + (31)) / (32)
+ DIV_ROUND_UP(e1,32)
)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qed-check.c           |  3 ++-
 disas/ia64.c                |  4 ++--
 hw/char/virtio-serial-bus.c | 11 ++++++-----
 hw/display/vga.c            |  2 +-
 hw/display/virtio-gpu.c     |  4 ++--
 hw/pci/msix.c               |  4 ++--
 hw/usb/dev-hub.c            |  8 ++++----
 libdecnumber/decNumber.c    |  2 +-
 target/i386/arch_dump.c     | 25 +++++++++++++++----------
 target/ppc/kvm.c            |  4 ++--
 target/ppc/mem_helper.c     |  2 +-
 target/ppc/translate.c      |  2 +-
 ui/cursor.c                 |  2 +-
 ui/vnc-enc-tight.c          |  2 +-
 ui/vnc.c                    |  3 ++-
 15 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/block/qed-check.c b/block/qed-check.c
index dcd4f036b8..f447053d24 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -228,7 +228,8 @@ int qed_check(BDRVQEDState *s, BdrvCheckResult *resul=
t, bool fix)
     };
     int ret;
=20
-    check.used_clusters =3D g_try_new0(uint32_t, (check.nclusters + 31) =
/ 32);
+    check.used_clusters =3D g_try_new0(uint32_t,
+                                     DIV_ROUND_UP(check.nclusters, 32));
     if (check.nclusters && check.used_clusters =3D=3D NULL) {
         return -ENOMEM;
     }
diff --git a/disas/ia64.c b/disas/ia64.c
index 140754c944..bf576d3099 100644
--- a/disas/ia64.c
+++ b/disas/ia64.c
@@ -10156,14 +10156,14 @@ locate_opcode_ent (ia64_insn opcode, enum ia64_=
insn_type type)
 		    }
 		  if (x > count)
 		    {
-		      next_op =3D op_pointer + ((oplen + 7) / 8);
+		      next_op =3D op_pointer + (DIV_ROUND_UP(oplen, 8));
 		      currbitnum -=3D count;
 		      break;
 		    }
 		}
 	      else if (! currbit)
 		{
-		  next_op =3D op_pointer + ((oplen + 7) / 8);
+		  next_op =3D op_pointer + (DIV_ROUND_UP(oplen, 8));
 		  break;
 		}
 	    }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f5bc173844..823e1c915c 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -663,7 +663,7 @@ static void virtio_serial_save_device(VirtIODevice *v=
dev, QEMUFile *f)
=20
     /* The ports map */
     max_nr_ports =3D s->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         qemu_put_be32s(f, &s->ports_map[i]);
     }
=20
@@ -798,7 +798,7 @@ static int virtio_serial_load_device(VirtIODevice *vd=
ev, QEMUFile *f,
     qemu_get_be32s(f, &tmp);
=20
     max_nr_ports =3D s->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         qemu_get_be32s(f, &ports_map);
=20
         if (ports_map !=3D s->ports_map[i]) {
@@ -863,7 +863,7 @@ static uint32_t find_free_port_id(VirtIOSerial *vser)
     unsigned int i, max_nr_ports;
=20
     max_nr_ports =3D vser->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         uint32_t map, zeroes;
=20
         map =3D vser->ports_map[i];
@@ -1075,8 +1075,9 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
         vser->ovqs[i] =3D virtio_add_queue(vdev, 128, handle_output);
     }
=20
-    vser->ports_map =3D g_malloc0(((vser->serial.max_virtserial_ports + =
31) / 32)
-        * sizeof(vser->ports_map[0]));
+    vser->ports_map =3D
+        g_malloc0(DIV_ROUND_UP(vser->serial.max_virtserial_ports, 32)
+                  * sizeof(vser->ports_map[0]));
     /*
      * Reserve location 0 for a console port for backward compat
      * (old kernel, new qemu)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index dcc95f88e2..c2d3e8f54b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1621,7 +1621,7 @@ static void vga_draw_graphic(VGACommonState *s, int=
 full_update)
            s->line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
     addr1 =3D (s->start_addr * 4);
-    bwidth =3D (width * bits + 7) / 8;
+    bwidth =3D DIV_ROUND_UP(width * bits, 8);
     y_start =3D -1;
     d =3D surface_data(surface);
     linesize =3D surface_stride(surface);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 58dc0b2737..641f57e7c5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -408,7 +408,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU =
*g,
     }
=20
     format =3D pixman_image_get_format(res->image);
-    bpp =3D (PIXMAN_FORMAT_BPP(format) + 7) / 8;
+    bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     stride =3D pixman_image_get_stride(res->image);
=20
     if (t2d.offset || t2d.r.x || t2d.r.y ||
@@ -570,7 +570,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     scanout =3D &g->scanout[ss.scanout_id];
=20
     format =3D pixman_image_get_format(res->image);
-    bpp =3D (PIXMAN_FORMAT_BPP(format) + 7) / 8;
+    bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     offset =3D (ss.r.x * bpp) + ss.r.y * pixman_image_get_stride(res->im=
age);
     if (!scanout->ds || surface_data(scanout->ds)
         !=3D ((uint8_t *)pixman_image_get_data(res->image) + offset) ||
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index bb54e8b0ac..4af09afe6b 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -431,7 +431,7 @@ void msix_save(PCIDevice *dev, QEMUFile *f)
     }
=20
     qemu_put_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
-    qemu_put_buffer(f, dev->msix_pba, (n + 7) / 8);
+    qemu_put_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
 }
=20
 /* Should be called after restoring the config space. */
@@ -446,7 +446,7 @@ void msix_load(PCIDevice *dev, QEMUFile *f)
=20
     msix_clear_all_vectors(dev);
     qemu_get_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
-    qemu_get_buffer(f, dev->msix_pba, (n + 7) / 8);
+    qemu_get_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
     msix_update_function_masked(dev);
=20
     for (vector =3D 0; vector < n; vector++) {
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index e82a6a6c44..c79d7bc030 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -109,7 +109,7 @@ static const USBDescIface desc_iface_hub =3D {
         {
             .bEndpointAddress      =3D USB_DIR_IN | 0x01,
             .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        =3D 1 + (NUM_PORTS + 7) / 8,
+            .wMaxPacketSize        =3D 1 + DIV_ROUND_UP(NUM_PORTS, 8),
             .bInterval             =3D 0xff,
         },
     }
@@ -442,14 +442,14 @@ static void usb_hub_handle_control(USBDevice *dev, =
USBPacket *p,
             data[2] =3D NUM_PORTS;
=20
             /* fill DeviceRemovable bits */
-            limit =3D ((NUM_PORTS + 1 + 7) / 8) + 7;
+            limit =3D (DIV_ROUND_UP(NUM_PORTS + 1, 8)) + 7;
             for (n =3D 7; n < limit; n++) {
                 data[n] =3D 0x00;
                 var_hub_size++;
             }
=20
             /* fill PortPwrCtrlMask bits */
-            limit =3D limit + ((NUM_PORTS + 7) / 8);
+            limit =3D limit + (DIV_ROUND_UP(NUM_PORTS, 8));
             for (;n < limit; n++) {
                 data[n] =3D 0xff;
                 var_hub_size++;
@@ -477,7 +477,7 @@ static void usb_hub_handle_data(USBDevice *dev, USBPa=
cket *p)
             unsigned int status;
             uint8_t buf[4];
             int i, n;
-            n =3D (NUM_PORTS + 1 + 7) / 8;
+            n =3D DIV_ROUND_UP(NUM_PORTS + 1, 8);
             if (p->iov.size =3D=3D 1) { /* FreeBSD workaround */
                 n =3D 1;
             } else if (n > p->iov.size) {
diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
index c9e7807f87..9667d27c7c 100644
--- a/libdecnumber/decNumber.c
+++ b/libdecnumber/decNumber.c
@@ -5021,7 +5021,7 @@ static decNumber * decMultiplyOp(decNumber *res, co=
nst decNumber *lhs,
       /* to the right to avoid overwrite during the unchunking. */
       needbytes=3Diacc*sizeof(uLong);
       #if DECDPUN=3D=3D1
-      zoff=3D(iacc+7)/8;	      /* items to offset by */
+      zoff=3DDIV_ROUND_UP(iacc, 8);	      /* items to offset by */
       needbytes+=3Dzoff*8;
       #endif
       if (needbytes>(Int)sizeof(zaccbuff)) {
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index e6788250b8..158e056b59 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -77,8 +77,9 @@ static int x86_64_write_elf64_note(WriteCoreDumpFunctio=
n f,
     regs.gs =3D env->segs[R_GS].selector;
=20
     descsz =3D sizeof(x86_64_elf_prstatus);
-    note_size =3D ((sizeof(Elf64_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4)
+                 + DIV_ROUND_UP(name_size, 4)
+                 + DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -156,8 +157,9 @@ static int x86_write_elf64_note(WriteCoreDumpFunction=
 f, CPUX86State *env,
=20
     x86_fill_elf_prstatus(&prstatus, env, id);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D ((sizeof(Elf64_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4)
+                 + DIV_ROUND_UP(name_size, 4)
+                 + DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -211,8 +213,9 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
=20
     x86_fill_elf_prstatus(&prstatus, &cpu->env, cpuid);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D ((sizeof(Elf32_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf32_Nhdr), 4)
+                 + DIV_ROUND_UP(name_size, 4)
+                 + DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -443,10 +446,12 @@ ssize_t cpu_get_note_size(int class, int machine, i=
nt nr_cpus)
 #endif
     qemu_desc_size =3D sizeof(QEMUCPUState);
=20
-    elf_note_size =3D ((note_head_size + 3) / 4 + (name_size + 3) / 4 +
-                     (elf_desc_size + 3) / 4) * 4;
-    qemu_note_size =3D ((note_head_size + 3) / 4 + (name_size + 3) / 4 +
-                      (qemu_desc_size + 3) / 4) * 4;
+    elf_note_size =3D (DIV_ROUND_UP(note_head_size, 4)
+                     + DIV_ROUND_UP(name_size, 4)
+                     + DIV_ROUND_UP(elf_desc_size, 4)) * 4;
+    qemu_note_size =3D (DIV_ROUND_UP(note_head_size, 4)
+                      + DIV_ROUND_UP(name_size, 4)
+                      + DIV_ROUND_UP(qemu_desc_size, 4)) * 4;
=20
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce79e..3b712a0434 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -601,8 +601,8 @@ static void kvm_sw_tlb_put(PowerPCCPU *cpu)
         return;
     }
=20
-    bitmap =3D g_malloc((env->nb_tlb + 7) / 8);
-    memset(bitmap, 0xFF, (env->nb_tlb + 7) / 8);
+    bitmap =3D g_malloc(DIV_ROUND_UP(env->nb_tlb, 8));
+    memset(bitmap, 0xFF, DIV_ROUND_UP(env->nb_tlb, 8));
=20
     dirty_tlb.bitmap =3D (uintptr_t)bitmap;
     dirty_tlb.num_dirty =3D env->nb_tlb;
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e6383c6bfa..a34e604db3 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -111,7 +111,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr,=
 uint32_t reg,
                  uint32_t ra, uint32_t rb)
 {
     if (likely(xer_bc !=3D 0)) {
-        int num_used_regs =3D (xer_bc + 3) / 4;
+        int num_used_regs =3D DIV_ROUND_UP(xer_bc, 4);
         if (unlikely((ra !=3D 0 && lsw_reg_in_range(reg, num_used_regs, =
ra)) ||
                      lsw_reg_in_range(reg, num_used_regs, rb))) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d927..76f9ccde25 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2882,7 +2882,7 @@ static void gen_lswi(DisasContext *ctx)
     }
     if (nb =3D=3D 0)
         nb =3D 32;
-    nr =3D (nb + 3) / 4;
+    nr =3D DIV_ROUND_UP(nb, 4);
     if (unlikely(lsw_reg_in_range(start, nr, ra))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
         return;
diff --git a/ui/cursor.c b/ui/cursor.c
index 5155b392e8..2e2fe13fa6 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -118,7 +118,7 @@ void cursor_put(QEMUCursor *c)
=20
 int cursor_get_mono_bpl(QEMUCursor *c)
 {
-    return (c->width + 7) / 8;
+    return DIV_ROUND_UP(c->width, 8);
 }
=20
 void cursor_set_mono(QEMUCursor *c,
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 1e53b1cf84..15a49ee53d 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -980,7 +980,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
     }
 #endif
=20
-    bytes =3D ((w + 7) / 8) * h;
+    bytes =3D (DIV_ROUND_UP(w, 8)) * h;
=20
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_PALETTE);
diff --git a/ui/vnc.c b/ui/vnc.c
index 47b49c7318..e0952441fc 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2782,7 +2782,8 @@ static int vnc_refresh_server_surface(VncDisplay *v=
d)
             PIXMAN_FORMAT_BPP(pixman_image_get_format(vd->guest.fb));
         guest_row0 =3D (uint8_t *)pixman_image_get_data(vd->guest.fb);
         guest_stride =3D pixman_image_get_stride(vd->guest.fb);
-        guest_ll =3D pixman_image_get_width(vd->guest.fb) * ((guest_bpp =
+ 7) / 8);
+        guest_ll =3D pixman_image_get_width(vd->guest.fb)
+            * DIV_ROUND_UP(guest_bpp, 8);
     }
     line_bytes =3D MIN(server_stride, guest_ll);
=20
--=20
2.13.0.91.g00982b8dd
