Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF72C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD51120684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BGZepXpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD51120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsF0-0007GH-Rq
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:15:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYsDe-0006O1-Cq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hYsDb-00078k-A9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:14:14 -0400
Received: from mail-bgr052101135051.outbound.protection.outlook.com
	([52.101.135.51]:8834
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hYsDT-0006BX-WD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IMlKcBzHiqXUK34661s5MJ59809eXFqX9rZODEGrYAQ=;
	b=BGZepXprmdLyTC5PJIcoz7dKTtfCsIRe3IyqngWqg4Wz2WVcDtx6nv1acAC/7z3Py6309are4fZWFqJIAmH9CRjMd9C793y6w6llKq/RP0HpfIUEVyF/Z69FqqFCaTMosSZza9LcVvBDP2ThmXSaAhzTbKGmOcAudG1y0CIVqCg=
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com (10.171.190.153) by
	AM4PR08MB2833.eurprd08.prod.outlook.com (10.171.189.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.14; Thu, 6 Jun 2019 13:13:50 +0000
Received: from AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f]) by
	AM4PR08MB2676.eurprd08.prod.outlook.com
	([fe80::6169:9a70:7143:1c1f%3]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 13:13:50 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Liran Alon <liran.alon@oracle.com>
Thread-Topic: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
Thread-Index: AQHVG/xInft6kgOMtki3E7d/wsNAsKaOT4sAgAAIEQCAAAOQgIAADNYAgAAzXwA=
Date: Thu, 6 Jun 2019 13:13:50 +0000
Message-ID: <20190606131348.GA32258@rkaganb.sw.ru>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
	<20190606084222.GA2788@work-vm>
	<862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
	<20190606092358.GE2788@work-vm>
	<8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
In-Reply-To: <8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Liran Alon
	<liran.alon@oracle.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,	kvm list
	<kvm@vger.kernel.org>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR06CA0153.eurprd06.prod.outlook.com
	(2603:10a6:7:16::40) To AM4PR08MB2676.eurprd08.prod.outlook.com
	(2603:10a6:205:c::25)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ca635ad-7cb8-4a19-0140-08d6ea80d125
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM4PR08MB2833; 
x-ms-traffictypediagnostic: AM4PR08MB2833:|AM4PR08MB2833:
x-microsoft-antispam-prvs: <AM4PR08MB283394D0B58A8B63D857588FC9170@AM4PR08MB2833.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(366004)(136003)(346002)(376002)(39840400004)(396003)(199004)(189003)(64756008)(256004)(14444005)(6916009)(25786009)(66066001)(4326008)(6246003)(66446008)(66476007)(66946007)(6436002)(58126008)(229853002)(11346002)(446003)(26005)(305945005)(54906003)(316002)(66556008)(33656002)(6486002)(76176011)(53936002)(68736007)(386003)(6506007)(52116002)(36756003)(8936002)(8676002)(81156014)(81166006)(7736002)(102836004)(99286004)(186003)(9686003)(6512007)(71200400001)(71190400001)(73956011)(478600001)(486006)(1076003)(86362001)(6116002)(3846002)(476003)(14454004)(5660300002)(2906002)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:AM4PR08MB2833;
	H:AM4PR08MB2676.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d/3xkCmU+cr1294OBLF8QetlYWVUxnk+pelE31c3XTbx2G2v6gOos1YfSMQXN5HuyCGiRTTmHaQZFIZkD2HF2jJAFzpRT85oL7nW0YhKwypzwBxEFJqnxPbIPE8r9GQ+Lr/ndY1VCT8Lr4uvXY7lYo8Ku+Wn3WjhpckUgusadPL4sppaLpehemKKzM2aYquXQ/c/oNh5E1VwCrisa9Q0GaPpYiwLVRePypCwF+h4wa74BYr65OpFfGGKet2c46d08QypnLSgO5hNqOY36uPQD9Kw/zNKlYRHPMcldJZ3e2FI/5auHjIr5qOd+5C+zAuPz23Tnv/O7WWCdL46qWqsjHH9N86TWYRlwh9BcWyJrQ2pv3LUfQNBLLW6FVnR2e7M58FfqgdqPquuIxLevlVCaWNY6/Nje5Wb8lPy5RUWdsN0S0jzFdPESlL3LaTk6bM+U+OABuekcbeoHiYucDqDTYFJiyBRjchnxK8q/ffJXjgGmvQWfrHNnBQomRp3zH1s
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B5059CCF1E804283AF18238A7D88B6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca635ad-7cb8-4a19-0140-08d6ea80d125
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 13:13:50.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2833
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.51
Subject: Re: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	kvm list <kvm@vger.kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCBKdW4gMDYsIDIwMTkgYXQgMDE6MDk6NTZQTSArMDMwMCwgTGlyYW4gQWxvbiB3cm90
ZToNCj4gRmlyc3QsIG1hY2hpbmUtdHlwZSBleHByZXNzIHRoZSBzZXQgb2YgdkhXIGJlaGF2aW91
ciBhbmQgcHJvcGVydGllcyB0aGF0IGlzIGV4cG9zZWQgdG8gZ3Vlc3QuDQo+IFRoZXJlZm9yZSwg
bWFjaGluZS10eXBlIHNob3VsZG7igJl0IGNoYW5nZSBmb3IgYSBnaXZlbiBndWVzdCBsaWZldGlt
ZSAoaW5jbHVkaW5nIExpdmUtTWlncmF0aW9ucykuDQo+IE90aGVyd2lzZSwgZ3Vlc3Qgd2lsbCBl
eHBlcmllbmNlIGRpZmZlcmVudCB2SFcgYmVoYXZpb3VyIGFuZCBwcm9wZXJ0aWVzIGJlZm9yZS9h
ZnRlciBMaXZlLU1pZ3JhdGlvbi4NCj4gU28gSSB0aGluayBtYWNoaW5lLXR5cGUgaXMgbm90IHJl
bGV2YW50IGZvciB0aGlzIGRpc2N1c3Npb24uIFdlIHNob3VsZCBmb2N1cyBvbiBmbGFncyB3aGlj
aCBzcGVjaWZ5DQo+IG1pZ3JhdGlvbiBiZWhhdmlvdXIgKHN1Y2ggYXMg4oCceC1taWdyYXRlLXNt
aS1jb3VudOKAnSB3aGljaCBjYW4gYWxzbyBiZSBjb250cm9sbGVkIGJ5IG1hY2hpbmUtdHlwZSBi
dXQgbm90IG9ubHkpLg0KDQpNeSBleHBlcmllbmNlIGluIGRlYWxpbmcgd2l0aCBtaWdyYXRpb24g
Y29tcGF0aWJpbGl0eSBtYXR0ZXJzIChzZWUgZS5nLg0KOWI0Y2YxMDdiMDlkMThhYzMwZjQ2ZmQx
YzRkZTg1ODVjY2JhMDMwYykgaXMgdGhhdCB0aGUgc3RyYXRlZ3kgaXMNCmJhc2ljYWxseSAiZG9u
J3QgbGV0IGFueXRoaW5nIGJ1dCBRRU1VIGNvbnRyb2wgd2hhdCB0aGUgZ3Vlc3Qgc2VlcyIuICBJ
Zg0KUUVNVSBpcyBzdGFydGVkIHdpdGggYSBwYXJ0aWN1bGFyIHNldCBvZiBmbGFncyBkZWZpbmlu
ZyBndWVzdC12aXNpYmxlDQp0aGluZ3MgKGFuZCBtYWNoaW5lLXR5cGUgaXMganVzdCBhIGNvbnZl
bmllbnQgcHJlc2V0IG9mIGZsYWdzKSwgYW5kDQphbnl0aGluZyBpbiB0aGUgZW52aXJvbm1lbnQg
KGhvc3Qga2VybmVsLCBsaWJyYXJpZXMsIGV0Yy4pIHByZXZlbnRzIGl0DQpmcm9tIGFjdHVhbGx5
IHByb3ZpZGluZyB0aGF0IGZ1bmN0aW9uYWxpdHksIGl0IHNob3VsZCBkZXRlY3QgaXQgYmVmb3Jl
DQpydW5uaW5nIGFueSBndWVzdCBjb2RlIG9yIHRha2luZyB0aGUgaW5jb21pbmcgbWlncmF0aW9u
IHN0cmVhbSwgYW5kDQpyZWZ1c2UgdG8gc3RhcnQgaW5zdGVhZC4NCg0KQUZBSUNTIGZyb20gYSBx
dWljayBnbGFuY2UsIFFFTVUgZG9lc24ndCBoYXZlIGEgZmxhZyB0byB3aGljaCB0aGUNCnZpc2li
bGl0eSBvZiBNU1JfU01JX0NPVU5UIGlzIHRpZWQsIHdoaWNoIElNSE8gaXMgYSBidWcuICBBcyB0
aGUNCnByZXNlbmNlIG9mIHRoaXMgTVNSIGluIHRoZSBDUFUgaXMgb25seSBkZXRlcm1pbmVkIGJ5
IHRoZSBDUFUgbW9kZWwsDQppdCdkIHByb2JhYmx5IGJlIGNvcnJlY3QgdG8ganVzdCByZWZ1c2Ug
c3RhcnRpbmcgd2hlbiBzdWNoIGEgQ1BVIGlzDQpyZXF1ZXN0ZWQgYW5kIHRoZSBob3N0IEtWTSBk
b2Vzbid0IHN1cHBvcnQgTVNSX1NNSV9DT1VOVC4NCg0KPiBUaGlyZCwgbGV04oCZcyBhc3N1bWUg
YWxsIGhvc3RzIGluIGZsZWV0IHdhcyB1cGdyYWRlZCB0byBuZXdfa2VybmVsLiBIb3cNCj4gZG8g
SSBtb2RpZnkgYWxsIGxhdW5jaGVkIFFFTVVzIG9uIHRoZXNlIG5ldyBob3N0cyB0byBub3cgaGF2
ZQ0KPiDigJx4LW1pZ3JhdGUtc21pLWNvdW504oCdIHNldCB0byB0cnVlPw0KDQpJbiAobXkpIGlk
ZWFsIHdvcmxkIHRoaXMgZmxhZyBzaG91bGRuJ3QgaGF2ZSBleGlzdGVkLiAgRHVubm8gaG93IGl0
IGNhbWUNCmFib3V0OyBJIGd1ZXNzIGl0IHdhcyBzb21lIHNvcnQgb2YgYSBjb21wcm9taXNlLiAg
VGhlIHJlYWwgcHJvYmxlbSBpcw0KSU1PIHRoYXQgUUVNVSBsZXRzIHRoZSBjb250cm9sIGxvb3Nl
IG9uIHdoZXRoZXIgTVNSX1NNSV9DT1VOVCBpcyBwcmVzZW50DQppbiB0aGUgZ3Vlc3QuDQoNClJv
bWFuLg0K

