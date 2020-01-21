Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE29BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C0120882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSfiC6PP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrsJ-0002yJ-UQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itrrY-0002Vz-MU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itrrT-0004np-S6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:38:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itrrT-0004nC-KB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579606702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F8XxGJsjoaQe+jUlTZbC+k5CrlCU7PiSJnd4bAavd4=;
 b=dSfiC6PPpXEokOUFz61oaedmjjMfE4WWBqqi49aRX0bLBzPXCtpnBmiZlu/hcZ8k08qGfx
 1n/qDaYcRT6Djqjt5NCV+QpmDkBV3q7BwJsRYI95eVx6nMCqnqqwwHYwcbuvktQESutWxX
 fJI9p+0DmD9dWTw+9NmtGN3XR3pKQC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Xb4iN7CSNFWAzfyn6-W1ig-1; Tue, 21 Jan 2020 06:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68FA8800D4C;
 Tue, 21 Jan 2020 11:38:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E73C55DA66;
 Tue, 21 Jan 2020 11:38:14 +0000 (UTC)
Date: Tue, 21 Jan 2020 11:38:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 016/104] virtiofsd: Open vhost connection instead of
 mounting
Message-ID: <20200121113812.GD2929@work-vm>
References: <20191212163904.159893-17-dgilbert@redhat.com>
 <20200121065721.28912-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200121065721.28912-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Xb4iN7CSNFWAzfyn6-W1ig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > When run with vhost-user options we conect to the QEMU instead
> > via a socket.  Start this off by creating the socket.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
>=20
> <snip>
> > +    /*
> > +     * Poison the fuse FD so we spot if we accidentally use it;
> > +     * DO NOT check for this value, check for fuse_lowlevel_is_virtio(=
)
> > +     */
> > +    se->fd =3D 0xdaff0d11;
> </snip>
>=20
> As a result of this, se->fd now holds dummy fd.
> So we should remove close(se->fd) in fuse_session_destroy():
> https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-dev/tools/virtiofsd/fuse=
_lowlevel.c#L2663

Thanks; the easier fix here is to remove the dummy
0xdaff0d11 value and just use -1  - it was quite a useful trick when
I first did this to find places where we were accidentally using
the fd when we shouldn't, but it's not really needed now we got it
going.

> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thanks.

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


