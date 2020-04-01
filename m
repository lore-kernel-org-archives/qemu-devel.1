Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C9DC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE9920675
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSxHtxTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE9920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJckF-0000lk-6v
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJcjW-00008l-0d
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJcjU-00085B-Kf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:44:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJcjU-0007zp-Fk
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585745075;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uywxQoBqHHe3087FmumeXx2GemrlDvKTgT2rZ+zWEc0=;
 b=QSxHtxTYNLyCXP/AHzwNpLmg0DcXC5rqFqodEQccVg/viChG+fEyATDoL5nGEwMQGmJAEP
 9rqNLj2v93S4gYfQ5X7H0X5zaa2Ljbgkq/nhVOMevcSapNk9T5mHVIunIBFNLgBzV7Ddjg
 2DMdcEzxMo/2IQvuQu1Dm5fAJCO6zAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-WQIsV3ubMf6dczy1GhadzA-1; Wed, 01 Apr 2020 08:44:28 -0400
X-MC-Unique: WQIsV3ubMf6dczy1GhadzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546D1107ACC7;
 Wed,  1 Apr 2020 12:44:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9068F19C70;
 Wed,  1 Apr 2020 12:44:25 +0000 (UTC)
Date: Wed, 1 Apr 2020 13:44:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
Message-ID: <20200401124422.GC393810@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8sblgto.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 01, 2020 at 11:02:11AM +0200, Markus Armbruster wrote:
> QEMU's Error was patterned after GLib's GError.  Differences include:
>=20
> * &error_fatal, &error_abort for convenience

I think this doesn't really need to exist, and is an artifact
of the later point "return values" where we commonly make methds
return void.  If we adopted a non-void return value, then these
are no longer so compelling.

Consider if we didn't have &error_fatal right now, then we would
need to

   Error *local_err =3D NULL;
   qemu_boot_set(boot_once, &local_err)
   if (*local_err)
      abort();

This is tedious, so we invented &error_abort to make our lives
better

   qemu_boot_set(boot_once, &error_abort)


If we had a "bool" return value though, we would probably have just
ended up doing:

   assert(qemu_boot_set(boot_once, NULL));

or

   if (!qemu_boot_set(boot_once, NULL))
       abort()

and would never have invented &error_fatal.

> * Distinguishing different errors
>=20
>   Where Error has ErrorClass, GError has Gquark domain, gint code.  Use
>   of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is strongly
>   discouraged.  When we need callers to distinguish errors, we return
>   suitable error codes separately.

The GQuark is just a static string, and in most cases this ends up being
defined per-file, or sometimes per functional group. So essentially you
can consider it to approximately a source file in most cases. The code
is a constant of some arbitrary type that is generally considered to be
scoped within the context of the GQuark domain.

> * Return value conventions
>=20
>   Common: non-void functions return a distinct error value on failure
>   when such a value can be defined.  Patterns:
>=20
>   - Functions returning non-null pointers on success return null pointer
>     on failure.
>=20
>   - Functions returning non-negative integers on success return a
>     negative error code on failure.
>=20
>   Different: GLib discourages void functions, because these lead to
>   awkward error checking code.  We have tons of them, and tons of
>   awkward error checking code:
>=20
>     Error *err =3D NULL;
>     frobnicate(arg, &err);
>     if (err) {
>         ... recover ...
>         error_propagate(errp, err);
>     }

Yeah, I really dislike this verbose style...

>=20
>   instead of
>=20
>     if (!frobnicate(arg, errp))
>         ... recover ...
>     }

...so I've followed this style for any code I've written in QEMU
where possible.

>=20
>   Can also lead to pointless creation of Error objects.
>=20
>   I consider this a design mistake.  Can we still fix it?  We have more
>   than 2000 void functions taking an Error ** parameter...

Even if we don't do full conversion, we can at least encourage the
simpler style - previously reviewers have told me to rewrite code
to use the more verbose style, which I resisted. So at the very
least setting the expectations for preferred style is useful.

>   Transforming code that receives and checks for errors with Coccinelle
>   shouldn't be hard.  Transforming code that returns errors seems more
>   difficult.  We need to transform explicit and implicit return to
>   either return true or return false, depending on what we did to the
>   @errp parameter on the way to the return.  Hmm.

Even if we only converted methods which are currently void, that
would be a notable benefit I think.

It is a shame we didn't just use GError from the start, but I guess
its probably too late to consider changing that now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


