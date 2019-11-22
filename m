Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D65C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6595A20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy8gJ9yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595A20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9JM-0001uI-6P
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iY9G6-0000Qh-9X
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iY9G3-0006SA-R4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:46:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iY9G2-0006Rh-Se
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574430357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WShRKj48036N4/tpgIhVdr3bMBYpW0E56yC2fO+jE3I=;
 b=Cy8gJ9ywBeHYby9SJAlph+rD+RI9ulUOPJ2ofpnhgOEyN4c/P9nh1ISS6FTqBp7ZopUGNc
 wm9V4uSC/zRnxaZQznJUr8OSUJ648f2plMzSgxCjio0F8X9j0hC4rqJ+o+Lq6ejuHlMICb
 NxDaRwJuzN6JU+NCX4qqGFtLaW1Aii0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-tqpa3nqrObOwhk0FSTcJfA-1; Fri, 22 Nov 2019 08:45:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6414B8024C3;
 Fri, 22 Nov 2019 13:45:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB3C75E57;
 Fri, 22 Nov 2019 13:45:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id A218F220AFF; Fri, 22 Nov 2019 08:45:47 -0500 (EST)
Date: Fri, 22 Nov 2019 08:45:47 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/4] virtiofsd: Release file locks using F_UNLCK
Message-ID: <20191122134547.GC8636@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-2-vgoyal@redhat.com>
 <20191122100713.GB464656@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191122100713.GB464656@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tqpa3nqrObOwhk0FSTcJfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 10:07:13AM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 15, 2019 at 03:55:40PM -0500, Vivek Goyal wrote:
> > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pas=
sthrough_ll.c
> > index bc214df0c7..028e7da273 100644
> > --- a/contrib/virtiofsd/passthrough_ll.c
> > +++ b/contrib/virtiofsd/passthrough_ll.c
> > @@ -936,6 +936,14 @@ static void put_shared(struct lo_data *lo, struct =
lo_inode *inode)
> >  =09}
> >  }
> > =20
> > +static void release_plock(gpointer data)
>=20
> The name posix_locks_value_destroy() would be clearer because it matches
> g_hash_table_new_full() terminology and the function cannot be confused
> with a lock acquire/release operation.

Ok, will use this name.

>=20
> This patch conflicts with the cleanups that are currently being made to
> virtiofsd:
> https://github.com/stefanha/qemu/commit/1e493175feca58a81a2d0cbdac93b92e5=
425d850#diff-ca2dea995d1e6cdb95c8a47c7cca51ceR773

Yes it will. I see you are removing element from hash table on lo_flush().
This works fine today but with waiting locks, we drop the
inode->plock_mutex lock and then wait for the lock and expect
"lo_inode_plock" to not go away.

So I don't think you can remove the element from hash table upon
lo_flush(). May be we can refcount lo_inode_plock structure and first
release all the locks using setlk(UNLCK) and then drop the reference. If
this is last refernce, it will be freed.

And waiting lock code, will obtain a refernce under inode->posix_locks
and then wait for lock outside the lock.

IOW, I will say don't do this optimization of lookup + remove because
it will not work with blocking locks.

Thanks
Vivek


