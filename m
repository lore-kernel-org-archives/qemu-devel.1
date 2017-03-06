Received: from eggs.gnu.org ([2001:4830:134:3::10]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMs-0002q4-B3
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMo-0002ow-P5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMo-0002na-GE
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0E93C0567B3
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:12:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EC1ef004520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:12:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:54 +0100
Message-Id: <1488809515-4047-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/24] docs/qapi-code-gen.txt: Clarify naming
 rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-24-git-send-email-armbru@redhat.com>
---
 docs/qapi-code-gen.txt | 61 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 6746c10..9514d93 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -216,33 +216,38 @@ single-dimension array of that type; multi-dimension arrays are not
 directly supported (although an array of a complex struct that
 contains an array member is possible).
 
+All names must begin with a letter, and contain only ASCII letters,
+digits, hyphen, and underscore.  There are two exceptions: enum values
+may start with a digit, and names that are downstream extensions (see
+section Downstream extensions) start with underscore.
+
+Names beginning with 'q_' are reserved for the generator, which uses
+them for munging QMP names that resemble C keywords or other
+problematic strings.  For example, a member named "default" in qapi
+becomes "q_default" in the generated C code.
+
 Types, commands, and events share a common namespace.  Therefore,
 generally speaking, type definitions should always use CamelCase for
-user-defined type names, while built-in types are lowercase. Type
-definitions should not end in 'Kind', as this namespace is used for
-creating implicit C enums for visiting union types, or in 'List', as
-this namespace is used for creating array types.  Command names,
-and member names within a type, should be all lower case with words
-separated by a hyphen.  However, some existing older commands and
-complex types use underscore; when extending such expressions,
-consistency is preferred over blindly avoiding underscore.  Event
-names should be ALL_CAPS with words separated by underscore.  Member
-names cannot start with 'has-' or 'has_', as this is reserved for
-tracking optional members.
+user-defined type names, while built-in types are lowercase.
+
+Type names ending with 'Kind' or 'List' are reserved for the
+generator, which uses them for implicit union enums and array types,
+respectively.
+
+Command names, and member names within a type, should be all lower
+case with words separated by a hyphen.  However, some existing older
+commands and complex types use underscore; when extending such
+expressions, consistency is preferred over blindly avoiding
+underscore.
+
+Event names should be ALL_CAPS with words separated by underscore.
+
+Member names starting with 'has-' or 'has_' are reserved for the
+generator, which uses them for tracking optional members.
 
 Any name (command, event, type, member, or enum value) beginning with
 "x-" is marked experimental, and may be withdrawn or changed
-incompatibly in a future release.  All names must begin with a letter,
-and contain only ASCII letters, digits, dash, and underscore.  There
-are two exceptions: enum values may start with a digit, and any
-extensions added by downstream vendors should start with a prefix
-matching "__RFQDN_" (for the reverse-fully-qualified-domain-name of
-the vendor), even if the rest of the name uses dash (example:
-__com.redhat_drive-mirror).  Names beginning with 'q_' are reserved
-for the generator: QMP names that resemble C keywords or other
-problematic strings will be munged in C to use this prefix.  For
-example, a member named "default" in qapi becomes "q_default" in the
-generated C code.
+incompatibly in a future release.
 
 In the rest of this document, usage lines are given for each
 expression type, with literal strings written in lower case and
@@ -643,6 +648,18 @@ any non-empty complex type (struct, union, or alternate), and a
 pointer to that QAPI type is passed as a single argument.
 
 
+=== Downstream extensions ===
+
+QAPI schema names that are externally visible, say in the Client JSON
+Protocol, need to be managed with care.  Names starting with a
+downstream prefix of the form __RFQDN_ are reserved for the downstream
+who controls the valid, reverse fully qualified domain name RFQDN.
+RFQDN may only contain ASCII letters, digits, hyphen and period.
+
+Example: Red Hat, Inc. controls redhat.com, and may therefore add a
+downstream command __com.redhat_drive-mirror.
+
+
 == Client JSON Protocol introspection ==
 
 Clients of a Client JSON Protocol commonly need to figure out what
-- 
2.7.4
