Received: from eggs.gnu.org ([2001:4830:134:3::10]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6H-0004Te-0V
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUE6D-0001zY-0S
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUE6C-0001yy-Qu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:54:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 19 Jan 2017 15:53:56 +0100
Message-Id: <1484837637-16896-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1484837637-16896-1-git-send-email-armbru@redhat.com>
References: <1484837637-16896-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] error: error_setg_errno(): errno gets
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sascha Silbe <silbe@linux.vnet.ibm.com>

From: Sascha Silbe <silbe@linux.vnet.ibm.com>

C11 allows errno to be clobbered by pretty much any library function
call, so in general callers need to take care to save errno before
calling other functions.

However, for error reporting functions this is rather awkward and can
make the code on the caller side more complicated than
necessary. error_setg_errno() already takes care of preserving errno
and some functions rely on that, so just promise that we continue to
do so in the future.

Signed-off-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Message-Id: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 0576659..7e532d0 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -170,6 +170,9 @@ void error_setg_internal(Error **errp,
  * Just like error_setg(), with @os_error info added to the message.
  * If @os_error is non-zero, ": " + strerror(os_error) is appended to
  * the human-readable error message.
+ *
+ * The value of errno (which usually can get clobbered by almost any
+ * function call) will be preserved.
  */
 #define error_setg_errno(errp, os_error, fmt, ...)                      \
     error_setg_errno_internal((errp), __FILE__, __LINE__, __func__,     \
-- 
2.7.4
