Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417CDC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090D720727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFJlRpBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090D720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdNn-0007rQ-Vr
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iWdIZ-0004Ll-Tk
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iWdIY-0001UD-TS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:26:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iWdIY-0001Tz-PH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574069178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d1gS7yjLrXLb41dDA+DJOHruZEQcS8wq/a9kXPdLGk=;
 b=FFJlRpBRuq9r5q0kEGvjtsH9wN/jBVEm3sipTxQKu0zYLLfFyWEk0PsNjzN4Jceg3xFfTQ
 5i88oFZEdr36Z1q8QhxqHsMeElFL7UMRMZLNrAFAAqptVZXme+JU2OI2sTsa7bbNSiD6kh
 5QRSQuk+Kqquh16fRkjDiEt7+JjspxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Ao_66zJLOs2HXff8gfbR8A-1; Mon, 18 Nov 2019 04:26:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31F51005500;
 Mon, 18 Nov 2019 09:26:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
 [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A93D260856;
 Mon, 18 Nov 2019 09:26:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BDE51138648; Mon, 18 Nov 2019 10:26:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 for-5.0 0/8] ppc: Consolidate QOM links and pointers to
 the same object
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
Date: Mon, 18 Nov 2019 10:26:12 +0100
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan> (Greg
 Kurz's message of "Fri, 15 Nov 2019 16:55:21 +0100")
Message-ID: <87zhgtwn63.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Ao_66zJLOs2HXff8gfbR8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> There's a recurring pattern in the code where a const link is added to a
> newly instanciated object and the link is then used in the object's reali=
ze
> function to keep a pointer to the QOM entity which the link points to.
>
> void create_obj_b(Object *obj_a)
> {
>     Object *obj_b;
>
>     obj_b =3D object_new(TYPE_B);
>     object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_abor=
t);
>     object_property_set_bool(obj_b, true, "realized", &error_abort);
> }
>
> void object_b_realize(DeviceState *dev, Error **errp)
> {
>     Object *obj_a;
>
>     obj_a =3D object_property_get_link(OBJECT(dev), "link-to-a", errp);
>     if (!obj_a) {
>         return;
>     }
>
>     obj_b->obj_a =3D A(obj_a); // If obj_b->obj_a is changed, the link pr=
operty
>                              // still points to the original obj_a that w=
as
>                              // passed to object_property_add_const_link(=
)
> }
>
> Confusing bugs could arise if the pointer and the link go out of sync for
> some reason. This can be avoided if the property is defined to directly u=
se
> the pointer with the DEFINE_PROP_LINK() macro.
>
> This series just does that for all occurences of the fragile pattern in
> the XIVE and PNV code.

Have you looked for the pattern elsewhere?


