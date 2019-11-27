Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12872C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D1720835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQA3B1W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D1720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2go-0004yS-32
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ia2fp-00049P-6v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ia2fl-0005G6-Fd
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:08:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52883
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ia2fj-0005BU-7c
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574881695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjrYGUsjBB6L9bMCkND2XrZ4wH6eNS1nrdsk3UtnteE=;
 b=NQA3B1W6zheG3zx7dhJmBzXPdwhH2WSce11RNl0YWBeghshTtn1xlvx2PiISRn9U/u3LJ2
 YjD14aODv2zKE9RneTQ1SfcacRD0heuO1vRysyBaCiP1ZJeu4madICX6FZqjmxbMf01lQC
 3gbxIlEQh7WHumKcG33QJuRvllWbpmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-JTPhCQzYPbq9m2Qp5U7vYA-1; Wed, 27 Nov 2019 14:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D349800D4C;
 Wed, 27 Nov 2019 19:08:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 662C869181;
 Wed, 27 Nov 2019 19:08:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D75392202E9; Wed, 27 Nov 2019 14:08:08 -0500 (EST)
Date: Wed, 27 Nov 2019 14:08:08 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191127190808.GA18507@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
 <20191122174732.GL2785@work-vm> <20191125154414.GC13247@redhat.com>
 <20191126130229.GG2928@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191126130229.GG2928@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JTPhCQzYPbq9m2Qp5U7vYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, miklos@szeredi.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 01:02:29PM +0000, Dr. David Alan Gilbert wrote:

[..]
> > > > @@ -1950,21 +1948,54 @@ static void lo_setlk(fuse_req_t req, fuse_i=
no_t ino,
> > > > =20
> > > >  =09if (!plock) {
> > > >  =09=09saverr =3D ret;
> > > > +=09=09pthread_mutex_unlock(&inode->plock_mutex);
> > > >  =09=09goto out;
> > > >  =09}
> > > > =20
> > > > +=09/*
> > > > +=09 * plock is now released when inode is going away. We already h=
ave
> > > > +=09 * a reference on inode, so it is guaranteed that plock->fd is
> > > > +=09 * still around even after dropping inode->plock_mutex lock
> > > > +=09 */
> > > > +=09ofd =3D plock->fd;
> > > > +=09pthread_mutex_unlock(&inode->plock_mutex);
> > > > +
> > > > +=09/*
> > > > +=09 * If this lock request can block, request caller to wait for
> > > > +=09 * notification. Do not access req after this. Once lock is
> > > > +=09 * available, send a notification instead.
> > > > +=09 */
> > > > +=09if (sleep && lock->l_type !=3D F_UNLCK) {
> > > > +=09=09/*
> > > > +=09=09 * If notification queue is not enabled, can't support async
> > > > +=09=09 * locks.
> > > > +=09=09 */
> > > > +=09=09if (!se->notify_enabled) {
> > > > +=09=09=09saverr =3D EOPNOTSUPP;
> > > > +=09=09=09goto out;
> > > > +=09=09}
> > > > +=09=09async_lock =3D true;
> > > > +=09=09unique =3D req->unique;
> > > > +=09=09fuse_reply_wait(req);
> > > > +=09}
> > > >  =09/* TODO: Is it alright to modify flock? */
> > > >  =09lock->l_pid =3D 0;
> > > > -=09ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
> > > > +=09if (async_lock)
> > > > +=09=09ret =3D fcntl(ofd, F_OFD_SETLKW, lock);
> > > > +=09else
> > > > +=09=09ret =3D fcntl(ofd, F_OFD_SETLK, lock);
> > >=20
> > > What happens if the guest is rebooted after it's asked
> > > for, but not been granted a lock?
> >=20
> > I think a regular reboot can't be done till a request is pending, becau=
se
> > virtio-fs can't be unmounted and unmount will wait for all pending
> > requests to finish.
> >=20
> > Destroying qemu will destroy deamon too.
> >=20
> > Are there any other reboot paths I have missed.
>=20
> Yes, there are a few other ways the guest can reboot:
>   a) A echo b > /proc/sysrq-trigger

I tried it. Both qemu and virtiofsd hang. virtiofsd wants to stop a=20
queue. And that tries to stop thrad pool. But one of the threads in
thread pool is blocked on setlkw. So g_thread_pool_free() hangs.

I am not seeing any option in glib thread pool API to stop or send
signal to threads which are blocked.

Thanks
Vivek


