Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6F8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C979E206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0w5fxvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C979E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwC0-0006Tl-GZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIw5C-0001f0-LO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIw5A-00015U-SN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600357460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bpjk+WWlPDFoxx66cmH4yqyKkktF/kR7kgzF9vMSbrE=;
 b=B0w5fxvNDMclxeJDzMYGwk+7eiUfEfj3VTgt1yux6TGLnbMkM89pMbiGF0+LCsjFYjgKFv
 KmAJv2l4tXHMiT8T2q7eRFkOp7xuUVGWobDTpjPNLswBYzRaJ3TsHOsTMkpxsNd5ow+nEm
 CcjmGhnedDgDecuRhH10yY7S38mJrPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-1CNH0h5aM1K_uk33OwxCmA-1; Thu, 17 Sep 2020 11:44:18 -0400
X-MC-Unique: 1CNH0h5aM1K_uk33OwxCmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A9321084C84;
 Thu, 17 Sep 2020 15:44:17 +0000 (UTC)
Received: from localhost (ovpn-112-183.ams2.redhat.com [10.36.112.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69D5310023A5;
 Thu, 17 Sep 2020 15:44:16 +0000 (UTC)
Date: Thu, 17 Sep 2020 16:44:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200917154415.GB839531@stefanha-x1.localdomain>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 armbru@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 03:36:57PM +0800, Zhenyu Ye wrote:
> When the hang occurs, the QEMU is blocked at:
>=20
> =09#0  0x0000ffff95762b64 in ?? () from target:/usr/lib64/libpthread.so.0
> =09#1  0x0000ffff9575bd88 in pthread_mutex_lock () from target:/usr/lib64=
/libpthread.so.0
> =09#2  0x0000aaaabb1f5948 in qemu_mutex_lock_impl (mutex=3D0xaaaacc8e1860=
,
> =09    file=3D0xaaaabb4e1bd0 "/Images/eillon/CODE/5-opensource/qemu/util/=
async.c", line=3D605)
> =09#3  0x0000aaaabb20acd4 in aio_context_acquire (ctx=3D0xaaaacc8e1800)
> =09#4  0x0000aaaabb105e90 in bdrv_query_image_info (bs=3D0xaaaacc934620,
> =09    p_info=3D0xaaaaccc41e18, errp=3D0xffffca669118)
> =09#5  0x0000aaaabb105968 in bdrv_block_device_info (blk=3D0xaaaacdca19f0=
, bs=3D0xaaaacc934620,
> =09    flat=3Dfalse, errp=3D0xffffca6692b8)
> =09#6  0x0000aaaabb1063dc in bdrv_query_info (blk=3D0xaaaacdca19f0, p_inf=
o=3D0xaaaacd29c9a8,
> =09    errp=3D0xffffca6692b8)
> =09#7  0x0000aaaabb106c14 in qmp_query_block (errp=3D0x0)
> =09#8  0x0000aaaabacb8e6c in hmp_info_block (mon=3D0xffffca6693d0, qdict=
=3D0xaaaacd089790)

Great, this shows that the main loop thread is stuck waiting for the
AioContext lock.

Please post backtraces from all QEMU threads ((gdb) thread apply all bt)
so we can figure out which thread is holding up the main loop.

Thanks,
Stefan

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9jhE8ACgkQnKSrs4Gr
c8hrxQf/TsDGZ8gWUynrHDZvPKbMfpDqWBuhJAoGiDAoUk18FYQYyZz4mnYBAGsr
wRufv15uvsHt3eMAG4qDkdm6vFAfvFhpQR2DVlra25g5nJmlECIINoXH47XfqRe6
Yh1X+2Wxo9ET3LVRMNY1ocI6n5/0pmhhO9ITOsxfRsAROk5XOIITEKTmTsTags/J
gBR9rnkqAVq5sy4BbxMyAPCbYSpT/TgY0gN5Oyml+CjsaQHeVVgXYW2Xcb3iw0yu
7UiIMva/h3EvuPYm10B3O5LUpzFVBj1YemDyIZEc69beCl/qTEv3xuLZ9jvlGMqT
8HJN2v5DtBmeNenopCqG6HrXCIT+jg==
=ASkc
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--


