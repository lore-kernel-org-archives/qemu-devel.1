Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFBC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCE920644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MOAWksyL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SWFC4c0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCE920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ5F-00031w-GT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:10:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3k-0002KV-7w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3j-0006zI-C6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3g-0006x4-IB; Tue, 30 Apr 2019 16:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654957; x=1588190957;
	h=from:to:cc:subject:date:message-id:content-id:
	content-transfer-encoding:mime-version;
	bh=RyYTPhB4Jg33CLBqxfFmZhjvr5CIq3Og+MpdEMJCpXk=;
	b=MOAWksyLKh0ojkdMN49j4fqTWgf2ofnx8iBEtRuPDzO+ujIYMEQBHBFb
	nYiAx4SfKIyTHaDkWJgr6trlRgU2wSSes9vtSoQ+XjJ0OUPSwvaHGdmTg
	2+QNSZkHwOtw+D9DGDo3MSBygo/KUXMXQ7lEONBOx9lwNf2Z0FxRBxrQt
	GfB8xajMwLIofh40oJWBIYrKrTXh4tOO2oP+u0UMRYfSfkjgW0wHBSmpQ
	rPBS4HdrRnUBfwxD7xOJ4bjVPDaVK7C3dQYV8ngDDEdr3Y8wfi4h3O/A6
	Sni/CXZGvuWGeAdYF7Ca5q/bUkAjNyhLnQ+T9+MWoOFAYCHc9ZAV7DJbL w==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="206404305"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RyYTPhB4Jg33CLBqxfFmZhjvr5CIq3Og+MpdEMJCpXk=;
	b=SWFC4c0K4yvRqdAmzw+scc0sk+C3uksCnNc3peLsi6YJCspe0yAVtQ6BDb5/AxUEj9ibMCfXdlYgLa2CKynZ1qNHblRGFTrOfZWzvrmFcNsVUnZX+S7PpVoQ/d8SwpsSc/QTWNzNAWaviC/52Bpq53V2WjQqGyOqaRFSg+8DzGo=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:08:48 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:08:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 0/5]  Fix some GCC 9 build warnings
Thread-Index: AQHU/5CF98rOkh8qNE20R4ARsjTsUQ==
Date: Tue, 30 Apr 2019 20:08:48 +0000
Message-ID: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de486422-1b4f-4f18-91d8-08d6cda7a7b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56725ED8CE331734A70F8B0E903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(4744005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(102836004)(2906002)(26005)(6486002)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7XPiGO0ZYBv/TSIV2vXUSSjAUMb8Fgoegk6Wt8OSac4nI0jOi6Vci/0UAsn+et+gO+OCcnnW9fy+6/MYetBtYlPqZciUaXbVMRua7vFYTVp/jRjLJADDrbfEH23ihr2l740WIo5ZMNakYHfREqbxJA+vONtkU9X+FTOB5Ocikv4aSPd/YEwFPij9qT3VNUQ+LnnBQW6r4XLx4zj5I0Esdf4z7ZNhWaV69EEHjdlR1OwPh6JyqnNBfJCcSRK8swmv44daJzbCyP4S/qUP2e8Heg9/Bj40xFW8n0YuaKUH+3e+cHpo8boFREDHLWR+QzlCJSYwQMMPDxqzuyDT8mv4kLrCrmmcWWtoL2cmQ1D9Hjtp4irWnAUJoFqwVp3R6WeJs3bgpBg09suiNmoj6TMXZibG7IuRcH4AG1ZU1qhBoJI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <6A8AA2ACCF27F947A1EDB119EA6FF4F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de486422-1b4f-4f18-91d8-08d6cda7a7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:08:48.0314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 0/5]  Fix some GCC 9 build warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430200848.w2yehNVK0OajJBu7sHtrDw11vjW9TWJIk0lxuosqArA@z>

DQpBbGlzdGFpciBGcmFuY2lzICg1KToNCiAgdXRpbC9xZW11LXNvY2tldHM6IEZpeCBHQ0MgOSBi
dWlsZCB3YXJuaW5ncw0KICBody91c2IvaGNkLXhoY2k6IEZpeCBHQ0MgOSBidWlsZCB3YXJuaW5n
DQogIGh3L3VzYi9kZXYtbXRwOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZw0KICBsaW51eC11c2Vy
L3VuYW1lOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCiAgbGludXgtdXNlci9lbGZsb2FkOiBG
aXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCg0KIGh3L3VzYi9kZXYtbXRwLmMgICAgIHwgMTMgKysr
KysrKysrKysrKw0KIGh3L3VzYi9oY2QteGhjaS5oICAgIHwgIDIgKy0NCiBsaW51eC11c2VyL2Vs
ZmxvYWQuYyB8ICA0ICsrLS0NCiBsaW51eC11c2VyL3VuYW1lLmMgICB8ICA4ICsrKysrKysrDQog
dXRpbC9xZW11LXNvY2tldHMuYyAgfCAgNCArKy0tDQogNSBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjEuMA0KDQo=

