Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B6BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EF32177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff0VMfzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EF32177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2u7h-00030u-Lq
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2u6w-0002S1-PV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:23:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2u6u-0000Jn-TV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596536635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xkA82i6F+nGmf8DbYpVTl+eeXZZVvEB5HlbFXMbpKpE=;
 b=ff0VMfzkyNOIsgIu5s4eGRgFeKjGf/KMobDwKblrhf0OWGo4h8edc4fTWSvFSYVsI6L14+
 V/j4euD04TaIBLL8TFwxtn3JCguhz0tGUb2eT7tYK20pP8SuI2AQb8HmONJxw1IhX6klbY
 Ow+v3Q3uwx+xYeefCKoxKL31RjtouPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-70UX6EeMNBGjsCv5iL0FIQ-1; Tue, 04 Aug 2020 06:23:52 -0400
X-MC-Unique: 70UX6EeMNBGjsCv5iL0FIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD4E19253C0;
 Tue,  4 Aug 2020 10:23:51 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53F6E10013D0;
 Tue,  4 Aug 2020 10:23:51 +0000 (UTC)
Date: Tue, 4 Aug 2020 11:23:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] async: always set ctx->notified in aio_notify()
Message-ID: <20200804102350.GA1284284@stefanha-x1.localdomain>
References: <20200804052804.1165291-1-stefanha@redhat.com>
 <20200804052804.1165291-3-stefanha@redhat.com>
 <eb304bcb-6b5b-8544-0e94-e84055d4fab8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eb304bcb-6b5b-8544-0e94-e84055d4fab8@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 09:12:46AM +0200, Paolo Bonzini wrote:
> On 04/08/20 07:28, Stefan Hajnoczi wrote:
> > @@ -425,19 +425,14 @@ void aio_notify(AioContext *ctx)
> >      smp_mb();
> >      if (atomic_read(&ctx->notify_me)) {
> >          event_notifier_set(&ctx->notifier);
> > -        atomic_mb_set(&ctx->notified, true);
> >      }
> > +
> > +    atomic_mb_set(&ctx->notified, true);
> >  }
>=20
> This can be an atomic_set since it's already ordered by the smp_mb()
> (actually a smp_wmb() would be enough for ctx->notified, though not for
> ctx->notify_me).
>=20
> >  void aio_notify_accept(AioContext *ctx)
> >  {
> > -    if (atomic_xchg(&ctx->notified, false)
> > -#ifdef WIN32
> > -        || true
> > -#endif
> > -    ) {
> > -        event_notifier_test_and_clear(&ctx->notifier);
> > -    }
> > +    atomic_mb_set(&ctx->notified, false);
> >  }
>=20
> I am not sure what this should be.
>=20
> - If ctx->notified is cleared earlier it's not a problem, there is just
> a possibility for the other side to set it to true again and cause a
> spurious wakeup
>=20
> - if it is cleared later, during the dispatch, there is a possibility
> that it we miss a set:
>=20
> =09CPU1=09=09=09=09CPU2
> =09------------------------------- ------------------------------
> =09read bottom half flags
> =09=09=09=09=09set BH_SCHEDULED
> =09=09=09=09=09set ctx->notified
> =09clear ctx->notified (reordered)
>=20
> and the next polling loop misses ctx->notified.
>=20
> So the requirement is to write ctx->notified before the dispatching
> phase start.  It would be a "store acquire" but it doesn't exist; I
> would replace it with atomic_set() + smp_mb(), plus a comment saying
> that it pairs with the smp_mb() (which actually could be a smp_wmb()) in
> aio_notify().
>=20
> In theory the barrier in aio_bh_dequeue is enough, but I don't
> understand memory_order_seqcst atomics well enough to be sure, so I
> prefer an explicit fence.
>=20
> Feel free to include part of this description in aio_notify_accept().

Cool, thanks! Will fix in v2.

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pNzUACgkQnKSrs4Gr
c8jC9wgAgBRsbqxrZIVHIwtsjPprfm2mNdfz5Rbn1a1tAAvkXZegXtVaOLfkSohg
6oIuWRh2XaKA74rQW8nhlydX+HTk1jHISP+DPt1EKWGqT85TvhxmDiCMrcoyBzdm
OhjcbSOv1E30rD/UymVrfyvfA38fuQGrs+P9pAXpaUumQvXeK4g2/QzU6p4hHQ8d
KrKQ3fvNKRuPQDvT64+y10sBuo+kHgFAspX6ciiWEcS4VQZtRhUelvUqyhtE9jN/
zro8IW+HWUsZzl3Iw26YNtKqWSVoEmiNYRiuakhc+Sb+oBE55I+R8Rxd8qK1NTAR
aXDiPZBYpxZllLfJ0qEWvEANJaztRw==
=21+x
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


