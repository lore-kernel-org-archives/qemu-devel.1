Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38AC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 05:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FE4206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 05:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JttnSgAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FE4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isKSP-0006nQ-7z
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 00:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isKRO-0006A9-S6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 00:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isKRN-00029b-21
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 00:45:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isKRM-00026U-VD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 00:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579239903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NcNAvW0lJFuobri0ZOzkDoU6+9IqehkDDs0SJk5woo=;
 b=JttnSgAkOkn3qxxksX58eNv7vr2ypmxB8Cv6xMfkd1kq14kmzhoE+/+LRPtA5lcpM4kee8
 t5E6I3nkKWPq5jOiWsy4ZQGS+DROXnG6REPbGOMPMvCryZQkHvcnRXMj5MpudTUDWN7R8D
 Nq5Zzog/EADcLQGO4CvFQjz4j6diOs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-jAPs7XkvNw-znsmRhMsjzg-1; Fri, 17 Jan 2020 00:44:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C5CF8010C8;
 Fri, 17 Jan 2020 05:44:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BA5684346;
 Fri, 17 Jan 2020 05:44:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C52821138600; Fri, 17 Jan 2020 06:44:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 4/4] block: Mark 'block_resize' as coroutine
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-5-kwolf@redhat.com>
 <87tv4vzqd7.fsf@dusky.pond.sub.org>
 <20200116101333.GA9470@linux.fritz.box>
 <875zhbtox2.fsf@dusky.pond.sub.org>
 <20200116152312.GI9470@linux.fritz.box>
Date: Fri, 17 Jan 2020 06:44:53 +0100
In-Reply-To: <20200116152312.GI9470@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 16 Jan 2020 16:23:12 +0100")
Message-ID: <871rryr60a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jAPs7XkvNw-znsmRhMsjzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 16.01.2020 um 16:13 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 16.01.2020 um 10:45 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> > block_resize is safe to run in a coroutine, so use it as an example=
 for
>> >> > the new 'coroutine': true annotation in the QAPI schema.
>> >> >
>> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> >> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> >> > diff --git a/blockdev.c b/blockdev.c
>> >> > index 8e029e9c01..b5e5d1e072 100644
>> >> > --- a/blockdev.c
>> >> > +++ b/blockdev.c
>> >> > @@ -3161,9 +3161,9 @@ void hmp_drive_del(Monitor *mon, const QDict =
*qdict)
>> >> >      aio_context_release(aio_context);
>> >> >  }
>> >> > =20
>> >> > -void qmp_block_resize(bool has_device, const char *device,
>> >> > -                      bool has_node_name, const char *node_name,
>> >> > -                      int64_t size, Error **errp)
>> >> > +void coroutine_fn qmp_block_resize(bool has_device, const char *de=
vice,
>> >> > +                                   bool has_node_name, const char =
*node_name,
>> >> > +                                   int64_t size, Error **errp)
>> >> >  {
>> >> >      Error *local_err =3D NULL;
>> >> >      BlockBackend *blk =3D NULL;
>> >>=20
>> >> Pardon my ignorant question: what exactly makes a function a
>> >> coroutine_fn?
>> >
>> > When Stefan requested adding the coroutine_fn marker, it seemed to mak=
e
>> > sense to me because the QMP dispatcher will always call it from
>> > coroutine context now, and being always run in coroutine context makes=
 a
>> > function a coroutine_fn.
>> >
>> > However, it's also called from hmp_block_resize(), so at least for now
>> > coroutine_fn is actually wrong.
>>=20
>> This answers the question when we mark a function a coroutine_fn.  I
>> meant to ask what conditions the function itself must satisfy to be
>> eligible for this mark.
>
> The requirement is actually not about the function itself, it's about
> the callers, as stated above.
>
> But being a coroutine_fn allows the function to call other functions
> that only work in coroutine context (other coroutine_fns). In the end
> the reason why a function only works in coroutine context is usually
> that it (or any other coroutine_fns called by it) could yield, which
> obviously doesn't work outside of coroutine contest.

Thanks.

I think "being always run in coroutine context makes a function a
coroutine_fn" is inaccurate.  It's "calling a coroutine_fn without
switching to coroutine context first when not already in coroutine
context".  The induction terminates at basic coroutine_fn like
qemu_coroutine_yield().

Pertinent:

    /**
     * Return whether or not currently inside a coroutine
     *
     * This can be used to write functions that work both when in coroutine=
 context
     * and when not in coroutine context.  Note that such functions cannot =
use the
     * coroutine_fn annotation since they work outside coroutine context.
     */
    bool qemu_in_coroutine(void);

For qmp_block_resize(), it's used like this, in bdrv_truncate():

    if (qemu_in_coroutine()) {
        /* Fast-path if already in coroutine context */
        bdrv_truncate_co_entry(&tco);
    } else {
        co =3D qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
        bdrv_coroutine_enter(child->bs, co);
        BDRV_POLL_WHILE(child->bs, tco.ret =3D=3D NOT_DONE);
    }

where bdrv_truncate_co_entry() is a coroutine_fn.


