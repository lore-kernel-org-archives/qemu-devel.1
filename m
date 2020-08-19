Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C96C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B35F20882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLpllgNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B35F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QZu-0004DI-7p
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8QWK-0008HO-3F
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:01:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8QWF-0005SP-98
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oju+xsgARreMiVkjJ22C0ojgZL49FLbumEOdpAzA+C4=;
 b=cLpllgNjsN2wC4y5c/uz4Iz1vL6KhdEG409PveSCPo+i7xQiv/DRAXlsNt+DPd/2UVMWjz
 8t7zH4hq0grTfST1K12ti3baLi/u3F5Kv2K2x/wToMZcV9scDnZvtlgMI47UU8/vzLXWUH
 Hk7F+ZCWbJyTkrtvdGczt9kCkPP98WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-sLsI2PW4P_yu2qMQhNBuUQ-1; Wed, 19 Aug 2020 12:00:51 -0400
X-MC-Unique: sLsI2PW4P_yu2qMQhNBuUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7874B1009BA2;
 Wed, 19 Aug 2020 16:00:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8063160BEC;
 Wed, 19 Aug 2020 16:00:49 +0000 (UTC)
Date: Wed, 19 Aug 2020 18:00:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 10/47] mirror-top: Support compressed writes
Message-ID: <20200819160048.GG10272@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-11-mreitz@redhat.com>
 <20200818102734.GC6865@linux.fritz.box>
 <b586341c-4276-eb17-dbcc-c637c5c9d375@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b586341c-4276-eb17-dbcc-c637c5c9d375@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.08.2020 um 17:35 hat Max Reitz geschrieben:
> On 18.08.20 12:27, Kevin Wolf wrote:
> > Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/mirror.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/block/mirror.c b/block/mirror.c
> >> index e8e8844afc..469acf4600 100644
> >> --- a/block/mirror.c
> >> +++ b/block/mirror.c
> >> @@ -1480,6 +1480,15 @@ static int coroutine_fn bdrv_mirror_top_pdiscar=
d(BlockDriverState *bs,
> >>                                      NULL, 0);
> >>  }
> >> =20
> >> +static int coroutine_fn bdrv_mirror_top_pwritev_compressed(BlockDrive=
rState *bs,
> >> +                                                           uint64_t o=
ffset,
> >> +                                                           uint64_t b=
ytes,
> >> +                                                           QEMUIOVect=
or *qiov)
> >> +{
> >> +    return bdrv_mirror_top_pwritev(bs, offset, bytes, qiov,
> >> +                                   BDRV_REQ_WRITE_COMPRESSED);
> >> +}
> >=20
> > Hm, not sure if it's a problem, but bdrv_supports_compressed_writes()
> > will now return true for mirror-top. However, with an active mirror to =
a
> > target that doesn't support compression, trying to actually do a
> > compressed write will always return -ENOTSUP.
>=20
> Right.
>=20
> > So I guess the set of nodes patch 7 looks at still isn't quite complete=
.
> > However, it's not obvious how to make it more complete without
> > delegating to the driver.
> >=20
> > Maybe we need to use bs->supported_write_flags, which is set by the
> > driver, instead of looking at the presence of callbacks.
>=20
> Hm, yes, that would work better.  Not sure if it=E2=80=99s worth it for t=
his
> series.

This patch looks like a feature addition that is only marginally related
to the goal of the series anyway. Maybe it should be a separate small
series on top?

The other compression related patches in the series don't seem to have
this problem, so they could stay there anyway.

> The only problem we=E2=80=99d have is late failure when trying to do a
> compressed backup to a target that=E2=80=99s running an active mirror.  (=
Late as
> in =E2=80=9Cfirst write fails without explanation=E2=80=9D, as opposed to=
 =E2=80=9Cjob fails
> during set-up=E2=80=9D.)
>=20
> Which I hope is not a case anyone would ever encounter, and even if they
> do, the failure doesn=E2=80=99t seem catastrophic to me.  So I don=E2=80=
=99t think it=E2=80=99s
> really a problem.

Yeah, it's just a bit unfortunate to add a new function that we know
doesn't do what it promises.

Kevin

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl89TK8ACgkQfwmycsiP
L9Z7Rg//ecnwLZdvfIcVT3DXOcaeRKIvk+E0zRQSkNL/rCnIiVV2InF9mrYL5CiM
Ch8xRerjRxJNZ2Tvh4z7O0e3v3Sgp23Xco1qNuUopdapyBU8kVOTDjkMPnmcCVVI
PQwZajuXATCpdo6CCaVU6gjZrDq0sVCQBJ3WmTtThXb+6SsYK0OYO4VaZ7KKGrQ/
5sFaaJB0P/+JUOmjvw+ulJkXt0R9y3R7gCOVctHL8x96R8XF/pntQj/Fc7bPr1Kd
b/Tp48Zb5ShY9GeqVtZo//QhFAfFF3ND34Wkzj2/A6Hg+QrjulcnzvMTf/5Q60co
IJdhzSO179ur1j0Y/Yt35eSED669TMsoQ8hBx8JFbrNC79TNhC750sPVb3ExwcRG
03haMzTUFDZouQ7yx95Dq+LmCtqNdT998yW9OuSUCYr7k+CKafWKbKTHZPKZEohJ
1+Xgmpp9AmRArwX2Ha5HhMDbpogwM9Zl+Eb70S4YcuAHJNKO/xJKdU5jWW7TfnYD
sFbfGCh07xff4vqLaYqRMc5pqpF/hBSwSQOYWq4VT1NlANtNFOYI3N7ytoW3kS+x
aPw83zmnN4HZ9FydScllA/EDaVj7Dmw7/jgYWXhNRqIx0Tf8n502k5cFU5dJepNH
zN8BAdX1VHZYh0AUDkXyDHAlLGICT41oYT84Zpk3WNFIWzBeWZo=
=eQoa
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--


