Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BCCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9356A214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9356A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOM31-0008R5-Nc
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 09:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOIF1-0007Tb-Pt
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOIF0-0006En-9J
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:20:11 -0400
Received: from smtp.h3c.com ([60.191.123.50]:11929 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iOIEz-00064n-Fc; Sat, 26 Oct 2019 05:20:10 -0400
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
 by h3cspam02-ex.h3c.com with ESMTPS id x9Q9JkP6084473
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 26 Oct 2019 17:19:46 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Oct 2019 17:19:49 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Sat, 26 Oct 2019 17:19:49 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWL3hfRDHnwa5Z/SpmfNSa9xKBzHA==
Date: Sat, 26 Oct 2019 09:19:48 +0000
Message-ID: <9845459389d245fcaca2c017c27be8bc@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com x9Q9JkP6084473
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
X-Mailman-Approved-At: Sat, 26 Oct 2019 09:21:52 -0400
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKCksIHRoZSBzYW5pdHkgY2hlY2sgb24gdGhl
DQpncmFudWxhcml0eSB3aWxsIGNhdXNlIHVpbnQ2NF90IGludGVnZXIgbGVmdC1zaGlmdCBvdmVy
Zmxvdw0Kd2hlbiBjbHVzdGVyX3NpemUgaXMgMk0gYW5kIHRoZSBncmFudWxhcml0eSBpcyBiaWdn
ZXIgdGhhbg0KMzJLIHdoaWNoIGlzIGV2ZW4gc21hbGxlciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVl
IGZvciBhIHFjb3cyDQpkaXNrIHdpdGggY2x1c3Rlcl9zaXplIHNldCB0byA2NGsgb3IgYmlnZ2Vy
LiBUaGlzIHBhdGNoIGZpeA0KdGhlIGlzc3VlIGJ5IHJpZ2h0LXNoaWZ0IEBsZW4gaW5zdGVhZC4N
Cg0KU2lnbmVkLW9mZi1ieTogR3VveWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+DQotLS0NCiBibG9j
ay9xY293Mi1iaXRtYXAuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ibG9jay9xY293Mi1iaXRtYXAuYyBi
L2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQppbmRleCA5ODI5NGE3Li4yYTFkNzg5IDEwMDY0NA0KLS0t
IGEvYmxvY2svcWNvdzItYml0bWFwLmMNCisrKyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQpAQCAt
MTcyLDggKzE3Miw4IEBAIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KICAgICB9DQoNCiAgICAgaWYgKChsZW4gPiAodWludDY0X3Qp
Qk1FX01BWF9QSFlTX1NJWkUgPDwgZ3JhbnVsYXJpdHlfYml0cykgfHwNCi0gICAgICAgIChsZW4g
PiAodWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICogcy0+Y2x1c3Rlcl9zaXplIDw8DQotICAg
ICAgICAgICAgICAgZ3JhbnVsYXJpdHlfYml0cykpDQorICAgICAgICAoKGxlbiA+PiBncmFudWxh
cml0eV9iaXRzKSA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKg0KKyAgICAgICAgICAg
ICAgICBzLT5jbHVzdGVyX3NpemUpKQ0KICAgICB7DQogICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJUb28gbXVjaCBzcGFjZSB3aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZSBiaXRtYXAuICINCiAgICAg
ICAgICAgICAgICAgICAgIlVzZSBsYXJnZXIgZ3JhbnVsYXJpdHkiKTsNCi0tDQoyLjcuNA0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5paw5Y2O5LiJ6ZuG
5Zui55qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX
5Ye6DQrnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXl
vaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLj
gIHlpI3liLbjgIENCuaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaC
qOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWP
keS7tuS6uuW5tuWIoOmZpOacrA0K6YKu5Lu277yBDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFj
aG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3IEgzQywgd2hp
Y2ggaXMNCmludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJl
c3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZQ0KaW5mb3JtYXRpb24gY29udGFpbmVk
IGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwg
b3IgcGFydGlhbA0KZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBi
eSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkDQpyZWNpcGllbnQocykgaXMgcHJvaGli
aXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlcg0KYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEN
Cg==

