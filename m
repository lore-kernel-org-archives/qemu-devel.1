Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A281FC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE7B2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J03w48Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE7B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgBj-00026l-1P
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4j-0005eg-97
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4e-0007sk-Sn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
 id 1hdg4b-0007Yc-NE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJ8ZxT074719;
 Wed, 19 Jun 2019 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2018-07-02; bh=NkXgzSdPzOVUZDNJyEcRjrNqZpjA81OtuuhO4YYVHbc=;
 b=J03w48Zkdx31N+VWxi3Ik1ek7fpOXznc946KeabxUzjy97jkH6MtNJKa60uJUS7YgcMz
 QtOVlg4MEfY/YcU++S3I0rA6pUjafAy2EXy1ijpqM0sbX80burpFehtxjXLsX1oieMtd
 cSn7rKbxDPkgHKM9Yuq0eJj+2uUt7QiEBF5LI9jqpzQg26r5ZLdeVBkLCZYSlOTHuTje
 HcLkGMaIKEngrfWM7YuhjH6oeHb48wYw6dy3n0bqtb85ZvlBaBobCdEmw1Jg4CILNOBy
 uJAZnB8E1LlFaA2PnRlO6cMnUgRyjdVGSVi8rJ9Mf1J1xWNxWe2MXlA8hyDuNyhGRn29 nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2t7809d8rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJFEoa094497;
 Wed, 19 Jun 2019 19:16:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2t7rdwtkvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JJGSkQ008841;
 Wed, 19 Jun 2019 19:16:28 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 12:16:27 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:14:46 -0400
Message-Id: <6b19cb7359a10a6bedc3ea0fce22fed3ef93c102.1560806687.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1560806687.git.lidong.chen@oracle.com>
References: <cover.1560806687.git.lidong.chen@oracle.com>
In-Reply-To: <cover.1560806687.git.lidong.chen@oracle.com>
References: <cover.1560806687.git.lidong.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190157
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 x5JJ8ZxT074719
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [Qemu-devel PATCH v3 1/2] sd: Fix out-of-bounds
 assertions
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liq3ea@gmail.com,
 f4bug@amsat.org, armbru@redhat.com, lidong.chen@oracle.com,
 darren.kenny@oracle.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 amarkovic@wavecomp.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to an off-by-one error, the assert statements allow an
out-of-bound array access.

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaab15f..818f86c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates st=
ate)
     if (state =3D=3D sd_inactive_state) {
         return "inactive";
     }
-    assert(state <=3D ARRAY_SIZE(state_name));
+    assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
=20
@@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
     if (rsp =3D=3D sd_r1b) {
         rsp =3D sd_r1;
     }
-    assert(rsp <=3D ARRAY_SIZE(response_name));
+    assert(rsp < ARRAY_SIZE(response_name));
     return response_name[rsp];
 }
=20
--=20
1.8.3.1


