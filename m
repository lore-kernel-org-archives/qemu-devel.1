Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5AC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C652F20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0C9vbey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C652F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59Yb-00025J-Uw
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j59Xo-00019b-E1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j59Xn-0004cb-Bt
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:44:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j59Xn-0004c4-79
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582296282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCaW8t629myuAGHZUnUCz3SL450VL+SJL9/VA/+ALUk=;
 b=O0C9vbeyJFVjoXtc8rV0cWK6LC50wwnH5lUmkVqneB+3xeJFSgT1TfXSdn6Xl0y+R2AXDC
 sBoSjJpnYUcwRQflI+coNon9sFauuCofIO1rEZoGPDu4fG9fVrdWtpwQNo+Ky8QuLbRjaZ
 bfWMYZVMPJAx5bNnkguBR+w1GfOidBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-iwMSlhlMPOO5Gqz4Dz86lA-1; Fri, 21 Feb 2020 09:44:40 -0500
X-MC-Unique: iwMSlhlMPOO5Gqz4Dz86lA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7048E800D4E;
 Fri, 21 Feb 2020 14:44:39 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265302709B;
 Fri, 21 Feb 2020 14:44:35 +0000 (UTC)
Date: Fri, 21 Feb 2020 14:44:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
Message-ID: <20200221144434.GC1501077@stefanha-x1.localdomain>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
 <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 02:06:26PM +0100, Paolo Bonzini wrote:
> On 21/02/20 13:59, Stefan Hajnoczi wrote:
> > 1. It doesn't crash if the node is currently not on a list.
> > 2. It clears the node's linked list pointers so that future linked
> >    list operations (like QLIST_SAFE_REMOVE()) aren't accidentally
> >    performed on stale pointers.
> >
> > The node has a long lifespan and will be inserted into ready_lists
> > multiple times.  We need to safely remove it from ready_list to protect
> > against a corruption the next time the node is inserted into a
> > ready_list again:
>=20
> Ah, so the one I singled out is for (2) (we know the node is currently
> on a list), while the one below is for (1).  Would it make sense to move
> (2) to Q*_REMOVE_*?  We can do it separately after this pull request.

Extending all Q*_REMOVE*() macros to clear the linked list pointers is
nice.  I'll send a follow-up patch.

Stefan

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P7NIACgkQnKSrs4Gr
c8hBtgf/W91GlEYDMbtkJ84jZqmE2/Z+ITuI90mhg2geX9zrq768KFldMyUCvYVr
8ATf9Z/Fv3+u4RBHaBhD5ikSYn3pLZjpS/2szDFB9k14AWTX54S9TWP7EZgZIUwm
bn4ust8CStMxvBIG1KYQs2s91Um/ytB1vsg594W37HHEuYioP8Rp5iuCBMgXSD5C
qD5Iu10/3mXVOvMFXSbo2L2egJL5xssIEgwFdPHmro7aMehjSHUUy1S8J7cmELtX
c8nVn//ckoxIYaepuGTeJCI7JM8gZ+pg5ROkZ8B03gPmQCKZO4DmB7/zeF41nydo
lL5CcIHrDXnYp+XLYW1YXCWWr9fsqQ==
=QHni
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--


