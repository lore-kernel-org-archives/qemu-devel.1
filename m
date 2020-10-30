Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F414C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480CB20731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6PwTcqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480CB20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUMu-00032c-Uf
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYUM0-0002VL-1l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYULw-0004co-RY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604064119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xiUI3WK9VxzLW19FzCnMl5zWoZ6trtyrMJaaMcM/dB8=;
 b=g6PwTcqtiSRS7CGHjRU91ufNy3E/zcJUsCeEPaAJBaJnmZKZwHLOsvgSYEVDw4gGajRwQl
 /nrX+4Pt0iJtA83N97C/IryLBmrIdmUEGfQD0txK9puy+B4m2z8UVVjWqF6mEKjSeF7OQS
 Qj2yObsCU8UDgjqADDSYpgd8hkIY4Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-xP5-RQIwP9CzvB88CTtDWA-1; Fri, 30 Oct 2020 09:21:56 -0400
X-MC-Unique: xP5-RQIwP9CzvB88CTtDWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FEB184216F;
 Fri, 30 Oct 2020 13:21:55 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6059710027AA;
 Fri, 30 Oct 2020 13:21:54 +0000 (UTC)
Date: Fri, 30 Oct 2020 13:21:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: cenjiahui <cenjiahui@huawei.com>
Subject: Re: [PATCH v3 0/9] block-backend: Introduce I/O hang
Message-ID: <20201030132153.GB320132@stefanha-x1.localdomain>
References: <20201022130303.1092-1-cenjiahui@huawei.com>
 <20201026165341.GM52035@stefanha-x1.localdomain>
 <b5aef6d9-bc2c-1cf4-b392-5db37049df33@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b5aef6d9-bc2c-1cf4-b392-5db37049df33@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, fangying1@huawei.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 05:42:42PM +0800, cenjiahui wrote:
>=20
> On 2020/10/27 0:53, Stefan Hajnoczi wrote:
> > On Thu, Oct 22, 2020 at 09:02:54PM +0800, Jiahui Cen wrote:
> >> A VM in the cloud environment may use a virutal disk as the backend st=
orage,
> >> and there are usually filesystems on the virtual block device. When ba=
ckend
> >> storage is temporarily down, any I/O issued to the virtual block devic=
e will
> >> cause an error. For example, an error occurred in ext4 filesystem woul=
d make
> >> the filesystem readonly. However a cloud backend storage can be soon r=
ecovered.
> >> For example, an IP-SAN may be down due to network failure and will be =
online
> >> soon after network is recovered. The error in the filesystem may not b=
e
> >> recovered unless a device reattach or system restart. So an I/O rehand=
le is
> >> in need to implement a self-healing mechanism.
> >>
> >> This patch series propose a feature called I/O hang. It can rehandle A=
IOs
> >> with EIO error without sending error back to guest. From guest's persp=
ective
> >> of view it is just like an IO is hanging and not returned. Guest can g=
et
> >> back running smoothly when I/O is recovred with this feature enabled.
> >=20
> > Hi,
> > This feature seems like an extension of the existing -drive
> > rerror=3D/werror=3D parameters:
> >=20
> >   werror=3Daction,rerror=3Daction
> >       Specify which action to take on write and read errors. Valid
> >       actions are: "ignore" (ignore the error and try to continue),
> >       "stop" (pause QEMU), "report" (report the error to the guest),
> >       "enospc" (pause QEMU only if the host disk is full; report the
> >       error to the guest otherwise).  The default setting is
> >       werror=3Denospc and rerror=3Dreport.
> >=20
> > That mechanism already has a list of requests to retry and live
> > migration integration. Using the werror=3D/rerror=3D mechanism would av=
oid
> > code duplication between these features. You could add a
> > werror/rerror=3Dretry error action for this feature.
> >=20
> > Does that sound good?
> >=20
> > Stefan
> >=20
>=20
> Hi Stefan,
>=20
> Thanks for your reply. Extending the rerror=3D/werror=3D mechanism is a f=
easible
> way for the retry feature.
>=20
> However, AFAIK, the rerror=3D/werror=3D mechanism in block-backend layer =
only
> provides ACTION, and the real handler of errors need be implemented sever=
al
> times in device layer for different devices. While our I/O Hang mechanism
> directly handles AIO errors no matter which type of devices it is. Is it =
a
> more common way to implement the feature in block-backend layer? Especial=
ly we
> can set retry timeout in a common structure BlockBackend.
>=20
> Besides, is there any reason that QEMU implements the rerror=3D/werror me=
chansim
> in device layer rather than in block-backend layer?

Yes, it's because failed requests can be live-migrated and retried on
the destination host. In other words, live migration still works even
when there are failed requests.

There may be things that can be refactored so there is less duplication
in devices, but the basic design goal is that the block layer doesn't
keep track of failed requests because they are live migrated together
with the device state.

Maybe Kevin Wolf has more thoughts to share about rerror=3D/werror=3D.

Stefan

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+cE3EACgkQnKSrs4Gr
c8g+JwgAlZdrFu5IuBpXXWP6TKZRBvVeRLHYvh7SCjHuH8203DBMv0PdyHvZAHvF
9vXATiXFa/a3NGz5dowYF72HmqoGPBhxHESrr61Mxe73xF6LZg2ra7b9up8Z/kag
nBMfv5GWz+AeRL/Y/JdAdUXaJvMJpIGCv/beI1J901dSck+Ekl42ZlDqUiYfZbGb
dtua+7xqFMUPLmhUq1SRZ+nU8VJOIiCZCe9ImFk1LgpmQJCTGB/ZXyQbzmI9Nc5T
zEbnO9yyZJ47aqJhyv0yfU5rA3bjLICGaJeTAMTPVe4Q3ZHJgsVaInX42+8AiOkG
ZYwwT1etlyA1tqCF1IzK+7ktRjwLGg==
=kV4n
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--


