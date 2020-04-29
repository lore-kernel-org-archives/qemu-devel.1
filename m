Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B4AC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4CF206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgUidnJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4CF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTonG-00053p-AQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:38:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jTolt-0002hr-Sc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jToi0-0003Bt-97
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:36:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jTohz-00038W-Sb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588174388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5bxZ/W7rL1Fd2qslcQp1LARUxM9Lx/djYUTjHUOd2c=;
 b=WgUidnJ5vo0J5G3epYif1rkHkJJ5J9uizyyns4JwvAr+nSr1fwEar5c/TzKqmtNxsIdFEw
 yRjGE6VU6hAOubnLxo4zG4r9q0I3JpVcG/CDOnQPA2I0bY8SiS3re+vwqqAMr/SGsSMVhb
 iqaMNl5n5GYwZORFoILpB0BFRIv9smg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-B7DUCMcPP8-ODSRY2NGIkQ-1; Wed, 29 Apr 2020 11:33:05 -0400
X-MC-Unique: B7DUCMcPP8-ODSRY2NGIkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1737984B8A6;
 Wed, 29 Apr 2020 15:33:04 +0000 (UTC)
Received: from localhost (unknown [10.40.208.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FBB266065;
 Wed, 29 Apr 2020 15:32:56 +0000 (UTC)
Date: Wed, 29 Apr 2020 17:32:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200429173254.58c8582f@redhat.com>
In-Reply-To: <20200424184448.GS4952@habkost.net>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
 <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
 <20200424184448.GS4952@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFu?= =?UTF-8?B?Z8Op?=" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Apr 2020 14:44:48 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Apr 24, 2020 at 03:23:56PM +0000, Ani Sinha wrote:
> >=20
> >  =20
> > > On Apr 22, 2020, at 4:15 PM, Ani Sinha <ani.sinha@nutanix.com> wrote:
> > >=20
> > >=20
> > >  =20
> > >> On Apr 21, 2020, at 8:32 PM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > >>=20
> > >> On Tue, Apr 21, 2020 at 02:45:04PM +0000, Ani Sinha wrote: =20
> > >>>=20
> > >>>  =20
> > >>>> On Apr 20, 2020, at 8:32 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > >>>>=20
> > >>>> But I for one would like to focus on keeping PIIX stable
> > >>>> and focus development on q35.  Not bloating PIIX with lots of new
> > >>>> features is IMHO a good way to do that. =20
> > >>>=20
> > >>> Does this mean this patch is a no-go then? :( =20
> > >>=20
> > >> I'd support this patch, as I don't think it can really be described =
as
> > >> bloat or destabalizing. It is just adding a simple property to
> > >> conditionalize existing functionality.  Telling people to switch to =
Q35
> > >> is unreasonable as it is not a simple 1-1 conversion from existing u=
se
> > >> of PIIX. Q35 has much higher complexity in its configuration, has hi=
gher
> > >> memory overhead per VM too, and lacks certain features of PIIX too. =
=20
> > >=20
> > > Cool. How do we go forward from here?
> > >  =20
> >=20
> > We would really appreciate if we can add this extra knob in
> > Qemu. Maybe someone else also in the community will find this
> > useful. We don=E2=80=99t want to maintain this patch internally forever
> > but rather prefer we maintain this as a Qemu community. =20
>=20
> Michael, I agree with Daniel here and I don't think we should
> start refusing PIIX features if they are useful for a portion of
> the QEMU community.
>=20
> Would you reconsider and merge this patch?

I put this patch on my review queue (hopefully next week I'd be able to get=
 to it)


