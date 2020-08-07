Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE59C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDBE20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsBtThIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDBE20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zDG-0004BH-8C
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zCX-0003Gd-Sb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:02:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zCW-0006RF-5u
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzZWtB7beTMcsBKVlbPSMzEkynQZmnlmRTU9BQzylY=;
 b=VsBtThIycehDCUT4l9JK5zjZfdZPjojHw4pP9Hiv4VueTjdsT3qcnNe7hqiSuMyH/Y9d1L
 l82Lj0rPVLgWYH8KsZdV3OQ3CrM6yxX6ANmCQh3tDMAW+MmYdMozqPkRkGeI+OmTr261p3
 QLvY9YtUN8xH1VpHo0yQiirrNujLZFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-CyKE0pEmOcCrIqwBk087-w-1; Fri, 07 Aug 2020 06:02:08 -0400
X-MC-Unique: CyKE0pEmOcCrIqwBk087-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868E710059C4;
 Fri,  7 Aug 2020 10:02:07 +0000 (UTC)
Received: from localhost (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D42D87A7D;
 Fri,  7 Aug 2020 10:02:06 +0000 (UTC)
Date: Fri, 7 Aug 2020 11:02:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/3] async: always set ctx->notified in aio_notify()
Message-ID: <20200807100205.GB600298@stefanha-x1.localdomain>
References: <20200806131802.569478-1-stefanha@redhat.com>
 <20200806131802.569478-3-stefanha@redhat.com>
 <1e47af10-47fb-0a2f-7aa2-8a426ec86361@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1e47af10-47fb-0a2f-7aa2-8a426ec86361@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 03:45:33PM +0200, Paolo Bonzini wrote:
> On 06/08/20 15:18, Stefan Hajnoczi wrote:
> > +    atomic_set(&ctx->notified, false);
> > +
> > +    /*
> > +     * Write ctx->notified before reading e.g. bh->flags.  Pairs with =
smp_mb in
> > +     * aio_notify.
> > +     */
> > +    smp_wmb();
>=20
> Sorry I was not clear: the memory barrier has to be smp_mb(), but the
> comment has to say smp_wmb().  No need to repost for this.

Ah, right! I'll fix it up when merging. Thanks!

Stefan

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8tJp0ACgkQnKSrs4Gr
c8gKIwf6A7bdQ25QQkY8lGpHucPWHP8aJBCkE8QMb6cs/F30xwEuchusI3UQlIyp
IUUzFIYYfhk46XFXWup+ZGxP9sPxGYZVigPuy1Z/JH/Y8tBzkPeIbK+a7r0X5P6J
3rzsv/PGQl9wIXvvUwrnJH3DA/B+LBdHfh5WytobPpHCQNgPDKjYKXxlkUnjLS8O
fpIu1tLxCbrHbmu8hOJ7uqQPICeZQahuFnGoitkV7IqhrsPRiIJGQqe+fyd49an3
DudB23E1w6UUs46vciLCpa+Bxsp8jlQLrn1wXyBR7a2WRHjSK4m86k+s3rCCRm1i
E2weVzKskKz9VlpRUE12YxupepTXvQ==
=FiKG
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--


