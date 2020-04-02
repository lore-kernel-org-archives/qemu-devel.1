Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5031AC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA62073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK98g-000192-8S
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 19:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK97t-0000WF-Fm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK97s-0004NZ-Iy
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30214
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jK97q-0004FZ-Gl; Thu, 02 Apr 2020 19:19:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032N3xQ1070922; Thu, 2 Apr 2020 19:19:50 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 304g87x8xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 19:19:49 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032NFXV9021451;
 Thu, 2 Apr 2020 23:19:49 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 301x774jdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 23:19:49 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 032NJk5K12648736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2020 23:19:46 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83852BE04F;
 Thu,  2 Apr 2020 23:19:46 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78046BE051;
 Thu,  2 Apr 2020 23:19:41 +0000 (GMT)
Received: from LeoBras (unknown [9.85.174.86])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2020 23:19:41 +0000 (GMT)
Message-ID: <2cf25efdae30ea7a728c1a1e62e41c65f9073d5c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 02 Apr 2020 20:19:34 -0300
In-Reply-To: <20200402231645.GT47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
 <20200402224925.GN47772@umbus.fritz.box>
 <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
 <20200402231645.GT47772@umbus.fritz.box>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-PnDDO2ZJYhY9kyUVadu0"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_13:2020-04-02,
 2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=813 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020166
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


--=-PnDDO2ZJYhY9kyUVadu0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-03 at 10:16 +1100, David Gibson wrote:
> On Thu, Apr 02, 2020 at 08:00:57PM -0300, Leonardo Bras wrote:
> > Hello David,
> >=20
> > On Fri, 2020-04-03 at 09:49 +1100, David Gibson wrote:
> > > The change looks reasonable.  Is there a PAPR RFC I can see describin=
g
> > > the new bit, though?
> >=20
> > The ACR is approved and I already added the change to LoPAPR/LOPAR,
> > it's just a matter of time to get it released.
> > (I think it's accessible to members of OpenPower Foundation)
>=20
> Hrm.  The latest LoPAPR I can find is from 2016, so a "matter of time"
> isn't very encouraging.

I understand the feeling.
There is a new initiative inside the OpenPower Foundation to keep these
documents updated.=20

I think we will be able to have more frequent updates of the
documentation soon.

Best Regards,

--=-PnDDO2ZJYhY9kyUVadu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6GcwYACgkQlQYWtz9S
ttQT6g/9HQGmYwnf+P3f4AgAo8xiN4rLFt2XSQ2bNQ5tVGthS1gTtFUHMvN8E31D
Nv8wezb73hClF8suU88h8N5tggfqq4Wk0KYRwiR4uzLMzMBS1Pc881O+jd9vLdQf
sDitQ/916mt71vDnOtkmy3AeoHbdCH0QnIerKg+B0mrSYNdyC3i84ePlYMaj5rTc
TF/8HLClIHi59Eg+U9VfkR+2TKGKktFFiDCARc0oJqV0VYtRVFcz8jIeABkkIHUq
457+zF61Hb2qsBhCAmwXL+V7kMMkOF62rmCGMVWul1qbMbyapwrx2CefUh0b/NQO
KC5igVqUiGV3bWuYyLxXzvB+IrXD1g3dPXxczngHPoNrWfM3VUIbVQnYvYe5z9EC
9hYPzk9Ub3BouKb5kg9qsnpNf40l+lsRALUdMbqiBns4cvNMZ//sw4mn+Q8u/Wtg
beXtic8Vorpnc+Pjf/CKkXmJExCVB/yDB85IY1zPMUjxwv4elPZaLh7h8u9PEvCY
ov7V/DZNcvGrZq0DnO1HQWdrHRBVIiB7B1UA2oqDC6wuX3k2V9VT+NBfoZ8+vPuE
fORE8ac9TTbLdFpJ3jVPjpVLh7Wl8gpeuW0ttwx4r4kYzmwkxbvj5MD4eL/qh+Qz
q9iXB2n60neRKIeLW5AXxxUmVYb4jQVgdfXmIuqCqlBvSKo57YE=
=NxUl
-----END PGP SIGNATURE-----

--=-PnDDO2ZJYhY9kyUVadu0--


