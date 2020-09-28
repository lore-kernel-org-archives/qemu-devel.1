Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F0C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ABA20E65
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTwr1aYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ABA20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMp2R-0005O8-MQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMp0C-0003gA-B5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMp09-0000LO-RC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:59:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601283557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epdoEx4lbS6+UznSrOBmPfv9JsF2WKhf2aGACkImCxo=;
 b=RTwr1aYQxTon7il5f0ZISdw2KESFhgpBt9v21uJUDTMOICM/qjmLMXI9Y/A+ikk2yJrtR/
 DYTBMRathhw99HC8MN9yoCxDnhmjWdObL/tYY0kgYUyd6Yi/+h0f9nW+/RBAgZEmWJ7AtC
 zuEXhI2lN0PeUorZYNY9yrcmEAPiKFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-rDks4f9jM9G2B64s_l4apg-1; Mon, 28 Sep 2020 04:59:14 -0400
X-MC-Unique: rDks4f9jM9G2B64s_l4apg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADA691868437;
 Mon, 28 Sep 2020 08:59:12 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8F510013D7;
 Mon, 28 Sep 2020 08:59:12 +0000 (UTC)
Date: Mon, 28 Sep 2020 09:59:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 12/13] block: Add bdrv_co_move_to_aio_context()
Message-ID: <20200928085911.GD43571@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-13-kwolf@redhat.com>
 <20200915143142.GE629589@stefanha-x1.localdomain>
 <20200925160051.GI5731@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200925160051.GI5731@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
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

--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 06:00:51PM +0200, Kevin Wolf wrote:
> Am 15.09.2020 um 16:31 hat Stefan Hajnoczi geschrieben:
> > On Wed, Sep 09, 2020 at 05:11:48PM +0200, Kevin Wolf wrote:
> > > Add a function to move the current coroutine to the AioContext of a
> > > given BlockDriverState.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  include/block/block.h |  6 ++++++
> > >  block.c               | 10 ++++++++++
> > >  2 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/include/block/block.h b/include/block/block.h
> > > index 981ab5b314..80ab322f11 100644
> > > --- a/include/block/block.h
> > > +++ b/include/block/block.h
> > > @@ -626,6 +626,12 @@ bool bdrv_debug_is_suspended(BlockDriverState *b=
s, const char *tag);
> > >   */
> > >  AioContext *bdrv_get_aio_context(BlockDriverState *bs);
> > > =20
> > > +/**
> > > + * Move the current coroutine to the AioContext of @bs and return th=
e old
> > > + * AioContext of the coroutine.
> > > + */
> > > +AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverStat=
e *bs);
> >=20
> > I'm not sure this function handles all cases:
> > 1. Being called without the BQL (i.e. from an IOThread).
> > 2. Being called while a device stops using its IOThread.
> >=20
> > The races that come to mind are fetching the AioContext for bs and then
> > scheduling a BH. The BH is executed later on by the event loop. There
> > might be cases where the AioContext for bs is updated before the BH
> > runs.

The scenario I'm thinking about is where bs' AioContext changes while we
are trying to move there.

There is a window of time between fetching bs' AioContext, scheduling a
BH in our old AioContext (not in bs' AioContext), and then scheduling
the coroutine into the AioContext we previously fetched for bs.

Is it possible for the AioContext value we stashed to be outdated by the
time we use it?

I think the answer is that it's safe to use this function from the main
loop thread under the BQL. That way nothing else will change bs'
AioContext while we're running. But it's probably not safe to use this
function from an arbitrary IOThread (without the BQL).

I think this limitation is okay but it needs to be documented. Maybe an
assertion can verify that it holds.

Stefan

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xpd4ACgkQnKSrs4Gr
c8g/6Af/arrpIXYyb2tkKVu5eA9xNy4Kp+z9BMnJ5gkfBSsV5UK7kAmMNfEO6slF
GbKnF3ZmcJlr3XW+g4TgwFNNb0a2to/udT61X6M+xJiO1qea8RUM0ERepVhQ/0nj
wEZ+4TJFK+2HUajAexux9qttqJTE5crxnXG9gVPS8dQtBc453yYz2PCI/0LveUFi
PLdyTXZhH1lhYYvdf5ewmBi905+onGRVYvpPzGsXXwDQwKoLcjAAyIFCxUd0pYhf
opoCJZdzZUJI//YI2XjWPn9k+k+nADuL8Rt7rOuHYrEGVi5FiGBbGVlmtIgJBgyz
BiSCpH1OTmBLVIsuIaHmLLJfT26jcw==
=crrh
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--


