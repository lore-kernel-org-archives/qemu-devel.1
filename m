Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEFDC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FF920657
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSS8pDzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FF920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXR7D-0000b0-W3
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXR2u-0005qh-6J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXR2s-0002hE-Dk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603813077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ir2gDTy+ER5JXYHh2z1eckxKPyG3ScAGfAHSq4Ftc6g=;
 b=QSS8pDzkFSPNG82adAXpMub/+3sSaZlAS0EsZV2MHaPLKZlOofdrujCUFrdJvT99rfyGKx
 tec3v/4nZoi8zUONsNohkwjco1n/JCBlnUmx2w6X+G/n2N8vwtN1GRncHE9SRx38kMCR1B
 j6kltCIhguI99CXH6jaBfwEaLpGbDsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-J56raPpQM-O1M-Wd1YCXPQ-1; Tue, 27 Oct 2020 11:37:54 -0400
X-MC-Unique: J56raPpQM-O1M-Wd1YCXPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77E1E809DD6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 15:37:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2F91C4;
 Tue, 27 Oct 2020 15:37:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C0FF113865F; Tue, 27 Oct 2020 16:37:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH 0/3] console: make QMP screendump use coroutine
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
Date: Tue, 27 Oct 2020 16:37:43 +0100
In-Reply-To: <20201010204106.1368710-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Sun, 11 Oct 2020 00:41:03 +0400")
Message-ID: <87pn5365o8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> Thanks to recent work by Kevin, it becomes possible to run HMP/QMP comman=
ds i=3D
> n a
> coroutine. The screendump command is a good target, as it requires to re-=
enter
> the main-loop in ordre to flush the display, and write to file in a non-b=
lock=3D
> ing
> way.
>
> Despite the flush, the dump may still have glitches. The graphic device m=
ay
> perform some operations during the write on the same framebuffer. Doing a=
 mem=3D
> ory
> copy could help, but it would also create a number of other issues. Keepi=
ng t=3D
> he
> BQL would defeat a number of advantages of using a coroutine. Afaik, ther=
e is=3D
>  no
> mechanism to "freeze" the device either (and this could also have bad
> consequences anyway). Good enough?

This is v2 of
Message-Id: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02313.html

The title has become slightly misleading: v2 covers HMP, too, as the
description says.

A changelog would've helped me review.  Next time :)

[...]


