Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD26C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DC72166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="kOvavzNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DC72166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfMj-0001kq-Nj
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <torbjorn.svensson@st.com>) id 1hResy-00005c-5c
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <torbjorn.svensson@st.com>) id 1hResx-0002tU-9g
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:35:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18802
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <torbjorn.svensson@st.com>)
	id 1hResw-0002mi-LW; Fri, 17 May 2019 11:35:03 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4HFRWZ2014982; Fri, 17 May 2019 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
	h=from : to : cc : subject
	: date : message-id : content-type : content-transfer-encoding :
	mime-version; s=STMicroelectronics;
	bh=1XYccIoWwNLvvjGwJIeuX2Nqkml1hD9sAZKLIbJ7PrQ=;
	b=kOvavzNHikw0X+YPzsogx6ltjtm8u/D4VbV2+3DlTZ2yVDz/s3Z2ZfZZ1H8FqfHSSnoJ
	skDHwZlVo1t/y3M03j6xvDYyjrelzjI+/kS7t0M2fXs45RNwMQmyeWpjjTig8XSB8LDq
	CHOTqJ9yA4EQoibnet3s1iOdg0UNZ3jfzkeQAb2unf54PNADzqdd6r0olOXir/tCRxg5
	JvnZftgsUJy8GN8nXyv4l6bBowl7+4WMqKkFJNtcxqWDQPnp1sYX98tbDRlsp5qLTJPA
	H5i9KHwACAQmK6FH9Qw19Lw8EcKVm2WT6t+3hf1TxaQchD5/aEGf02tfvAEEg/6WD680
	Qw== 
Received: from eur03-am5-obe.outbound.protection.outlook.com
	(mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
	by mx08-00178001.pphosted.com with ESMTP id 2shvrj8yun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2019 17:34:57 +0200
Received: from VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM (52.134.28.152) by
	VI1PR10MB1968.EURPRD10.PROD.OUTLOOK.COM (52.134.28.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.17; Fri, 17 May 2019 15:34:55 +0000
Received: from VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM
	([fe80::41f:87d1:8ca:39be]) by VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM
	([fe80::41f:87d1:8ca:39be%6]) with mapi id 15.20.1900.010;
	Fri, 17 May 2019 15:34:55 +0000
From: Torbjorn SVENSSON <torbjorn.svensson@st.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Thread-Topic: [PATCH] target/arm: Fix broken VQADD and VQSUB causing abort
Thread-Index: AdUMxY0RShgfpEqqTEGIfg5CjmaqVA==
Date: Fri, 17 May 2019 15:34:55 +0000
Message-ID: <VI1PR10MB204723BF7D62501F0339242A810B0@VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd285210-a872-4790-cffc-08d6dadd3673
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR10MB1968; 
x-ms-traffictypediagnostic: VI1PR10MB1968:
x-microsoft-antispam-prvs: <VI1PR10MB196884393561B61B442BC7E5810B0@VI1PR10MB1968.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(6436002)(478600001)(26005)(55236004)(305945005)(256004)(2906002)(9686003)(6916009)(25786009)(3846002)(54906003)(6116002)(52536014)(486006)(316002)(53936002)(74316002)(14454004)(71200400001)(102836004)(71190400001)(476003)(99286004)(186003)(68736007)(450100002)(4326008)(6506007)(86362001)(81156014)(33656002)(55016002)(5660300002)(2501003)(5640700003)(66066001)(66946007)(66556008)(7736002)(8676002)(2351001)(81166006)(8936002)(64756008)(66446008)(66476007)(7696005)(76116006)(73956011);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR10MB1968;
	H:VI1PR10MB2047.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: st.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ynylTfSa4CdGb0q+FdIwq64MB+CNY9fSZVTbcE/PG1QQKDR3/dEUz9Duidba1iXL33kw8JNyTuw4F8VpnPKgmyXRI50j+zYUbKyRuNIRRxzAjtDDZJhaFUy0LfomfLbN4hi8BHmMI/ySM+YjqLpX984KCceEvrTffMHPhF3VB79eLqtxKfrUw4KbuLuTB23IOALyMPgz0riKb+rClaBwnOd1TyyS+cTIJiGJ1TFy44cQeD5ZexVokJtwN9NbPeJqrWosuprAFQ1JDyElf03mVCGkXWlcWDk6luPftzWJ5/d2l0IoaZ8BZf9BBcf9PJxj3ebyeHZj0R+NsYQy/2JX1035IUSBzE8sHyMvQDCRMxrMdjsucb0AdhCQ6UsPUZWYDAuyIz9RvxrO6fVqM0+x1nQVa4JiYKCRNpRkmY7GU40=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd285210-a872-4790-cffc-08d6dadd3673
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 15:34:55.4831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=754
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905170094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 91.207.212.93
X-Mailman-Approved-At: Fri, 17 May 2019 12:04:59 -0400
Subject: [Qemu-devel] [PATCH] target/arm: Fix broken VQADD and VQSUB causing
 abort
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel HULTGREN <samuel.hultgren@st.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 89e68b575e138d0af1435f11a8ffcd8779c237bd, the handling of
VQADD and VQSUB was changed for Cortex-A and the new handling does
not return properly after calling tcg_gen_gvec_4(), thus the code
after is executed and that does not know about the VQADD or VQSUB
instructions and calls abort.

Detected running GCC testsuite for Cortex-A7 and executing the tests
in QEMU using Cortex-A15 since Cortex-A7 and Cortex-A15 have similar
instruction set.

Signed-off-by: Torbj=F6rn SVENSSON <torbjorn.svensson@st.com>
---
 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dd053c80d6..298c262825 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6598,13 +6598,13 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
                            (u ? uqadd_op : sqadd_op) + size);
-            break;
+            return 0;
=20
         case NEON_3R_VQSUB:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
                            (u ? uqsub_op : sqsub_op) + size);
-            break;
+            return 0;
=20
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
--=20
2.18.0


