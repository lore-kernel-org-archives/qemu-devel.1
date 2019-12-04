Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D807C2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557C324651
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbDdADov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557C324651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icPAm-0001l7-CY
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 02:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icP5S-0000G1-Hp
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icP5F-0008AX-0X
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:28:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icP5D-000849-Cr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575444499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfoLyVykGep8qTS980pf9CUG9Fxqu6E7QR6HGHckRsQ=;
 b=JbDdADovUs/1ys0TgcyygwItn5dDORH/L9Gb196TckgbqLVhiwUexfI6+vYI3ecx/y/iiP
 j7JArdI47ZzGxCJiMIuWTKwivbrfrS4a10+xYVZRia2J9L6tyL4dtDaRH+i9x0DtLet240
 YBHvs8qm0j012XNXS/rX0RTEbZExT1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-D9iAnCJCOE2dcp2esQRC2Q-1; Wed, 04 Dec 2019 02:28:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D8B10054E3;
 Wed,  4 Dec 2019 07:28:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EEF95D6AE;
 Wed,  4 Dec 2019 07:28:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93FCF1138606; Wed,  4 Dec 2019 08:28:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 20/21] hw/intc/s390: Simplify error handling in
 kvm_s390_flic_realize()
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-21-armbru@redhat.com>
 <20191202174007.0f7ad8bc.cohuck@redhat.com>
 <20191203210340.66cbb5ed.pasic@linux.ibm.com>
Date: Wed, 04 Dec 2019 08:28:13 +0100
In-Reply-To: <20191203210340.66cbb5ed.pasic@linux.ibm.com> (Halil Pasic's
 message of "Tue, 3 Dec 2019 21:03:40 +0100")
Message-ID: <87tv6gft2q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: D9iAnCJCOE2dcp2esQRC2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Halil Pasic <pasic@linux.ibm.com> writes:

> On Mon, 2 Dec 2019 17:40:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Sat, 30 Nov 2019 20:42:39 +0100
>> Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> > Cc: Halil Pasic <pasic@linux.ibm.com>
>> > Cc: Cornelia Huck <cohuck@redhat.com>
>> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  hw/intc/s390_flic_kvm.c | 10 ++++------
>> >  1 file changed, 4 insertions(+), 6 deletions(-)
>>=20
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>=20
>> ...someone else wants to take a look before I queue this?
>>=20
>
> I guess it is a matter of taste.
>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!

> The only difference I can see is if the **errp argument where
> to already contain an error (*errp). I guess the old code would
> just keep the first error, and discard the next one, while error_setv()
> does an assert(*errp =3D=3D NULL).

Correct.

> I assume calling with *errp !=3D NULL is not a valid scenario.

Correct again.  On function entry, @errp must either be null,
@error_fatal, @error_abort, or point to null.

>                                                              But then, I
> can't say I understand the use-case behind this discard the newer error
> behavior of error_propagate().

The documented[1] use case is "receive and accumulate multiple errors
(first one wins)".  See the big comment in include/qapi/error.h.

For what it's worth, GError explicitly disallows such accumulation: "The
error variable dest points to must be NULL"[2].  If you do it anyway, it
logs a warning nobody reads[3], then throws away the newer error.


[1] It's "ex post facto" documentation, like much of the Error API
documentation.

[2] https://developer.gnome.org/glib/stable/glib-Error-Reporting.html#g-pro=
pagate-error

[3] First order approximation based on the amount of crap supposedly
stable applications log.


