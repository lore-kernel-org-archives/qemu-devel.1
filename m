Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BAC2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JJPvwlS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BAC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqfI-0002j5-7L
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552bcb7ef=acatan@amazon.com>)
 id 1kTqbI-00087Y-58
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:06:44 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:28586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552bcb7ef=acatan@amazon.com>)
 id 1kTqbF-0004xy-Fj
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1602957997; x=1634493997;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-id:mime-version:content-transfer-encoding:subject;
 bh=zWCcIWQD6xGx9ejw97Me0zftznbDXo04u09ZpNKNrPk=;
 b=JJPvwlS5ESfJs1lpu2i0AhIF8dNxsZeNzdqsV2BqMeQJ56zNxBIKvxe+
 ip60B1RzLtp8Nr87bV0CXeefDskzGh91csMzWhdXeS4nz/MWCZNXels/O
 2QOH/S3tqd1PuUZqd/bWk29n6BrlxS/w5Yk3LweEtqz3rxPhtzvLvKD3D 4=;
X-IronPort-AV: E=Sophos;i="5.77,387,1596499200"; d="scan'208";a="85548146"
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Thread-Topic: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-41350382.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 17 Oct 2020 18:06:28 +0000
Received: from EX13D07EUB003.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-41350382.us-west-2.amazon.com (Postfix) with ESMTPS
 id 0EFFDC2A21; Sat, 17 Oct 2020 18:06:26 +0000 (UTC)
Received: from EX13D08EUB004.ant.amazon.com (10.43.166.158) by
 EX13D07EUB003.ant.amazon.com (10.43.166.173) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 17 Oct 2020 18:06:25 +0000
Received: from EX13D08EUB004.ant.amazon.com ([10.43.166.158]) by
 EX13D08EUB004.ant.amazon.com ([10.43.166.158]) with mapi id 15.00.1497.006;
 Sat, 17 Oct 2020 18:06:25 +0000
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
CC: Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Eric Biggers" <ebiggers@kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse, David"
 <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir"
 <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com"
 <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers
 <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko
 <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
 <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>
Thread-Index: AQHWo8lIfZnFKGe8nkGmhTCXwq5R36mbBVEAgAAgZgCAAAdoAIAACOIAgAAHlICAAAn4AIAABFwAgAAOgACAAAMJAIAAbJEAgACBKAA=
Date: Sat, 17 Oct 2020 18:06:25 +0000
Message-ID: <76FF304F-C828-46CB-B82B-0948D4E927F5@amazon.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
In-Reply-To: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.242]
Content-Type: text/plain; charset="utf-8"
Content-ID: <54388C129E88694AB95901884CDE5626@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=552bcb7ef=acatan@amazon.com; helo=smtp-fw-9102.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 14:06:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -145
X-Spam_score: -14.6
X-Spam_bar: --------------
X-Spam_report: (-14.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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

ICAgIEFmdGVyIGRpc2N1c3NpbmcgdGhpcyBvZmZsaW5lIHdpdGggSmFubiBhIGJpdCwgSSBoYXZl
IGEgZmV3IGdlbmVyYWwNCiAgICBjb21tZW50cyBvbiB0aGUgZGVzaWduIG9mIHRoaXMuIA0KICAg
IEZpcnN0LCB0aGUgVVVJRCBjb21tdW5pY2F0ZWQgYnkgdGhlIGh5cGVydmlzb3Igc2hvdWxkIGJl
IGNvbnN1bWVkIGJ5DQogICAgdGhlIGtlcm5lbCAtLSBhZGRlZCBhcyBhbm90aGVyIGlucHV0IHRv
IHRoZSBybmcgLS0gYW5kIHRoZW4gdXNlcnNwYWNlDQogICAgc2hvdWxkIGJlIG5vdGlmaWVkIHRo
YXQgaXQgc2hvdWxkIHJlc2VlZCBhbnkgdXNlcnNwYWNlIFJOR3MgdGhhdCBpdA0KICAgIG1heSBo
YXZlLCB3aXRob3V0IGFjdHVhbGx5IGNvbW11bmljYXRpbmcgdGhhdCBVVUlEIHRvIHVzZXJzcGFj
ZS4gSU9XLA0KICAgIEkgYWdyZWUgd2l0aCBKYW5uIHRoZXJlLiBUaGVuLCBpdCdzIHRoZSBmdW5j
dGlvbmluZyBvZiB0aGlzDQogICAgbm90aWZpY2F0aW9uIG1lY2hhbmlzbSB0byB1c2Vyc3BhY2Ug
dGhhdCBpcyBpbnRlcmVzdGluZyB0byBtZS4NCg0KQWdyZWVkISBUaGUgVVVJRC92bWdlbmlkIGlz
IHRoZSBnbHVlIHRvIHRoZSBoeXBlcnZpc29yIHRvIGJlIGFibGUgdG8gZmluZCANCm91dCBhYm91
dCBWTSBzbmFwc2hvdHMvZm9ya3MuIFRoZSByZWFsbHkgaW50ZXJlc3RpbmcgKGFuZCBpbXBvcnRh
bnQpIHRvcGljDQpoZXJlIGlzIGZpbmRpbmcgdGhlIHJpZ2h0IG5vdGlmaWNhdGlvbiBtZWNoYW5p
c20gdG8gdXNlcnNwYWNlLg0KDQouLi5JbiByZXRyb3NwZWN0LCBJIHNob3VsZCBoYXZlIHBvc3Rl
ZCB0aGlzIGFzIFJGQyBpbnN0ZWFkIG9mIFBBVENILg0KICAgIA0KICAgIFNvLCBhbnl3YXksIGhl
cmUgYXJlIGEgZmV3IG9wdGlvbnMgd2l0aCBzb21lIHByb3MgYW5kIGNvbnMgZm9yIHRoZQ0KICAg
IGtlcm5lbCBub3RpZnlpbmcgdXNlcnNwYWNlIHRoYXQgaXRzIFJORyBzaG91bGQgcmVzZWVkLg0K
ICAgIDEuIFNJR1JORCAtIGEgbmV3IHNpZ25hbC4gTG9sLg0KICAgIDIuIFVzZXJzcGFjZSBvcGVu
cyBhIGZpbGUgZGVzY3JpcHRvciB0aGF0IGl0IGNhbiBlcG9sbCBvbi4gUHJvcyBhcmUNCiAgICB0
aGF0IG1hbnkgbm90aWZpY2F0aW9uIG1lY2hhbmlzbXMgYWxyZWFkeSB1c2UgdGhpcy4gQ29ucyBp
cyB0aGF0IHRoaXMNCiAgICByZXF1aXJlcyBzeXNjYWxsIGFuZCBtaWdodCBiZSBtb3JlIHJhY3kg
dGhhbiB3ZSB3YW50LiBBbm90aGVyIGNvbiBpcw0KICAgIHRoYXQgdGhpcyBhIG5ldyB0aGluZyBm
b3IgdXNlcnNwYWNlIHByb2dyYW1zIHRvIGRvLg0KICAgIDMuIFdlIHN0aWNrIGFuIGF0b21pYyBj
b3VudGVyIGluIHRoZSB2RFNPLCBKYW5uJ3Mgc3VnZ2VzdGlvbi4gUHJvcyBhcmUNCiAgICB0aGF0
IHRoaXMgaXMgZXh0cmVtZWx5IGZhc3QsIGFuZCBhbHNvIHNpbXBsZSB0byB1c2UgYW5kIGltcGxl
bWVudC4NCiAgICBUaGVyZSBhcmUgZW5vdWdoIHNlcXVlbmNlIHBvaW50cyBpbiB0eXBpY2FsIGNy
eXB0byBwcm9ncmFtcyB0aGF0DQogICAgY2hlY2tpbmcgdG8gc2VlIHdoZXRoZXIgdGhpcyBjb3Vu
dGVyIGhhcyBjaGFuZ2VkIGJlZm9yZSBkb2luZyB3aGF0ZXZlcg0KICAgIG9wZXJhdGlvbiBzZWVt
cyBlYXN5IGVub3VnaC4gQ29ucyBhcmUgdGhhdCB0eXBpY2FsbHkgd2UndmUgYmVlbg0KICAgIGNv
bnNlcnZhdGl2ZSBhYm91dCBhZGRpbmcgdGhpbmdzIHRvIHRoZSB2RFNPLCBhbmQgdGhpcyBpcyBh
bHNvIGEgbmV3DQogICAgdGhpbmcgZm9yIHVzZXJzcGFjZSBwcm9ncmFtcyB0byBkby4NCg0KRm9y
IGVhY2ggMSwgMiwgYW5kIDMgb3B0aW9ucywgdXNlcnNwYWNlIHByb2dyYW1zIF9oYXZlIHRvIGRv
IHNtdGggbmV3Xw0KYW55d2F5LCBzbyBJIHdvdWxkbid0IHdlaWdoIHRoYXQgYXMgYSBjb24uDQoN
CkFuIGF0b21pYyBjb3VudGVyIGluIHRoZSB2RFNPIGxvb2tzIGxpa2UgdGhlIG1vc3QgYmFuZyBm
b3IgdGhlIGJ1Y2sgdG8gbWUuDQpJJ20gcmVhbGx5IGN1cmlvdXMgdG8gaGVhciBtb3JlIG9waW5p
b25zIG9uIHdoeSB3ZSBzaG91bGRuJ3QgZG8gaXQuDQogICAgDQogICAgNC4gV2UgYWxyZWFkeSBo
YXZlIGEgbWVjaGFuaXNtIGZvciB0aGlzIGtpbmQgb2YgdGhpbmcsIGJlY2F1c2UgdGhlDQogICAg
c2FtZSBpc3N1ZSBjb21lcyB1cCB3aGVuIGZvcmsoKWluZy4gVGhlIHNvbHV0aW9uIHdhcyBNQURW
X1dJUEVPTkZPUkssDQogICAgd2hlcmUgdXNlcnNwYWNlIG1hcmtzIGEgcGFnZSB0byBiZSB6ZXJv
ZWQgd2hlbiBmb3JraW5nLCBmb3IgdGhlDQogICAgcHVycG9zZXMgb2YgdGhlIFJORyBiZWluZyBu
b3RpZmllZCB3aGVuIGl0cyB3b3JsZCBnZXRzIHNwbGl0IGluIHR3by4NCiAgICBUaGlzIGlzIGJh
c2ljYWxseSB0aGUgc2FtZSB0aGluZyBhcyB3ZSdyZSBkaXNjdXNzaW5nIGhlcmUgd2l0aCBndWVz
dA0KICAgIHNuYXBzaG90cywgZXhjZXB0IGl0J3Mgb24gdGhlIHN5c3RlbSBsZXZlbCByYXRoZXIg
dGhhbiB0aGUgcHJvY2Vzcw0KICAgIGxldmVsLCBhbmQgYSBzeXN0ZW0gaGFzIG1hbnkgcHJvY2Vz
c2VzLiBCdXQgdGhlIHByb2JsZW0gc3BhY2UgaXMgc3RpbGwNCiAgICBhbG1vc3QgdGhlIHNhbWUs
IGFuZCB3ZSBjb3VsZCBzaW1wbHkgcmV1c2UgdGhhdCBzYW1lIG1lY2hhbmlzbS4gVGhlcmUNCiAg
ICBhcmUgYSBmZXcgaW1wbGVtZW50YXRpb24gc3RyYXRlZ2llcyBmb3IgdGhhdDoNCg0KSSBkb24n
dCB0aGluayB3ZSBjYW4gcGlnZ3kgYmFjayBvbiBNQURWX1dJUEVPTkZPUksuIFRoYXQgbWFkdmlz
ZSBmbGFnDQpoYXMgYSBjbGVhciBjb250cmFjdCBvZiBvbmx5IHdpcGluZyBfb24gZm9ya18uIE92
ZXJsb2FkaW5nIGl0IHdpdGggd2lwaW5nDQpvbiBWTS1mb3JrIC0gd2hpbGUgcHJvY2VzcyBkb2Vz
bid0IGZvcmsgLSBtaWdodCBicmVhayBzb21lIG9mIGl0cyB1c2Vycy4NCiAgICANCiAgICA0YS4g
V2UgbWVzcyB3aXRoIHRoZSBQVEVzIG9mIGFsbCBwcm9jZXNzZXMnIHBhZ2VzIHRoYXQgYXJlDQog
ICAgTUFEVl9XSVBFT05GT1JLLCBsaWtlIGZvcmsgZG9lcyBub3csIHdoZW4gdGhlIGh5cGVydmlz
b3Igbm90aWZpZXMgdXMNCiAgICB0byBkbyBzby4gVGhlbiB3ZSB3aW5kIHVwIHJldXNpbmcgdGhl
IGFscmVhZHkgZXhpc3RpbmcgbG9naWMgZm9yDQogICAgdXNlcnNwYWNlIFJOR3MuIENvbnMgbWln
aHQgYmUgdGhhdCB0aGlzIHVzdWFsbHkgcmVxdWlyZXMgc2VtYXBob3JlcywNCiAgICBhbmQgd2Un
cmUgaW4gaXJxIGNvbnRleHQsIHNvIHdlJ2QgaGF2ZSB0byBob2lzdCB0byBhIHdvcmtxdWV1ZSwg
d2hpY2gNCiAgICBtZWFucyBlaXRoZXIgbW9yZSB3YWtlIHVwIGxhdGVuY3ksIG9yIGEgbGFyZ2Vy
IHJhY2Ugd2luZG93Lg0KICAgIDRiLiBXZSBqdXN0IG1lbXplcm8gYWxsIHByb2Nlc3NlcycgcGFn
ZXMgdGhhdCBhcmUgTUFEVl9XSVBFT05GT1JLLA0KICAgIHdoZW4gdGhlIGh5cGVydmlzb3Igbm90
aWZpZXMgdXMgdG8gZG8gc28uIFRoZW4gd2Ugd2luZCB1cCByZXVzaW5nIHRoZQ0KICAgIGFscmVh
ZHkgZXhpc3RpbmcgbG9naWMgZm9yIHVzZXJzcGFjZSBSTkdzLg0KICAgIDRjLiBUaGUgZ3Vlc3Qg
a2VybmVsIG1haW50YWlucyBhbiBhcnJheSBvZiBwaHlzaWNhbCBhZGRyZXNzZXMgdGhhdCBhcmUN
CiAgICBNQURWX1dJUEVPTkZPUksuIFRoZSBoeXBlcnZpc29yIGtub3dzIGFib3V0IHRoaXMgYXJy
YXkgYW5kIGl0cw0KICAgIGxvY2F0aW9uIHRocm91Z2ggd2hhdGV2ZXIgcHJvdG9jb2wsIGFuZCBi
ZWZvcmUgcmVzdW1pbmcgYQ0KICAgIG1vdmVkL3NuYXBzaG90dGVkL2R1cGxpY2F0ZWQgVk0sIGl0
IHRha2VzIHRoZSByZXNwb25zaWJpbGl0eSBmb3INCiAgICBtZW16ZXJvaW5nIHRoaXMgbWVtb3J5
LiBUaGUgaHVnZSBwcm8gaGVyZSB3b3VsZCBiZSB0aGF0IHRoaXMNCiAgICBlbGltaW5hdGVzIGFs
bCByYWNlcywgYW5kIHJlZHVjZXMgY29tcGxleGl0eSBxdWl0ZSBhIGJpdCwgYmVjYXVzZSB0aGUN
CiAgICBoeXBlcnZpc29yIGNhbiBwZXJmZWN0bHkgc3luY2hyb25pemUgaXRzIGJyaW5ndXAgKGFu
ZCBTTVAgYnJpbmd1cCkNCiAgICB3aXRoIHRoaXMsIGFuZCBpdCBjYW4gZXZlbiBvcHRpbWl6ZSB0
aGluZ3MgbGlrZSBvbi1kaXNrIG1lbW9yeQ0KICAgIHNuYXBzaG90cyB0byBzaW1wbHkgbm90IHdy
aXRlIG91dCB0aG9zZSBwYWdlcyB0byBkaXNrLg0KDQpJJ3ZlIHByZXZpb3VzbHkgcHJvcG9zZWQg
YSBwYXRoIHNpbWlsYXIgKGluIGNvbmNlcHQgYXQgbGVhc3QpIHdpdGggYSBjb21iaW5hdGlvbg0K
b2YgNCBhLGIgYW5kIGMgLSBodHRwczovL2x3bi5uZXQvbWwvbGludXgtbW0vQjc3OTNCN0EtMzY2
MC00NzY5LTlCOUEtRkZDRjI1MDcyOEJCQGFtYXpvbi5jb20vDQp3aXRob3V0IHJldXNpbmcgTUFE
Vl9XSVBFT05GT1JLLCBidXQgYnkgYWRkaW5nIGEgZGVkaWNhdGVkDQpNQURWX1dJUEVPTlNVU1BF
TkQuDQoNClRoYXQgcHJvcG9zYWwgd2FzIGNsdW5reSBob3dldmVyIHdpdGggbWFueSBwZW9wbGUg
cmFpc2luZyBjb25jZXJucyBhcm91bmQNCmhvdyB0aGUgaW50ZXJmYWNlIGlzIHRvbyBzdWJ0bGUg
YW5kIGhhcmQgdG8gd29yayB3aXRoLg0KDQpBIHZtZ2VuaWQgZHJpdmVyIG9mZmVyaW5nIGEgY2xl
YW4gRlMgaW50ZXJmYWNlIHNlZW1lZCBjbGVhbmVyLCBhbHRob3VnaCwgbGlrZQ0Kc29tZSBvZiB5
b3Ugb2JzZXJ2ZWQsIGl0IHN0aWxsIGFsbG93cyBhIHdpbmRvdyBvZiB0aW1lIGJldHdlZW4gYWN0
dWFsIFZNIGZvcmsNCmFuZCB1c2Vyc3BhY2UgaGFuZGxpbmcgb2YgdGhlIGV2ZW50Lg0KDQpPbmUg
b3RoZXIgZGlyZWN0aW9uIHRoYXQgSSB3b3VsZCBsaWtlIHRvIGV4cGxvcmUgYW5kIEkgZmVlbCBp
dOKAmXMgc2ltaWxhciB0byB5b3VyIDRjDQpwcm9wb3NhbCBpcyB0byBkbyBzbXRoIGxpa2U6DQoi
bW06IGV4dGVuZCBtZW1mZCB3aXRoIGFiaWxpdHkgdG8gY3JlYXRlICdzZWNyZXQnIG1lbW9yeSIN
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tbS9wYXRjaC8yMDIw
MDEzMDE2MjM0MC5HQTE0MjMyQHJhcG9wb3J0LWxueC8NCg0KTWF5YmUgd2UgY2FuIGNvbWJpbmUg
aWRlYXMgZnJvbSB0aGUgdHdvIHBhdGNoZXMgaW4gc210aCBsaWtlOiBpbnN0ZWFkIG9mIGxpYnMN
CnVzaW5nIGFub24gbWVtIHdpdGggTUFEVl9XSVBFT05TVVNQRU5ELCB0aGV5IGNhbiB1c2UgYSBz
ZWNyZXRfbWVtX2ZkDQp3aXRoIGEgKHNlY3JldG1lbSBzcGVjaWZpYykgV0lQRU9OU1VTUEVORCBm
bGFnOyB0aGVuIGluc3RlYWQgb2YgY3Jhd2xpbmcNClBURXMgaW4gdGhlIGNvcmUgUE0gY29kZSBs
b29raW5nIGZvciBNQURWX1dJUEVPTlNVU1BFTkQgbWFwcGluZ3MsDQp3ZSBjYW4gcmVnaXN0ZXIg
dGhpcyBzZWNyZXRtZW0gZGV2aWNlIHRvIHdpcGUgaXRzIG93biBzZWNyZXRzIGR1cmluZyBhIHBt
IGNhbGxiYWNrLg0KDQpGcm9tIGEgY3J5cHRvIHNhZmV0eSBwb3YsIHRoZSBpZGVhbCBzb2x1dGlv
biB3b3VsZCBiZSBvbmUgd2hlcmUgd2lwaW5nIGhhcHBlbnMNCmJlZm9yZSBvciBkdXJpbmcgVk0g
Zm9ya3MsIG5vdCBhZnRlci4NCkhhdmluZyBzYWlkIHRoYXQsIEkgdGhpbmsgYSB2RFNPICh1cGRh
dGVkIGJ5IHRoZSBndWVzdCBrZXJuZWwgX2FmdGVyXyBWTSBmb3JrKSBzdGlsbA0KY2xvc2VzIHRo
YXQgZ2FwIGVub3VnaCB0byBiZSBwcmFjdGljYWxseSBzYWZlLg0KDQpUaGFua3MsDQpBZHJpYW4u
DQoNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMuUi5MLiByZWdpc3Rl
cmVkIG9mZmljZTogMjdBIFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29yIDIsIElhc2ksIElh
c2kgQ291bnR5LCA3MDAwNDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9tYW5pYS4gUmVnaXN0
cmF0aW9uIG51bWJlciBKMjIvMjYyMS8yMDA1Lgo=


