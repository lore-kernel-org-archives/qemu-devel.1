Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F18C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5564208CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiR4WZTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5564208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2CF-0002Ym-41
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2B3-0001A7-EO
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2Ay-0004BL-NB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw2Ay-0004B2-JG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580123008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEE+qjBgJRvhkzE15L+RA0MhSMYvD9Qe88u8fB1iz3A=;
 b=PiR4WZTEgDycDEuOiuS3B3sF+Rp2pAu4D3jmrtWXCrwVf+tRiQFSkxNJXo2oZvplIKgGhB
 xvfZFo+atbn0RpqTk32zIcfihO2Mn7c925BQLmNA9HNzZl1TTrFvdqoaLBQdmG30NYqUYd
 gutwJ0ByJDJ8rHLxIC2UruJW2WIGPyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-bFR8YXEXMee813Cye2wgKQ-1; Mon, 27 Jan 2020 06:03:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59179184BBAD;
 Mon, 27 Jan 2020 11:03:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B52C03B7;
 Mon, 27 Jan 2020 11:03:23 +0000 (UTC)
Message-ID: <2340ed69227b0e9e1a370f9fac4cb39955bdc5bb.camel@redhat.com>
Subject: Re: [PATCH 3/9] monitor: move hmp_drive_del and hmp_commit to
 blockdev-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 13:03:22 +0200
In-Reply-To: <87muchkc95.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-4-mlevitsk@redhat.com>
 <87muchkc95.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bFR8YXEXMee813Cye2wgKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-27 at 08:29 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  blockdev-hmp-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
> >  blockdev.c          | 95 --------------------------------------------
> >  2 files changed, 96 insertions(+), 96 deletions(-)
> > 
> > diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> > index 21ff6fa9a9..8884618238 100644
> > --- a/blockdev-hmp-cmds.c
> > +++ b/blockdev-hmp-cmds.c
> > @@ -33,7 +33,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "monitor/monitor.h"
> >  #include "block/block_int.h"
> > -
> > +#include "qapi/qapi-commands-block.h"
> 
> I prefer keeping qapi/ stuff together.  Please add this right before
> #include "qapi/qmp/qdict.h".

Absolutely no problem!

Best regards,
	Maxim Levitsky




