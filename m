Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE09AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EFA2084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gekg4eC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EFA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQdf-0002dB-Gx
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 02:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=21215ebf9=graf@amazon.de>) id 1iUQbl-0001sU-18
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=21215ebf9=graf@amazon.de>) id 1iUQbj-0002nG-Qz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:29:00 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=21215ebf9=graf@amazon.de>)
 id 1iUQbf-0002jV-NK; Tue, 12 Nov 2019 02:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1573543736; x=1605079736;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=RyvCqFZvFwYZ3N0bZBdZwAvrpWyTSX4ddC9HK3PFDww=;
 b=gekg4eC2xmX+QR3s4p21SYcn5OfRyJ/SoKKJIYJmC1qEaxEbp++YUhXP
 iP6YrelLY+PJjE27LHkg8YJkEBin+LPkg/7889CMb8xGDzWozzwDuGm4E
 kVGWLNLDGywloEC+6F8sGNNyk7Ii+mQL8+lZQBIoqPNUC0u2W1IAUcdh+ I=;
IronPort-SDR: rd/xyY8e+f5VFLbGnAp4bEijYT1IV0uBFJaspNuVuyAabqc7itf8T8gCbWMQ43hIGK76tkt/a5
 PEB9zgIh1Vuw==
X-IronPort-AV: E=Sophos;i="5.68,295,1569283200"; 
   d="scan'208";a="6673907"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 12 Nov 2019 07:28:48 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS
 id 0ADC0A16A3; Tue, 12 Nov 2019 07:28:46 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 07:28:46 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.160.101) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 07:28:44 +0000
Subject: Re: [PATCH] pl031: Expose RTCICR as proper WC register
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Hendrik Borghorst <hborghor@amazon.de>
References: <20191104115228.30745-1-graf@amazon.com>
 <CAFEAcA8zkR_MZ-28Nc=x4j05U9MsFYfzQtkHxTf65ZwacK020w@mail.gmail.com>
From: Alexander Graf <graf@amazon.com>
Message-ID: <246a7cd4-7c39-c92e-05c3-1045bca2c114@amazon.com>
Date: Tue, 12 Nov 2019 09:28:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zkR_MZ-28Nc=x4j05U9MsFYfzQtkHxTf65ZwacK020w@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.101]
X-ClientProxiedBy: EX13D34UWC002.ant.amazon.com (10.43.162.137) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.190.10
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

SGV5IFBldGVyLAoKT24gMDguMTEuMTkgMTc6NTgsIFBldGVyIE1heWRlbGwgd3JvdGU6Cj4gT24g
TW9uLCA0IE5vdiAyMDE5IGF0IDExOjUyLCBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29t
PiB3cm90ZToKPj4KPj4gVGhlIGN1cnJlbnQgcGwwMzEgUlRDSUNSIHJlZ2lzdGVyIGltcGxlbWVu
dGF0aW9uIGFsd2F5cyBjbGVhcnMgdGhlIElSUQo+PiBwZW5kaW5nIHN0YXR1cyBvbiBhIHJlZ2lz
dGVyIHdyaXRlLCByZWdhcmRsZXNzIG9mIHRoZSB2YWx1ZSBpdCB3cml0ZXMuCj4+Cj4+IFRvIGp1
c3RpZnkgdGhhdCBiZWhhdmlvciwgaXQgcmVmZXJlbmNlcyB0aGUgYXJtOTI2ZSBkb2N1bWVudGF0
aW9uCj4+IChEREkwMjg3QikgYW5kIGluZGljYXRlcyB0aGF0IHNhaWQgZG9jdW1lbnQgc3RhdGVz
IHRoYXQgYW55IHdyaXRlIGNsZWFycwo+PiB0aGUgaW50ZXJuYWwgSVJRIHN0YXRlLiBJIGNvdWxk
IGhvd2V2ZXIgbm90IGZpbmQgYW55IHRleHQgaW4gdGhhdCBkb2N1bWVudAo+PiBiYWNraW5nIHRo
ZSBzdGF0ZW1lbnQuIEluIGZhY3QsIGl0IGV4cGxpY2l0bHkgc2F5czoKPj4KPj4gICAgIldyaXRp
bmcgMSB0byBiaXQgMCBvZiBSVENJQ1IgY2xlYXJzIHRoZSBSVENJTlRSIGZsYWcuIgo+Pgo+PiB3
aGljaCBkZXNjcmliZXMgaXQgYXMgbXVjaCBhcyBhIHdyaXRlLXRvLWNsZWFyIHJlZ2lzdGVyIGFz
IHRoZSBQTDAzMSBzcGVjCj4+IChEREkwMjI0KSBkb2VzOgo+Pgo+PiAgICAiV3JpdGluZyAxIHRv
IGJpdCBwb3NpdGlvbiAwIGNsZWFycyB0aGUgY29ycmVzcG9uZGluZyBpbnRlcnJ1cHQuCj4+ICAg
ICBXcml0aW5nIDAgaGFzIG5vIGVmZmVjdC4iCj4gCj4gRERJMDI4N0IgcGFnZSAxMS0yIHNlY3Rp
b24gMTEuMSBzYXlzCj4gIlRoZSBpbnRlcnJ1cHQgaXMgY2xlYXJlZCBieSB3cml0aW5nIGFueSBk
YXRhIHZhbHVlIHRvIHRoZQo+IGludGVycnVwdCBjbGVhciByZWdpc3RlciBSVENJQ1IiLiBBcyB5
b3Ugbm90ZSwgdGhpcyBjb250cmFkaWN0cwo+IHdoYXQgaXQgc2F5cyBsYXRlciBvbiBpbiBzZWN0
aW9uIDExLjIuMi4KPiAKPiAoSW50ZXJlc3RpbmdseSwgdGhlIFBMMDMwIGRvZXMgaGF2ZSBhICJ3
cml0ZSBhbnkgdmFsdWUgdG8KPiBjbGVhciB0aGUgaW50ZXJydXB0IiByZWdpc3RlciwgUlRDRU9J
LikKPiAKPiBJJ20gZmFpcmx5IHN1cmUgdGhpcyBwYXRjaCBpcyByaWdodCBhbmQgdGhlIERESTAy
ODdCIGRvY3VtZW50Cj4gaGFzIGFuIGVycm9yLCBzaW5jZSBpdCBpc24ndCBpbnRlcm5hbGx5IGNv
bnNpc3RlbnQgYW5kIGRvZXNuJ3QKPiBtYXRjaCB0aGUgcHJvcGVyIFBMMDMxIFRSTS4KPiAKPiBE
aWQgeW91IGZpbmQgdGhpcyBiZWNhdXNlIHlvdSBoYWQgYSBndWVzdCB0aGF0IGFzc3VtZWQgdGhl
Cj4gb3RoZXIgYmVoYXZpb3VyPyBUaGlzIGJ1ZyBoYXMgYmVlbiBpbiBRRU1VIGZvciBhIHZlcnkg
bG9uZyB0aW1lLAo+IGFuZCBpdCBzZWVtcyBvZGQgZm9yIGEgZ3Vlc3QgdG8gZGVsaWJlcmF0ZWx5
IHBlcmZvcm0gYW4gYWN0aW9uCj4gKHdyaXRpbmcgMCkgd2hpY2ggaXMgZG9jdW1lbnRlZCB0byBo
YXZlIG5vIGVmZmVjdCBvbiB0aGUgZGV2aWNlLi4uCgpXZSBmb3VuZCB0aGlzIGJ1ZyBieSB0cnlp
bmcgdG8gZmluZCBqdXN0aWZpY2F0aW9uIGZvciB0aGUgYmVoYXZpb3IgaW4gCnRoZSBzcGVjIGFu
ZCBhcHBhcmVudGx5IG15IHNwZWMgcmVhZGluZyBza2lsbHMgd2VyZSBsYWNraW5nLiBJIGNvdWxk
IG5vdCAKZmluZCB0aGUgcmVmZXJlbmNlIHlvdSBjaXRlZCBhYm92ZS4KClNvIG5vLCBJIGRpZCBu
b3Qgc2VlIGFueSBndWVzdCBicmVha2FnZS4KCkkgc3RpbGwgdGhpbmsgdGhhdCBiZWluZyBjb25z
aXN0ZW50IHdpdGggdGhlIGFjdHVhbCBQTDAzMSBzcGVjIGlzIApwcmVmZXJhYmxlIHRob3VnaC4g
SWYgYW55IHJlYWwgd29ybGQgZ3Vlc3QgYnJlYWtzIGJlY2F1c2Ugb2YgdGhpcywgd2UgCmNhbiBz
dGlsbCByZXZlcnQgdGhpcyBwYXRjaCBhbmQgZG9jdW1lbnQgdGhlIGV4YWN0IGJyZWFrYWdlIGlu
IHRoZSAKY29tbWVudCBpbnN0ZWFkLgoKCkFsZXgKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVo
cnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmljaApFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGlu
ClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


