Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vd-0001lH-KJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vX-0008F5-O0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vX-0008EJ-DY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:19 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:42 +0200
Message-Id: <20180525081754.29506-2-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 01/13] linux-user: Assert on bad type in
 thunk_type_align() and thunk_type_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In thunk_type_align() and thunk_type_size() we currently return
-1 if the value at the type_ptr isn't one of the TYPE_* values
we understand. However, this should never happen, and if it does
then the calling code will go confusingly wrong because none
of the callsites try to handle an error return. Switch to an
assertion instead, so that if this does somehow happen we'll have
a nice clear backtrace of what happened rather than a weird crash
or misbehaviour.

This also silences various Coverity complaints about not handling
the negative return value (CID 1005735, 1005736, 1005738, 1390582).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180514174616.19601-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/user/thunk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 8f55b233b3..8d3af5a3be 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -135,7 +135,7 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
         se = struct_entries + type_ptr[1];
         return se->size[is_host];
     default:
-        return -1;
+        g_assert_not_reached();
     }
 }
 
@@ -185,7 +185,7 @@ static inline int thunk_type_align(const argtype *type_ptr, int is_host)
         se = struct_entries + type_ptr[1];
         return se->align[is_host];
     default:
-        return -1;
+        g_assert_not_reached();
     }
 }
 
-- 
2.14.3
