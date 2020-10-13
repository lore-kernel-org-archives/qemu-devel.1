Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD3F208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QB5Xrty8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD3F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSDa0-0003vw-FK
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.jensen@samsung.com>)
 id 1kSDZQ-0003Vr-Lg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 02:14:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.jensen@samsung.com>)
 id 1kSDZO-0002Ks-FG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 02:14:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20201013061341euoutp011ae79fda73bcaa27b479e93673ce5010~9eJRsmQ8E0439804398euoutp01F;
 Tue, 13 Oct 2020 06:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20201013061341euoutp011ae79fda73bcaa27b479e93673ce5010~9eJRsmQ8E0439804398euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1602569621;
 bh=4ZT3GOXUxtHwRsFbraOunRE2h4EliaSV1QLAVEpD/Hw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QB5Xrty8nOVPVYiasBwJpwfl9f5ONEXXzxOabx2zosCEPw9ZiqSh6JRT6fS7LhYbG
 5UH4UJBxevizW8HAi64xhZOXoxDetqiuUa6fefgs/E+GtOSjrFck1H9CF9r46WIfF1
 o3ecxQJndDaNZp4KAbiayeclH5fwWqZrUza8D4u8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20201013061340eucas1p13e34c8f5f3794de6276c7d8278a9e4b9~9eJQh62Yo0715107151eucas1p1e;
 Tue, 13 Oct 2020 06:13:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.A0.05997.395458F5; Tue, 13
 Oct 2020 07:13:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20201013061339eucas1p1d0f18bfccdb3692e878279334047ce6d~9eJQB-0FV2572425724eucas1p1B;
 Tue, 13 Oct 2020 06:13:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20201013061339eusmtrp282ae855e6b7814a0b1c21f6711a7e1d0~9eJQBQ73d1084710847eusmtrp2P;
 Tue, 13 Oct 2020 06:13:39 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-91-5f85459374e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.28.06314.395458F5; Tue, 13
 Oct 2020 07:13:39 +0100 (BST)
Received: from apples.localdomain (unknown [106.210.248.164]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20201013061338eusmtip1e95cc50457da85b7858125dd4cf39d9c~9eJPbFzg20287902879eusmtip1e;
 Tue, 13 Oct 2020 06:13:38 +0000 (GMT)
Date: Tue, 13 Oct 2020 08:13:38 +0200
From: Klaus Jensen <k.jensen@samsung.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 14/21] contrib/gitdm: Add Samsung to the domain map
Message-ID: <20201013061103.GC57365@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline
In-Reply-To: <20201004180443.2035359-15-f4bug@amsat.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHeXcuO64Wx9nwQYNiFHahcl2PlZekYBBE0OWDULbqtKTtTM5c
 ZZ+sbA0tywqnC9pcdtPUWpZLJ80hrTLtYtqWBV0ha9IqtQTR3M4k+/Z7/s/zf58LL4XJQkQC
 lcPlsTyn1ipICX73wXDnwnPrj2cn9zanMOZ3BYi5VV5PMIEWv4h56GzFmGuldoJ5dMRNMEH/
 Y4z5+qKaZHynXDjjr28nmd/vL4ozpqg8XyrFqlqfH6ne9LhJ1aee2yJVSUM12kRkSdbsYbU5
 B1h+cdpOyb7AywIyt1R+qHUshBegU7IiFEMBvQw6zx/Fi5CEktHXENR8rkZCMIDAaQthQvAL
 QcMxGz5haR7qjVZdRfC8qkwkBD8RFA90EuEqnJ4DZddPisNM0vOgcWQs4p5Op8KdOnOkIUZ7
 MCgP9pPhRBy9AV77WiJFUnolOIbdSOBYeFTxKaJj9CH4XOgcf5Qa50S4OkqF5RiageONLZFR
 gR4Ug2NkmBRGXQfnL58UCRwHX30NYoFnwNg9m0gwFCMoCQ1G3eUILFd+k+EOQK+GkidawbAW
 /A5LVJ4G/v5YYZ5pcPauBRNkKZhN0aMq4Nx9U7QtQM+tV0hgFXRf6oie1IWgq6qPOINmWSet
 aZ20pvXfmgLOg/qmxf+p4eIFcKXyGyZwKtTVfcftSFyN4lmjQadhDUs49uAig1pnMHKaRbv1
 Oica/3vto74BF2oa2eVFNIUUU6X2jYXZMkJ9wJCv86LZ4y99uFnzDCXgnJ5jFdOlmR3tO2TS
 Per8wyyvz+aNWtbgRYkUroiXLnX0bZfRGnUeu59lc1l+IiuiYhIK0K6k5qkzt5zeqd9i3P7x
 xw+XXD74/W1v09xg4IHp2Wu7yXohpcIal5W3ZCvPJgfJ5Y2eP82Sp2/bMtaNyTmL8WBhk6vY
 E0NvTs+qqRo6UdFhWa/0DtSWvesKKbtnJCn25nC2j4hFyZl1NvOsFTfSOn0at5IPpK+6vY2n
 2xauVeCGfWrlfIw3qP8CwHuz9YMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7qTXVvjDf4vkraYe/c8i0XHgwZG
 i40z1rNa3Nx7g8nixKaDzBYrJi5gtTjZuIfV4s2NU8wWry6tYrM43ruDxeLG+tNsFt8fzmN3
 4PE48GIhu8fa4zcYPe5c28Pm8eTaZiaPvi2rGANYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30
 jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy5vV1MRb0i1ZM6epiamDsFupi5OSQEDCR2P3t
 NmMXIxeHkMBSRolDT8+xQiQkJA7tOwJlC0v8udbFBlH0gVHi7ZNpTCAJFgFViWkre9hBbDYB
 TYntf/6zgNgiArYSW9d1sIA0MAscYZZ4vGMaI0hCWMBb4tbxvWBFvALmEot+7gGLCwmkSMyb
 eJcRIi4ocXLmE7AaZoEyiRmrFwIt4wCypSWW/+MACXMKWEi0bt/LPIFRYBaSjllIOmYhdECE
 1SX+zLvEjCGsLbFs4WtmCNtWYt269ywLGNlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbv
 tmM/N+9gvLQx+BCjAAejEg/vAr+WeCHWxLLiytxDjCpAYx5tWH2BUYolLz8vVUmE1+ns6Tgh
 3pTEyqrUovz4otKc1OJDjKbAoJvILCWanA9MOHkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
 E0tSs1NTC1KLYPqYODilGhjFL+98LOvU0Pt71dp7C0SrNr85ePjO7l92wtomQb8+/P330dp4
 vw/j3wcVlmUHDC4/1nzxnt/rfdH1pKn8O3WWyc3QSHhb/3qXz+1/n9m/uXqfvXXzkdjLYGO9
 ZTsV7lu6L5Ow5qoy3JW++sGktJXi2tOK3ku8v7cgJE3bYL5YQGtNT+nFq4kzlFiKMxINtZiL
 ihMBNsQvUwADAAA=
X-CMS-MailID: 20201013061339eucas1p1d0f18bfccdb3692e878279334047ce6d
X-Msg-Generator: CA
X-RootMTR: 20201013061339eucas1p1d0f18bfccdb3692e878279334047ce6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201013061339eucas1p1d0f18bfccdb3692e878279334047ce6d
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-15-f4bug@amsat.org>
 <CGME20201013061339eucas1p1d0f18bfccdb3692e878279334047ce6d@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.11; envelope-from=k.jensen@samsung.com;
 helo=mailout1.w1.samsung.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:13:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Pavel Fedin <p.fedin@samsung.com>, qemu-devel@nongnu.org,
 Alexey Perevalov <a.perevalov@samsung.com>,
 SeokYeon Hwang <syeon.hwang@samsung.com>, YuYeon Oh <yuyeon.oh@samsung.com>,
 Oleg Ogurtsov <o.ogurtsov@samsung.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jaroslaw Pelczar <j.pelczar@samsung.com>,
 cccccnjgdhvlrgthvetfcdfhkgchcrutgbrbevvnbgn@apples.localdomain
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct  4 20:04, Philippe Mathieu-Daud=C3=A9 wrote:
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>=20
> Cc: Alexey Perevalov <a.perevalov@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Evgeny Voevodin <e.voevodin@samsung.com>
> Cc: Igor Mitsyanko <i.mitsyanko@samsung.com>
> Cc: Igor Skalkin <i.skalkin@samsung.com>
> Cc: Ilya Maximets <i.maximets@samsung.com>
> Cc: Jaroslaw Pelczar <j.pelczar@samsung.com>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Maksim Kozlov <m.kozlov@samsung.com>
> Cc: Mario Smarduch <m.smarduch@samsung.com>
> Cc: Maxim Ostapenko <m.ostapenko@partner.samsung.com>
> Cc: Mike McCormack <mj.mccormack@samsung.com>
> Cc: Mikhail Ilyin <m.ilin@samsung.com>
> Cc: Munkyu Im <munkyu.im@samsung.com>
> Cc: Oleg Ogurtsov <o.ogurtsov@samsung.com>
> Cc: Pavel Fedin <p.fedin@samsung.com>
> Cc: Sangho Park <sangho1206.park@samsung.com>
> Cc: SeokYeon Hwang <syeon.hwang@samsung.com>
> Cc: Sergey Fedorov <s.fedorov@samsung.com>
> Cc: Stanislav Vorobiov <s.vorobiov@samsung.com>
> Cc: Yeongkyoon Lee <yeongkyoon.lee@samsung.com>
> Cc: YuYeon Oh <yuyeon.oh@samsung.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 47522dff02..77f2a140cd 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -31,6 +31,7 @@ proxmox.com     Proxmox
>  quicinc.com     Qualcomm
>  redhat.com      Red Hat
>  rt-rk.com       RT-RK
> +samsung.com     Samsung
>  siemens.com     Siemens
>  sifive.com      SiFive
>  suse.de         SUSE
> --=20
> 2.26.2
>=20

Thanks!

Acked-by: Klaus Jensen <k.jensen@samsung.com>

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+FRZEACgkQTeGvMW1P
Dek+nAf/WvmfWvo6HYn7OIzh/k+zCsFp6arycmNh0IoQ2S5e2zHUlTrXhdvKs4MA
yTiUozVzysPd1Es4nBjz3bVPtbcObiQNfTv4Hux18bbivWQOY8OHZiHRLIRwbJZ/
rj1ZOU4IpOyOBuF7eJwMVKBGDJJ/DP5wkQD/Dfdy6BPwHu+nBWgsliqmBEyMCr39
Pkp11yTjC7r2cD143D/vilAvMYEHWjYcrgT72cVCRpj3LqAsjHQbC0Mur7v4mPOg
YdWgUYYUJgDTPna6Bzv4QjOeFXFn0rTt45QdSmDkcCHp+V3Agi4aZ8AC/z0tDlCX
B6EH7Kb6RCVQWwwy2QFZ0K+CQHH6dg==
=mSUO
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--

