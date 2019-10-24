Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E724620679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGqsxxDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E724620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaqM-0003cP-Cj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNaoZ-0001Sp-N5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNaoX-0002zL-Oc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:57:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNaoX-0002yU-Jm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5csi6x/hSuHoKlH7HI8cZRnRu4o5pBVTHoH/EQ8Exw=;
 b=EGqsxxDIncoFnHrmSqb78PX68Vj1Kt8lL6pcAEFcr0DLaxtvUdqFP8MDJ0AA8eDzzjg8ZO
 sWU8edf5HSWI0wVI5HVl598HluFz4NjfeDitiZespBhC8aEQjUXw6SXwUcybZ+QZirdNEd
 /kyump86NXjNutBmLDCbWgPEbnvbRNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-prHYF28nP2ukvVkroafotw-1; Thu, 24 Oct 2019 06:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AA51800DBE;
 Thu, 24 Oct 2019 10:57:50 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDD12196B2;
 Thu, 24 Oct 2019 10:57:47 +0000 (UTC)
Date: Thu, 24 Oct 2019 12:57:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH 2/3] qcow2: Assert that qcow2_cache_get() callers hold
 s->lock
Message-ID: <20191024105746.GB6200@linux.fritz.box>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-3-kwolf@redhat.com>
 <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3600fb84-e1f1-c70a-4b83-e7a379f50614@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: prHYF28nP2ukvVkroafotw-1
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

Am 24.10.2019 um 12:01 hat Denis Lunev geschrieben:
> On 10/23/19 6:26 PM, Kevin Wolf wrote:
> > qcow2_cache_do_get() requires that s->lock is locked because it can
> > yield between picking a cache entry and actually taking ownership of it
> > by setting offset and increasing the reference count.
> >
> > Add an assertion to make sure the caller really holds the lock. The
> > function can be called outside of coroutine context, where bdrv_pread
> > and flushes become synchronous operations. The lock cannot and need not
> > be taken in this case.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2-cache.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> > index d29b038a67..75b13dad99 100644
> > --- a/block/qcow2-cache.c
> > +++ b/block/qcow2-cache.c
> > @@ -327,6 +327,9 @@ static int qcow2_cache_do_get(BlockDriverState *bs,=
 Qcow2Cache *c,
> >      int min_lru_index =3D -1;
> > =20
> >      assert(offset !=3D 0);
> > +    if (qemu_in_coroutine()) {
> > +        qemu_co_mutex_assert_locked(&s->lock);
> > +    }
>=20
> that is looking not good to me. If this is really requires lock, we shoul=
d
> check for the lock always. In the other hand we could face missed
> lock out of coroutine.

As the commit message explains, outside of coroutine context, we can't
yield and bdrv_pread and bdrv_flush become synchronous operations
instead, so there is nothing else that we need to protect against.

Kevin


