Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8029C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903B92464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3fCXZ7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903B92464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icovc-0006iZ-Ny
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 06:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icouc-0005gy-Vv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icoub-0001y6-GT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:03:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icoub-0001vY-3x
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575543788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/NC2doAAGqygxYVUUJL9TSozoz3UmknkWaD9vZEw8Q=;
 b=R3fCXZ7lXq5T3a0WvBz1dMoA73HDyEsR4JXSaWU+v8yFdRRY8obZEUBzp0jthCylleint9
 mAUMyLNosJwwjKiLTaaxF84OJWpmK9c5Nakngw8YaKsSCWlu1IjfNPJsa/YpBTZWTtzet0
 xK1eTHCjjvWbRoHMZpo/3i5Eme5sey4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-Xw_unCXyPgG45FA2aEOCww-1; Thu, 05 Dec 2019 06:03:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE8F800EB9;
 Thu,  5 Dec 2019 11:03:06 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF78F5C1C3;
 Thu,  5 Dec 2019 11:02:57 +0000 (UTC)
Date: Thu, 5 Dec 2019 12:02:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] s390x/tcg: clear local interrupts on reset normal
Message-ID: <20191205120255.76b9443a.cohuck@redhat.com>
In-Reply-To: <9e887988-652d-d325-3524-df5f3de5ce08@redhat.com>
References: <20191205103844.10404-1-cohuck@redhat.com>
 <9e887988-652d-d325-3524-df5f3de5ce08@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Xw_unCXyPgG45FA2aEOCww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 11:56:33 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Cornelia,
>=20
> On 12/5/19 11:38 AM, Cornelia Huck wrote:
> > We neglected to clean up pending interrupts and emergency signals;
> > fix that.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
> > Noted while looking at the fixes for the kvm reset handling. =20
>=20
> IIUC we always neglected to clean these fields, but Janosh recent work=20
> [*] helped you to realize that?

Yes, that was what I was trying to express :)

>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg661541.html
>=20
> > We now clear some fields twice in the paths for clear or initial reset;
> > but (a) we already do that for other fields and (b) it does not really
> > hurt. Maybe we should give the cpu structure some love in the future,
> > as it's not always clear whether some fields are tcg only.
> >=20
> > ---
> >   target/s390x/cpu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> > index 829ce6ad5491..f2572961dc3a 100644
> > --- a/target/s390x/cpu.c
> > +++ b/target/s390x/cpu.c
> > @@ -133,6 +133,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_t=
ype type)
> >       case S390_CPU_RESET_NORMAL:
> >           env->pfault_token =3D -1UL;
> >           env->bpbc =3D false;
> > +        env->pending_int =3D 0;
> > +        env->external_call_addr =3D 0;
> > +        bitmap_zero(env->emergency_signals, S390_MAX_CPUS);
> >           break;
> >       default:
> >           g_assert_not_reached();
> >  =20
>=20


