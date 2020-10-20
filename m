Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822F0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0C42177B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xvn9fzCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0C42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuxp-0005FP-Oy
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5550c0b6f=acatan@amazon.com>)
 id 1kUuuK-0002Xm-02
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:54:44 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5550c0b6f=acatan@amazon.com>)
 id 1kUuuI-0003fW-6g
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1603212882; x=1634748882;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=+bj8U8RezaG268JdXw29LicrkbrnImce7j6a9Ka41Fw=;
 b=Xvn9fzCqFxG26aOelWRp+RsdzuGvi7a7Xq6Wos7M0fJIY610uXTvhFep
 8pQs1IiwOPsPiHDQmwDDOSYtVtW3KuaDZ/j+IqJZ7OGc0K3KhSSBIevfl
 tliCD5TzplUjfe5Ep5Z3hpRuDYnZjNP0F5AbfsSSk08l1C0XIUOafROWU k=;
X-IronPort-AV: E=Sophos;i="5.77,397,1596499200"; d="scan'208";a="60147548"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 20 Oct 2020 16:54:33 +0000
Received: from EX13D07EUB001.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS
 id 1185CA18F0; Tue, 20 Oct 2020 16:54:25 +0000 (UTC)
Received: from EX13D08EUB004.ant.amazon.com (10.43.166.158) by
 EX13D07EUB001.ant.amazon.com (10.43.166.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 16:54:24 +0000
Received: from EX13D08EUB004.ant.amazon.com ([10.43.166.158]) by
 EX13D08EUB004.ant.amazon.com ([10.43.166.158]) with mapi id 15.00.1497.006;
 Tue, 20 Oct 2020 16:54:24 +0000
From: "Catangiu, Adrian Costin" <acatan@amazon.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
CC: Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Eric Biggers" <ebiggers@kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>,
 "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>,
 "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com"
 <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Qemu
 Developers" <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "Christian
 Borntraeger" <borntraeger@de.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "Mathiske, Bernd" <mathiske@amazon.com>, "Hohensee,
 Paul" <hohensee@amazon.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Thread-Topic: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Thread-Index: AQHWpLCgyRz7zwEeX0C0PpiPp4JTxamg7DuA
Date: Tue, 20 Oct 2020 16:54:24 +0000
Message-ID: <9CB99FC7-3EDF-488E-B52C-DE0368A4BC81@amazon.com>
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
 <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D222EABD850A32409B803CF44A854938@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=72.21.196.25;
 envelope-from=prvs=5550c0b6f=acatan@amazon.com; helo=smtp-fw-2101.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 12:54:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -145
X-Spam_score: -14.6
X-Spam_bar: --------------
X-Spam_report: (-14.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgYWxsLA0KDQrvu79PbiAxNy8xMC8yMDIwLCAyMTowOSwgIkdyYWYgKEFXUyksIEFsZXhhbmRl
ciIgPGdyYWZAYW1hem9uLmRlPiB3cm90ZToNCiAgICANCiAgICBPbiAxNy4xMC4yMCAxNToyNCwg
SmFzb24gQS4gRG9uZW5mZWxkIHdyb3RlOg0KICAgID4gDQogICAgPiBBZnRlciBkaXNjdXNzaW5n
IHRoaXMgb2ZmbGluZSB3aXRoIEphbm4gYSBiaXQsIEkgaGF2ZSBhIGZldyBnZW5lcmFsDQogICAg
PiBjb21tZW50cyBvbiB0aGUgZGVzaWduIG9mIHRoaXMuDQogICAgPiANCiAgICA+IEZpcnN0LCB0
aGUgVVVJRCBjb21tdW5pY2F0ZWQgYnkgdGhlIGh5cGVydmlzb3Igc2hvdWxkIGJlIGNvbnN1bWVk
IGJ5DQogICAgPiB0aGUga2VybmVsIC0tIGFkZGVkIGFzIGFub3RoZXIgaW5wdXQgdG8gdGhlIHJu
ZyAtLSBhbmQgdGhlbiB1c2Vyc3BhY2UNCiAgICANCiAgICBXZSBkZWZpbml0ZWx5IHdhbnQgYSBr
ZXJuZWwgaW50ZXJuYWwgbm90aWZpZXIgYXMgd2VsbCwgeWVzIDopLg0KDQpXaGF0IHdvdWxkIGJl
IGEgZ2VuZXJpYyBldmVudCB0cmlnZ2VyIG1lY2hhbmlzbSB3ZSBjb3VsZCB1c2UgZnJvbSBhIGtl
cm5lbA0KbW9kdWxlL2RyaXZlciBmb3IgdHJpZ2dlcmluZyBybmcgcmVzZWVkIChwb3NzaWJseSBh
ZGRpbmcgdGhlIHV1aWQgdG8gdGhlIG1peA0KYXMgd2VsbCk/DQoNCiAgDQoNCgoKCkFtYXpvbiBE
ZXZlbG9wbWVudCBDZW50ZXIgKFJvbWFuaWEpIFMuUi5MLiByZWdpc3RlcmVkIG9mZmljZTogMjdB
IFNmLiBMYXphciBTdHJlZXQsIFVCQzUsIGZsb29yIDIsIElhc2ksIElhc2kgQ291bnR5LCA3MDAw
NDUsIFJvbWFuaWEuIFJlZ2lzdGVyZWQgaW4gUm9tYW5pYS4gUmVnaXN0cmF0aW9uIG51bWJlciBK
MjIvMjYyMS8yMDA1Lgo=


