Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqgWB-0001av-9O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqgP3-0007i5-1c
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:43:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqgP1-0007YR-06
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:43:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id a16so355484wrv.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 07:43:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 16:43:12 +0100
Message-Id: <1549294992-46543-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] queue: fix QTAILQ_FOREACH_REVERSE_SAFE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com

The iteration was stopping as soon as prev_var was set to NULL, and
therefore it skipped the first element.  Fortunately, or unfortunately,
we have only one use of QTAILQ_FOREACH_REVERSE_SAFE.  Thus this only
showed up as incorrect register preferences on the very first translation
block that was compiled.

Reported-by: Thomas Huth <thuth@redhat.com>
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
