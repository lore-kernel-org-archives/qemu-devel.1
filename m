Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCAC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEC920661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTosKH3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEC920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Cd-000328-0M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2BM-0001VN-28
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2BL-0004Ja-1V
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35079
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw2BK-0004J2-UV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580123030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCx4/VAnB+Gb+nKkfS+UkkdzEgV8xr2Rmn7ioGkqJqk=;
 b=eTosKH3P8tVIDU7HuQiEBTv+df9MSLndIuNmYhU8d92swd9zObNWBBSHbqrgeu1D5T/Dk1
 tnfLPtQeTCsEAhDTw7hJGKFoUij99c2Xf0deH0Z+8Gvevh/sYbOBXwsNMEVsnOr5wTVHkk
 TEN0EtZgssJmAUcLiOxON/5uSYX0aaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-SfjWoXTxNYC2VsIkdMtogw-1; Mon, 27 Jan 2020 06:03:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B5C1005510;
 Mon, 27 Jan 2020 11:03:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 015C48882C;
 Mon, 27 Jan 2020 11:03:39 +0000 (UTC)
Message-ID: <fb9015104ed131205669cce09416701ba4ba5624.camel@redhat.com>
Subject: Re: [PATCH 3/9] monitor: move hmp_drive_del and hmp_commit to
 blockdev-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 13:03:38 +0200
In-Reply-To: <87imn5kbaw.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-4-mlevitsk@redhat.com>
 <87imn5kbaw.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SfjWoXTxNYC2VsIkdMtogw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-27 at 08:50 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  blockdev-hmp-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
> >  blockdev.c          | 95 --------------------------------------------
> >  2 files changed, 96 insertions(+), 96 deletions(-)
> 
> hmp_drive_add() and hmp_drive_del() are now in the same .c, which feels
> right.  Their declarations are still in separate .h.  Suggest to move
> hmp_drive_add() from sysemu/sysemu.h to sysemu/blockdev.h.  Or maybe
> create a separate .h for the block HMP stuff, just like you created a
> separate .c.
> 
> 

Agree, I totally forgot about the headers.
I added include/block/blockdev-hmp-cmds.h for that now.

Best regards,
	Maxim Levitsky


