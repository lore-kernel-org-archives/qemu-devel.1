Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 00:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E979F207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 00:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E979F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK9mB-0000pq-2G
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 20:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK9lD-0000C7-W5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 20:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK9lD-0000py-3B
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 20:00:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6680
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jK9lA-0000oO-Rr; Thu, 02 Apr 2020 20:00:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032NXcxI013798; Thu, 2 Apr 2020 20:00:27 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 305s82s2at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 20:00:27 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 033005ju003133;
 Fri, 3 Apr 2020 00:00:26 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 301x77cm6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Apr 2020 00:00:26 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03300NIM8913288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Apr 2020 00:00:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97B1DC605D;
 Fri,  3 Apr 2020 00:00:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B91A9C6059;
 Fri,  3 Apr 2020 00:00:17 +0000 (GMT)
Received: from LeoBras (unknown [9.85.174.86])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  3 Apr 2020 00:00:17 +0000 (GMT)
Message-ID: <c3df447617f5dcc01b8a61421d53293196d53909.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 02 Apr 2020 21:00:10 -0300
In-Reply-To: <20200402234038.GU47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
 <20200402224925.GN47772@umbus.fritz.box>
 <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
 <20200402231645.GT47772@umbus.fritz.box>
 <2cf25efdae30ea7a728c1a1e62e41c65f9073d5c.camel@linux.ibm.com>
 <20200402234038.GU47772@umbus.fritz.box>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-90+QTdvz5cw6OXMd8a+G"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_13:2020-04-02,
 2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=984 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020173
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-90+QTdvz5cw6OXMd8a+G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-03 at 10:40 +1100, David Gibson wrote:
> Urgh.  Ok, I'm sorry Leonardo, but,
>=20
> Nack.  I will not merge a change where my only knowledge of the spec
> has to be based on hearsay.
>=20
> By all means use this as ammunition to convince IBM and/or the
> openpower foundation to expedite getting a workable document release
> process up and running.

No problem David, of course I understand your point.

I am working on this document release, and it will probably be
available soon.=20

When it is, we can visit this patch again.

Best regards,
Leonardo Bras

--=-90+QTdvz5cw6OXMd8a+G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6GfIoACgkQlQYWtz9S
ttQLpxAAzlbM7J9tn1sbpVS2Vo0ozyUYLGFb46tVAmiYaPpVlolYPTd2Vy2fiBPh
bNmh76XNTql5S9l/NKBoYTY7quWnuWuao1MP3Xa9QmpdDezY6SLca5plynJgIrYe
5Jb1yJ5+ysQkRP5WnXzyRQtB7HH9eeIvYWv6eFiHbwMZDyhFpJNlUmTJQsIE50L+
RvvXb4L/66mXK+WJmkV/0K49Te2HdIhss5pTIa1E7PkI873u49ZHCBLeDPc9iRje
ex9rTf2pOVk/LI5XE2WQE518tjAcrkKU8+kxdAvTCGPLpNb1E7UVCr4gmwNI1itC
iLKzK4IWWj6u8KRngYm0184cr1ECN+IXPl+jRS/0GV2D3cLcqkPkBzkFx6qEehpA
S3UG3GXkRd+9xZ74bXZMKUBKX/Cod1C48IbEgrKQgr+lOULu+cAErYcuAjO17oZK
AvVm+lolKEbSltw/DCaA9kFQN8PaqRFityz5YnFGu/+HYxOzFEaNpbGNQKLDIfzQ
EJq0XTOJDClr7fvih6VMkmkPmB9Z5GjxL4A38rh/+ZFbMytiG95IbKp5sTGV6ndE
7z0wlxoQ3CGmM1x+txn/4Q6Kby0p9DIrsA6xqx94pCaWUPhxlxZiqYJpJwlWgoaW
rixGW4XuzRUFLycDCLyzf0HN6C2zdOaKYEunVLH8CbKfwKXxKkA=
=KE1u
-----END PGP SIGNATURE-----

--=-90+QTdvz5cw6OXMd8a+G--


