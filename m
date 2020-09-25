Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC1CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434BE21741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ub5JLGEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434BE21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpsD-0004fS-87
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpmp-0007nW-4M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpmj-0007E5-2q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:37:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601048237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r+ZrPN4PJ8fO1pGpR3Ejy/1rSpS+dz9mz7NC2iNFPI=;
 b=Ub5JLGEln9Wm5fT8dtTHHIYhzcGhOgqdDqMSA6VdJ/ccZXnZ/cv9ehNZNOBW15POr5C+sa
 fVCm14RFbuNjUTQjAV0Tl9CasW14ztDTKbjv+THqXM+yKrOZ25wu6qjXwZV5eGr1fV6CIQ
 bZdYIY7kFqQB9khLwSL3aFgEiDxsECo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-JhzpEDpGMxiN2Q_nNmwAng-1; Fri, 25 Sep 2020 11:37:13 -0400
X-MC-Unique: JhzpEDpGMxiN2Q_nNmwAng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C30391084D78;
 Fri, 25 Sep 2020 15:37:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93D6F5D9DC;
 Fri, 25 Sep 2020 15:37:08 +0000 (UTC)
Date: Fri, 25 Sep 2020 17:37:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 08/13] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200925153707.GG5731@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-9-kwolf@redhat.com>
 <87r1r4mlt5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r1r4mlt5.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.09.2020 um 17:15 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > This patch adds a new 'coroutine' flag to QMP command definitions that
> > tells the QMP dispatcher that the command handler is safe to be run in a
> > coroutine.
> >
> > The documentation of the new flag pretends that this flag is already
> > used as intended, which it isn't yet after this patch. We'll implement
> > this in another patch in this series.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt            | 12 ++++++++++++
> >  include/qapi/qmp/dispatch.h             |  1 +
> >  tests/test-qmp-cmds.c                   |  4 ++++
> >  scripts/qapi/commands.py                | 10 +++++++---
> >  scripts/qapi/doc.py                     |  2 +-
> >  scripts/qapi/expr.py                    | 10 ++++++++--
> >  scripts/qapi/introspect.py              |  2 +-
> >  scripts/qapi/schema.py                  | 12 ++++++++----
> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
> >  tests/qapi-schema/meson.build           |  1 +
> >  tests/qapi-schema/oob-coroutine.err     |  2 ++
> >  tests/qapi-schema/oob-coroutine.json    |  2 ++
> >  tests/qapi-schema/oob-coroutine.out     |  0
> >  tests/qapi-schema/qapi-schema-test.json |  1 +
> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
> >  15 files changed, 54 insertions(+), 14 deletions(-)
> >  create mode 100644 tests/qapi-schema/oob-coroutine.err
> >  create mode 100644 tests/qapi-schema/oob-coroutine.json
> >  create mode 100644 tests/qapi-schema/oob-coroutine.out
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index f3e7ced212..36daa9b5f8 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -472,6 +472,7 @@ Syntax:
> >                  '*gen': false,
> >                  '*allow-oob': true,
> >                  '*allow-preconfig': true,
> > +                '*coroutine': true,
> >                  '*if': COND,
> >                  '*features': FEATURES }
> >  
> > @@ -596,6 +597,17 @@ before the machine is built.  It defaults to false.  For example:
> >  QMP is available before the machine is built only when QEMU was
> >  started with --preconfig.
> >  
> > +Member 'coroutine' tells the QMP dispatcher whether the command handler
> > +is safe to be run in a coroutine.
> 
> We need to document what exactly makes a command handler coroutine safe
> / unsafe.  We discussed this at some length in review of PATCH v4 1/4:
> 
>     Message-ID: <874kwnvgad.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg05015.html
> 
> I'd be willing to accept a follow-up patch, if that's more convenient
> for you.

Did we ever arrive at a conclusion for a good definition?

I mean I can give a definition like "it's coroutine safe if it results
in the right behaviour even when called in coroutine context", but
that's not really helpful.

FWIW, I would also have a hard time giving a much better definition than
this for thread safety.

> >                                     It defaults to false.  If it is true,
> > +the command handler is called from coroutine context and may yield while
> 
> Is it *always* called from coroutine context, or could it be called
> outside coroutine context, too?  I guess the former, thanks to PATCH 10,
> and as long as we diligently mark HMP commands that such call QMP
> handlers, like you do in PATCH 13.

Yes, it must *always* be called from coroutine context. This is the
reason why I included HMP after all, even though I'm really mostly just
interested in QMP.

> What's the worst than can happen when we neglect to mark such an HMP
> command?

When the command handler tries to yield and it's not in coroutine
context, it will abort(). If it never tries to yield, I think it would
just work - but of course, the ability to yield is the only reason why
you would want to run a command handler in a coroutine.

Kevin


