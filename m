Received: from eggs.gnu.org ([2001:4830:134:3::10]:53818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUi-0000Ez-1K
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUd-0007Hy-53
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUc-0007Hl-VW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0F9283F44
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E2279343A
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:27 +0200
Message-Id: <20170901125611.29295-4-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/47] qobject: Explain how QNum works, and why
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503384739-17207-1-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[Comment typos fixed]
---
 include/qapi/qmp/qnum.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 09d745c490..d6b0791139 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -23,6 +23,27 @@ typedef enum {
     QNUM_DOUBLE
 } QNumKind;
=20
+/*
+ * QNum encapsulates how our dialect of JSON fills in the blanks left
+ * by the JSON specification (RFC 7159) regarding numbers.
+ *
+ * Conceptually, we treat number as an abstract type with three
+ * concrete subtypes: floating-point, signed integer, unsigned
+ * integer.  QNum implements this as a discriminated union of double,
+ * int64_t, uint64_t.
+ *
+ * The JSON parser picks the subtype as follows.  If the number has a
+ * decimal point or an exponent, it is floating-point.  Else if it
+ * fits into int64_t, it's signed integer.  Else if it fits into
+ * uint64_t, it's unsigned integer.  Else it's floating-point.
+ *
+ * Any number can serve as double: qnum_get_double() converts under
+ * the hood.
+ *
+ * An integer can serve as signed / unsigned integer as long as it is
+ * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
+ * convert under the hood.
+ */
 typedef struct QNum {
     QObject base;
     QNumKind kind;
--=20
2.13.5
