Received: from eggs.gnu.org ([209.51.188.92]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wic-0003qj-6k
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wia-0000Qe-AN
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WiY-0000M2-Ci
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id q187so14583757wme.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:57 +0100
Message-Id: <1552117698-12355-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/25] block/iscsi: Restrict Linux-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Some Linux specific code is missing guards, leading to
build failure on OSX:

  $ sudo brew install libiscsi
  $ ./configure && make
  [...]
    CC      block/iscsi.o
  qemu/block/iscsi.c:338:24: error: 'iscsi_aiocb_info' defined but not used [-Werror=unused-const-variable=]
   static const AIOCBInfo iscsi_aiocb_info = {
                          ^~~~~~~~~~~~~~~~
  qemu/block/iscsi.c:168:1: error: 'iscsi_schedule_bh' defined but not used [-Werror=unused-function]
   iscsi_schedule_bh(IscsiAIOCB *acb)
   ^~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Add guards to restrict this code for Linux.

Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
Message-Id: <20190220000553.28438-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/iscsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index a0c0084..f31c612 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -145,6 +145,8 @@ static const unsigned iscsi_retry_times[] = {8, 32, 128, 512, 2048, 8192, 32768}
  * unallocated. */
 #define ISCSI_CHECKALLOC_THRES 64
 
+#ifdef __linux__
+
 static void
 iscsi_bh_cb(void *p)
 {
@@ -172,6 +174,8 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
     qemu_bh_schedule(acb->bh);
 }
 
+#endif
+
 static void iscsi_co_generic_bh_cb(void *opaque)
 {
     struct IscsiTask *iTask = opaque;
@@ -290,6 +294,8 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
     };
 }
 
+#ifdef __linux__
+
 /* Called (via iscsi_service) with QemuMutex held. */
 static void
 iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
@@ -338,6 +344,7 @@ static const AIOCBInfo iscsi_aiocb_info = {
     .cancel_async       = iscsi_aio_cancel,
 };
 
+#endif
 
 static void iscsi_process_read(void *arg);
 static void iscsi_process_write(void *arg);
-- 
1.8.3.1
