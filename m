Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B104C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BD020679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="xRpeoB7S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="XTk5dqkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BD020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5Hg-0002PV-Aa
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5Gk-000196-Sj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:55:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:31520)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5Gi-0003wi-9M
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598486152; x=1630022152;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dfq4oll5jxoBaTfKE6kn+aol1L7j4bc1190edObOrrc=;
 b=xRpeoB7SpCJGa0lZCirbUKO1NRuB+xfPYAniomU6grEtb3AlKGLYxSjn
 PVdBZhaS16HdEhIQQE9lxoTUGe1IEncAfI8ZdzI0CoR6aGJ4ilkNqZM4G
 qQegVuk3A7QO3Yv8N5Id7Jme7DU9d+C4nbLGup97GZ1pzN+EgXElf+iEl s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:55:51 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:55:50 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:53:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:53:08 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:37 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:37 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 24/34] Hexagon (target/hexagon) opcode data
 structures
Thread-Topic: [RFC PATCH v3 24/34] Hexagon (target/hexagon) opcode data
 structures
Thread-Index: AQHWdXdgbQ1mIJd7ikOoAcCZ9hozn6lKj1qAgACEUoA=
Date: Wed, 26 Aug 2020 23:52:37 +0000
Message-ID: <BYAPR02MB4886CAE48350DD3145089260DE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-25-git-send-email-tsimpson@quicinc.com>
 <290827a0-6f54-d75a-9576-de7c8e826cd1@linaro.org>
In-Reply-To: <290827a0-6f54-d75a-9576-de7c8e826cd1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 353ed125-c6a5-4e43-f60b-08d84a1b1c66
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB4952B5B7207E2FB007DD14B7DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QRIBr2Ku6rKBMw8lFMD/rnmg30yr6BrjB5w+nnYLisrmDq90LLO4MZg8A1pOIaa7N1Z+tz7NhoBhao7yjJ/YC3IgS2O1hsgzViSHZxLty6/MSLU4Ks0Kd0GtjbDTgsFCJaQWzCZY1nqzLDV6Ge0n//5gOe3XFoYjq8lrlaKLvNCOQj7KiJFj+0ZOh7P0E0RMfSEIQT28lTi+Xdz08nRiXGP8ClzpDR6gvHEGnK3RWMB72/LCn+NzGLX1Y6opYqje+bxhOSvYRJZ8Y7oN1CO1kMxsKcMquskq+FF379vUUJQl0432rps6lTLs3yjeY8+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1WQ+GKBF3YO37rFU3mKXHLXkC1MItsB2Hqb6PqmUgt1Bv0C24hciPUTdDKpTl4apffl/4HTrGmpsbck8nh+pKWqTXdgvJJiaIrtdu5Mumoj28PWmxzwjz0T7HXlaKPNfWNs7Wm4R0xE+52xy5WISlDzemTtojO6bfBauK8HsKBU4YEBp2vnlkmP4fqu6XKH5dq9dFcU245OvanovK7omum8lTouBZwHveGkcxI89ho24ApAEVay3OyJhoSe23wFRBk5GI0VUfPQg+5zRRocg0Sm0Yol6mRaTJsXGOnrM+VvmtWr9tzY/uqa1d02VmHvxX54PWIX0lBFzHCPa10ARdKsuXCwVaKtTJPHrrrRwyptiwsNa3kQCC1/gKIR+oqn/VtaK3thEsQ7N8H0Hfetg+hnLLr5QYyfI28JngMnINLj8TyfpL30DHstt1wtmiUcl11q2SrfEXeAROGw7UDMIXzHjseYTU+m88QEoFQn8Pw5W4tGxyV/WMFWxmJ/GvH5YKcHtMZoaNaeCBBLjMDcrTRa+rOBdwVSknfOB/dAS9VkSz3yvRjPsf/4endP9FE5gG1yMxtFwYQ3UoEHReRteakmKPfxWHcG4t6PaPfKz6H1mrArJnJV7kUoAGCBSjYbhlVbEB+G5vxY7dtx5TdpFcg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuhS6w0egMXEMiN5RxzZ0W6zZQ1PjUNtMZ0tPrXmNIKNX3qnDde7NyYCs7EOb1kM0jw2k4iyZpBxDlYZNnGUM55b3KHboBWh/geseSz5Ss/tDiSvh71n5JJKL96xbvjMCAG+9G9gCa03Ygy6f3H9dT6SPI46MFfw9PHLbC2BzmfD8HjXpFjNOz4isk2qpoftgQk/2L4voH2wKDBqPGPF5YGlERd4npUnXtwDwMj/EQ4L+7NrxREWhUEm5yg6qQafbOL3v04fTJlIavxaRAHEKpGcLHSxpAWCTN+p2QIaIWrqmHmnjAIHcsfTMgsdHWZa2quqUTrp8uOLUvVvIahWaA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8cFBPbPF1v0baTDHmTUtJpCbXVguGmJbr6t4JrNXZE=;
 b=C2sMvoV+37LQ0dylOAtZuyj7w2c9NC6+wTBw7OORHhiyVMMFY9/NIxNeE7TJPpN2fkInHGv74Arj+B6TlBedMi71emImwSFRd7nelOcipdxSD1nLceUU7KJ3cf/7JuwqeMdauzR0dgC2MfAp39+t7AiMrIN3gP2ix0lp6FcsKxfKFQIlZEfmdNbzmXGmDIFhT6ru7GnyJd2itnYvYvhIIneRBO3XWDS/uNAGH9E5/94DoVWqIvVbRGJpHBbS1IXby8qFVF28xTr7VKHDYejqMJJpf8YD3RcswigjmUSy/SROBU2MA+AwOe/TvLGaiZ+XyaxqzT0Sy/kQwTWNhjrYIw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8cFBPbPF1v0baTDHmTUtJpCbXVguGmJbr6t4JrNXZE=;
 b=XTk5dqkI5niFl5V+X1smb+8tbGDTS2ToB8D9EeWnFfaUR2vd8uCRZnE1lRreEM/y/VO95pwDqm/Q1fnFkQt22hV6RRT3RwXZ5ub/kVDZRk+ETrduY4zg7wG01q5EVJ71AqEy3l0rSFDhZmbj4KAoftfDqXzeFdkjAgGV9V7V0QQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 353ed125-c6a5-4e43-f60b-08d84a1b1c66
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:37.2468 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3qM+P/qAi8mVhFsGHNpzo6mKJIR2P0+lwHEbnJkH83OCr/LPndW7m2JYTBIDXJ5riz9LsWczRBYdAgFbi0lwZg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:00
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDk6MjYgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAy
NC8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIG9wY29kZSBkYXRhDQo+IHN0cnVjdHVyZXMN
Cj4NCj4gPiArZXh0ZXJuIGNvbnN0IGNoYXIgKm9wY29kZV9uYW1lc1tdOw0KPiA+ICsNCj4gPiAr
ZXh0ZXJuIGNvbnN0IGNoYXIgKm9wY29kZV9yZWdpbmZvW107DQo+ID4gK2V4dGVybiBjb25zdCBj
aGFyICpvcGNvZGVfcnJlZ3NbXTsNCj4gPiArZXh0ZXJuIGNvbnN0IGNoYXIgKm9wY29kZV93cmVn
c1tdOw0KPg0KPiBjb25zdCBjaGFyICogY29uc3QNCg0KT0sNCg0KPiA+ICtleHRlcm4gb3Bjb2Rl
X2VuY29kaW5nX3Qgb3Bjb2RlX2VuY29kaW5nc1tYWF9MQVNUX09QQ09ERV07DQo+DQo+IGNvbnN0
Lg0KDQpPSw0KDQo+ID4gK2V4dGVybiBzaXplNHVfdA0KPiA+ICsgICAgb3Bjb2RlX2F0dHJpYnNb
WFhfTEFTVF9PUENPREVdWyhBX1paX0xBU1RBVFRSSUIgLw0KPiBBVFRSSUJfV0lEVEgpICsgMV07
DQo+DQo+IGNvbnN0Lg0KDQpPSw0KDQo+IEFuZCB1c2luZyBxZW11L2JpdG9wcy5oIGlmIHBvc3Np
YmxlLCBhcyBkaXNjdXNzZWQgZWFybGllciB2cyBhdHRyaWJzLmguDQoNCkRvIHlvdSBtZWFuIHJl
cGxhY2UgdGhlIEdFVF9BVFRSSUIgbWFjcm8gd2l0aCB0ZXN0X2JpdCBmcm9tIHFlbXUvYml0b3Bz
Lmg/DQoNCj4gSnVzdCBpbml0aWFsaXplIG9wY29kZV9zaG9ydF9zZW1hbnRpY3Mgd2l0aCBzaG9y
dGNvZGVfZ2VuZXJhdGVkLmggaW4gdGhlDQo+IGZpcnN0DQo+IHBsYWNlLiAgVGhlbiB5b3UgZG9u
J3QgbmVlZCB0byBjcmVhdGUgYSB0YWJsZSBvZiBOVUxMIGFuZCBvdmVyd3JpdGUgYXQNCj4gc3Rh
cnR1cC4NCj4NCj4gQW5kIHlvdSBjYW4gYWxzbyBtYWtlIHRoZSB0YWJsZSBjb25zdGFudC4NCg0K
T0sNCg0KPiA+ICsgICAgaWYgKHAgPT0gTlVMTCkgew0KPiA+ICsgICAgICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7DQo+ID4gKyAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAgICB9DQo+DQo+IEkg
cHJlZmVyIGFzc2VydChwICE9IE5VTEwpIHRvIGlmICh0ZXN0KSB7IGFib3J0KCk7IH0sIHdoZXJl
IHBvc3NpYmxlLiAgRS5nLg0KPiB0aGlzIGxhdGVyIG9uZSBpcyBmaW5lOg0KDQpPSw0KDQo=

