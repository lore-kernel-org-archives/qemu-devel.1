Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE7C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2449D20678
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwn6O-0004Tt-G0
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1iwn5a-0003aj-3Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1iwn5Z-0003CX-25
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:09:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31020
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1iwn5Y-0003A2-Tb; Wed, 29 Jan 2020 08:09:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00TD68QZ050471; Wed, 29 Jan 2020 08:08:59 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xtrmbacn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2020 08:08:59 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00TD7Teg054816;
 Wed, 29 Jan 2020 08:08:58 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xtrmbacmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2020 08:08:58 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00TD5GIL004666;
 Wed, 29 Jan 2020 13:08:57 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 2xrda6t1yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2020 13:08:57 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00TD8vt151708380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 13:08:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19BCD12405B;
 Wed, 29 Jan 2020 13:08:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 078DB124055;
 Wed, 29 Jan 2020 13:08:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jan 2020 13:08:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 1/1] tpm-ppi: page-align PPI RAM
Date: Wed, 29 Jan 2020 08:08:45 -0500
Message-Id: <20200129130845.1886915-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129130845.1886915-1-stefanb@linux.vnet.ibm.com>
References: <20200129130845.1886915-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-29_02:2020-01-28,
 2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 suspectscore=1 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290107
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 00TD68QZ050471
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

post-copy migration fails on destination with error such as:
2019-12-26T10:22:44.714644Z qemu-kvm: ram_block_discard_range:
Unaligned start address: 0x559d2afae9a0

Use qemu_memalign() to constrain the PPI RAM memory alignment.

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200103074000.1006389-3-marcandre.lureau@redhat.com
---
 hw/tpm/tpm_ppi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index ff314592b4..6d9c1a3e40 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -43,7 +43,8 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
 void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
                   hwaddr addr, Object *obj)
 {
-    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    tpmppi->buf =3D qemu_memalign(qemu_real_host_page_size,
+                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
--=20
2.24.1


