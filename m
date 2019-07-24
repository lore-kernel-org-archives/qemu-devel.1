Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C9FC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8FB21926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8FB21926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIIx-0003VF-EG
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqIIc-0002Sd-Fk
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqIIb-000570-5z
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqIIa-00056J-UG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31D1B307CDFC;
 Wed, 24 Jul 2019 14:31:20 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-46.ams2.redhat.com
 [10.36.117.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B94260BEC;
 Wed, 24 Jul 2019 14:31:17 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 16:31:04 +0200
Message-Id: <20190724143105.307042-3-sgarzare@redhat.com>
In-Reply-To: <20190724143105.307042-1-sgarzare@redhat.com>
References: <20190724143105.307042-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 14:31:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 2/3] elf-ops.h: Map into memory the ELF to
 load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reduce the memory footprint we map into memory
the ELF to load using g_mapped_file_new_from_fd() instead of
reading each sections. In this way we can share the ELF pages
between multiple instances of QEMU.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
  - fix the missing of g_mapped_file_unref() in the success case [Paolo]
  - fix the rom_add_elf_program() comment [Paolo]
v3:
  - renamed 'GMappedFile *gmf' in 'GMappedFile *mapped_filed' for readabi=
lity.
  - passed the GMappedFile* to rom_add_elf_program() to correctly handle =
the
    reference count. [Paolo]
  - set 'data' pointer only if 'file_size > 0' as the original behaviour
    [check-qtest-ppc64 fails without it]
v2:
  - used g_mapped_file_new_from_fd() with 'writeble' set to 'true',
    since we can modify the mapped buffer. [Paolo, Peter]
---
 include/hw/elf_ops.h | 71 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index fede37ee9c..1496d7e753 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -323,8 +323,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
     struct elfhdr ehdr;
     struct elf_phdr *phdr =3D NULL, *ph;
     int size, i, total_size;
-    elf_word mem_size, file_size;
+    elf_word mem_size, file_size, data_offset;
     uint64_t addr, low =3D (uint64_t)-1, high =3D 0;
+    GMappedFile *mapped_file =3D NULL;
     uint8_t *data =3D NULL;
     char label[128];
     int ret =3D ELF_LOAD_FAILED;
@@ -409,20 +410,32 @@ static int glue(load_elf, SZ)(const char *name, int=
 fd,
         }
     }
=20
+    /*
+     * Since we want to be able to modify the mapped buffer, we set the
+     * 'writeble' parameter to 'true'. Modifications to the buffer are n=
ot
+     * written back to the file.
+     */
+    mapped_file =3D g_mapped_file_new_from_fd(fd, true, NULL);
+    if (!mapped_file) {
+        goto fail;
+    }
+
     total_size =3D 0;
     for(i =3D 0; i < ehdr.e_phnum; i++) {
         ph =3D &phdr[i];
         if (ph->p_type =3D=3D PT_LOAD) {
             mem_size =3D ph->p_memsz; /* Size of the ROM */
             file_size =3D ph->p_filesz; /* Size of the allocated data */
-            data =3D g_malloc0(file_size);
-            if (ph->p_filesz > 0) {
-                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
-                    goto fail;
-                }
-                if (read(fd, data, file_size) !=3D file_size) {
+            data_offset =3D ph->p_offset; /* Offset where the data is lo=
cated */
+
+            if (file_size > 0) {
+                if (g_mapped_file_get_length(mapped_file) <
+                    file_size + data_offset) {
                     goto fail;
                 }
+
+                data =3D (uint8_t *)g_mapped_file_get_contents(mapped_fi=
le);
+                data +=3D data_offset;
             }
=20
             /* The ELF spec is somewhat vague about the purpose of the
@@ -513,25 +526,25 @@ static int glue(load_elf, SZ)(const char *name, int=
 fd,
                 *pentry =3D ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
=20
-            if (mem_size =3D=3D 0) {
-                /* Some ELF files really do have segments of zero size;
-                 * just ignore them rather than trying to create empty
-                 * ROM blobs, because the zero-length blob can falsely
-                 * trigger the overlapping-ROM-blobs check.
-                 */
-                g_free(data);
-            } else {
+            /* Some ELF files really do have segments of zero size;
+             * just ignore them rather than trying to create empty
+             * ROM blobs, because the zero-length blob can falsely
+             * trigger the overlapping-ROM-blobs check.
+             */
+            if (mem_size !=3D 0) {
                 if (load_rom) {
                     snprintf(label, sizeof(label), "phdr #%d: %s", i, na=
me);
=20
-                    /* rom_add_elf_program() seize the ownership of 'dat=
a' */
-                    rom_add_elf_program(label, NULL, data, file_size, me=
m_size,
-                                        addr, as);
+                    /*
+                     * rom_add_elf_program() takes its own reference to
+                     * 'mapped_file'.
+                     */
+                    rom_add_elf_program(label, mapped_file, data, file_s=
ize,
+                                        mem_size, addr, as);
                 } else {
                     address_space_write(as ? as : &address_space_memory,
                                         addr, MEMTXATTRS_UNSPECIFIED,
                                         data, file_size);
-                    g_free(data);
                 }
             }
=20
@@ -547,14 +560,16 @@ static int glue(load_elf, SZ)(const char *name, int=
 fd,
             struct elf_note *nhdr =3D NULL;
=20
             file_size =3D ph->p_filesz; /* Size of the range of ELF note=
s */
-            data =3D g_malloc0(file_size);
-            if (ph->p_filesz > 0) {
-                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
-                    goto fail;
-                }
-                if (read(fd, data, file_size) !=3D file_size) {
+            data_offset =3D ph->p_offset; /* Offset where the notes are =
located */
+
+            if (file_size > 0) {
+                if (g_mapped_file_get_length(mapped_file) <
+                    file_size + data_offset) {
                     goto fail;
                 }
+
+                data =3D (uint8_t *)g_mapped_file_get_contents(mapped_fi=
le);
+                data +=3D data_offset;
             }
=20
             /*
@@ -570,19 +585,17 @@ static int glue(load_elf, SZ)(const char *name, int=
 fd,
                     sizeof(struct elf_note) =3D=3D sizeof(struct elf64_n=
ote);
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);
             }
-            g_free(data);
             data =3D NULL;
         }
     }
=20
-    g_free(phdr);
     if (lowaddr)
         *lowaddr =3D (uint64_t)(elf_sword)low;
     if (highaddr)
         *highaddr =3D (uint64_t)(elf_sword)high;
-    return total_size;
+    ret =3D total_size;
  fail:
-    g_free(data);
+    g_mapped_file_unref(mapped_file);
     g_free(phdr);
     return ret;
 }
--=20
2.20.1


