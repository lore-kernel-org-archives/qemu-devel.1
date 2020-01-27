Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474CCC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135BA206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsYoU3t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135BA206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2E0-0005yg-95
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2Ba-0001s7-Hm
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2BZ-0004X0-JA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:04:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw2BZ-0004VC-Bz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580123045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sin60CkYijCQ8Cz22jWHN+WjsGUcRdh8Q2kQCNrT+7Q=;
 b=SsYoU3t3o+p9r5flUOb7YrWYeZERFdGnd+N1DcZlNRf3mDw+qYZp6oskC+/Gxk62utl9C7
 bBxLzyfGAEsemyWz88t2nFhS/yD0nx8AdYL+jqzSpsxegIJ8jUqVLCnFkIL28BcEAdNjvR
 nYEpBi2dQAQ59m4NdOpmzPUfqL2wtKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-WoTbAEw_MbKJFMU0UYJ4MQ-1; Mon, 27 Jan 2020 06:04:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D688045D1;
 Mon, 27 Jan 2020 11:04:01 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 522191084192;
 Mon, 27 Jan 2020 11:03:55 +0000 (UTC)
Message-ID: <158f709d0d3eb4a8029a7f7d38028db97b5cbe2b.camel@redhat.com>
Subject: Re: [PATCH 5/9] monitor: move hmp_block_job* to blockdev-hmp-cmd.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 13:03:55 +0200
In-Reply-To: <87r21tkcig.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-6-mlevitsk@redhat.com>
 <87r21tkcig.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WoTbAEw_MbKJFMU0UYJ4MQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-27 at 08:24 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  blockdev-hmp-cmds.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
> >  monitor/hmp-cmds.c  | 52 ---------------------------------------------
> >  2 files changed, 52 insertions(+), 52 deletions(-)
> > 
> > diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> > index 5ae899a324..e333de27b1 100644
> > --- a/blockdev-hmp-cmds.c
> > +++ b/blockdev-hmp-cmds.c
> > @@ -238,3 +238,55 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict)
> >      hmp_handle_error(mon, &err);
> >  }
> >  
> > +
> 
> Is this extra blank line intentional?

Yes, it gives me 1 black line spacing between all functions.

Best regards,
	Maxim Levitsky



