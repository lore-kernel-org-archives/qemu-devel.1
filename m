Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F0C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66E02077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETcqZLsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66E02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGt0-0005rd-TE
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ieGs2-0005QP-Tr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ieGs1-0003QI-9n
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:06:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ieGs1-0003Pp-29
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575889588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzsCG7XOU7Z5xoj8yg3xIM/eZU+HB/jzKirzk7RSnBA=;
 b=ETcqZLsvCIM//b6rFsO8mcICymPjS5NtxiFe2b2euyLrpV6M7qi+CvW0EU69nm5T6MePwb
 8MDEnZXwL8pgtHvjFhDXdAJ0gk/KPoqMZi07UmGEPSZkgFGqJfAMB48L9ouUPNhkrv+NNB
 jeXU/iOMgWdXatBi9fIPKrCL9MWhbmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-hoWKANAdNw-9zpfZrwAGNQ-1; Mon, 09 Dec 2019 06:06:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04233107ACCD;
 Mon,  9 Dec 2019 11:06:24 +0000 (UTC)
Received: from work-vm (ovpn-116-253.ams2.redhat.com [10.36.116.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BF2460BE1;
 Mon,  9 Dec 2019 11:06:20 +0000 (UTC)
Date: Mon, 9 Dec 2019 11:06:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191209110617.GE3403@work-vm>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
 <20191122174732.GL2785@work-vm> <20191125154414.GC13247@redhat.com>
 <20191126130229.GG2928@work-vm> <20191127190808.GA18507@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127190808.GA18507@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hoWKANAdNw-9zpfZrwAGNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Tue, Nov 26, 2019 at 01:02:29PM +0000, Dr. David Alan Gilbert wrote:
>=20
> [..]
> > > > > @@ -1950,21 +1948,54 @@ static void lo_setlk(fuse_req_t req, fuse=
_ino_t ino,
> > > > > =20
> > > > >  =09if (!plock) {
> > > > >  =09=09saverr =3D ret;
> > > > > +=09=09pthread_mutex_unlock(&inode->plock_mutex);
> > > > >  =09=09goto out;
> > > > >  =09}
> > > > > =20
> > > > > +=09/*
> > > > > +=09 * plock is now released when inode is going away. We already=
 have
> > > > > +=09 * a reference on inode, so it is guaranteed that plock->fd i=
s
> > > > > +=09 * still around even after dropping inode->plock_mutex lock
> > > > > +=09 */
> > > > > +=09ofd =3D plock->fd;
> > > > > +=09pthread_mutex_unlock(&inode->plock_mutex);
> > > > > +
> > > > > +=09/*
> > > > > +=09 * If this lock request can block, request caller to wait for
> > > > > +=09 * notification. Do not access req after this. Once lock is
> > > > > +=09 * available, send a notification instead.
> > > > > +=09 */
> > > > > +=09if (sleep && lock->l_type !=3D F_UNLCK) {
> > > > > +=09=09/*
> > > > > +=09=09 * If notification queue is not enabled, can't support asy=
nc
> > > > > +=09=09 * locks.
> > > > > +=09=09 */
> > > > > +=09=09if (!se->notify_enabled) {
> > > > > +=09=09=09saverr =3D EOPNOTSUPP;
> > > > > +=09=09=09goto out;
> > > > > +=09=09}
> > > > > +=09=09async_lock =3D true;
> > > > > +=09=09unique =3D req->unique;
> > > > > +=09=09fuse_reply_wait(req);
> > > > > +=09}
> > > > >  =09/* TODO: Is it alright to modify flock? */
> > > > >  =09lock->l_pid =3D 0;
> > > > > -=09ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
> > > > > +=09if (async_lock)
> > > > > +=09=09ret =3D fcntl(ofd, F_OFD_SETLKW, lock);
> > > > > +=09else
> > > > > +=09=09ret =3D fcntl(ofd, F_OFD_SETLK, lock);
> > > >=20
> > > > What happens if the guest is rebooted after it's asked
> > > > for, but not been granted a lock?
> > >=20
> > > I think a regular reboot can't be done till a request is pending, bec=
ause
> > > virtio-fs can't be unmounted and unmount will wait for all pending
> > > requests to finish.
> > >=20
> > > Destroying qemu will destroy deamon too.
> > >=20
> > > Are there any other reboot paths I have missed.
> >=20
> > Yes, there are a few other ways the guest can reboot:
> >   a) A echo b > /proc/sysrq-trigger
>=20
> I tried it. Both qemu and virtiofsd hang. virtiofsd wants to stop a=20
> queue. And that tries to stop thrad pool. But one of the threads in
> thread pool is blocked on setlkw. So g_thread_pool_free() hangs.
>=20
> I am not seeing any option in glib thread pool API to stop or send
> signal to threads which are blocked.

Is there a way to setup pthread_cancel ?  The upstream libfuse code
has somec ases where it enables cancellation very carefully around
something that might block, does it, then disables cancellation.

Dave

> Thanks
> Vivek
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


