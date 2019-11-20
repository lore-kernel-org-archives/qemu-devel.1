Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02981C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD9F208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdKhhq3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTWt-0002ld-0E
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iXTVQ-0008ST-Ix
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iXTVP-0008MC-FX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:11:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iXTVP-0008Ky-Az
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574269862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcTDOFZYcOYmWDjNBdEiytMPebhgFKmVUQ83YVeEUHM=;
 b=fdKhhq3ZVbmcSiMX+T8z6f5y2kZ5N3N5w05bwIq4cLJ14cP9ROiuiBJW1rGiHi9slTMJ8s
 h9tx2+enU04T6UMSQtElTgXCPPJihmji5t+46KjfEykgk/x8dB/kwjnV6dfums6jReTj+C
 6/Ken7WzRJHZwvACYOJ8zKfNFI4YraA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-UlpqSWOdMF239jDlnp13hA-1; Wed, 20 Nov 2019 12:10:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740F4184CAA0;
 Wed, 20 Nov 2019 17:10:58 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55B3A1042B7D;
 Wed, 20 Nov 2019 17:10:52 +0000 (UTC)
Date: Wed, 20 Nov 2019 14:10:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 28/37] qdev: use g_strcmp0() instead of open-coding it
Message-ID: <20191120171050.GR3812@habkost.net>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-29-marcandre.lureau@redhat.com>
 <c6506012-cbae-bbf0-a373-398635f98692@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c6506012-cbae-bbf0-a373-398635f98692@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UlpqSWOdMF239jDlnp13hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 05:25:47PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/20/19 4:24 PM, Marc-Andr=E9 Lureau wrote:
> > Minor code simplification.
> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/core/qdev.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index cf1ba28fe3..c79befc865 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -394,11 +394,8 @@ static NamedGPIOList *qdev_get_named_gpio_list(Dev=
iceState *dev,
> >       NamedGPIOList *ngl;
> >       QLIST_FOREACH(ngl, &dev->gpios, node) {
> > -        /* NULL is a valid and matchable name, otherwise do a normal
> > -         * strcmp match.
> > -         */
> > -        if ((!ngl->name && !name) ||
> > -                (name && ngl->name && strcmp(name, ngl->name) =3D=3D 0=
)) {
> > +        /* NULL is a valid and matchable name. */
> > +        if (g_strcmp0(name, ngl->name) =3D=3D 0) {
>=20
> Cocci pattern?

This seems tricky because there are many different ways of
writing an equivalent expression.  I tried to catch a few
variations, but the script below didn't find any other
occurrences except for the one being touched by this patch.

@@
expression A, B;
@@
(
-(!A && !B) || (A && B && !strcmp(A, B))
+!g_strcmp0(A, B)
|
-(!B && !A) || (A && B && !strcmp(A, B))
+!g_strcmp0(A, B)
|
-(!A && !B) || (B && A && !strcmp(A, B))
+!g_strcmp0(A, B)
|
-(!B && !A) || (B && A && !strcmp(A, B))
+!g_strcmp0(A, B)
|
-(!A && !B) || (B && A && strcmp(A, B) =3D=3D 0)
+!g_strcmp0(A, B)
|
-(!B && !A) || (B && A && strcmp(A, B) =3D=3D 0)
+!g_strcmp0(A, B)
|
-(!A && !B) || (A && B && strcmp(A, B) =3D=3D 0)
+!g_strcmp0(A, B)
|
-(!B && !A) || (A && B && strcmp(A, B) =3D=3D 0)
+!g_strcmp0(A, B)
)

--=20
Eduardo


