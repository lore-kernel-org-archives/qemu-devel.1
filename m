Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1CC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952A620656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tttlw0Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952A620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59bC-0004C7-M1
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j59aK-0003ey-Q5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j59aJ-00045M-Pm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:47:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j59aJ-00040J-K6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582296438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohnRIrW3NYepDldk/f4zWaUgr/cHHRUIYg+AymK3XhQ=;
 b=Tttlw0ObYrO73E7HbEO2sqQOxe4nHxrSm5oU7Mf7qBi18fIVHuIiITl9AQTayeK2WsONu8
 BdN6pcmZIF0WRtDfBVJ2DEkinCWLdUFi4WPKVB+ljLisnD03G0OPN0O0f4KSR4/HLCx8NB
 qtgb05LAD8sK6XXrDQrkkw8Fh8I9OkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-mMTsbRdGO2ePiXfjRK7Arg-1; Fri, 21 Feb 2020 09:47:14 -0500
X-MC-Unique: mMTsbRdGO2ePiXfjRK7Arg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742B718C35BB;
 Fri, 21 Feb 2020 14:47:13 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 551B45DA7B;
 Fri, 21 Feb 2020 14:47:09 +0000 (UTC)
Date: Fri, 21 Feb 2020 14:47:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
Message-ID: <20200221144708.GD1501077@stefanha-x1.localdomain>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
 <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 02:06:26PM +0100, Paolo Bonzini wrote:
> On 21/02/20 13:59, Stefan Hajnoczi wrote:
> >   /* Add a handler to a ready list */
> >   static void add_ready_handler(AioHandlerList *ready_list,
> >                                 AioHandler *node,
> >                                 int revents)
> >   {
> >       QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested parent=
's list */
> >       ^---- would cause corruption if node->node_ready was stale!
> >=20
> > Would you like me to add a comment?
> No, it's okay.

Are you happy with this series?

Shall I include it in my next pull request or do you want to merge it?

Thanks,
Stefan

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P7WsACgkQnKSrs4Gr
c8hzagf/Wk2NRG7S23xHy9QjIDlET4zOXq/CWD2cki9azLxkdkjsqiY1KvBOsEq4
xmkqNCvNFP6VstHjbGQnJAGMV9o9E6vzwGnJRCB568ELJZ1bIJO/DvPyf0A8glK1
8jLTfIBW3D63yJX4BrFjnrnUGEzKwF2TH4swH4ZI//VE+K3NSiVHX8HQb5Yuz9Wi
U5sffXRB9LkLIAife/+BMpwDY3hionzeFgvni6WbNL1S9qhXvuADPPE0cI1AKUzg
dNsW6qvKBx/mMtimMfLo3dWw6DLWnmfg0eRHzS/YdYPonXg+773+UzoV5Lr1xcBd
KjbHVg4wDmxk3Kfs4rvIj7E+xjyI1g==
=45GU
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--


