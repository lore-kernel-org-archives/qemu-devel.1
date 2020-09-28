Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE04C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD3C221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3jqujBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD3C221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpm2-0004eH-T8
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMpks-00047U-PD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMpkr-0006Oh-9I
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:47:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601286452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tsQGfwFCHLF9/t4j8scyCPzc/d98n5fx83nIiDLfTZc=;
 b=i3jqujBN6y2uPJd3p6BFo8y+V96pJmd4XcO1jiaj8vEAR4Mx9BzDNirm72pDfjcXc6xqwk
 1WZxsaOyevL40QZQOGtz+uh6ll/V/4ySza/xNfBmBeeGKGCXD8xEwD3AjG4MSvHzb2oSGP
 YbhEVTvjMMxKZuO7kS97IL8Rsj+8U+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-1aS7slj_MvClvVtjYx_YQQ-1; Mon, 28 Sep 2020 05:47:27 -0400
X-MC-Unique: 1aS7slj_MvClvVtjYx_YQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A081785C706;
 Mon, 28 Sep 2020 09:47:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EAA0614F5;
 Mon, 28 Sep 2020 09:47:22 +0000 (UTC)
Date: Mon, 28 Sep 2020 11:47:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 00/13] monitor: Optionally run handlers in coroutines
Message-ID: <20200928094720.GB5451@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200910132439.GE45048@stefanha-x1.localdomain>
 <20200925171541.GK5731@linux.fritz.box>
 <20200928084609.GC43571@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200928084609.GC43571@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.09.2020 um 10:46 hat Stefan Hajnoczi geschrieben:
> On Fri, Sep 25, 2020 at 07:15:41PM +0200, Kevin Wolf wrote:
> > Am 10.09.2020 um 15:24 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Sep 09, 2020 at 05:11:36PM +0200, Kevin Wolf wrote:
> > > > Some QMP command handlers can block the main loop for a relatively =
long
> > > > time, for example because they perform some I/O. This is quite nast=
y.
> > > > Allowing such handlers to run in a coroutine where they can yield (=
and
> > > > therefore release the BQL) while waiting for an event such as I/O
> > > > completion solves the problem.
> > > >=20
> > > > This series adds the infrastructure to allow this and switches
> > > > block_resize to run in a coroutine as a first example.
> > > >=20
> > > > This is an alternative solution to Marc-Andr=E9's "monitor: add
> > > > asynchronous command type" series.
> > >=20
> > > Please clarify the following in the QAPI documentation:
> > >  * Is the QMP monitor suspended while the command is pending?
> >=20
> > Suspended as in monitor_suspend()? No.
> >=20
> > >  * Are QMP events reported while the command is pending?
> >=20
> > Hm, I don't know to be honest. But I think so.
> >=20
> > Does it matter, though? I don't think events have a defined order
> > compared to command results, and the client can't respond to the event
> > anyway until the current command has completed.
>=20
> You're right, I don't think it matters because the client must expect
> QMP events at any time.
>=20
> I was trying to understand the semantics of coroutine monitor commands
> from two perspectives:
>=20
> 1. The QMP client - do coroutine commands behave differently from
>    non-coroutine commands? I think the answer is no. The monitor will
>    not process more commands until the coroutine finishes?

No, on the wire, things should look exactly the same. If you consider
more than the QMP traffic and the client communicates with the guest, it
might see that the guest isn't blocked any more, of course.

> 2. The command implementation - which thread does the coroutine run in?
>    I guess it runs in the main loop thread with the BQL and the
>    AioContext acquired?

By default, yes. But the coroutine can reschedule itself to another
thread. Block-related handlers will want to reschedule themselves to
bs->aio_context because you can't just hold the AioContext lock from
another thread across yields. This is what block_resize does after this
series.

Kevin

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9xsSgACgkQfwmycsiP
L9ZPNQ//awis3NuIbLiEZeIiUnkijCWgzCyLQf6cWGbk2snNtw3JXw5OM/M79dlM
2gjvxLYPNZizztU0MAXcdaqfdWV1pjixCYOS4vE1a0Dchm/g50DbgCjbG6e4QnjE
Lx5UnMZ85KNBIRpHpTW9iFs3fkMqr6pd9k2EUmUj695YLS9kYbVp6DIW7psYEbTh
a5k5YpYau2A/L6lCy+Opivd3ecqZ33jNM89Xp3ibfdgU8eCLYdf20MprDNkIvVCw
IMwR+HJzhwr2JPYkrwZecZ+Yt4mWFlLR8tYvqpSfnIjIxwEhkopuVRFImx2VdboF
CvFr19NoJYStUesFIWA58Sc8JS/GFeANdptFqfxiuWwEuTzxpLRTJD2XYxRuwyzS
HkDYXGIILxTCM5oR4xJ4CZqB7qndXY2TYG0N8J6oKlEky6veRz2xWMO3257kRcMF
/D2elC68g5asOvoKR2556oi0gKMRnItClrH3z7+J3X1VftAC3gXXnZFOOm6aPgag
mlnbV8Wwzub+B0bGl6b5uPiwKao8EemG4LVEIWePxVpnZW1PlDzpNw3TukrlnynA
FU975mmIv1Gkln/h5iLxHoaSKR55casVxJZpVyunBniFq+Y0JWQ8Pdr0UgTukUJO
4pe/mGXHNfIyEDU1FF6JwVGdu8n0KtxIXxm3IknBdRjHYWENXB8=
=1H8A
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


