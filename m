Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC44C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5EE20735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKG1/XoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5EE20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICdR-00056F-IF
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaY-0001Xr-Ad
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaW-0008PU-7A
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+R9N/9X9GsVNzQOdJYRzeP0Jlmn4xR7hCOpsHGkLPQ=;
 b=iKG1/XoK6iidf8ZJ8V1FUdRk+2WFm3lIZuW6JMqnLW1v0G2ytpMzlQoT5ZGb3x1a8JN5fN
 RosCAhkP1vG9C10vs1P+OpuLviJIUNHyNhnOs1s/97hLv/P6O9Y9tNEJA1GGfU5My+Uzgk
 y6Hit9m8UoTq2XRl95+zXtg4sS8urJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-16eItS1yM9OjaMnjwuqbsg-1; Tue, 15 Sep 2020 11:09:35 -0400
X-MC-Unique: 16eItS1yM9OjaMnjwuqbsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988FE1009479;
 Tue, 15 Sep 2020 15:09:04 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BCB760FC2;
 Tue, 15 Sep 2020 15:09:04 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:58:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
Message-ID: <20200915145801.GG629589@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200910132439.GE45048@stefanha-x1.localdomain>
 <878sdco0n6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <878sdco0n6.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, marcandre.lureau@gmail.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 05:09:49PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Wed, Sep 09, 2020 at 05:11:36PM +0200, Kevin Wolf wrote:
> >> Some QMP command handlers can block the main loop for a relatively lon=
g
> >> time, for example because they perform some I/O. This is quite nasty.
> >> Allowing such handlers to run in a coroutine where they can yield (and
> >> therefore release the BQL) while waiting for an event such as I/O
> >> completion solves the problem.
> >>=20
> >> This series adds the infrastructure to allow this and switches
> >> block_resize to run in a coroutine as a first example.
> >>=20
> >> This is an alternative solution to Marc-Andr=E9's "monitor: add
> >> asynchronous command type" series.
> >
> > Please clarify the following in the QAPI documentation:
> >  * Is the QMP monitor suspended while the command is pending?
> >  * Are QMP events reported while the command is pending?
>=20
> Good points.  Kevin, I'd be willing to take this as a follow-up patch,
> if that's more convenient for you.
>=20
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Stefan, I could use your proper review of PATCH 11-13.  Pretty-please?

Sounds good. I have reviewed the patches 11-13 and left questions for
Kevin.

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9g1nkACgkQnKSrs4Gr
c8gITwf/U3d5UvFxcnfsK2TTQD1CyGHC4GzR6jqfLi6dL/uVDxPtHredWWsQzDJv
+9xmHGFLCa6XuCvBxwiJdrb3sPD8UcZFoQEpOC+e6B9q3w6EK03s5papeMsDxx5i
STL/4ANNObpZFVMpRKLDJ8068C9+fnAd8qG8gHRQN+SBrs8GSOrqyoqALO2CMWMB
0pDWQRfJelOuVN8XtN28m5G4KHktIhkxKoJtW2+N5nK7ge4rDYnCx/5NSMsnhuNx
ANDrLmWL9p6ddFKSBOdMikZhhuPVZ1bH6GRWCoczIbZRJPKPJX7CGfxksfbRpQCA
Pf1PNfwuIniP0yAvh4XLiAyo1vnRZw==
=y1lT
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--


