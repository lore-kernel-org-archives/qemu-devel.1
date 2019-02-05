Received: from eggs.gnu.org ([209.51.188.92]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H9-00039y-0Q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H8-0004W4-5S
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5H7-0004ST-Rz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id z3so4741047wrv.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:46 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.16.44
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:16:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:26 +0100
Message-Id: <1549390526-24246-77-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 76/76] queue: fix QTAILQ_FOREACH_REVERSE_SAFE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The iteration was stopping as soon as prev_var was set to NULL, and
therefore it skipped the first element.  Fortunately, or unfortunately,
we have only one use of QTAILQ_FOREACH_REVERSE_SAFE.  Thus this only
showed up as incorrect register preferences on the very first translation
block that was compiled.

Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 1f8e219..0379bd8 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -439,7 +439,7 @@ union {                                                                 \
 
 #define QTAILQ_FOREACH_REVERSE_SAFE(var, head, field, prev_var)         \
         for ((var) = QTAILQ_LAST(head);                                 \
-             (var) && ((prev_var) = QTAILQ_PREV(var, field));           \
+             (var) && ((prev_var) = QTAILQ_PREV(var, field), 1);        \
              (var) = (prev_var))
 
 /*
-- 
1.8.3.1
