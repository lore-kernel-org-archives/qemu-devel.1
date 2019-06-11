Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55AFC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF482089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF482089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hailE-0007Zk-W1
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1haidq-0004b7-Ce
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1haidp-0006LK-A2
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1haido-0006Kr-Qw
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26943C057F4B
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:24:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB8E95D705
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:24:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD1FE11384AA; Tue, 11 Jun 2019 17:24:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 17:24:42 +0200
Message-Id: <20190611152448.29436-7-armbru@redhat.com>
In-Reply-To: <20190611152448.29436-1-armbru@redhat.com>
References: <20190611152448.29436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 11 Jun 2019 15:24:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/12] scripts/clean-header-guards: Fix handling
 of trailing comments
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

clean-header-guards.pl fails to recognize a header guard #endif when
it's followed by a // comment, or multiple comments.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190604181618.19980-3-armbru@redhat.com>
---
 scripts/clean-header-guards.pl | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/clean-header-guards.pl b/scripts/clean-header-guards=
.pl
index 5e67f1998c..f47d673ad5 100755
--- a/scripts/clean-header-guards.pl
+++ b/scripts/clean-header-guards.pl
@@ -103,7 +103,7 @@ sub preprocess {
 for my $fname (@ARGV) {
     my $text =3D slurp($fname);
=20
-    $text =3D~ m,\A(\s*\n|\s*//\N*\n|\s*/\*.*?\*/\s*\n)*|,msg;
+    $text =3D~ m,\A(\s*\n|\s*//\N*\n|\s*/\*.*?\*/\s*\n)*|,sg;
     my $pre =3D $&;
     unless ($text =3D~ /\G(.*\n)/g) {
         $text =3D~ /\G.*/;
@@ -137,14 +137,16 @@ for my $fname (@ARGV) {
     }
=20
     unless ($body =3D~ m,\A((.*\n)*)
-                       (\s*\#\s*endif\s*(/\*\s*.*\s*\*/\s*)?\n?)
-                       (\n|\s)*\Z,x) {
+                       ([ \t]*\#[ \t]*endif([ \t]*\N*)\n)
+                       ((?s)(\s*\n|\s*//\N*\n|\s*/\*.*?\*/\s*\n)*)
+                       \Z,x) {
         skipping($fname, "can't find end of header guard");
         next;
     }
     $body =3D $1;
     my $line3 =3D $3;
     my $endif_comment =3D $4;
+    my $post =3D $5;
=20
     my $oldg =3D $guard;
=20
@@ -186,14 +188,14 @@ for my $fname (@ARGV) {
         my $newl1 =3D "#ifndef $guard\n";
         my $newl2 =3D "#define $guard\n";
         my $newl3 =3D "#endif\n";
-        $newl3 =3D~ s,\Z, /* $guard */, if defined $endif_comment;
+        $newl3 =3D~ s,\Z, /* $guard */, if $endif_comment;
         if ($line1 ne $newl1 or $line2 ne $newl2 or $line3 ne $newl3) {
             $pre =3D~ s/\n*\Z/\n\n/ if $pre =3D~ /\N/;
             $body =3D~ s/\A\n*/\n/;
             if ($opt_n) {
                 print "$fname would be cleaned up\n" if $opt_v;
             } else {
-                unslurp($fname, "$pre$newl1$newl2$body$newl3");
+                unslurp($fname, "$pre$newl1$newl2$body$newl3$post");
                 print "$fname cleaned up\n" if $opt_v;
             }
         }
--=20
2.21.0


