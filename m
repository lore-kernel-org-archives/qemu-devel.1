Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BAC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BF12419A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxLqKtnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BF12419A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjvb-0005b5-4U
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXjuc-0004oE-As
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXjua-0001vp-27
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603885598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voRYXyZHXY+3LKEYJcMXDmvPN0doGt5O5LtLvOzrVuM=;
 b=LxLqKtnXSon2dvRBd5tK49Z6MreY3G2bZZhDAGuk0kIIG6aHSJjL6/pDHvn/Gjhm04F47G
 Wpv73g7bfA4zaWd7VvEtVWX5sUPPgD7BEQIjOrzLbfZy+YCtJpMFAgAfNu+T4eMQuXy14W
 Xm94i3QOEaTt2RXvFU9oWskj1hIVWt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-RQwqVP3wNP-yX4AKAPYz4A-1; Wed, 28 Oct 2020 07:46:36 -0400
X-MC-Unique: RQwqVP3wNP-yX4AKAPYz4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B6B1DDFB;
 Wed, 28 Oct 2020 11:46:35 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-164.ams2.redhat.com [10.36.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74B9C60FC2;
 Wed, 28 Oct 2020 11:46:27 +0000 (UTC)
Date: Wed, 28 Oct 2020 12:46:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
Message-ID: <20201028114625.GA7355@merkur.fritz.box>
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
 <87a6w63kbw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a6w63kbw.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.10.2020 um 08:01 hat Markus Armbruster geschrieben:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 26/10/20 11:10, Markus Armbruster wrote:
> >> Kevin's "[PATCH v2 0/6] qemu-storage-daemon: QAPIfy --chardev"
> >> involves surgery to the QAPI generator.  Some (most?) of it should go
> >> away if we deprecate the "data" wrappers due to simple unions in QMP.
> >> 
> >> Do we really need to mess with the code generator to solve the problem
> >> at hand?
> >> 
> >> 
> >> Let's recapitulate the problem:
> >> 
> >> * We want to QAPIfy --chardev, i.e. define its argument as a QAPI
> >>   type.
> >
> > Considering that this is not 5.2 stuff at this point, I would like to
> > suggest again moving chardevs to -object, and ask you to evaluate that
> > option with the agreement that I do the work instead of you. :)

I don't think this is the right thing to do at this point. Making more
use of QOM is an orthogonal problem and would only make solving this one
harder.

The problem we have and we're trying to solve is that we have
chardev-add (which has a QAPI schema) and -chardev (which doesn't). We
want to get an option that is described by the schema, doesn't duplicate
things and is still convenient to use.

Whether this option starts with -chardev or with -object doesn't really
make much of a difference. The QAPI schema you need behind it will be
almost or even exactly the same.

> Replacing -chardev with -object without regressing features would be
> lovely.  One feature in particular: introspection.
> 
> If we manage to fully QAPIfy -object, we should be good.  I understand
> Eduardo is cutting a path through the jungle.

I don't expect many difficulties with the existing -object (famous last
words).

But if you make chardevs user creatable objects first, it becomes much
harder because you just combined two problems (one of which is already
known to be hard) into one large problem.

> I can offer assistance with bridging QAPI schema to QOM.

So, the steps that I would suggest are:

1a. Finish the QAPI schema for object-add

1b. Find some way to unify chardev-add's ChardevBackend and a
    CLI-friendly version of it in the schema

2. Generate QOM boilerplate code from ObjectOptions instead of
   duplicating it in the implementation

3. Convert chardevs to using QOM properites only now

If we do 3. earlier, we'll write code that we want to replace later
anyway. If we even do it in parallel with 1b. we'll additionally get
merge conflicts. And if we do it before 1b. we'll do it without
considering QAPI in detail and will lose any flexibility to change
things in the new interface, which will make 1b. much harder.

Kevin


