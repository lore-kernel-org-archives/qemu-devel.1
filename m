Received: from eggs.gnu.org ([2001:4830:134:3::10]:54565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN8-00038x-I1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN6-0001Da-FQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dafN6-0001D9-6r
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Jul 2017 11:46:15 +0200
Message-Id: <1501148776-16890-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1501148776-16890-1-git-send-email-armbru@redhat.com>
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] host-utils: Proactively fix pow2floor(),
 switch to unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

The function's stated contract is simple enough: "round down to the
nearest power of 2".  Suggests the domain is the representable numbers
>= 1, because that's the smallest power of two.

The implementation doesn't check for domain errors, but returns
garbage instead:

* For negative arguments, pow2floor() returns -2^63, which is not even
  a power of two, let alone the nearest one.

  What sort of works is passing *unsigned* arguments >= 2^63.  The
  implicit conversion to signed is implementation defined, but
  commonly yields the (negative) two's complement.  pow2floor() then
  returns -2^63.  Callers that convert that back to unsigned get the
  correct value 2^63.

* For a zero argument, pow2floor() shifts right by 64.  Undefined
  behavior.  Common actual behavior is to shift by 0, yielding -2^63.

Fix by switching from int64_t to uint64_t and amending the contract to
map zero to zero.

Callers are fine with that:

* memory_access_size()

  This function makes no sense unless the argument is positive and the
  return value fits into int.

* raw_refresh_limits()

  Passes an int between 1 and BDRV_REQUEST_MAX_BYTES.

* iscsi_refresh_limits()

  Passes an integer between 0 and INT_MAX, converts the result to
  uint32_t.  Passing zero would be undefined behavior, but commonly
  yield zero.  The patch gives us the zero without the undefined
  behavior.

* cache_init()

  Passes a positive int64_t argument.

* xbzrle_cache_resize()

  Passes a positive int64_t argument (>= TARGET_PAGE_SIZE, actually).

* spapr_node0_size()

  Passes a positive uint64_t argument, and converts the result to
  hwaddr, i.e. uint64_t.

* spapr_populate_memory()

  Passes a positive hwaddr argument, and converts the result to
  hwaddr.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/host-utils.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 95cf4f4..6c6005f 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -369,13 +369,16 @@ static inline bool is_power_of_2(uint64_t value)
     return !(value & (value - 1));
 }
 
-/* round down to the nearest power of 2*/
-static inline int64_t pow2floor(int64_t value)
+/**
+ * Return @value rounded down to the nearest power of two or zero.
+ */
+static inline uint64_t pow2floor(uint64_t value)
 {
-    if (!is_power_of_2(value)) {
-        value = 0x8000000000000000ULL >> clz64(value);
+    if (!value) {
+        /* Avoid undefined shift by 64 */
+        return 0;
     }
-    return value;
+    return 0x8000000000000000ull >> clz64(value);
 }
 
 /* round up to the nearest power of 2 (0 if overflow) */
-- 
2.7.5
