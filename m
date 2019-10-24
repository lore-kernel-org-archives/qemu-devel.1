Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F39CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F3D20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzfY5p6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F3D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNan1-0007Du-DK
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNal6-0004u2-1t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNal3-0001fW-QR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:54:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNal3-0001f1-K9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0lYdZ6C06NPcCJlDe0gCUhvu9DciXiqBjimCh+LKec=;
 b=TzfY5p6zYpNeat1c+3tjEccwYVg89FpkCfc/4NiuGcj2N/lSkN4m+uPR9kalzozWJZfpVv
 MtgZ7GEe8MckN1ZhPdQU5JVs4FeVnd7HbmSq4fzTi7X2acwUDAj4I75H8RhXnaU2zq++Dv
 W38UC2YgJ1GlifE6I5Zi/dAx96wbfVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-R56ei82sN4eDDeFYTofqbQ-1; Thu, 24 Oct 2019 06:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 564F1107AD31;
 Thu, 24 Oct 2019 10:54:15 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE1C600C4;
 Thu, 24 Oct 2019 10:54:12 +0000 (UTC)
Date: Thu, 24 Oct 2019 12:54:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Message-ID: <20191024105411.GA6200@linux.fritz.box>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-2-kwolf@redhat.com>
 <173e0a00-34e3-522a-4e9b-a33661e3f5ba@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <173e0a00-34e3-522a-4e9b-a33661e3f5ba@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: R56ei82sN4eDDeFYTofqbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.10.2019 um 11:59 hat Denis Lunev geschrieben:
> On 10/23/19 6:26 PM, Kevin Wolf wrote:
> > Some functions require that the caller holds a certain CoMutex for them
> > to operate correctly. Add a function so that they can assert the lock i=
s
> > really held.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/qemu/coroutine.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> > index 9801e7f5a4..a36bcfe5c8 100644
> > --- a/include/qemu/coroutine.h
> > +++ b/include/qemu/coroutine.h
> > @@ -167,6 +167,13 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mute=
x);
> >   */
> >  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
> > =20
> > +/**
> > + * Assert that the current coroutine holds @mutex.
> > + */
> > +static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *m=
utex)
> > +{
> > +    assert(mutex->locked && mutex->holder =3D=3D qemu_coroutine_self()=
);
> > +}
> > =20
> >  /**
> >   * CoQueues are a mechanism to queue coroutines in order to continue e=
xecuting
> I think that we should use atomic_read(&mutex->locked) and require barrie=
rs
> working with holder.

Hm, this would only be necessary for the case that the assertion doesn't
hold true. I'll do the atomic_read() because it's easy enough, but I
don't think we need or want barriers here. If another thread modifies
this concurrently, the condition is false either way.

Kevin


