Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00ACC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A50206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ws4QkSxV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FGLerTMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A50206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qPH-00082c-Qa
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=4159a14019=amithash@fb.com>) id 1i8qNm-000785-4B
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=4159a14019=amithash@fb.com>) id 1i8qNk-00069Z-VX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:33:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=4159a14019=amithash@fb.com>)
 id 1i8qNk-00068k-Gk; Fri, 13 Sep 2019 14:33:20 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8DIUPXT027226; Fri, 13 Sep 2019 11:33:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 mime-version; s=facebook; bh=5Kw91oFuRjtResEKubaFgFlxo/C38FOGLcB+noiiMj0=;
 b=Ws4QkSxVOW6JQaDObQtmb+0blekrB0npJ8DP2izp+Ya8G9AY9m/7HilBKAzKGUhq4ITk
 Zbt+dnmrD43LS49DOKM47IJukXVF44v8Pqb5vmBrCTWF8TF0JsDaS4htv2xiYXIRwb8/
 1MKMB1cW9xDEkGqGO6aUzt+SHuCemID2pmI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2v0ev4rgr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 13 Sep 2019 11:33:07 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Sep 2019 11:33:05 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Sep 2019 11:33:05 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Sep 2019 11:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0RqyPc5UdoPJyovWx+mEWnEWx65jqAs5jVwSGM5c41GaHy/IOZ5q8OCOsoz6QqTCreIDkKUQS062DzR/21zqHdiiimvAox2kRh5yclfOAULp95aL5L0U4veq1zzxxX71qRurl5rrMrzZOi651ifMP/egND/UDHY1aNDcZ7jqFFBjqpBFQ/SjMK9IDuA4QzxYdwqwDvc5Clq4na3dZfUIctWd8O/4eHZYd03ctzs+/mK+LHKgD11bM/XnZh6wQhGmvDNM2zm/cNZYDb4FCi0QcR7632zTMrjCusdtEM6L0P/AFt5rpkFmbgW+Xjfw4QQQJNx/XC2OE7Qn946ubH/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kw91oFuRjtResEKubaFgFlxo/C38FOGLcB+noiiMj0=;
 b=O6T+8ZHiJWYbZZeH+X4/4WtdrQ57Z8dDTenAD+Shm0H5oLBrOavLg5bWDfUx4S3ljG/72SKaMOSvKJSD0voO36+03iteHTn18a+KvsN6NEJl4LM2W2efy4etdobGWgsIwOSuI5p3PmKHNYifPMs/6GYeZzN25TOhVKhEygbzbX9eWDv7Rt+HuT5DElOUnFZgAXwbO4iUbAmqTP7U18s5XHuuVOq0fJUcaqSNNHRmDZf/QvpXFyYH55j1tNzBNPlVFDun6M01thfGgSWJXImy8d9qn5nlVf9TaPxmeKco9sIsBmTljZkenAR/DTsx013OD6iWs5dGBTiaunLj6p/VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kw91oFuRjtResEKubaFgFlxo/C38FOGLcB+noiiMj0=;
 b=FGLerTMOgOLZPTZD53fFM6ROPaAl0iq73AFVv/LQxXrvjFCrqH6zc/wdMr0hmEjXvS2UN6Fx14w7AzZGVEGw3+a+zrfNkyEMy7F09JSmM0W1dCKvMZE1y5XNept6FjNrsmwh1Z4v+4XjnNREXojobdhPYeOSIDE5VdfVtFS5W9s=
Received: from MWHPR15MB1486.namprd15.prod.outlook.com (10.173.228.145) by
 MWHPR15MB1824.namprd15.prod.outlook.com (10.174.99.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 18:33:04 +0000
Received: from MWHPR15MB1486.namprd15.prod.outlook.com
 ([fe80::35b6:162a:1a68:d3b7]) by MWHPR15MB1486.namprd15.prod.outlook.com
 ([fe80::35b6:162a:1a68:d3b7%6]) with mapi id 15.20.2241.022; Fri, 13 Sep 2019
 18:33:04 +0000
From: Amithash Prasad <amithash@fb.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley
 <joel@jms.id.au>
Thread-Topic: [PATCH] Check correct register for clock source
Thread-Index: AQHVZE/kN0xuphW6Tk2ioNhgk1tZ5acd2OkAgABnUwCAC7E9WQ==
Date: Fri, 13 Sep 2019 18:33:04 +0000
Message-ID: <MWHPR15MB1486EA95E701C24117C48148B2B30@MWHPR15MB1486.namprd15.prod.outlook.com>
References: <20190906011010.1135084-1-amithash@fb.com>
 <CACPK8Xds26gq=e=7D9qtPJ4FOvhHb0Q-_Chj_MFHcWO99EBcwg@mail.gmail.com>,
 <773184fa-ade7-f1f8-491f-b2c0b16b5a9a@kaod.org>
In-Reply-To: <773184fa-ade7-f1f8-491f-b2c0b16b5a9a@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::36e5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bdebcc2-b2b6-4527-b75c-08d73878d0c2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MWHPR15MB1824; 
x-ms-traffictypediagnostic: MWHPR15MB1824:
x-microsoft-antispam-prvs: <MWHPR15MB18243B91E9DE0203DA3B1D04B2B30@MWHPR15MB1824.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(54906003)(316002)(6506007)(110136005)(74316002)(99286004)(186003)(476003)(478600001)(76176011)(66446008)(19627405001)(64756008)(66556008)(66476007)(46003)(5660300002)(486006)(66946007)(52536014)(256004)(2906002)(105004)(7696005)(14454004)(102836004)(6436002)(8676002)(81156014)(81166006)(86362001)(558084003)(6246003)(8936002)(33656002)(25786009)(4326008)(11346002)(446003)(6116002)(7736002)(76116006)(71190400001)(71200400001)(54896002)(9686003)(229853002)(55016002)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR15MB1824;
 H:MWHPR15MB1486.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DSQZs2ZF9ucgrz3b5/P8SqZWivSqqum47ojUcTyoBM72TgHNNsWrsnBx+5EFCSKvF+wCbrJyaX1nM7qRG9UaF8ztGq8x6sZyKeYSIK54hCzBkSjIUgh2RaegdSiPREwQRxDxVJeK3AqhUpUToN5OuVkEWmIUkzvvoVgyw7g4s4AsEASj6coimUxrMdWZTgETGKgWuKXe84gFt6MAwhhtzRg8pQnMbt4Ww7CBMDBPq3lEjXF7ZGwFKpoMqnLl6Ajj71NQxMa9B6J2znWKkso2dT+43rY3Zpd2uUum1wxHjPxdNv81WEbUp91NPO9yBP9YfVk0amzKW1Ll0Rlt2pEG8IgKwyYK+uhUdmNLSwQ6H5rfyeYjdcrDViR+lrUCorSBGQSrwqoQBHI4wntv3wZrFsPsyl9cNq+P55mL6X8sHk4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdebcc2-b2b6-4527-b75c-08d73878d0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 18:33:04.4847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU+kiTk2ceQc+iimE+l0RC1+fNzRCgej6yUjLMbpSj6dn+6GWS7CoeXIShddoFVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_08:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=748 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130188
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.145.42
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Check correct register for clock source
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>  yes. I have pushed it on the aspeed-4.2 branch but it can go independen=
tly
>>as there are no conflicts. I changed the title slightly to reflect the
>> area being changed.
Thanks! If required, I can change the patch title and resubmit.
