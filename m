Received: from eggs.gnu.org ([209.51.188.92]:60150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7x-00067N-Rt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-0004I4-RS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7v-00046r-5Q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id t27so956001wra.6
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.37.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:37:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:19 +0100
Message-Id: <1549305379-51117-78-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 77/77] queue: fix QTAILQ_FOREACH_REVERSE_SAFE
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
