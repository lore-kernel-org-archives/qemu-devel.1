Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF546C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDE122245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ypegr8hO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="H7VYL+8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDE122245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeeH-0007UL-0J
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZebB-0006He-Ap
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:30:33 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:49143)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZeaz-00082S-8A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604341821; x=1635877821;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=7n/C3Q+HjHfI+HCWjwx1DB3qcwjrw8+zCZeMpwhZVwU=;
 b=ypegr8hOgpS//X1MfFRPo8EPh6POpwz2lbB7wolDZbwUrZHgtEIxveoj
 3kYLVUXFIjJCSfyKHmJlvVdSVApG0U1pyzjAnv94nuOS1i5y3QhpkicLe
 8BhyVQw4ysh0lMmSe5d46kQMi5SnNr4wRwRQ7KogxDkMzLpyZ14AQI6+b Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Nov 2020 10:30:15 -0800
X-QCInternal: smtphost
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 02 Nov 2020 10:30:05 -0800
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 10:30:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 2 Nov 2020 10:30:03 -0800
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR02MB2670.namprd02.prod.outlook.com
 (2603:10b6:300:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 18:30:02 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c%7]) with mapi id 15.20.3477.035; Mon, 2 Nov 2020
 18:30:02 +0000
From: Stephen Long <steplong@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: linux-user/elfload.c: Seeing a segfault in qemu with a binary with no
 data section
Thread-Topic: linux-user/elfload.c: Seeing a segfault in qemu with a binary
 with no data section
Thread-Index: AdaxRVDe+MdaD6+YT3i9FplTxX2tug==
Date: Mon, 2 Nov 2020 18:30:02 +0000
Message-ID: <MWHPR0201MB3547611C45D39E28B0377296C7100@MWHPR0201MB3547.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [2606:6000:cfc0:2f:41ec:6160:7613:734c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e808faec-c2d7-4c50-da1e-08d87f5d502e
x-ms-traffictypediagnostic: MWHPR02MB2670:
x-microsoft-antispam-prvs: <MWHPR02MB26701DFA5768DEEE2D0248B4C7100@MWHPR02MB2670.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2xKsOUpCLMkdftWY9ae8pulxS3ioIF0MoWZfXWWP7nPx+dVWDBsfVG+9HwSJ9jtM+rkYjeG5+JU+XBptomEReDtZF6aMmZrMDku9VrO4eRb59pz59ugsiu2Z9Qt/zbouhfaXVkZL0MT9DW07K1t67XDKBALn7yOz73+xTnTXvEgAen64/ZWc+Et3cU5fK9DMXgvef0187V81Bxi84cynHCsl6mCYWpkcDTkXnrrXKjYcoxqNLqHKOFG7YgypVIetRkFytuL1VeEI7lIt73GLzN2BK8iMW08u3dPC5lzL8UEmmyTNLlZ6ZPkUwrBrwI6gOy5v7aJKYsJ55t9a/i63A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(71200400001)(64756008)(66446008)(66476007)(5660300002)(9686003)(55016002)(52536014)(2906002)(66946007)(66556008)(316002)(478600001)(4744005)(76116006)(6506007)(33656002)(6916009)(186003)(4326008)(7696005)(8936002)(86362001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ko2/Lt8y+SSd+3aRdrwbFCYk/5Q4cV2RpLm9mqmGwb/EI+JordrZhIL/YxXtPtMjMWshjfi0k3tewJ8CwaFnw0glvDU7BrYZ+6hTsBdmHgvqj2Knw3Dznz57jrDATx6MB4kdOXT2H6DJ8yzqc3zJS0D8yUkFEEfadGvTNXXcO4y54x5nAqvZxqGKJ/D/HnBottD+mr0VlsZAxu0bShUjxT/9uP8oer3/GeZFbYJBgxUkaJUDbOT6yUoa8GSm/UotgYOgRZ+ppE3D2kKd6LNxdhpw6tR/iuDLbRYFJrC7MlobeKa9EjZ/xGp2GVy0z0ndGmDpK0mMIPEwpkVUSnVSLMus0nyqKmMiTIrI1a6EmosWwCzeqdZneo4hLbItp4bMKOpATvb37UehlvQ3mJRVyrJi2Sni+Pqb29H9nDOvb6n+L5m2TvSwe9tNFx42dLJ+wnw6D8Hcr7yf1BJKeXmdyF/ILkJ1uXS3wDPLQCzOGVHNYPwRxW8sWHYRvTB4tkFagS0Nc0zUxa4DzjXYzGb95B5dxUDs1I2A2GYeWPDUb/5cMlEWH8xGLJ36+XGzSpsWsnlFIPS2HU3Q5zYomintzyx4an9pbpp0e5d1Ny2QutdR1sy9769zaD2CwqvvEkj2YDlf10+H9P1AMm4gNKDckY0F7QNXe/zwjW6m+BMZXPlRRUHO71hCAMhyaPCPayqyo/xoPKFwekYlqkCxrIA6Fw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIqscf0Hfoo9gqpimKDnq2HnbTQwaiauiVfdczlZPscRIoR4ZO5H2pWgQD208N8Qo9vIJ1YlTJ4rNUicZGqehawyYOzqnAD1T0ewle6iMxg9vH2eWnsrNxYUYvPW8jdfLS5hGQ5YdAPkV0Bx6CuwkiHq0SJpdovPe1ejJCA5ObnAsuMMxwMfUrl0Ab/3JCX5xrCyrbF8fH668ktLMrwKQueeM1BaTeEDLxBBj2+dDe48DeXBwYt9Z6KC/WvrHvaAhCNwNa8v0XRztEfumGvXQ1NxgFzxcQ8Ma0mmbRKQleOQJt7FHlL5uNSLDK6zJaRoGFfB2Q7TiMp0NrVqh/DdrQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88PgKi/CQOm5gc05jLsyONPUo09xMYLCk2WitwEWTSk=;
 b=fvOI9QFb2WE9K7/rmAKnISY053cTtlr95KAadLUQTU2cSfxcWFiMrWn5RuK3tY4BWSnYHVVCe5lDnUF2dgF7iXI8HzAHrXDnYcShHZYSRLj1udJtCJjMcLetBUFYY2C1wdcDUKm/cQt117VqIM/S7OoKKF8Hwtb0p2EkcmkgUTK4QIdO9z6LZ57xU6IBCw3pdE3u4M2BeNmUrZ7GuGZmtlWlxmGifCti6BYAYEYTEHRTJU6nlkZAsn/Uu+wnkjFMdOrDq6a2CpPX36vbuA80oUNG11jAOcJHBl9pFR48k8A9JOMm3517y0yVNrqHyK8yJ51j43WDqOG7tJiS4betPg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88PgKi/CQOm5gc05jLsyONPUo09xMYLCk2WitwEWTSk=;
 b=H7VYL+8DXObWcce/WHmZYbvrM4xMAsFsify8FKKBiHqJOUEJU2YB1QyigYXbBrVmY1tgE3MSvMIfbwOX53HKcjO9toY/pkfaf3KfMGorDlntRyg4uPeqG7jaLeW+jDdY6fSW4j5ynYLQdfF2sFFVELW97ooD+5bREVTbXUhsn4Q=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MWHPR0201MB3547.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e808faec-c2d7-4c50-da1e-08d87f5d502e
x-ms-exchange-crosstenant-originalarrivaltime: 02 Nov 2020 18:30:02.5319 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: UAXtOWLXJ5eeTuilwFyp2j/a+XITFte8W7H9WN7dvpTLsOpsAbzsQPC655wOL2I15mWujFeg3dUnk1DNcZcFtw==
x-ms-exchange-transport-crosstenantheadersstamped: MWHPR02MB2670
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 13:30:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, we are seeing a segfault in qemu in the following code snippet in zero_=
bss():

if (host_start < host_map_start) {
  memset((void *)host_start, 0, host_map_start - host_start);
}

The elf doesn't have a data section, so host_start isn't mapped. I'm not su=
re whether this is a qemu issue or the generated elf is no good.

Thanks,
Stephen

