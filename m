Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D9A20732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSsovMlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D9A20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QKC-0001JW-Hi
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9QJZ-0000JN-6A
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9QJX-0000ih-6x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:27:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9QJX-0000fK-0z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583314058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aglu8KZgXG/HtCwiIY6m0Xm5vgL2DZKDg/hl1dLtxXA=;
 b=DSsovMlHvpyWolIk2uTTdclVPdxWCAxkjhAFFE+Ev3KfSbrCBNJnCSBNAMSW4Yk4kRvIaj
 Dorrzqns4IbVO2mc8VWeBZxI7+4U6UTq/mtlDSeOP9Ax5xk9+LTy1mME8t4JXrjP8cED0b
 uMCUxrT/nvcytY5yIw8ptezXYsDKKP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-W8A9trcoMB-hfUt7wAJyGQ-1; Wed, 04 Mar 2020 04:27:36 -0500
X-MC-Unique: W8A9trcoMB-hfUt7wAJyGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 154F7800D5B;
 Wed,  4 Mar 2020 09:27:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 118D860C84;
 Wed,  4 Mar 2020 09:27:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9412D11386A6; Wed,  4 Mar 2020 10:27:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
References: <20200303163505.32041-1-armbru@redhat.com>
 <CAFEAcA_g=ghK1OO0dTdEoYL2Gon4gPff4pfj5kEo8C1v8N4=wA@mail.gmail.com>
 <87r1y8pm6w.fsf@dusky.pond.sub.org>
 <CAFEAcA8hbmZAEnJzBXa=rwaNdgXgCP2LH+EiErcp1O6mcvrp=Q@mail.gmail.com>
Date: Wed, 04 Mar 2020 10:27:30 +0100
In-Reply-To: <CAFEAcA8hbmZAEnJzBXa=rwaNdgXgCP2LH+EiErcp1O6mcvrp=Q@mail.gmail.com>
 (Peter Maydell's message of "Wed, 4 Mar 2020 09:01:17 +0000")
Message-ID: <87r1y8mpvh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Libvirt <libvir-list@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 4 Mar 2020 at 08:18, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > How much do you think this is likely to affect the
>> > generate-rst-from-qapi-docs series? I'd really like
>> > that to go in for this release, but this looks like
>> > it's shaping up to be a big conflict :-(
>>
>> I paused reviewing your series to post this one, because "I'd really
>> like that to go in for this release" :)
>>
>> My series touches 21 existing commented definitions in qapi/, six more
>> in tests/qapi-schema/doc-good.json, and adds new module
>> qapi/compat.json.  Consolidated diff appended.
>>
>> Rule of thumb for reducing conflict resolution labor: the bigger manual
>> change goes first.  Yours is bigger, but I don't remember how manual it
>> is.
>
> We got pretty much all the manual changes I needed into
> master already, so all that's left really is the script parts.
> The conflicts would basically be where this series affects
> the generate-docs parts of the scripts -- any changes here
> to doc.py are basically dead-code-walking and would need
> to be done over again in the equivalent code for rust generation.
> But looking at the diffstat
>  scripts/qapi/doc.py                           |  16 +-
> so hopefully it won't be too bad.

Not bad at all: two patches, both trivial for this file:

$ git-log --patch master..posted/qapi-features scripts/qapi/doc.py
commit 63daae3c1da9a7d8a189a9dfc80804c812b3f6af
Author: Markus Armbruster <armbru@redhat.com>
Date:   Fri Oct 18 11:23:40 2019 +0200

    qapi: Consistently put @features parameter right after @ifcond
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 36e823338b..92f584edcf 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,8 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                 texi_members(doc, 'Values',
                                              member_func=3Dtexi_enum_value=
)))
=20
-    def visit_object_type(self, name, info, ifcond, base, members, variant=
s,
-                          features):
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
@@ -262,9 +262,9 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
         self._gen.add(texi_type('Alternate', doc, ifcond,
                                 texi_members(doc, 'Members')))
=20
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig,
-                      features):
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Command', doc, ifcond,
                                texi_arguments(doc,

commit 9e101e2b1803f326df46e42d88bae9f281da9fe4
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Oct 15 14:33:24 2019 +0200

    qapi: Add feature flags to remaining definitions
   =20
    In v4.1.0, we added feature flags just to struct types (commit
    6a8c0b5102^..f3ed93d545), to satisfy an immediate need (commit
    c9d4070991 "file-posix: Add dynamic-auto-read-only QAPI feature").  In
    v4.2.0, we added them to commands (commit 23394b4c39 "qapi: Add
    feature flags to commands") to satisfy another immediate need (commit
    d76744e65e "qapi: Allow introspecting fix for savevm's cooperation
    with blockdev").
   =20
    Add them to the remaining definitions: enumeration types, union types,
    alternate types, and events.
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 1787a53d91..36e823338b 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -243,7 +243,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
     def write(self, output_dir):
         self._gen.write(output_dir)
=20
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
+    def visit_enum_type(self, name, info, ifcond, features, members, prefi=
x):
         doc =3D self.cur_doc
         self._gen.add(texi_type('Enum', doc, ifcond,
                                 texi_members(doc, 'Values',
@@ -257,7 +257,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
         self._gen.add(texi_type('Object', doc, ifcond,
                                 texi_members(doc, 'Members', base, variant=
s)))
=20
-    def visit_alternate_type(self, name, info, ifcond, variants):
+    def visit_alternate_type(self, name, info, ifcond, features, variants)=
:
         doc =3D self.cur_doc
         self._gen.add(texi_type('Alternate', doc, ifcond,
                                 texi_members(doc, 'Members')))
@@ -270,7 +270,7 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                texi_arguments(doc,
                                               arg_type if boxed else None)=
))
=20
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         doc =3D self.cur_doc
         self._gen.add(texi_msg('Event', doc, ifcond,
                                texi_arguments(doc,


