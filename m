Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC20C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAF722B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgSlSbTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAF722B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FH9-00012f-1h
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3FGY-0000XK-Pe
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:59:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3FGX-0001NK-2O
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpXI24a2koXYFcD0mcpaWC2ecEzv122Zucta3I9GMtw=;
 b=YgSlSbTJ+J/3woF0dA4KEz2rTfHfmvUQ9IsB1xHyLT+erx3RAYA9NUn0MFlMQe4Du96QKv
 EtqYEYmXicktCuUIcqxW3hiI91FnbrX2J2k0c8/3sN4K09z4AT2oQZ2ypaiP1XqDP7xVix
 m05cRE3s3ccAqDeO1/llJe58p+Qb7Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-_ACVH84eOwy9OgFDLMxYiw-1; Wed, 05 Aug 2020 04:59:13 -0400
X-MC-Unique: _ACVH84eOwy9OgFDLMxYiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E0E80183C;
 Wed,  5 Aug 2020 08:59:12 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3536160BF3;
 Wed,  5 Aug 2020 08:59:12 +0000 (UTC)
Date: Wed, 5 Aug 2020 09:59:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] aio-posix: keep aio_notify_me disabled during polling
Message-ID: <20200805085910.GA172138@stefanha-x1.localdomain>
References: <20200804052804.1165291-1-stefanha@redhat.com>
 <20200804052804.1165291-4-stefanha@redhat.com>
 <20200804102941.GB1284284@stefanha-x1.localdomain>
 <92e8cc23-a361-f1d4-a2a6-160268cd8b3a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <92e8cc23-a361-f1d4-a2a6-160268cd8b3a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
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

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 06:53:09PM +0200, Paolo Bonzini wrote:
> On 04/08/20 12:29, Stefan Hajnoczi wrote:
> > On Tue, Aug 04, 2020 at 06:28:04AM +0100, Stefan Hajnoczi wrote:
> >> @@ -597,15 +574,38 @@ bool aio_poll(AioContext *ctx, bool blocking)
> >>       * system call---a single round of run_poll_handlers_once suffice=
s.
> >>       */
> >>      if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
> >> +        /*
> >> +         * aio_notify can avoid the expensive event_notifier_set if
> >> +         * everything (file descriptors, bottom halves, timers) will
> >> +         * be re-evaluated before the next blocking poll().  This is
> >> +         * already true when aio_poll is called with blocking =3D=3D =
false;
> >> +         * if blocking =3D=3D true, it is only true after poll() retu=
rns,
> >> +         * so disable the optimization now.
> >> +         */
> >> +        if (timeout) {
> >> +            atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) =
+ 2);
> >> +            /*
> >> +             * Write ctx->notify_me before computing the timeout
> >> +             * (reading bottom half flags, etc.).  Pairs with
> >> +             * smp_mb in aio_notify().
> >> +             */
> >> +            smp_mb();
> >> +
> >> +            /* Check again in case a shorter timer was added */
> >> +            timeout =3D qemu_soonest_timeout(timeout, aio_compute_tim=
eout(ctx));
> >> +        }
> >> +
> >>          ret =3D ctx->fdmon_ops->wait(ctx, &ready_list, timeout);
> >> -    }
> >> =20
> >> -    if (blocking) {
> >> -        /* Finish the poll before clearing the flag.  */
> >> -        atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notif=
y_me) - 2);
> >> -        aio_notify_accept(ctx);
> >> +        if (timeout) {
> >> +            /* Finish the poll before clearing the flag.  */
> >> +            atomic_store_release(&ctx->notify_me,
> >> +                                 atomic_read(&ctx->notify_me) - 2);
> >> +        }
> >>      }
> >=20
> > Hi Paolo,
> > We can avoid calling aio_compute_timeout() like this, what do you think=
?
>=20
> I don't understand :) except I guess you mean we can avoid the second
> call.  Can you post either a complete patch with this squashed, or a 4th
> patch (whatever you think is best)?

Sure, I'll post a new revision of this series.

Stefan

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qdNoACgkQnKSrs4Gr
c8jxWwf+I5AXujG/h+3pZMvHNQ6PzRclXJLn09Dtt8MK89duFv3PI0/LkpUSZGHq
Utv9e3NSUWhUzkks/pDYQTWxi+7nnYMiG8/ZlMsCmFBpggCjLAxuXMyI/Ew5lbtY
5lnIoC7iMgW5mnmobmrXW6hrsrhIdqrrOFCn8/+djPGwEjjyzLE2YV4ZOyst4qvh
BOvXNlFQSTttH67rUVbFEysLgoQ8rC47Ku7FUfg+aNspPhgnInVyiQCbQedtKbv5
zFiaMX24U94cwNAGTajqHhzrdf1t4m4jMJ9oXjJSotijuz1AQcmZvmiQGM8WAeGJ
SgSJmhdw2MYfWpkMo8kT0BQ5FgXoPA==
=I8zJ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--


