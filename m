Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72EC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D5220748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er0qrgXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D5220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isNsR-0001aE-71
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1isNrk-00013L-Uh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1isNrj-0003hh-2h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:24:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1isNri-0003h5-VF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579253070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pp3Vs9w4uQbtdVCf5G8e7VyLd8hMd3Kw8DVMRQ9FZg4=;
 b=Er0qrgXzVNvs6ML2gGENvvqeHh8ZJzd+HsAzTEvcHOal9zWYs2vxQ0XTsHw8+VgygqqMsy
 9+2OORmgEB65T2Y83aIlDeBor6GZBY9wHnih3VYvfhNRATf6tpcGIYImz7IEy5hnQvVVI4
 ce8/lkD2t7KTiGXQxftDx+/8fVIUzUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-mjFqLWwSNVeDVdvVFgEJkg-1; Fri, 17 Jan 2020 04:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD2BB800D48;
 Fri, 17 Jan 2020 09:24:25 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CE8B5DA32;
 Fri, 17 Jan 2020 09:24:22 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:24:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 4/4] block: Mark 'block_resize' as coroutine
Message-ID: <20200117092421.GB5646@dhcp-200-226.str.redhat.com>
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-5-kwolf@redhat.com>
 <87tv4vzqd7.fsf@dusky.pond.sub.org>
 <20200116101333.GA9470@linux.fritz.box>
 <875zhbtox2.fsf@dusky.pond.sub.org>
 <20200116152312.GI9470@linux.fritz.box>
 <871rryr60a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rryr60a.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mjFqLWwSNVeDVdvVFgEJkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.01.2020 um 06:44 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 16.01.2020 um 16:13 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>=20
> >> > Am 16.01.2020 um 10:45 hat Markus Armbruster geschrieben:
> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> >> > block_resize is safe to run in a coroutine, so use it as an examp=
le for
> >> >> > the new 'coroutine': true annotation in the QAPI schema.
> >> >> >
> >> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> >> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> >
> >> >> > diff --git a/blockdev.c b/blockdev.c
> >> >> > index 8e029e9c01..b5e5d1e072 100644
> >> >> > --- a/blockdev.c
> >> >> > +++ b/blockdev.c
> >> >> > @@ -3161,9 +3161,9 @@ void hmp_drive_del(Monitor *mon, const QDic=
t *qdict)
> >> >> >      aio_context_release(aio_context);
> >> >> >  }
> >> >> > =20
> >> >> > -void qmp_block_resize(bool has_device, const char *device,
> >> >> > -                      bool has_node_name, const char *node_name,
> >> >> > -                      int64_t size, Error **errp)
> >> >> > +void coroutine_fn qmp_block_resize(bool has_device, const char *=
device,
> >> >> > +                                   bool has_node_name, const cha=
r *node_name,
> >> >> > +                                   int64_t size, Error **errp)
> >> >> >  {
> >> >> >      Error *local_err =3D NULL;
> >> >> >      BlockBackend *blk =3D NULL;
> >> >>=20
> >> >> Pardon my ignorant question: what exactly makes a function a
> >> >> coroutine_fn?
> >> >
> >> > When Stefan requested adding the coroutine_fn marker, it seemed to m=
ake
> >> > sense to me because the QMP dispatcher will always call it from
> >> > coroutine context now, and being always run in coroutine context mak=
es a
> >> > function a coroutine_fn.
> >> >
> >> > However, it's also called from hmp_block_resize(), so at least for n=
ow
> >> > coroutine_fn is actually wrong.
> >>=20
> >> This answers the question when we mark a function a coroutine_fn.  I
> >> meant to ask what conditions the function itself must satisfy to be
> >> eligible for this mark.
> >
> > The requirement is actually not about the function itself, it's about
> > the callers, as stated above.
> >
> > But being a coroutine_fn allows the function to call other functions
> > that only work in coroutine context (other coroutine_fns). In the end
> > the reason why a function only works in coroutine context is usually
> > that it (or any other coroutine_fns called by it) could yield, which
> > obviously doesn't work outside of coroutine contest.
>=20
> Thanks.
>=20
> I think "being always run in coroutine context makes a function a
> coroutine_fn" is inaccurate.  It's "calling a coroutine_fn without
> switching to coroutine context first when not already in coroutine
> context".  The induction terminates at basic coroutine_fn like
> qemu_coroutine_yield().

I think we would tend to mark things as coroutine_fn even if they don't
call other coroutine_fns (yet), but would be allowed to. But this is now
really splitting hairs.

Maybe I should just have referred to the documentation in the source:

/**
 * Mark a function that executes in coroutine context
 *
 * Functions that execute in coroutine context cannot be called directly fr=
om
 * normal functions.  In the future it would be nice to enable compiler or
 * static checker support for catching such errors.  This annotation might =
make
 * it possible and in the meantime it serves as documentation.
 *
 * For example:
 *
 *   static void coroutine_fn foo(void) {
 *       ....
 *   }
 */
#define coroutine_fn

Kevin


