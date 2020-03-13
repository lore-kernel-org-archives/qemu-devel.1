Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927A20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVBnQOVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClxf-0000ER-Gz
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jClww-0007s1-71
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jClwu-0005C0-5O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:10:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jClwt-00058l-S1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584112207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDi1CkvvhdEhpyurGadulpmxSYXXD/3K0RB05JR0sms=;
 b=GVBnQOVHMnNUQFEThVTRsiyMI8+8Ov7T32wSc4w7yye2YKbdI2VwyM6Nn42kqIh0kGlm6D
 wyxzVSHzj1wjNwwP1n6uSK4dsJp/TCYuZgwVRUykE8W/r/mZvGJUyEkykmRdmNi7RokBBA
 TdtCAkjG8fO+iFcqBue3p8IccdpWSZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-DVYCD-o0OPiLEVdG2wslOw-1; Fri, 13 Mar 2020 11:10:04 -0400
X-MC-Unique: DVYCD-o0OPiLEVdG2wslOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7206618C35A3;
 Fri, 13 Mar 2020 15:10:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A38BD91298;
 Fri, 13 Mar 2020 15:09:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 18F0411386A6; Fri, 13 Mar 2020 16:09:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: QMP netdev_add multiple dnssearch values
References: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
 <87d0elmmdt.fsf@dusky.pond.sub.org>
 <2137591572344429@sas1-eb34c5849710.qloud-c.yandex.net>
 <87zhgha1lt.fsf@dusky.pond.sub.org>
 <d1f5421a-8a94-2869-4c96-24485cd17afd@redhat.com>
 <1819f914-1b88-d227-6a7b-b79ecb74679f@redhat.com>
Date: Fri, 13 Mar 2020 16:09:53 +0100
In-Reply-To: <1819f914-1b88-d227-6a7b-b79ecb74679f@redhat.com> (Eric Blake's
 message of "Thu, 12 Mar 2020 16:26:37 -0500")
Message-ID: <875zf8i94u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alex Kirillov <lekiravi@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+IHdyaXRlczoNCg0KPiBPbiAxMS8yNy8xOSA5
OjQ5IEFNLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gT24gMTEvMjcvMTkgNzozMCBBTSwgTWFya3Vz
IEFybWJydXN0ZXIgd3JvdGU6DQo+Pg0KPj4+ICJHb29kIGVub3VnaCIgd2FzIHRydWUgYmFjayB0
aGVuLsKgIEl0IHdhc24ndCB0cnVlIHdoZW4gd2UgcmV1c2VkIGl0IGZvcg0KPj4+IG5ldGRldl9h
ZGQ6IGhvc3Rmd2QgYW5kIGd1ZXN0ZndkIGFyZSBsaXN0LXZhbHVlZC4NCj4+Pg0KPj4+IFdlIGRp
ZCBkZWZpbmUgYSBRQVBJIHNjaGVtYSBhIGZldyBtb250aHMgbGF0ZXIgKDE0YWEwYzJkZTAgInFh
cGkgc2NoZW1hOg0KPj4+IGFkZCBOZXRkZXYgdHlwZXMiKS7CoCBuZXRfY2xpZW50X2luaXQoKSB1
c2VzIGl0IHRvIGNvbnZlcnQgZnJvbSBRZW11T3B0cw0KPj4+IHRvIFFBUEkgdHlwZSBOZXRkZXYu
wqAgVGhpcyB0b29rIHVzIHRvIHRoZSBjcmF6eSBwaXBlbGluZSB3ZSBzdGlsbCB1c2UNCj4+PiB0
b2RheToNCj4+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIENMSSwgSE1QDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChrZXk9dmFsdWUsLi4uKQ0KPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2DQo+Pj4gwqDCoMKgwqAgUU1QIChKU09OKSAtPiBRRGljdCAtPiBRZW11T3B0cyAtPiBO
ZXRkZXYNCj4+Pg0KPj4+IFdlIHNob3VsZCBpbnN0ZWFkIHVzZToNCj4+Pg0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ0xJLCBITVANCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoa2V5PXZhbHVl
LC4uLikNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHYNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFFlbXVPcHRzDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2DQo+Pj4g
wqDCoMKgwqAgUU1QIChKU09OKSAtPiBRRGljdCAtPiBOZXRkZXYNCj4+Pg0KPj4+IEJhY2sgaW4g
MjAxNiwgRXJpYyAoY2MnZWQpIHBvc3RlZCBwYXRjaGVzIHRvIGdldCB1cyB0byB0aGlzIHBpcGVs
aW5lLg0KPj4+IFRoZXkgZ290IHN0dWNrIG9uIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd29ycmll
czogdGhlIG9sZCBjb2RlIGFjY2VwdHMNCj4+PiBhbGwgcGFyYW1ldGVycyBhcyBKU09OIHN0cmlu
Z3MgaW4gYWRkaXRpb24gdG8gdGhlaXIgcHJvcGVyIHR5cGUsIHRoZSBuZXcNCj4+PiBjb2RlIGRv
ZXNuJ3QuwqAgVW5kb2N1bWVudGVkIG1pc2ZlYXR1cmUsIGJ1dCB3ZSBjaGlja2VuZWQgb3V0IGFu
eXdheS4NCj4+DQo+PiBUaGF0IHdhcyBiZWZvcmUgd2UgaGFkIGEgZGVwcmVjYXRpb24gcHJvY2Vz
cy7CoCBOb3cgd2UgZG8uwqAgSWYgd2UgYXJlDQo+PiBzdGlsbCB3b3JyaWVkIGFib3V0IGl0LCB0
aGVuIHdlIHNob3VsZCBzdGFydCB0aGUgZGVwcmVjYXRpb24gY2xvY2sNCj4+IChzcXVlZXppbmcg
aXQgaW50byA0LjItcmMzIGlzIHJpc2t5LCBtb3JlIGxpa2VseSBpcyBzdGFydGluZyBpdCBpbg0K
Pj4gNS4wLCBzbyB0aGF0IHdlIGdldCByaWQgb2Ygc3RyaW5nIHN1cHBvcnQgaW4gNS4yKS7CoCBJ
ZiB3ZSBhcmUgbm90DQo+PiB3b3JyaWVkIGFib3V0IGl0LCB0aGVuIHdlIGNhbiBqdXN0IGtpbGwg
dGhlIG1pc2ZlYXR1cmUgaW4gNS4wLg0KPg0KPiBJJ20gbGVhbmluZyB0b3dhcmRzIGp1c3Qga2ls
bGluZyB0aGUgbWlzZmVhdHVyZSAoaXQncyBhIGxvdCBvZiBnbHVlDQo+IGNvZGUgdG8gYWRkIHRv
IHN1cHBvcnQgdGhlIG1pc2ZlYXR1cmUgZm9yIDUuMCBhbmQgNS4xLCBpZiB3ZSdyZSBqdXN0DQo+
IGdvaW5nIHRvIHJpcCBpdCBiYWNrIG91dCBmb3IgNS4yKSwgZXNwZWNpYWxseSBzaW5jZSBpbnRy
b3NwZWN0aW9uIGlzDQo+IGVub3VnaCBmb3IgYW55IGFmZmVjdGVkIGNsaWVudHMgdG8gbGVhcm4g
YWJvdXQgdGhlIHN0cmljdGVyIGJlaGF2aW9yLg0KDQpIZXJlJ3MgbXkgcHJhY3RpY2FsIGFyZ3Vt
ZW50IGZvciBzaW1wbHkga2lsbGluZyBpdCB3aXRob3V0IGZ1cnRoZXINCmRlbGF5Lg0KDQpXZSBo
YXZlIGEgYnVnIHdlIGtub3cgdG8gYWZmZWN0IHVzZXJzOiB0aGUgb25lIHJlcG9ydGVkIGJ5IEFs
ZXguDQoNCldlIGhhdmUgYSBtaXNmZWF0dXJlIHVzZXJzIG1heSBvciBtYXkgbm90IHJlbHkgb246
IHRoZSBvbmUgdGhhdCBtYWRlIHVzDQpjaGlja2VuIG91dC4NCg0KVG8gZml4IHRoZSBidWcsIHdl
IGhhdmUgdG8ga2lsbCB0aGUgbWlzZmVhdHVyZS4gIEZpeGluZyBpdCB3aXRob3V0DQpraWxsaW5n
IHRoZSBtaXNmZWF0dXJlIGZlZWxzIGltcHJhY3RpY2FsLiAgRm9yIDUuMCwgaXQncyBmbGF0LW91
dA0KaW1wb3NzaWJsZS4NCg0KRGVwcmVjYXRpbmcgdGhlIG1pc2ZlYXR1cmUgZm9yIGEgZ3JhY2Ug
cGVyaW9kIGJlZm9yZSB3ZSBraWxsIGl0IG1lYW5zDQpsZXR0aW5nIHRoZSBidWcgY29udGludWUg
dG8gYml0ZSB1c2VycyBmb3IgdGhlIHdob2xlIGdyYWNlIHBlcmlvZC4NCg0KU2luY2Ugd2UgbGFj
ayB0aGUgbWVhbnMgdG8gY29tbXVuaWNhdGUgInlvdSdyZSB1c2luZyBhIGRlcHJlY2F0ZQ0KbWlz
ZmVhdHVyZSwgc3RvcCBpdCEiIHRvIFFNUCBjbGllbnRzLCB0aGUgZGVwcmVjYXRpb24gZ3JhY2Ug
cGVyaW9kIGlzDQp1bmxpa2VseSB0byBoZWxwIG11Y2guDQoNCj4+PiBMZXQncyByZWNvbnNpZGVy
LsKgIEVyaWMncyBwYXRjaGVzIGJyZWFrIGludGVyZmFjZSBtaXN1c2UgdGhhdCBtYXkgb3IgbWF5
DQo+Pj4gbm90IGV4aXN0IGluIHRoZSBmaWVsZC7CoCBUaGV5IGZpeCBhIGNvcnJlY3QgdXNlIG9m
IGludGVyZmFjZSBwZW9wbGUgd2FudA0KPj4+IHRvIHVzZSAob3IgQWxleCB3b3VsZG4ndCBoYXZl
IHJlcG9ydGVkIHRoaXMgYnVnKSwgYW5kIHRoZXkgbWFrZSBRTVANCj4+PiBpbnRyb3NwZWN0aW9u
IHdvcmsgZm9yIG5ldGRldl9hZGQuDQo+Pj4NCj4+PiBFcmljLCB3aGF0IGRvIHlvdSB0aGluaz8N
Cj4+DQo+PiBZZXMsIGl0J3MgdGltZSB0byByZXZpdmUgdGhhdCB3b3JrIChJIGhhdmUgbm8gaWRl
YSBpZiBteSBwYXRjaGVzDQo+PiBmcm9tIGJhY2sgdGhlbiB3aWxsIHN0aWxsIHJlYmFzZSBuaWNl
bHksIHRob3VnaCkuDQo+DQo+IE5vdyBwb3N0ZWQ6DQo+IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9h
cmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLTAzL21zZzAzODQyLmh0bWwNCg0KVGhhbmtzLCBJ
J2xsIHJldmlldy4NCg==


