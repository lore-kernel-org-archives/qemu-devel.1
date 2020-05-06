Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFBC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301EE20747
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a2UAsIzz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bQsyeoTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301EE20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOSf-0001Fq-9m
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=2395c42e42=amithash@fb.com>)
 id 1jWORa-0000fh-Bh; Wed, 06 May 2020 14:06:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=2395c42e42=amithash@fb.com>)
 id 1jWORY-0008Mi-Vz; Wed, 06 May 2020 14:06:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 046I1Wh0013357; Wed, 6 May 2020 11:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BZpcr1OmRPGGLUQxtaBASSLJZJ7uo6xxzrYDD4zk1r4=;
 b=a2UAsIzz+sobPM/led+dU5wJm9NPDsKHW+T8aCdqE0ERgngnl0rEwjRMWP+oQsieS5EJ
 5kxHIzhFXfOMnTCEmiQllpi6ewRS+jC6URJGpQicDNGmyNR2h/hjrdMAj6R9Ersk+RI7
 ns1taTMYNYEPnXjdzTkmB49Rg3/fHpgivaw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 30srvqamaa-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 06 May 2020 11:06:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 6 May 2020 11:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGvxWH3ZCFRMDc+/ZD6+bCVKkQKuf8IAacHQa3VIgkP91KlGSjkbFI6zbIoHPCfIUDxl4JuzFK8oJEMY13eYvJ7VXu2fpVVjGs3DByOzEmaYTXIDMF1jEfrWnFm1Fi2GDbDVglnU/e9b0v5TQBN9h3++inPPCb2eOnrR1mXkltEa8mq37iBWpE9IY0ZfDP4S090QRkThKMSYOImDbmtwpv4B2OZocMVONfcx2VsBffHJPe9MyiM4U4OHotC0wXNkz9kXTWxbEqaIVocOLb4Eus/a0lxz9AvC95A6MJVuzNJhSRjg9xFWkZMzavTu/E7J+D7TrUTlPkIyQ22UANunhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZpcr1OmRPGGLUQxtaBASSLJZJ7uo6xxzrYDD4zk1r4=;
 b=gfZ/7IXaAvOFHqb6PkN6BGGFRm4Bo3QoF6KllSJq/F0QaMCaozywV7O/oyMJAYYSvdhh/kfC0zuWN6r2IT5p1yXrmkncDyWUo6gj5jzp2vOnjVopIxAjAwDXvQsEBPS7vPpoTA8+Y9/Uy8/Ep7vnL2KQ35jDNVbqVvCBlvJotAJcp0tDIdKx0HdjeIWOsoRiet/leq1z0P2bFo8kg+uRz1AAdMNmY7oaDWB2hL7eEde+uuGxCFexKA6hkfUu/AxLv8ZH/j2UshiQgDlYrL1xz7zDmkjJmpIoXO9YohWVcVmI8qDs917ooCE7C4MsdUVCmyzJp2vvd1qJq7jAB6lIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZpcr1OmRPGGLUQxtaBASSLJZJ7uo6xxzrYDD4zk1r4=;
 b=bQsyeoTt7yIIL4Z7/vp8Bl4XxdzsCT279mmDgLJoEBvAR5ckNg3iJKD1nDvV1cJSS1c8i4vc2w2kle68atiO5wrGXKuh59PaIX7MzuTp9EJzDtXIWfUvPi/XTmKH56J8aTM52etFz/wsDH8qjYn4KmEsDjYJAfO2/3PvPdanKPg=
Received: from BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30)
 by BYAPR15MB3013.namprd15.prod.outlook.com (2603:10b6:a03:f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 18:06:34 +0000
Received: from BYAPR15MB2823.namprd15.prod.outlook.com
 ([fe80::11c8:398b:561a:3474]) by BYAPR15MB2823.namprd15.prod.outlook.com
 ([fe80::11c8:398b:561a:3474%4]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 18:06:34 +0000
To: Patrick Williams <patrick@stwcx.xyz>
CC: Vijay Khemka <vijaykhemka@fb.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] aspeed: Add support for the sonorapass-bmc board
Thread-Topic: [PATCH v2] aspeed: Add support for the sonorapass-bmc board
Thread-Index: AQHWI8wWAhkDgtx2AEqQaTNeQgpFP6ibWecz
Date: Wed, 6 May 2020 18:06:34 +0000
Message-ID: <BYAPR15MB2823122DCA19E2E831257DD6B2A40@BYAPR15MB2823.namprd15.prod.outlook.com>
References: <20200501113704.2240698-1-patrick@stwcx.xyz>,
 <20200506173035.2154053-1-patrick@stwcx.xyz>
In-Reply-To: <20200506173035.2154053-1-patrick@stwcx.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: stwcx.xyz; dkim=none (message not signed)
 header.d=none;stwcx.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:bf67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f46b3be-9bcf-46b5-519e-08d7f1e83652
x-ms-traffictypediagnostic: BYAPR15MB3013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB301357C3418DE0328D7B0E67B2A40@BYAPR15MB3013.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqqc9XM6Ar6exrvthnPX//esv/Yhyz4+0izlOgJe/c/nt68hTGJZjKQFmQ0ejQ7smGqeD/syjhmxSKZvl9+dop2luxiy4w2hG2Dl+JzNUNg9dL9wYZrnCFNkSTKtMAuBQ75+Hy1Hvy3kObvsuW0dBGkGRKviweA0qAKGvY/0DYS5GN2O2SqYFEvrg6YU36W0VCHuBcf6yMtII6900kiZVRlID7sM7UUcsKE9Gy/ETm6Ok0lc1F3VUv68d99xz1K+vV2S8S6ackBvLH1ySO5wEyCroRjIfpRubwg3LH588y2nhN55VR6ewFGrMWvGenMfaMECZWskJF28bfiTyBcvnR4SHku0snIvXkHEyiwTSyleFQORxzudidAf+/wCAKjz1/nXQP74dxf9y1ToAxJv2gKt5xfXTN9Mxchsl1639sZZXYK9r4blbjXhL7SfgBkBDMeZuIow61LGBXt8JOjvQMeVLZ21uVeeRk24VadGFzla3ZYD9/drb2kfkgpy4f4KigZq8W6ZSGrVz/ohzY/EMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2823.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(33430700001)(33440700001)(558084003)(66946007)(52536014)(55016002)(9686003)(76116006)(8936002)(316002)(7696005)(5660300002)(2906002)(478600001)(4326008)(186003)(86362001)(71200400001)(6916009)(66476007)(66556008)(8676002)(33656002)(6506007)(54906003)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: FqLjOSU593KxZPTP7Yl2kWy0FsEIkl4LzLwpP2s+s4U+roINmVi65ukfbeRBEhcdMx6/aRZK0uTX9+V4YtxkdwfEVNCNy/ZVmALiklvXGpFabtQl8MJnxBzW+OC1bCPeq81uW5GQvlPcO0SYr14cvsxSlTQF/CBotfdzQaZve74GOFX+PusmM/tkntlzveqj08nukybG40sh7spv3R3t5IpzQJEe4t6nLziPSL2S12+T8Zt2rFtVP7DD2oaSj/Bfxe+Lj0FrpPDcQmefQN58GLq4UVtfQ8jy1n3fW1B3HGrAoUAsugVeVvN0p8fO0b0Sg6qhCB39y4tWKdJNp25fpVryfYsrl3BWmUwLgB4KbgfTdGzrYNNaCBNyKg9bHs4SJdt/e6Z3F+MFAASy8iwffvXmTXVNP2pLe6hbx9pDCFJLgH+L0hyCCrqmlgumm7/Svfyf+22lK3pRPVbT8vXTRF7WwCPhI9dCLOp0eJsKYcxr/6JZ45zRp7hhtM4fcaQJur4dz9cpE9aXUe3bYiwq3Fm0bQ6b/TcQtEYXn0oc2xzp5FejmlW68rqFfl5gGXBoGIKPL2yST50gOQAgh+jRnSc9XdY3MCW01GhVC0NcmFEotb4YZbPBg8h2h/0J+vGafmqzBzSCGh6jzVlQYUJzUux/CjZyWvqvlgziqRTvQ2Mxq6rQ+v3QarbHwFap+x+p4BmFmE/gPUby9A/EiDTYzeMswBIuLdVhJSVtDweke9t/AaggicCm3UPWgWhtjdSrrIU/Y0qxnHLLhZt/jMKdf2xcHJyMEyEpTingcMTPls+543/PyEh3qapauPjDKYtfD9rOxSdaKReicD7mcerygA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f46b3be-9bcf-46b5-519e-08d7f1e83652
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 18:06:34.0706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9NMx+NbR6h3l6txyMtA8bgk79/V7vNCTw3V7A8tZBYG8m/Ezs31H1LU/CRBxUhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3013
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-06_09:2020-05-05,
 2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=641 bulkscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060147
X-FB-Internal: deliver
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=2395c42e42=amithash@fb.com; helo=mx0a-00082601.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 14:06:49
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIMWL_WL_MED=0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Amithash Prasad <amithash@fb.com>
From: Amithash Prasad via <qemu-devel@nongnu.org>

>> +=A0=A0=A0 mc->desc=A0=A0=A0=A0=A0=A0 =3D "OpenPOWER SonoraPass BMC (ARM=
1176)";=0A=
Open Compute Project?=0A=

