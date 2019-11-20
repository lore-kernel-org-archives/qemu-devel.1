Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF1D21906
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUyFBTbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF1D21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXONx-0001ms-Jv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iXOMl-0000tj-C5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iXOMj-00076c-MJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:41:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iXOMj-00075Q-BX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574250104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zalnQXLaPowJs7MLSHDtEvpAbA/8e+NyuWkugn7g8YE=;
 b=HUyFBTbEW0ktLkp8vok6d1lBRDQOwHkRmeIqgpxCuoqFaOY5gqwqM4PvWiUqdU0v6nYzH9
 DxtALlF8BCDeNPCGIhFG0mVV+swY3nAhF0RVcT0hMMttRfTgMrwG0bOWcGnKCmZ/avKVax
 ogi9GjzQshGhWY8ug+uPdCDCj5wLjkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-rP8yJImzMwy4YXQuOyF7qQ-1; Wed, 20 Nov 2019 06:41:43 -0500
X-MC-Unique: rP8yJImzMwy4YXQuOyF7qQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99419802689
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 11:41:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F22DE600C9;
 Wed, 20 Nov 2019 11:41:32 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:41:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] vhost-user-input: use free(elem) instead of g_free(elem)
Message-ID: <20191120114132.GD242924@stefanha-x1.localdomain>
References: <20191119111626.112206-1-stefanha@redhat.com>
 <6b45458f-386f-3be0-c3d8-20c88ca37a2b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6b45458f-386f-3be0-c3d8-20c88ca37a2b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 10:37:35AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/19/19 12:16 PM, Stefan Hajnoczi wrote:
> > The virtqueue element returned by vu_queue_pop() is allocated using
> > malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
> > function instead of glib's g_free().
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Fixes: 06914c97d3a ?

Good idea, I should have included that.

Stefan

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3VJmsACgkQnKSrs4Gr
c8iU8AgAjCH4yzbFhW6jh7iMfcADOu25yyP+aYBf6KRiBC7iUq+8wp7+qwzkeFu5
j1QD824m8L1I9J0WF6illuJnCrAKB+rZhDMJZplzoPxJB0dR8KiUKp8+kLftTLOS
pD8a2y1k8poznSaDy/qK8iIfXc8gTClqRkwhEwxUonWAWCkXEF6loUOOkQwTQXHt
HNTTur6NIoPmmlDlFzw4fD30G0VT5CBIBhKbyEDTlg51ud92cRjY//6FKFkjbFTs
fXQ66RBDtzt5ZDVKn52cDXtYG0QEC0BTepfZCj0tWcqN8XunDIvQtzdgNsHZ3rDc
bmmvvcvHGNYDjZp8TCBvqudiR8UGVg==
=yV3o
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--


