Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B37C20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1fC6ajG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qyT-0006eB-B5
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j9qxi-0005ch-60
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j9qxg-000552-UV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:54:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j9qxg-00053o-QK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583416484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9CYmkfMOJ7w+8fvl8C4hZ0TOPwfYMgwdzDQ4gmX/Us=;
 b=F1fC6ajGhDtWyvK6WU9VzTjliuCdkG6+fYkyq+KlpTV0qx7vUuHGEjASPR+EbSQPuL2sPf
 GiwDbIBGsxn03o+JSeTfQE8B5rurBx9v1NPgkafr8K5BxePGP1nvvkEnVueYNXtrRyxVZ4
 bW0WvfYYpv68fPvfxUdMb06ystVU818=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-PksgwXNaNSSKhUAVfd0NNQ-1; Thu, 05 Mar 2020 08:54:43 -0500
X-MC-Unique: PksgwXNaNSSKhUAVfd0NNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E48818B5F6C;
 Thu,  5 Mar 2020 13:54:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A9EE19C58;
 Thu,  5 Mar 2020 13:54:36 +0000 (UTC)
Date: Thu, 5 Mar 2020 13:54:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save
 32KiB of .bss
Message-ID: <20200305135434.GC2112347@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-3-philmd@redhat.com>
 <20200305134403.sagzdlf5iyk2iufs@steredhat>
 <b534a8ed-82dd-040f-a48e-9ba8c8c31db0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b534a8ed-82dd-040f-a48e-9ba8c8c31db0@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:49:37PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 3/5/20 2:44 PM, Stefano Garzarella wrote:
> > On Thu, Mar 05, 2020 at 01:45:18PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > This buffer is only used by the adlib audio device. Move it to
> > > the .heap to release 32KiB of .bss (size reported on x86_64 host).
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >   hw/audio/fmopl.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> > > index 173a7521f2..356d4dfbca 100644
> > > --- a/hw/audio/fmopl.c
> > > +++ b/hw/audio/fmopl.c
> > > @@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
> > >   /* envelope output curve table */
> > >   /* attack + decay + OFF */
> > > -static int32_t ENV_CURVE[2*EG_ENT+1];
> > > +static int32_t *ENV_CURVE;
> > >   /* multiple table */
> > >   #define ML 2
> > > @@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
> > >   =09OPL->clock =3D clock;
> > >   =09OPL->rate  =3D rate;
> > >   =09OPL->max_ch =3D max_ch;
> > > +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
> > >   =09/* init grobal tables */
> > >   =09OPL_initialize(OPL);
> > >   =09/* reset chip */
> > > @@ -1127,6 +1128,7 @@ void OPLDestroy(FM_OPL *OPL)
> > >   #endif
> > >   =09OPL_UnLockTable();
> > >   =09free(OPL);
> > > +    g_free(ENV_CURVE);
> >=20
> > Just for curiosity, here the entire fmopl.c is indented with tabs.
> >=20
> > In this case, is it better to continue with the tabs or use spaces
> > for new changes?
>=20
> checkpatch.pl doesn't allow us to use spaces.

ITYM  'tabs' here.

IMHO this is a case where the cure is worse than the disease.
In priority order I think we generally rank:

 * Exclusive use of space indent (best)
 * Exclusive use of tab indent (bad)
 * Mixture of space & tab indent (terrible)

IOW, this is a case where I would suggest either:

 - Have a cleanup commit first that eliminates all tabs

or

 - Continue to use tabs consistently & ignore checkpatch

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


