Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D847C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6947A21872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaAO7Lgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6947A21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iURZ0-0007Wa-GH
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 03:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iURY5-0006vJ-92
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iURY2-0007kK-Ig
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:29:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iURY2-0007if-FL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573547353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+05WDyMw/cN3On14Hp4pah/WUoG9VC6els1fMYil0E=;
 b=GaAO7LgqhMSz0CXywRpdJAoNEwuomJRv5r2lW8FFH90YR+legsT1dQuglWiMPqOGewLVjq
 wQdasv1BgdiVE52pGcdZL7DChE1cFnoRmu6yx8xiTPTVPJy1t8AZr6zNCGL8eYOKemDDj7
 KFyWFt5HvK4Ud+gwBlHhY/lwPeN4QsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-YvmNeZgkMe2QhmSQQJUcjQ-1; Tue, 12 Nov 2019 03:29:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4771005500;
 Tue, 12 Nov 2019 08:29:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 387B3BEA63;
 Tue, 12 Nov 2019 08:29:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53BB31138648; Tue, 12 Nov 2019 09:29:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 15/18] qapi: Support empty modules
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-16-kwolf@redhat.com>
Date: Tue, 12 Nov 2019 09:29:07 +0100
In-Reply-To: <20191017130204.16131-16-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:02:01 +0200")
Message-ID: <8736eto5v0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YvmNeZgkMe2QhmSQQJUcjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> If you added an include file that doesn't contain any definitions, no
> source files would be generated for it. However, in other source files,
> you would still get an #include for the header files of the empty
> module.

Bug.

Cause: we generate #include module.h always, and the module.h when
visiting its first definition.  If there are no definitions, we don't.

> The intended behaviour is that empty source files are created for empty
> modules.

Yes.

>          This patch makes QAPISchema keep a list of all modules
> (including empty ones) and modifies visit() to first visit all modules
> in that list.

Minimally invasive fix.  Backends still initialize module output on
first visit_module(), but now all modules are visited upfront.

Separating "initialize module" from "switch to module" might be easier
to understand.  Idea, not demand.

> Some test reference outputs need to be updated due to the additional
> visitor calls.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  scripts/qapi/schema.py                   | 9 +++++++++
>  tests/qapi-schema/comments.out           | 2 ++
>  tests/qapi-schema/doc-bad-section.out    | 2 ++
>  tests/qapi-schema/doc-good.out           | 2 ++
>  tests/qapi-schema/empty.out              | 2 ++
>  tests/qapi-schema/event-case.out         | 2 ++
>  tests/qapi-schema/include-repetition.out | 4 ++++
>  tests/qapi-schema/include-simple.out     | 3 +++
>  tests/qapi-schema/indented-expr.out      | 2 ++
>  tests/qapi-schema/qapi-schema-test.out   | 4 ++++
>  10 files changed, 32 insertions(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 38041098bd..e1b034d67d 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -749,6 +749,7 @@ class QAPISchema(object):
>          self.docs =3D parser.docs
>          self._entity_list =3D []
>          self._entity_dict =3D {}
> +        self._modules =3D [os.path.basename(fname)]
>          self._predefining =3D True
>          self._def_predefineds()
>          self._predefining =3D False
> @@ -800,6 +801,8 @@ class QAPISchema(object):
>              main_info =3D main_info.parent
>          fname =3D os.path.relpath(include, os.path.dirname(main_info.fna=
me))
>          self._def_entity(QAPISchemaInclude(fname, info))
> +        if fname not in self._modules:
> +            self._modules.append(fname)
> =20
>      def _def_builtin_type(self, name, json_type, c_type):
>          self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
> @@ -1033,6 +1036,12 @@ class QAPISchema(object):
>          visitor.visit_begin(self)
>          module =3D None
>          visitor.visit_module(module)
> +
> +        # Make sure that all modules are visited, even if they contain n=
o
> +        # entities
> +        for module in self._modules:
> +            visitor.visit_module(module)
> +

Slightly neater, I think:

           visitor.visit_begin(self)
  +
  +        # Visit all modules, to ensure @visitor sees them
  +        for module in self._modules:
  +            visitor.visit_module(module)
  +
           module =3D None
           visitor.visit_module(module)

This way, we keep starting with module None rather than whatever user
module comes last.  The .out diffs below then don't add a nother "module
None" line.

>          for entity in self._entity_list:
>              if visitor.visit_needed(entity):
>                  if entity.module !=3D module:
> diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
> index 273f0f54e1..fa7e95d1cc 100644
> --- a/tests/qapi-schema/comments.out
> +++ b/tests/qapi-schema/comments.out
> @@ -1,4 +1,6 @@
>  module None
> +module comments.json
> +module None
>  object q_empty
>  enum QType
>      prefix QTYPE
[...]


