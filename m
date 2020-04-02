Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D689E208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvgGl/T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D689E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvY8-0004Gm-03
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJvVa-0001SL-U2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJvVZ-0005jG-Gw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJvVZ-0005iP-C8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817248;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTekKKCPc758a1jnx1olfZfMBfwq/Fz4ZvFrm+PuqcA=;
 b=JvgGl/T3rgCl2mt9BlW6nFLrxlNE6GZ3fOaxpzIooV00vOBhlKyEIdmcXjUv9Q65XGwJTc
 KFwi7asZ50wFgrjZzCYgq/U4lQbhTEEObzxtmTlii2BHj88ujVpYHP80y3TdtTgTl6SrqB
 Yn5e/eLKk3nUWnTfmouHYK5PNoSKHGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-BZ6BUx9ZPXKx1jb894-m3g-1; Thu, 02 Apr 2020 04:47:25 -0400
X-MC-Unique: BZ6BUx9ZPXKx1jb894-m3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034AE108442D;
 Thu,  2 Apr 2020 08:47:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B2285C1B0;
 Thu,  2 Apr 2020 08:47:22 +0000 (UTC)
Date: Thu, 2 Apr 2020 09:47:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
Message-ID: <20200402084719.GB423991@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sghmbfgc.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 07:54:11AM +0200, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrot=
e:
> >>
> >> QEMU's Error was patterned after GLib's GError.  Differences include:
> >
> > From my POV the major problem with Error as we have it today
> > is that it makes the simple process of writing code like
> > device realize functions horrifically boilerplate heavy;
> > for instance this is from hw/arm/armsse.c:
> >
> >         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
> >                                  "memory", &err);
> >         if (err) {
> >             error_propagate(errp, err);
> >             return;
> >         }
> >         object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
> >         if (err) {
> >             error_propagate(errp, err);
> >             return;
> >         }
> >         object_property_set_bool(cpuobj, true, "realized", &err);
> >         if (err) {
> >             error_propagate(errp, err);
> >             return;
> >         }
> >
> > 16 lines of code just to set 2 properties on an object
> > and realize it. It's a lot of boilerplate and as
> > a result we frequently get it wrong or take shortcuts
> > (eg forgetting the error-handling entirely, calling
> > error_propagate just once for a whole sequence of
> > calls, taking the lazy approach and using err_abort
> > or err_fatal when we ought really to be propagating
> > an error, etc). I haven't looked at 'auto propagation'
> > yet, hopefully it will help?
>=20
> With that, you can have
>=20
>         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                  "memory", errp);
>         if (*errp) {
>             return;
>         }
>         object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
>         if (*errp) {
>             return;
>         }
>         object_property_set_bool(cpuobj, true, "realized", errp);
>         if (*errp) {
>             return;
>         }
>=20
> but you have to add
>=20
>         ERRP_AUTO_PROPAGATE();
>=20
> right at the beginning of the function.
>=20
> It's a small improvement.  A bigger one is
>=20
>         if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i])=
,
>                                      "memory", errp)) {
>             return;
>         }
>         if (object_property_set_link(cpuobj, OBJECT(s), "idau", errp)) {
>             return;
>         }
>         if (object_property_set_bool(cpuobj, true, "realized", errp)) {
>             return;
>         }
>=20
> This is item "Return value conventions" in the message you replied to.

Even better, we can then string the checks together

        if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                      "memory", errp) ||
            object_property_set_link(cpuobj, OBJECT(s), "idau", errp) ||
            object_property_set_bool(cpuobj, true, "realized", errp)) {
             return;
        }
=20
Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


