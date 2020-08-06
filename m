Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E52C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743FD2312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MkqNqXH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743FD2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g35-0001NA-F9
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k3g2H-0008Tx-VU; Thu, 06 Aug 2020 09:34:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k3g2F-0002P6-W9; Thu, 06 Aug 2020 09:34:21 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 076DXEP6046760; Thu, 6 Aug 2020 09:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=xLgXlOn9iAlBuzB6Hh5yozSZRWCW7vrFTdFTv5m99vs=;
 b=MkqNqXH4JmBDkG4waQxFrtdRObj4yeShzMpT0B7mbCagbCPn5mJ2agbjleXBzs54RgGE
 peWCQgiR28uHKPZFHyrjvjqudGhon9hHEqcRdan5ho5unEmH5cjI1iy9phhWNljBvhEl
 btEZ90RMFFDpb+GEQs8YK+R2kTS1vTmAUrorKLK7tkXq0BFbtO+83u2xcjzag3woBvwd
 7ZwWIkyMB6MXCfPPtfCJOdfmnZrEwFbG+lBlq0g1Lo98MJpsu6G//IsKl/isubr5JHX4
 USYqkkemBgBCc7TkFherKaswTESj3SQOrDCcBJMeVSBvY+pMeAkG8U7EENiAcutGlBWD VA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf386pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 09:34:18 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 076DXQcp047180;
 Thu, 6 Aug 2020 09:34:16 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf386n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 09:34:16 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076DGeT8016373;
 Thu, 6 Aug 2020 13:34:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06fra.de.ibm.com with ESMTP id 32mynhbcmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2020 13:34:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 076DY9KT11469252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Aug 2020 13:34:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9B9CA4068;
 Thu,  6 Aug 2020 13:34:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31AB3A405B;
 Thu,  6 Aug 2020 13:34:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.35.222])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  6 Aug 2020 13:34:09 +0000 (GMT)
Subject: Re: [PATCH for-5.2 v2 9/9] tests/qtest/cdrom: Add more s390x-related
 boot tests
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-10-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0188a660-926b-2326-c4fe-ba462f12f978@linux.ibm.com>
Date: Thu, 6 Aug 2020 15:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200806105349.632-10-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lTRppvqo0tivfP3WpwRiVZNpY5qCocj1L"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-06_09:2020-08-06,
 2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:28:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lTRppvqo0tivfP3WpwRiVZNpY5qCocj1L
Content-Type: multipart/mixed; boundary="ZKuuM4Vxk0PmxFmNg9Y8N3iOr0mOPonhN"

--ZKuuM4Vxk0PmxFmNg9Y8N3iOr0mOPonhN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/6/20 12:53 PM, Thomas Huth wrote:
> Let's add two new tests:
>=20
> 1) Booting with "bootindex" is the architected default behavior on the
> s390x target, so we should have at least one test that is using the
> "bootindex" property.
>=20
> 2) The s390-ccw bios used to fail when other unbootable devices have
> been specified before the bootable device (without "bootindex"). Now
> that the s390-ccw bios is a little bit smarter here, we should test
> this scenario, too, to avoid regressions.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Nice!

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  tests/qtest/cdrom-test.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index 833a0508a1..13e22f57c1 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -163,6 +163,18 @@ static void add_s390x_tests(void)
>      qtest_add_data_func("cdrom/boot/virtio-scsi",
>                          "-device virtio-scsi -device scsi-cd,drive=3Dc=
dr "
>                          "-blockdev file,node-name=3Dcdr,filename=3D", =
test_cdboot);
> +    qtest_add_data_func("cdrom/boot/with-bootindex",
> +                        "-device virtio-serial -device virtio-scsi "
> +                        "-device virtio-blk,drive=3Dd1 "
> +                        "-drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
none,id=3Dd1 "
> +                        "-device virtio-blk,drive=3Dd2,bootindex=3D1 "=

> +                        "-drive if=3Dnone,id=3Dd2,media=3Dcdrom,file=3D=
", test_cdboot);
> +    qtest_add_data_func("cdrom/boot/without-bootindex",
> +                        "-device virtio-scsi -device virtio-serial "
> +                        "-device x-terminal3270 -device virtio-blk,dri=
ve=3Dd1 "
> +                        "-drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
none,id=3Dd1 "
> +                        "-device virtio-blk,drive=3Dd2 "
> +                        "-drive if=3Dnone,id=3Dd2,media=3Dcdrom,file=3D=
", test_cdboot);
>  }
> =20
>  int main(int argc, char **argv)
>=20



--ZKuuM4Vxk0PmxFmNg9Y8N3iOr0mOPonhN--

--lTRppvqo0tivfP3WpwRiVZNpY5qCocj1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8sBtAACgkQ41TmuOI4
ufhyWg/+JtQB/28nfNXLYvojl/inR/6mPEdrmgYhHy4/HYJmcJjV1ucEtNybx60E
HC+r2508xRROwX+7feUnFKrjhkEAbUZDaf7aw0GRDUuvRDxetWISkDv/+GgssrPR
+myUfz2QNkFQov2W7DrCOz3MbMGaAG5vDEgf9yAvnS9AfqdZMqT85yA4QE57IB9O
HghQRaw1ZW355lfy4D3eaNArArxe0r4YZunyxLgxzia1y77v13ROIbBRAC2eR4hB
90at/4gi//PbEjR8YyeMRJW8S/+QDK04wjcVuAnRZwfmEaBguw6ftcFZbm7+ypUG
GyPVAqVR3V5mTnxf9o/Od0QkDEwHS9Hwh74xcqgvstUl3q25vY8kzQxBcN5JVDau
KN3EsfTbuSTkWeIVHPLp35w0czdTsIzeh+ylGHk84jj0Jq01ltQzUyswjbWiBLr1
HJWWo3d3MykBru+7POYxr7zNLFH1+3m7KE9fOLZNksCcqZB2pLqIcc0sgn3NQacn
jDX9JrKBnBegFiy3Bj/1WekyjCe9u0zR86hSwUW/UQzFg+7rV5+4cfBy8dbU3k3W
LwdcK3V4C9u+9w+sQi5vQGbel44IKC32AB4KUAY5SnWfoJOz56uBmimREzt22HCV
ZBNIrnXnI6ygT6bopt/4WzIkhlM7u7UmjfB5JyJzdCR7kCp98vQ=
=J1LW
-----END PGP SIGNATURE-----

--lTRppvqo0tivfP3WpwRiVZNpY5qCocj1L--


