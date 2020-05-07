Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2786DC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49E1207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 07:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpN2YqG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49E1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWamL-0004xx-Us
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 03:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWal7-0004No-5g
 for qemu-devel@nongnu.org; Thu, 07 May 2020 03:15:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWal4-0003HB-6w
 for qemu-devel@nongnu.org; Thu, 07 May 2020 03:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588835749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cf3b96NuvIThpS9f59kMDGSKOHiZbMPX7vmad87hH/4=;
 b=gpN2YqG9B3T2C9S1TbF/nif1XWEaRteoF2GqhlHCFiyUM9ct6NVRwPBo6WVv6ph481h8q1
 iD7Z0Yh/jpHUV5cEOfPQK6W1rN4kp4Q7yGXsD4Z3Fuqsk2llhi1RZ+GLA0cH4NYlR1Kdpq
 89/SVVhDV5OgY49KIVzo2c81J7FUlnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-gq0YGXbGPFGyjxjNMN0bZw-1; Thu, 07 May 2020 03:15:47 -0400
X-MC-Unique: gq0YGXbGPFGyjxjNMN0bZw-1
Received: by mail-wr1-f72.google.com with SMTP id z5so2829149wrt.17
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 00:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2vVigyUvQxsc7XSeajwsi+zbMnh697hw31fC4iTyfHo=;
 b=psS26WYZlApfclGqPKTLE2YoTZAvZTeQsRKW/udzrUhT8kUOu77LcbEyDt5D8DrY+3
 eBdvCs4Arxbu0U1CCe1f/nmYWR4MePAcmPYzmqo86J3uZ+PvX9+Gh7IFFtM18SIlXAoV
 ndB5ebX2rg9REQQOIvC63sT2n6ZlyqM7Tu1vxoSUB9NMpA1zRlUtIyx/UbpKSefK2tau
 uY/LiYihObY56d29cmQ2CRILdaCbiL8JNqIy3fgipfBTeKreoCACEX0hH48zmd/prgox
 BW1OSYKjxHjRFyUDn8JTMCBsWxKaoy9Kf8acnU9SWBVu9zO8+98tpIzA39TOIWUM+1yf
 +t3Q==
X-Gm-Message-State: AGi0PuZyClkv0STANmMyC1Ft639SGxo2gUFnd6h9Ee1nHRXVYqCdcO8n
 OVNr2Jx2e55VG+zb75iQVCtFWe6kMdQqcV70lQ+DbP7VssHSYcW0II3OUfrQCzSQwaAeUf57+TG
 ZUbHiwj/bBy6+5AU=
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr14062097wrl.308.1588835746237; 
 Thu, 07 May 2020 00:15:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxmVtHaOQGB7HjrSvi93vTnr3SqDf84RhB3xdBnm+SDBFkcDvBxhs3mSnob7xBEqsijhUNRg==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr14062054wrl.308.1588835745807; 
 Thu, 07 May 2020 00:15:45 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n6sm6772975wrs.81.2020.05.07.00.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 00:15:45 -0700 (PDT)
Date: Thu, 7 May 2020 03:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200507031519-mutt-send-email-mst@kernel.org>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, raphael.norwitz@nutanix.com, arei.gonglei@huawei.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, mreitz@redhat.com,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 06:08:34PM -0400, Raphael Norwitz wrote:
> As you correctly point out, this code needs to be looked at more
> carefully so that
> if the device does disconnect in the background we can handle the migrati=
on path
> gracefully. In particular, we need to decide whether a migration
> should be allowed
> to continue if a device disconnects durning the migration stage.
>=20
> mst, any thoughts?

Why not? It can't change state while disconnected, so it just makes
things easier.

> Have you looked at the suggestion I gave Li Feng to move vhost_dev_cleanu=
p()
> into the connection path in vhost-user-blk? I=E2=80=99m not sure if he=E2=
=80=99s
> actively working on it,
> but I would prefer if we can find a way to keep some state around
> between reconnects
> so we aren=E2=80=99t constantly checking dev->started. A device can be st=
opped
> for reasons
> other than backend disconnect so I=E2=80=99d rather not reuse this field =
to
> check for backend
> disconnect failures.
>=20
> On Thu, Apr 30, 2020 at 9:57 AM Dima Stepanov <dimastep@yandex-team.ru> w=
rote:
> >
> > If vhost-user daemon is used as a backend for the vhost device, then we
> > should consider a possibility of disconnect at any moment. If such
> > disconnect happened in the vhost_migration_log() routine the vhost
> > device structure will be clean up.
> > At the start of the vhost_migration_log() function there is a check:
> >   if (!dev->started) {
> >       dev->log_enabled =3D enable;
> >       return 0;
> >   }
> > To be consistent with this check add the same check after calling the
> > vhost_dev_set_log() routine. This in general help not to break a
>=20
> Could you point to the specific asserts which are being triggered?
>=20
> > migration due the assert() message. But it looks like that this code
> > should be revised to handle these errors more carefully.
> >
> > In case of vhost-user device backend the fail paths should consider the
> > state of the device. In this case we should skip some function calls
> > during rollback on the error paths, so not to get the NULL dereference
> > errors.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 3ee50c4..d5ab96d 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev=
 *dev,
> >  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >  {
> >      int r, i, idx;
>=20
> A couple points here
>=20
>=20
> (1) This will fail the live migration if the device is disconnected.
> That my be the right thing
>       to do, but if there are cases where migrations can proceed with
> a disconnected device,
>       this may not be desirable.
>=20
> (2) This looks racy. As far as I can tell vhost_dev_set_log() is only
> called by vhost_migration_log(),
>       and as you say one of the first things vhost_migration_log does
> is return if dev->started is not
>       set. What=E2=80=99s to stop a disconnect from clearing the vdev rig=
ht
> after this check, just before
>       vhost_dev_set_features() is called?
>=20
> As stated above, I would prefer it if we could add some state which
> would persist between
> reconnects which could then be checked in the vhost-user code before
> interacting with
> the backend. I understand this will be a much more involved change and
> will require a lot
> of thought.
>=20
> Also, regarding (1) above, if the original check in
> vhost_migration_log() returns success if the
> device is not started why return an error here? I imagine this could
> lead to some inconsistent
> behavior if the device disconnects before the first check verses
> before the second.
>=20
> > +
> > +    if (!dev->started) {
> > +        /*
> > +         * If vhost-user daemon is used as a backend for the
> > +         * device and the connection is broken, then the vhost_dev
> > +         * structure will be reset all its values to 0.
> > +         * Add additional check for the device state.
> > +         */
> > +        return -1;
> > +    }
> > +
> >      r =3D vhost_dev_set_features(dev, enable_log);
> >      if (r < 0) {
> >          goto err_features;
> > @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *de=
v, bool enable_log)
> >      }


