Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57410C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216662072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGzT7G/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216662072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMle-00019U-3l
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 03:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isMks-00006M-2a
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isMko-000121-At
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:13:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isMko-00011Z-2M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579248797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVxu6BgWo0QLlFyhfJPzlc8SGd/BVRDdFTZnRV6i16M=;
 b=iGzT7G/fZ5S/0VDbdNbDU4BTQwE9pwY4ok66hGy/YPwbirMqooxrTXkOyW790zCYTGABcX
 T9HzR2/4Q45atHM8h7S7dchKTRzP2KULOv/GXWc16FPgz77zRE0XYArqEYb9YJ2sy6LX6k
 Q0i6cn9N3ZaGFHU422BEh+IOhJv26iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-OoAV_6d7MwmwFigcAdoyUw-1; Fri, 17 Jan 2020 03:13:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662CE1800D48;
 Fri, 17 Jan 2020 08:13:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96FD5675AF;
 Fri, 17 Jan 2020 08:13:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A2661138600; Fri, 17 Jan 2020 09:13:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 4/4] block: Mark 'block_resize' as coroutine
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-5-kwolf@redhat.com>
 <87tv4vzqd7.fsf@dusky.pond.sub.org>
 <20200116101333.GA9470@linux.fritz.box>
Date: Fri, 17 Jan 2020 09:13:10 +0100
In-Reply-To: <20200116101333.GA9470@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 16 Jan 2020 11:13:33 +0100")
Message-ID: <875zhao609.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OoAV_6d7MwmwFigcAdoyUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 16.01.2020 um 10:45 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > block_resize is safe to run in a coroutine, so use it as an example fo=
r
>> > the new 'coroutine': true annotation in the QAPI schema.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>> > diff --git a/blockdev.c b/blockdev.c
>> > index 8e029e9c01..b5e5d1e072 100644
>> > --- a/blockdev.c
>> > +++ b/blockdev.c
>> > @@ -3161,9 +3161,9 @@ void hmp_drive_del(Monitor *mon, const QDict *qd=
ict)
>> >      aio_context_release(aio_context);
>> >  }
>> > =20
>> > -void qmp_block_resize(bool has_device, const char *device,
>> > -                      bool has_node_name, const char *node_name,
>> > -                      int64_t size, Error **errp)
>> > +void coroutine_fn qmp_block_resize(bool has_device, const char *devic=
e,
>> > +                                   bool has_node_name, const char *no=
de_name,
>> > +                                   int64_t size, Error **errp)
>> >  {
>> >      Error *local_err =3D NULL;
>> >      BlockBackend *blk =3D NULL;
>>=20
>> Pardon my ignorant question: what exactly makes a function a
>> coroutine_fn?
>
> When Stefan requested adding the coroutine_fn marker, it seemed to make
> sense to me because the QMP dispatcher will always call it from
> coroutine context now, and being always run in coroutine context makes a
> function a coroutine_fn.
>
> However, it's also called from hmp_block_resize(), so at least for now
> coroutine_fn is actually wrong.

With the coroutine_fn dropped:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Any plans to make more QMP commands 'coroutine': true?


