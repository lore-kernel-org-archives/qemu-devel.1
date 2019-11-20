Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAEBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9662120715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDGfdVMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9662120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVr5-000329-OB
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXVqL-0002FW-SW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXVqJ-0004AF-B3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:40:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXVqI-00049l-UV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574278845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjzGCDsYL83uoGgGqFcj0Ccyf5qAmON8hdOGlM0g1JM=;
 b=DDGfdVMBZsiIbBdnRWzoI0Hu5rzvjy9TdwUlbjIFbaPHlLG7VaHPfm/sbkb//8qODIyfBO
 +jGg3/TMu9ly1MkB5a6IA15Ha2laSDOxLYLqRD7ybRs7XzaGwxCIuRGea450Be/duZse55
 Gxo12btfjyV4qRg2HAmGTlG5l6wXu7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-kJJpApZ2N5yxMSvvAVWwzQ-1; Wed, 20 Nov 2019 14:40:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E7F2802691;
 Wed, 20 Nov 2019 19:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4D85A7EC;
 Wed, 20 Nov 2019 19:40:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6177A1138606; Wed, 20 Nov 2019 20:40:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/6] qapi: Module fixes and cleanups
References: <20191120182551.23795-1-armbru@redhat.com>
Date: Wed, 20 Nov 2019 20:40:39 +0100
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 20 Nov 2019 19:25:45 +0100")
Message-ID: <87eey2mj48.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kJJpApZ2N5yxMSvvAVWwzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fat-fingered Kevin's e-mail address...

Markus Armbruster <armbru@redhat.com> writes:

> Kevin recently posted a minimally invasive fix for empty QAPI
> modules[*].  This is my attempt at a fix that also addresses the
> design weakness that led to the bug.
>
> Markus Armbruster (6):
>   qapi: Tweak "command returns a nice type" check for clarity
>   tests/Makefile.include: Fix missing test-qapi-emit-events.[ch]
>   qapi: Generate command registration stuff into separate files
>   qapi: Proper intermediate representation for modules
>   qapi: Fix code generation for empty modules
>   qapi: Simplify QAPISchemaModularCVisitor
>
>  docs/devel/qapi-code-gen.txt             | 19 ++++-
>  Makefile                                 |  4 +-
>  monitor/misc.c                           |  7 +-
>  qga/main.c                               |  2 +-
>  tests/test-qmp-cmds.c                    |  1 +
>  .gitignore                               |  1 +
>  qapi/Makefile.objs                       |  1 +
>  qga/Makefile.objs                        |  1 +
>  scripts/qapi/commands.py                 | 17 +++--
>  scripts/qapi/events.py                   |  2 +-
>  scripts/qapi/gen.py                      | 28 ++++----
>  scripts/qapi/schema.py                   | 92 +++++++++++++++---------
>  scripts/qapi/types.py                    |  5 +-
>  scripts/qapi/visit.py                    |  8 +--
>  tests/.gitignore                         |  1 +
>  tests/Makefile.include                   |  9 ++-
>  tests/qapi-schema/empty.out              |  1 +
>  tests/qapi-schema/include-repetition.out |  6 +-
>  tests/qapi-schema/qapi-schema-test.out   | 24 +++----
>  19 files changed, 144 insertions(+), 85 deletions(-)


