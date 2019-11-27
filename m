Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9654C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963112071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNaz7c0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963112071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZs6a-00047e-K4
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZs5u-0003Vo-RZ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZs5t-0005Nz-3t
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:50:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZs5s-0005NC-Tk
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574841035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAbm5cGgP5ER5m7Um2qPCiBkyNONJDUGWZHXffecpgw=;
 b=JNaz7c0Fdp2EXF2JscCb4fMoqCl1SX7rqxszb9xzCp27R2dvNGl0YynCATIxfVmFvJNTXR
 WksT5sh0yUSyKmVh+dPPjMNDT4ryLhqzp9CLz0WK1gJq9aZAdE69g6n3x0ANQth301WrvR
 vSY7A956tn0oRg5h2hxEXHFUVteSs9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-r-j-mT1dP4SLZRtGGt0qUg-1; Wed, 27 Nov 2019 02:50:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37D5107B7E3;
 Wed, 27 Nov 2019 07:50:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC66F608AC;
 Wed, 27 Nov 2019 07:50:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 223EC1138606; Wed, 27 Nov 2019 08:50:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 3/9] monitor: move hmp_drive_del and hmp_commit to
 blockdev-hmp-cmds.c
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-4-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 08:50:31 +0100
In-Reply-To: <20191120185850.18986-4-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:44 +0200")
Message-ID: <87imn5kbaw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: r-j-mT1dP4SLZRtGGt0qUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  blockdev-hmp-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  blockdev.c          | 95 --------------------------------------------
>  2 files changed, 96 insertions(+), 96 deletions(-)

hmp_drive_add() and hmp_drive_del() are now in the same .c, which feels
right.  Their declarations are still in separate .h.  Suggest to move
hmp_drive_add() from sysemu/sysemu.h to sysemu/blockdev.h.  Or maybe
create a separate .h for the block HMP stuff, just like you created a
separate .c.


