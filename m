Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8553C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842D624684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+q/S1C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842D624684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOeD-0001Zz-Mm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1iwOcf-0008Ql-Nt
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1iwOce-0002FQ-Id
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:01:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1iwOca-0002Du-Px; Tue, 28 Jan 2020 06:01:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SAxIPq151919;
 Tue, 28 Jan 2020 11:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=dH3eMehNGxP5jZoJfTUakdzHuGtW6S9anpDHfJ1t0ag=;
 b=M+q/S1C5bH00xFfc0V6oOzzA1+8fmtj8ivv3SeAY7J+30JG6PgbGe4pMDO3reJbCkWok
 +V9CGYYom6BmSe6Bkn1OSKDep5dOgZipxRuGIKsnAETyLHwl2/G3KZy6NNZOQ6n8NxSY
 qWzFIaVHDhFNyGr3WgaoCX56pxRT3maOe2X9xaZrixJFma1zBRYBeW8uvJPOJ3+JPY6Z
 lMlqBwAEufj4LS7LodAxA3N+tT/jJ/4AZpmQjhGuQf1jcGYocvX5MYqKazOTAodUQuNX
 OAGU7zAfk8RYmcPEWzsTXjAi1Hfl4ZOuBhxI9TaujorOyR7diaGF0yYrNWCxsyj5p3jN Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2xrd3u5g54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 11:01:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SAxMs1066815;
 Tue, 28 Jan 2020 11:01:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2xry70f81g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 11:01:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00SB1FGS020396;
 Tue, 28 Jan 2020 11:01:15 GMT
Received: from [10.175.203.109] (/10.175.203.109)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Jan 2020 03:01:15 -0800
Subject: Re: [PATCH v4 4/7] python/qemu/machine: Allow to use other serial
 consoles than default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-5-f4bug@amsat.org>
 <6542670c-341f-b259-5705-a5374c5b722d@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <d9b078b4-dab7-da67-bb96-7b66c19d27a2@oracle.com>
Date: Tue, 28 Jan 2020 11:01:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6542670c-341f-b259-5705-a5374c5b722d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280089
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by userp2130.oracle.com id
 00SAxIPq151919
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjEvMDEvMjAyMCAwODoyMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+
IE9uIDEvMjEvMjAgMTI6NTEgQU0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
Pj4gQ3VycmVudGx5IHRoZSBRRU1VIFB5dGhvbiBtb2R1bGUgbGltaXRzIHRoZSBRRU1VTWFj
aGluZSBjbGFzcyB0bw0KPj4gdXNlIHRoZSBmaXJzdCBzZXJpYWwgY29uc29sZS4NCj4+DQo+
PiBTb21lIG1hY2hpbmVzL2d1ZXN0IG1pZ2h0IHVzZSBhbm90aGVyIGNvbnNvbGUgdGhhbiB0
aGUgZmlyc3Qgb25lIGFzDQo+PiB0aGUgJ2Jvb3QgY29uc29sZScuIEZvciBleGFtcGxlIHRo
ZSBSYXNwYmVycnkgUGkgdXNlcyB0aGUgc2Vjb25kDQo+PiAoQVVYKSBjb25zb2xlLg0KPj4N
Cj4+IFRvIGJlIGFibGUgdG8gdXNlIHRoZSBOdGggY29uc29sZSBhcyBkZWZhdWx0LCB3ZSBz
aW1wbHkgbmVlZCB0bw0KPj4gY29ubmVjdCBhbGwgdGhlIE4gLSAxIGNvbnNvbGVzIHRvIHRo
ZSBudWxsIGNoYXJkZXYuDQo+Pg0KPj4gQWRkIGFuIGluZGV4IGFyZ3VtZW50LCBzbyB3ZSBj
YW4gdXNlIGEgc3BlY2lmaWMgc2VyaWFsIGNvbnNvbGUgYXMNCj4+IGRlZmF1bHQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0
Lm9yZz4NCj4+IC0tLQ0KPj4gdjI6DQo+PiAtIHJlbmFtZWQgJ2NvbnNvbGVfaW5kZXgnLCBh
ZGRlZCBkb2NzdHJpbmcgKENsZWJlcikNCj4+IC0gcmV3b3JkZWQgZGVzY3JpcHRpb24gKHBt
MjE1KQ0KPj4gLS0tDQo+PiDCoCBweXRob24vcWVtdS9tYWNoaW5lLnB5IHwgOSArKysrKysr
Ky0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcHl0aG9uL3FlbXUvbWFjaGluZS5weSBiL3B5dGhv
bi9xZW11L21hY2hpbmUucHkNCj4+IGluZGV4IDczNGVmZDg1MzYuLmVmOWY1YjIxM2YgMTAw
NjQ0DQo+PiAtLS0gYS9weXRob24vcWVtdS9tYWNoaW5lLnB5DQo+PiArKysgYi9weXRob24v
cWVtdS9tYWNoaW5lLnB5DQo+PiBAQCAtMjQxLDYgKzI0MSw4IEBAIGNsYXNzIFFFTVVNYWNo
aW5lKG9iamVjdCk6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICdjaGFyZGV2PW1vbixtb2RlPWNvbnRyb2wnXSkNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiBzZWxmLl9tYWNoaW5lIGlzIG5vdCBOb25lOg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJncy5leHRlbmQoWyctbWFjaGluZScsIHNlbGYuX21h
Y2hpbmVdKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGZvciBpIGluIHJhbmdlKHNlbGYuX2NvbnNv
bGVfaW5kZXgpOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJncy5leHRlbmQoWyct
c2VyaWFsJywgJ251bGwnXSkNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgbm90IHN1ZmZpY2llbnQs
IHdlIGhhdmUgdG8gaW5pdGlhbGl6ZSBfY29uc29sZV9pbmRleCBpbiANCj4gX19pbml0X18o
KToNCj4gDQoNCndpdGggdGhhdCBmaXggYXBwbGllZA0KDQpSZXZpZXdlZC1ieTogTGlhbSBN
ZXJ3aWNrIDxsaWFtLm1lcndpY2tAb3JhY2xlLmNvbT4NClRlc3RlZC1ieTogTGlhbSBNZXJ3
aWNrIDxsaWFtLm1lcndpY2tAb3JhY2xlLmNvbT4NCg0KDQoNCg0KPiAtLSA+OCAtLQ0KPiBk
aWZmIC0tZ2l0IGEvcHl0aG9uL3FlbXUvbWFjaGluZS5weSBiL3B5dGhvbi9xZW11L21hY2hp
bmUucHkNCj4gaW5kZXggZWY5ZjViMjEzZi4uMTgzZDhmM2QzOCAxMDA2NDQNCj4gLS0tIGEv
cHl0aG9uL3FlbXUvbWFjaGluZS5weQ0KPiArKysgYi9weXRob24vcWVtdS9tYWNoaW5lLnB5
DQo+IEBAIC0xMTIsNiArMTEyLDcgQEAgY2xhc3MgUUVNVU1hY2hpbmUob2JqZWN0KToNCj4g
IMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5fc29ja19kaXIgPSBzb2NrX2Rpcg0KPiAgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLl9sYXVuY2hlZCA9IEZhbHNlDQo+ICDCoMKgwqDCoMKgwqDCoMKg
IHNlbGYuX21hY2hpbmUgPSBOb25lDQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLl9jb25zb2xl
X2luZGV4ID0gMA0KPiAgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLl9jb25zb2xlX3NldCA9IEZh
bHNlDQo+ICDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuX2NvbnNvbGVfZGV2aWNlX3R5cGUgPSBO
b25lDQo+ICDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuX2NvbnNvbGVfYWRkcmVzcyA9IE5vbmUN
Cj4gLS0tDQo+IA0KPiBFbHNlIGZvciB0ZXN0cyBub3QgY2FsbGluZyBzZWxmLnNldF9jb25z
b2xlKCkgd2UgZ2V0Og0KPiANCj4gIMKgJ1FFTVVNYWNoaW5lJyBvYmplY3QgaGFzIG5vIGF0
dHJpYnV0ZSAnX2NvbnNvbGVfaW5kZXgnDQo+IA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IHNlbGYuX2NvbnNvbGVfc2V0Og0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Vs
Zi5fY29uc29sZV9hZGRyZXNzID0gb3MucGF0aC5qb2luKHNlbGYuX3NvY2tfZGlyLA0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLl9u
YW1lICsgDQo+PiAiLWNvbnNvbGUuc29jayIpDQo+PiBAQCAtNTI3LDcgKzUyOSw3IEBAIGNs
YXNzIFFFTVVNYWNoaW5lKG9iamVjdCk6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgIiIiDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5fbWFjaGluZSA9IG1hY2hpbmVfdHlwZQ0KPj4g
LcKgwqDCoCBkZWYgc2V0X2NvbnNvbGUoc2VsZiwgZGV2aWNlX3R5cGU9Tm9uZSk6DQo+PiAr
wqDCoMKgIGRlZiBzZXRfY29uc29sZShzZWxmLCBkZXZpY2VfdHlwZT1Ob25lLCBjb25zb2xl
X2luZGV4PTApOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgICIiIg0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIFNldHMgdGhlIGRldmljZSB0eXBlIGZvciBhIGNvbnNvbGUgZGV2aWNlDQo+PiBA
QCAtNTQ4LDkgKzU1MCwxNCBAQCBjbGFzcyBRRU1VTWFjaGluZShvYmplY3QpOg0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjaGFyZGV2OmNvbnNvbGUiIGNvbW1hbmQgbGluZSBhcmd1bWVudCB3aWxsDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJlIHVzZWQgaW5zdGVhZCwgcmVzb3J0aW5nIHRvIHRoZSBtYWNoaW5lJ3MNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGVmYXVsdCBkZXZpY2UgdHlwZS4NCj4+ICvCoMKgwqDCoMKgwqDCoCBAcGFyYW0gY29uc29s
ZV9pbmRleDogdGhlIGluZGV4IG9mIHRoZSBjb25zb2xlIGRldmljZSB0byB1c2UuDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBJZiBub3QgemVybywgdGhlIGNvbW1hbmQgbGluZSB3aWxsIGNyZWF0ZQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJ2luZGV4IC0gMScgY29uc29sZXMgYW5kIGNvbm5lY3QgdGhlbSB0bw0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dGhlICdudWxsJyBiYWNraW5nIGNoYXJhY3RlciBkZXZpY2UuDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgIiIiDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5fY29uc29sZV9zZXQgPSBU
cnVlDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5fY29uc29sZV9kZXZpY2VfdHlwZSA9
IGRldmljZV90eXBlDQo+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5fY29uc29sZV9pbmRleCA9
IGNvbnNvbGVfaW5kZXgNCj4+IMKgwqDCoMKgwqAgQHByb3BlcnR5DQo+PiDCoMKgwqDCoMKg
IGRlZiBjb25zb2xlX3NvY2tldChzZWxmKToNCj4+DQo+IA0KPiANCg0K

