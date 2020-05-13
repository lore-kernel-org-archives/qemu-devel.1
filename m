Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E9ACA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0433206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+ya5mu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0433206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYn0J-00029q-HO
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYmz8-0000lT-BW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:43:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYmz7-0004sA-EU
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589359404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgRQJCBTW/FxKc+ZBbr1B6ASil0KczuqBVrBCf3MscY=;
 b=M+ya5mu9DyqXXXrxR2na/7+1WRf5CDpk4RuE5j1Zv7Aqk0cGEdSEO0zxRoAPhY3BMsbjiV
 lnZsLXwkoeFYXiARIdZFfZ+68tjQXS/vqNq0cWAUKsZdEuwJKMlW0OvW76y/NS+ks+YpHv
 J1Fdnr2g+RZu0F9rrVQJT8iQYypPoHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-KxFespvjOyGmYqAL3zkHYw-1; Wed, 13 May 2020 04:43:23 -0400
X-MC-Unique: KxFespvjOyGmYqAL3zkHYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E22F88014D7;
 Wed, 13 May 2020 08:43:20 +0000 (UTC)
Received: from localhost (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67EF910013D9;
 Wed, 13 May 2020 08:43:14 +0000 (UTC)
Date: Wed, 13 May 2020 09:43:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 12/36] multi-process: add functions to
 synchronize proxy and remote endpoints
Message-ID: <20200513084313.GB317907@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <7542e59e646421515051902fcd05fbb69fa4d866.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512102120.GC300009@stefanha-x1.localdomain>
 <E5540C92-59DD-45DB-9A9A-956C845B4592@oracle.com>
MIME-Version: 1.0
In-Reply-To: <E5540C92-59DD-45DB-9A9A-956C845B4592@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 08:28:39AM -0400, Jag Raman wrote:
> > On May 12, 2020, at 6:21 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > On Wed, Apr 22, 2020 at 09:13:47PM -0700, elena.ufimtseva@oracle.com wr=
ote:
> >> +uint64_t wait_for_remote(int efd)
> >> +{
> >> +    struct pollfd pfd =3D { .fd =3D efd, .events =3D POLLIN };
> >> +    uint64_t val;
> >> +    int ret;
> >> +
> >> +    ret =3D poll(&pfd, 1, 1000);
> >=20
> > This 1 second blocking operation is not allowed in an event loop since
> > it will stall any other event loop activity. If locks are held then
> > other threads may also be stalled.
> >=20
> > It's likely that this will need to change as part of the QEMU event loo=
p
> > integration. Caller code can be kept mostly unchanged if you use
> > coroutines.
>=20
> In case the remote process has hung or terminated, the 1 second timeout
> ensures that the IO operation does not block for too long.

Timeouts are fine. They just need to be integrated into the event loop
instead of blocking it. That way other processing can continue while
waiting for the remote device process to respond or time out.

Stefan

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl67syEACgkQnKSrs4Gr
c8gaHgf+KM/7izQu/Tgg+5DXct8bz7Dl6NN6x4u+lFTpAqCCWLzim52cGkLIkLFx
szUNdJPrji1kiNpVPUf0C8Z+uFFmK0QvffnHjLKM8cffLpIKNWVMLteRHkmwZMPm
3JVof1rzpm49GbQDBoLxf39Wgf7JciAFjUFSQ5Z0ziR1GGUo44w/klO6FoRErYOG
y+tedzQT6Y+xCNqTbR+82v7V7yn+/PvqhXpuxQgPlJNkg75IMYamHNFyJWENVsqC
tb8gFznNH+eyA3VJ9dhBK/gS2NwIUtFKDkzzxTxjPSPicwnKtwXtMok9zY3WffrJ
xP6hNJr3lKFJ0iN/b1TrNRQo6z0e3Q==
=+ud0
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--


