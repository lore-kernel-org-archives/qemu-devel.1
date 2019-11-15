Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34D3206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D3206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdyJ-0006LH-I6
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVdwX-0004gw-Ei
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVdwW-0003VS-1P
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39990
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVdwV-0003VE-Rk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:55:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFgT76070904
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9nv9ndxh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:55:25 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 15:55:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:55:22 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAFFtL8M50266276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:55:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8047AE055;
 Fri, 15 Nov 2019 15:55:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78B53AE04D;
 Fri, 15 Nov 2019 15:55:21 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:55:21 +0000 (GMT)
Subject: [PATCH v2 for-5.0 0/8] ppc: Consolidate QOM links and pointers to
 the same object
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 16:55:21 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111515-0016-0000-0000-000002C4027A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0017-0000-0000-00003325AAFA
Message-Id: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1034 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's a recurring pattern in the code where a const link is added to a
newly instanciated object and the link is then used in the object's realize
function to keep a pointer to the QOM entity which the link points to.

void create_obj_b(Object *obj_a)
{
    Object *obj_b;

    obj_b = object_new(TYPE_B);
    object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_abort);
    object_property_set_bool(obj_b, true, "realized", &error_abort);
}

void object_b_realize(DeviceState *dev, Error **errp)
{
    Object *obj_a;

    obj_a = object_property_get_link(OBJECT(dev), "link-to-a", errp);
    if (!obj_a) {
        return;
    }

    obj_b->obj_a = A(obj_a); // If obj_b->obj_a is changed, the link property
                             // still points to the original obj_a that was
                             // passed to object_property_add_const_link()
}

Confusing bugs could arise if the pointer and the link go out of sync for
some reason. This can be avoided if the property is defined to directly use
the pointer with the DEFINE_PROP_LINK() macro.

This series just does that for all occurences of the fragile pattern in
the XIVE and PNV code.

Changes in v2:
- use DEFINE_PROP_LINK() instead of object_property_add_link()
- dropped public -> private changes in type definitions

--
Greg

---

Greg Kurz (8):
      xive: Link "cpu" property to XiveTCTX::cs pointer
      xive: Link "xive" property to XiveSource::xive pointer
      xive: Link "xive" property to XiveEndSource::xrtr pointer
      ppc/pnv: Link "psi" property to PnvLpc::psi pointer
      ppc/pnv: Link "psi" property to PnvOCC::psi pointer
      ppc/pnv: Link "chip" property to PnvHomer::chip pointer
      ppc/pnv: Link "chip" property to PnvCore::chip pointer
      ppc/pnv: Link "chip" property to PnvXive::chip pointer


 hw/intc/pnv_xive.c   |   21 +++++++--------------
 hw/intc/spapr_xive.c |    8 ++++----
 hw/intc/xive.c       |   48 +++++++++++++++---------------------------------
 hw/ppc/pnv.c         |   32 ++++++++++++++++----------------
 hw/ppc/pnv_core.c    |   10 ++--------
 hw/ppc/pnv_homer.c   |   20 ++++++++++----------
 hw/ppc/pnv_lpc.c     |   19 ++++++++-----------
 hw/ppc/pnv_occ.c     |   20 +++++++++-----------
 hw/ppc/pnv_psi.c     |    3 +--
 9 files changed, 72 insertions(+), 109 deletions(-)


