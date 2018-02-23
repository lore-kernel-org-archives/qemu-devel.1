Received: from eggs.gnu.org ([2001:4830:134:3::10]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1epBsM-0001wJ-5o
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1epBsI-0007w6-6Q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:50:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1epBsH-0007uv-U9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:50:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NBn88E041478
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:50:48 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gaduaa4bf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:50:47 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 11:50:45 -0000
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<3b160f2d-8c32-7b0a-3afc-0519c02cee81@de.ibm.com>
	<5fd04c0d-ad1e-13a7-4e5a-5f28662479a7@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 12:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <5fd04c0d-ad1e-13a7-4e5a-5f28662479a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <68148fff-0c6e-0470-a0e5-0379ecfd3dd8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Interactive Boot Menu for DASD
 and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 23.02.2018 11:17, Thomas Huth wrote:
> On 23.02.2018 09:53, Christian Borntraeger wrote:
>> Hmmm, on my ubuntu 16.04 guest, I get the boot menu with no timeout even if I do not 
>> specify loadparm or boot menu:
>>
>> qemu-kvm -drive file=/var/lib/libvirt/qemu/image.zhyp140,if=none,id=d1 -device virtio-blk-ccw,drive=d1,bootindex=1 
> 
> I can reproduce this now, too. FWIW: It only happens with
> virtio-blk-ccw, not with virtio-scsi-ccw (that's why I did not notice it
> first). Collin, can you reproduce this, too?
> 
>  Thomas
> The idea is to support the zipl boot menu on ECKD disks (which have a timeout by themselves)
even without switching the boot menu on. This is to have the same behavior as one would see
on LPAR or z/VM.
The issue is that the boot code tries to interpret the program table of SCSI bootmaps as if
a boot menu has been specified.

The following patch fixes this. Collin might want to have a say in this matter as well.


The scsi program table was erroneously evaluated as implicit
boot menu. This patch adds a per-bootmap-type menu_is_enabled
function.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  | 4 ++--
 pc-bios/s390-ccw/menu.c     | 7 ++++++-
 pc-bios/s390-ccw/s390-ccw.h | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 81dbd4a..b6fd77e 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -265,7 +265,7 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     BootMapTable *bmt = (void *)sec;
     BootMapScript *bms = (void *)sec;
 
-    if (menu_is_enabled()) {
+    if (menu_is_enabled_for_zipl()) {
         loadparm = eckd_get_boot_menu_index(s1b_block_nr);
     }
 
@@ -568,7 +568,7 @@ static void ipl_scsi(void)
     debug_print_int("program table entries", program_table_entries);
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
-    if (menu_is_enabled()) {
+    if (menu_is_enabled_for_enum()) {
         loadparm = menu_get_enum_boot_index(program_table_entries);
     }
 
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 16b5310..ebe5e9f 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -237,7 +237,12 @@ void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
     timeout = boot_menu_timeout;
 }
 
-bool menu_is_enabled(void)
+bool menu_is_enabled_for_zipl(void)
 {
     return flag;
 }
+
+bool menu_is_enabled_for_enum(void)
+{
+    return flag & ~QIPL_FLAG_BM_OPTS_ZIPL;
+}
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index cfcaf3c..a18381f 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -89,7 +89,8 @@ void zipl_load(void);
 
 /* menu.c */
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
-bool menu_is_enabled(void);
+bool menu_is_enabled_for_zipl(void);
+bool menu_is_enabled_for_enum(void);
 int menu_get_zipl_boot_index(const char *menu_data);
 int menu_get_enum_boot_index(int entries);
 
-- 
1.9.1


-- 
Regards,
 Viktor Mihajlovski
