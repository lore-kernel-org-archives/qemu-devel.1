Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C23C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5DE208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zy4-00086k-Kc
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmS-0004mk-37
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmQ-0007lB-2A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmP-0007kF-NG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAAAA9B286;
 Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B011001956;
 Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BE8C1165603; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:21 +0200
Message-Id: <20190910063724.28470-14-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 10 Sep 2019 06:37:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have some compatibility advice buried in sections "Enumeration
types" and "Struct types".  Compatibility is actually about commands
and events.  It devolves to the types used there.  All kinds of types,
not just enumerations and structs.

Replace the existing advice by a new section "Compatibility
considerations".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 95 +++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 35 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 663ef10a56..d09232009e 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -178,14 +178,11 @@ While the C code starts numbering at 0, it is bette=
r to use explicit
 comparisons to enum values than implicit comparisons to 0; the C code
 will also include a generated enum member ending in _MAX for tracking
 the size of the enum, useful when using common functions for
-converting between strings and enum values.  Since the wire format
-always passes by name, it is acceptable to reorder or add new
-enumeration members in any location without breaking clients of Client
-JSON Protocol; however, removing enum values would break
-compatibility.  For any struct that has a member that will only contain
-a finite set of string values, using an enum type for that member is
-better than open-coding the member to be type 'str'.
+converting between strings and enum values.
=20
+For any struct that has a member that will only contain a finite set
+of string values, using an enum type for that member is better than
+open-coding the member to be type 'str'.
=20
 =3D=3D=3D Struct types =3D=3D=3D
=20
@@ -203,34 +200,6 @@ name.  An example of a struct is:
 The use of '*' as a prefix to the name means the member is optional in
 the corresponding JSON protocol usage.
=20
-The default initialization value of an optional argument should not be c=
hanged
-between versions of QEMU unless the new default maintains backward
-compatibility to the user-visible behavior of the old default.
-
-With proper documentation, this policy still allows some flexibility; fo=
r
-example, documenting that a default of 0 picks an optimal buffer size al=
lows
-one release to declare the optimal size at 512 while another release dec=
lares
-the optimal size at 4096 - the user-visible behavior is not the bytes us=
ed by
-the buffer, but the fact that the buffer was optimal size.
-
-On input structures (only mentioned in the 'data' side of a command), ch=
anging
-from mandatory to optional is safe (older clients will supply the option=
, and
-newer clients can benefit from the default); changing from optional to
-mandatory is backwards incompatible (older clients may be omitting the o=
ption,
-and must continue to work).
-
-On output structures (only mentioned in the 'returns' side of a command)=
,
-changing from mandatory to optional is in general unsafe (older clients =
may be
-expecting the member, and could crash if it is missing), although it
-can be done if the only way that the optional argument will be omitted
-is when it is triggered by the presence of a new input flag to the
-command that older clients don't know to send.  Changing from optional
-to mandatory is safe.
-
-A structure that is used in both input and output of various commands
-must consider the backwards compatibility constraints of both directions
-of use.
-
 A struct definition can specify another struct as its base.
 In this case, the members of the base type are included as top-level mem=
bers
 of the new struct's dictionary in the Client JSON Protocol wire
@@ -1037,6 +1006,62 @@ the names of built-in types.  Clients should exami=
ne member
 "json-type" instead of hard-coding names of built-in types.
=20
=20
+=3D=3D Compatibility considerations =3D=3D
+
+Maintaining backward compatibility at the Client JSON Protocol level
+while evolving the schema requires some care.  This section is about
+syntactic compatibility.  Necessary, but not sufficient for actual
+compatibility.
+
+Clients send commands with argument data, and receive command
+responses with return data and events with event data.
+
+Adding opt-in functionality to the send direction is backwards
+compatible: adding commands, optional arguments, enumeration values,
+union and alternate branches; turning an argument type into an
+alternate of that type; making mandatory arguments optional.  Clients
+oblivious of the new functionality continue to work.
+
+Incompatible changes include removing commands, command arguments,
+enumeration values, union and alternate branches, adding mandatory
+command arguments, and making optional arguments mandatory.
+
+The specified behavior of an absent optional argument should remain
+the same.  With proper documentation, this policy still allows some
+flexibility; for example, when an optional 'buffer-size' argument is
+specified to default to a sensible buffer size, the actual default
+value can still be changed.  The specified default behavior is not the
+exact size of the buffer, only that the default size is sensible.
+
+Adding functionality to the receive direction is generally backwards
+compatible: adding events, adding return and event data members.
+Clients are expected to ignore the ones they don't know.
+
+Removing "unreachable" stuff like events that can't be triggered
+anymore, optional return or event data members that can't be sent
+anymore, and return or event data member (enumeration) values that
+can't be sent anymore makes no difference to clients, except for
+introspection.  The latter can conceivably confuse clients, so tread
+carefully.
+
+Incompatible changes include removing return and event data members.
+
+Any change to a command definition's 'data' or one of the types used
+there (recursively) needs to consider send direction compatibility.
+
+Any change to a command definition's 'return', an event definition's
+'data', or one of the types used there (recursively) needs to consider
+receive direction compatibility.
+
+Any change to types used in both contexts need to consider both.
+
+Members of enumeration types, complex types and alternate types may be
+reordered freely.  For enumerations and alternate types, this doesn't
+affect the wire encoding.  For complex types, this might make the
+implementation emit JSON object members in a different order, which
+the Client JSON Protocol permits.
+
+
 =3D=3D Code generation =3D=3D
=20
 The QAPI code generator qapi-gen.py generates code and documentation
--=20
2.21.0


