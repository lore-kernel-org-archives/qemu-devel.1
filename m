Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFACC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8815420679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="uD1ihtsR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="De22XTLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8815420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5Fq-0008GN-Oh
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5E8-0005Dj-EZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:53:12 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54858)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5E6-0003P9-Kq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485990; x=1630021990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dLv/80KcmKCduqXUXvRz5lzho3ni8AaW8m0d63LYPts=;
 b=uD1ihtsRxV0JMj9rQICYMQ5xLTAs4MHvuu0jePUKo2vNuKyIyXwNr7SW
 kG6ojRhVN2WB1mdlg22T8JLOpCoRSHIs8KoVCEDDgmqEqBn/Xcl/T9sBK
 rvUzeuhFRvbYLU5xI72Nvm/3voGjQu2LR/uZmn6AygsijKQ47wu8+oI8m o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:53:09 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:53:09 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:53:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:53:08 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:35 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:35 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 17/34] Hexagon (target/hexagon/imported) arch
 import - macro definitions
Thread-Topic: [RFC PATCH v3 17/34] Hexagon (target/hexagon/imported) arch
 import - macro definitions
Thread-Index: AQHWdXdfzaVjV0UAtUmtekDkFDPNlqlKjRCAgACGCgA=
Date: Wed, 26 Aug 2020 23:52:34 +0000
Message-ID: <BYAPR02MB488612987F950647761579F7DE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-18-git-send-email-tsimpson@quicinc.com>
 <283ca509-1ab9-71db-2aa9-6ed19f22c18b@linaro.org>
In-Reply-To: <283ca509-1ab9-71db-2aa9-6ed19f22c18b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88664085-97de-4c6c-9934-08d84a1b1b10
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB4952740A0BEEE5EA981A23A5DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkHch4kSgCEHH4crrgthYbeVnK7AwFkXgYo7mwK0K3sPJo62dw9VcwiMGMj/DyAEXUeGHc85e/CGpWSy2/99/Lb0DREHKhvl5mOQ9ajVuE2mxrFg9Dw5SicKwng030iVoWg4RdAZOcFIoRuDAGdtgUx7jSSHbowypyJrcL5RttpV+r+et2P0Y69m080JfftENhA4Nuf2o6b02E7NWT1rxHVLTliKoGc/6TMifgvcypNWT+7+IROHEcT2c0TeSso6TBDeqHCifCjGQwAqeCS0db4kqM4hLVP53nSh4jZUtg6q+3XVQMPCij7QskhFw40UHfJbPkwTamGWO0AnJ/4jtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(4744005)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: y7YkkIwbMpXw5PJuJKoj4Hx0DwtGF1MbCsqVUVWDsGky1fXFGVbgDybZsaBdVPlCVMFHo8L8Tdf4SE9vlhaoHyFfzWgAc+0lxhNmuVvQuW3FKpkdyA+yhVZDYkvq0gBFKc15NbKmAtbwLAtolgW2ZhFLyeDML7vDY09Qv8Fl9YMioeocLlgZROwMMKPoE4502TAV17/L9oT0ctnOXsZEVYsO0owU3R/WSCK0a7UHVma13eJ66VwL+R3KizRCKzsIf1K94hRb90aATCx+f/9jbN5d1FrAz+y8IIv+ZhmWQg1bl+l707nA89fCujQToXYR10mKc1EHkYZeFqg+6wlC3t1FZloobJATRmtZLLLMzzZE4Bp5YJ5f3hVeKi4TzIMU6zrqe/NE+yb8L7oW5DxZ/GCH8a+xpdrlJZUVe0eT0kugRsLVvxCRMyD/xp+yLSyeCQZHRdCVVWmSvc7wFwIxLPtB5p41ZGEOUbPZIPa6ZzrJaXO+Ydl3LxyjUKBjRy3OMLC009GeHNXSQscwhPVMqlu1go+m8V+MZmBMDY0xCmdNwDW+1rxhusHIcpWkd+qAROjTVtpeC6ZXHkoowgWGcoLDpwvJbC3AgxLcwpGnrQg7gk4yKdGwr6kEHrE9gsirbPEgGmXe0c/uW5AmkFqc3g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAgCKPw2WVkFIvOsnciAHCyOxIhR3bw81TRKOhO4kuygr0gRl59SRKTOnAOif1r7+ofkMB0T4BhQ9EBk4btaXX0ovC9XSEhLIdPCjOM57OQfoI8T/aKKRhx+q7gPbESFwD6oo4T+xx7XyntUnshcwYzrXDjAZj9Zs9OrygmgWLmDqBWcPPcQkwqEeoAP8g6MrAmowpmk9HUFGpSgxgLMrMQnzsIaknxlkZ3i6ScHHlIdLOjRYujjejrXyraegpKyjRDFFyeB2ZHr01bNllzyJmniwT+kN10N5bsWuGKjsvZUNnFzaZpwxJlNKMqk3/BNjEbWQAiWBb19LhDxeuuDyw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCbSdik1iC25GUTBhQL3Bdyud870yWKKmpypJfhJagk=;
 b=VuZmr3vhr+SlsNJHdBSZiCxPgEfDh2xuHPHXyfR9eapXtAKxM4Ou11RQivqAwlsBvDBoEjsNzvBHbKj86vaJgzzXGtrwdFlbcRLt30UCt+omIjCONrTtcq3YP886vVIcY2h942o1sMJt2EToWvf1ym+hjX+BAIP7o7zp0Du8VL578gv0KS6dnmuNgFXP+vgGYiRKs9BathIwZARfm3qjnbkGOc2bM6tsYe6aUJWVSzQfsZ9pSpTbHBYOs8QyWmBVmTbJafMlR4aiXPOybct798Mwhcf91CLzny3wXXmWLEjO9XOIkmqY97cUWYrKTFROiNsSaewFe2/47rsLeq5O9A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCbSdik1iC25GUTBhQL3Bdyud870yWKKmpypJfhJagk=;
 b=De22XTLfHVUEqxVpjHsL/Dn51Mz/vXtkJOxkH/0PB5RvtwCR/g22NmHBkOz5LV4ruaGs9nFI3AjppTxoM00jAHlmisgee4y8lRdK+7gwFj32Q8rxObeA+P9EIZ2yBjKz11PQcj4PG2BEzfCU5mFbA/i5wFHOnb10Ji36kOPDcus=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 88664085-97de-4c6c-9934-08d84a1b1b10
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:34.9501 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: SfhubrfQoKT+WTZaW1U70rVl5l7/UroRCATibv0If4Fk9X77K/+AI3o6LhfCrraBpod0XIE3jkmr3wy3x0QDPA==
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
dXN0IDI2LCAyMDIwIDk6MTcgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
Ny8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQpIGFyY2gNCj4gaW1wb3J0IC0g
bWFjcm8gZGVmaW5pdGlvbnMNCj4NCj4gWW91IG1pZ2h0IGFzIHdlbGwgc3F1YXNoIGFsbCBvZiB0
aGUgcGF0Y2hlcyBkZWFsaW5nIHdpdGggaW1wb3J0ZWQgZmlsZXMsDQo+IGJlY2F1c2UgdGhleSdy
ZSBiZXlvbmQgcmV2aWV3LiAgVGhleSBhcmUgd2hhdCB0aGV5IGFyZTogYW5vdGhlciBwcm9qZWN0
J3MNCj4gZmlsZXMuDQo+DQo+IEdpdmUgdGhhdCBzcXVhc2hlZCBwYXRjaCBteQ0KPg0KPiBBY2tl
ZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQoN
Ck9LDQoNCj4gUFM6IEkgbm90aWNlIHRoYXQgdGhlIFJFQURNRSBtZW50aW9ucyBhcmNobGliLCBi
dXQgZG9lcyBub3QgZ2l2ZSBhIHBvaW50ZXIgdG8NCj4gaXQuDQoNCk90aGVyIHRoYW4gd2hhdCB3
ZSBpbXBvcnQgaGVyZSwgaXQncyBub3Qgb3BlbiBzb3VyY2UuDQoNCg==

