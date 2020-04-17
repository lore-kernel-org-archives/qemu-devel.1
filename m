Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B55C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB13020776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NsTfnGV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB13020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPT4n-0000wS-P3
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPT2Q-0006SP-B0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPT2P-0000K6-1R
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:36:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:13192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jPT2O-0000JZ-Sm
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:36:16 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03HFH4j9025357; Fri, 17 Apr 2020 08:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Zx6DW8XfIoaafZ9bhfr+phsKpweVUfwTa5Pt2eBkmPw=;
 b=NsTfnGV5Z5VdXHkBSe6fS1hPt+8EDFGFw3fGfx+WLpROIOzdXqSUoVAky/2AntByuoU+
 D20GZxEO7ESoQBDpd56wV/l7sdbLdHtmYGmmv37PU3bUCbblYPBXRO6r4qz/nVeVwr0H
 6t+btDxBT1y6fffxvEkke8scmuKyYR9Fz3P/bxzlxZDiN+cq1aEudXyWu0wI9MQnvfwD
 3KCyNySf7PWN4/grp2emLjBU5pWy0iDLE+qhcArCr83gFau/IetEpNNrwZlWAUMvpOld
 p2egfxoihD86lyNZR47FYXEamsqYznMKndXMdNNRP/kQhyJ18/zCpWJk5C2vYTYbDjLa NA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30dn8ey8kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 08:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM4lp9izhlvVVODxdIuUdXkTex0qdJcnYhQIydaCk4ChXjbF3IJtem4cQ3FjTeReKBU2wXXI1bbWcUIHk52lSGbJ7Hh5UjooBMIvoFA9EDKLA+Aqc14uuAbDZuKKXqz59JYoz6LfuRhQ+Oet7JLzAyLE+TClMxPCgUK8qm8s23nOfcRH/mE7s/GIyqpAix7MkyNj9pIiLUufGzNeP7ikUiX+YZXqbv7yjSCQ3XJpTq4ih5rQ5pecOyc/cX/JSqQYkzHJhXYWsU/gDDEhgapWK2gqkYWU7b1klDNMjdHdt4edFk2HkgHAp2TzMBwT0nLfwJVLv6yryj4YV32gRhIOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx6DW8XfIoaafZ9bhfr+phsKpweVUfwTa5Pt2eBkmPw=;
 b=Kam2BQDkM4Hlp3YTAB78cD3wD0yZBfmAn32X6Z7aw0bEiRBKXR1W3mfIw8OffPXDB5EWmjTAX5XMWDmDk0IQWoe/CCSqNjXDj78uNp5e6IecosijMt8hMSBrTPxBpMRSIk/VV1gQcOcmBBjNcmtN7zdcVI817LDN0DTYyBa+0wznUnEHfIG5gPbWFTXWB3t4PlOije3guFU/78BwxSluQwUvdATZjZCYeqXC3lnS24diDAjba/FNlB4emXL33tyPfAHJR+T86+6Cko8lOF4pPi1M/RMu0xhmDZQNvswH2P3D0k+Eq49mYYSLNt/Vyz9xxpbjMNwVqjOmJD2Awle8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6605.namprd02.prod.outlook.com (2603:10b6:208:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 15:36:14 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 15:36:14 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaIA=
Date: Fri, 17 Apr 2020 15:36:14 +0000
Message-ID: <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200417112620-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 301bfc35-4f1e-4d7d-db21-08d7e2e51055
x-ms-traffictypediagnostic: MN2PR02MB6605:
x-microsoft-antispam-prvs: <MN2PR02MB660595E7E6490BB9BC3D2F99F1D90@MN2PR02MB6605.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(64756008)(6506007)(53546011)(316002)(36756003)(186003)(54906003)(6916009)(33656002)(44832011)(91956017)(66446008)(2616005)(26005)(478600001)(76116006)(2906002)(8936002)(4744005)(5660300002)(66556008)(81156014)(8676002)(66946007)(86362001)(4326008)(71200400001)(6512007)(6486002)(66476007);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIomDbeLzBjZeJd+AJ4ULWBBEwiWOi15BIMDC1/fqUSNZLtbjNZe2jc0IIPwpucFMbXHmXt7Ve9Kjzn9WfRoaclHC65ufs/clg3cj6UWz1w2+5eSIpwYU6GEzkhIQto4B92X0tEXnPxMzA/sQmQUsjWkP7kmnPfySlbCIrP4GYca34x7r6ZPnTp+jN1ainDtWTO+GTim7UF9RwcnStkzUH58Vrko/wLmSpmP1VFff7srjUVJpDKL8zVWi0IpX4PQPUYzy3i0b1qx6LzlsHWPjiSFtSTm7nVJAUw2c5X8l4ZlHk52y6/mvoUno8kZxe1FHjxjs5z0rvHZ7+jXWoKROG8rz4MRJ338+fTdMpbdRt0XVGKS96QVK0nXBKSlJedmmBdkTpWLEWvLSFNS+9fAiW2oz7x41RrQVQi8uvZ4VAofSyZTeQGMSLy+Up6BhupJ
x-ms-exchange-antispam-messagedata: 8oYDs6dBDO/GgyIBMZmNOe7EN32V8fhVb57YcAytrODkHS2vOKhF13D5JcEaz9wgRU8EfB4P2Oxh1/OsgHPN/n/sqgl2IC+8mkj+pXLMqWQ5UiDPEpNLNMMM+u0YvxI3PedKpP2XR8PHhV/rhXRBNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71A32F98C9571744A149C6538EE30183@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301bfc35-4f1e-4d7d-db21-08d7e2e51055
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 15:36:14.4035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01WJ7dzA96OGbhEsl2NU8TtnLnsZBiyY0V61BHfCVS9n8quxu5aNO/0w4625tCoo62wfUEvQuOZ3eMZTmbtVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-17_06:2020-04-17,
 2020-04-17 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 17, 2020, at 8:57 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> Is there a real reason to do this? Can't we just limit the
> hotplug control to pcie ports? At some point I'd like us to
> start leaving piix alone..

Yes we really need this feature as want to be able to hot plug devices into=
 the guest but prevent customers from hot unplugging them from say Windows =
system tray.

ani


