Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHYD-0003S7-6a
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIHYC-0000x3-DE
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:46:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIHYC-0000w4-5x
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:46:20 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 18:46:16 +0100
Message-Id: <20180514174616.19601-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Assert on bad type in
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
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

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
---
 include/exec/user/thunk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index f19ef4b230..840d6d899b 100644
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
 
@@ -173,7 +173,7 @@ static inline int thunk_type_align(const argtype *type_ptr, int is_host)
         se = struct_entries + type_ptr[1];
         return se->align[is_host];
     default:
-        return -1;
+        g_assert_not_reached();
     }
 }
 
-- 
2.17.0
