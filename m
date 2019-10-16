Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D2FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FD62168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="dsDVcQUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FD62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKikP-0007aP-Fq
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKijR-00078O-Ks
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKijP-00072I-MN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:48:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:19756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1iKijP-000724-FW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:48:47 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9GCjLIU026300
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:48:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : subject
 : date : message-id : content-type : mime-version; s=proofpoint20171006;
 bh=ZqBdEt61l2m3RvTAhhyMquLh2FJY+MpNJQ8EuKf0enI=;
 b=dsDVcQUdrEoWKvk87aq0U/XDX4wtlikKgO+cb96UkTqg0m0BNg3HZkVX0mB/R09NatAT
 qtfYSjVuKTnAR0/DKXFW+AFY2ADtzeWdMAa2wUxaheV9ZPlHxxu2JBvb222SW4wAPdA2
 JbLFU5q7E7umIPhQHTCjNeb71kYxBBe/v+OZyMmwpXK0GxZpJdXHeNcRc4Yxbih5zOPn
 RPlFfz4tsXIXctBWS4tH/OyJEq6e32zEa4pkYOf8HRMIVBD1EAUHVimhtL7mBH5npU4W
 QZ4F9JQ2hoJVFOD/hfCiMw0Ta5+cHqcfUBfSO8TUZzLHBixs1udaDZEk4PbuH0TDYHm/ 1Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2vkcxjrc1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmi6dRq0Pd8WDTJGxW/Nd27aTG7hgq58FCYH7HCzJh60WX3DvtJUjLfXVVlZeFdzFqKzF8F3x/VMSaccmOnjlpubdXgGVl+iYDluj8TpkBa6vzDc/PCnziHKVJXocTxqJOrTibrvMHj18opfC5z/tPQYbsHm4vm6B1b9rnegl9PskjB6ddSNsvE6YsXIXpw+E2iCwEvfEUUtERwIG7syl3KG0blmoAawgENO7ET5R8O0twxrdjp75tDUiF0eNLw/d3XuZjLkbSB8D3AJxb8GX//pIIiy0+wqoCDmnGymy2mhy8EqZfLFRf+MDIQgUOnDKTleJOVpRaRurupBIbfXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqBdEt61l2m3RvTAhhyMquLh2FJY+MpNJQ8EuKf0enI=;
 b=WmKyOsB0giaQ+x5nB74lDF9s6aiTwRocgKeu/UPdJXldy+ix1S3xpiU1Hn4Ok26mT0zizN1cOnU/VkTkSAtQwa6cpUgO2wLb5vnZCUa4XR/wRFT4p4Sq0yOhkBHN9tR1px3xy+hHjtz08Y4eF5lkIEfz9BuIOjf6HxwTS9GCyR/pRBfHH9HKw3HySulFmG0aIzmaf0SpuNB92G3P17KLE2wuwzAADNJLEHrHuxFWipRPPaDCBTp9NZdHa7h5VNTeQ9ziInQmf0z967bfKski0GBb9GvWLch06saDT5TAbiOn6rIgtF2QvS4t2Gr4zG1J2vTv5z6dU701dV7LIGoCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB5135.namprd02.prod.outlook.com (52.135.99.152) by
 SN6PR02MB5629.namprd02.prod.outlook.com (20.177.251.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 12:48:43 +0000
Received: from SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba]) by SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba%2]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 12:48:43 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: TOPOEXT and CentOs 7 guests
Thread-Topic: TOPOEXT and CentOs 7 guests
Thread-Index: AQHVhCALCLRy80IVsUW+6b2LGtEckQ==
Date: Wed, 16 Oct 2019 12:48:43 +0000
Message-ID: <113f8174-8b0a-4574-9a64-45d5cfcce0cc@Spark>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.68.105.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc8e3f37-c950-4da5-a7cf-08d752372da8
x-ms-traffictypediagnostic: SN6PR02MB5629:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR02MB5629984BCE2FA9E7417AEF9EF1920@SN6PR02MB5629.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(66446008)(66476007)(33716001)(21615005)(2906002)(66556008)(6916009)(476003)(6116002)(3846002)(486006)(6436002)(256004)(7736002)(6306002)(9686003)(236005)(44832011)(6512007)(64756008)(5640700003)(54896002)(66946007)(81156014)(81166006)(8676002)(8936002)(2351001)(6486002)(76116006)(14454004)(31686004)(91956017)(316002)(99286004)(186003)(26005)(71200400001)(5660300002)(2501003)(966005)(478600001)(86362001)(606006)(6506007)(31696002)(25786009)(66066001)(102836004)(71190400001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB5629;
 H:SN6PR02MB5135.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPvMp5P8XrxUkFcAmD9ZLUosSNVMhKMnbDg0X1yxr6DeYS7Q7Qe3fomJIzOvgZuk9CkvJ/GiPTAqIMYL/WI25GKIqzjoluMlPhnpo/vB2IVcoka6VkCvsZzgA/NDtvZusjq1BhbWjj7waYpmJyGkwkoOiQUHkpXbbmfktJwJTs5a7Zj8ftJxKYX2SFd+QHSOe6atFp6BDnfcMJKGHjcImwRZ5WkU5YjXHDDTTDYilnsmXX8h/UWAtVo2NnmQ4Yf0rWqo5dzBGf+6BgnWU5R+79ox6UKrBkSKlA06DtFV+zDGO5Edg6OwYLN68HCQ5E8GeWgJr+4UY6n0EagqbNYRc/skt+kvdrMnOuTLkXHoB1n2p6svgCP2oEq2BqNdf/GM5NzBTW1RTBmzt7NRT7kDqxj6/OtT9Q/FpLZ4EA3Tzh/qAeobTHjqTEBoANtjo8SKmaBi2l4xvRzZdMUpBB/11A==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_113f81748b0a45749a6445d5cfcce0ccSpark_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8e3f37-c950-4da5-a7cf-08d752372da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 12:48:43.6490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juvZRYBlNsf59e+k7c9wzUihSrEtNs/y13ZSVS0z1Ma9GUykrH9D118ftkigCmQtJ5e9AwX5XIyU2vtTh01YmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5629
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_113f81748b0a45749a6445d5cfcce0ccSpark_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgOg0KDQpJIGFtIGxvb2tpbmcgYXQgYSBwYXRjaCB3aGVyZSB3ZSBkaXNhYmxlIFRPUE9FWFQg
d2hlbiAtY3B1IGhvc3Qgb3IgLWNwdSBtYXggaXMgcGFzc2VkIHRvIHFlbXUgOg0KDQppZiAoY3B1
LT5tYXhfZmVhdHVyZXMpIHsNCiAgIGZvciAodyA9IDA7IHcgPCBGRUFUVVJFX1dPUkRTOyB3Kysp
IHsNCiAgICAgLyogT3ZlcnJpZGUgb25seSBmZWF0dXJlcyB0aGF0IHdlcmVuJ3Qgc2V0IGV4cGxp
Y2l0bHkNCiAgICAgICogYnkgdGhlIHVzZXIuDQogICAgICAqLw0KICAgICAgZW52LT5mZWF0dXJl
c1t3XSB8PQ0KICAgICAgeDg2X2NwdV9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVfd29yZCh3LCBjcHUt
Pm1pZ3JhdGFibGUpICYNCiAgICAgICAgIH5lbnYtPnVzZXJfZmVhdHVyZXNbd10gJiBcDQogICAg
ICAgICB+ZmVhdHVyZV93b3JkX2luZm9bd10ubm9fYXV0b2VuYWJsZV9mbGFnczsNCiAgICB9DQp9
DQoNCmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4
LTA4L21zZzAxNjQxLmh0bWwNCg0KV2UgYXJlIHVzaW5nIGEgc2V0dXAgd2hlcmUgd2UgcGFzcyDi
gJxrdm02NOKAnSBhcyB0aGUgY3B1IG1vZGVsIGFsb25nIHdpdGggb3RoZXIgaHlwZXJ2aXNvciBD
UElVRCBjYXBhYmlsaXRpZXMgYXMgZGV0ZWN0ZWQgYnkgbGlidmlydCB0byBhIGNlbnRPUyA3Ljcg
Z3Vlc3QgYW5kIHRoZSBndWVzdCBpcyB1bmFibGUgdG8gYm9vdC4gV2UgYXJlIHVzaW5nIGEgQU1E
IEVQWUMgcGxhdGZvcm0gYW5kIHdlIGhhdmUgdHJhY2VkIGl0IGRvd24gdG8gVE9QT0VYVCBmbGFn
IGJlaW5nIHRoZSBvZmZlbmRpbmcgQ1BVSUQgZnJvbSB0aGUgaG9zdCBDUFUgd2hpY2ggaXMgY2F1
c2luZyB0aGUgaXNzdWUuIERvZXMgaXQgbWFrZXMgc2Vuc2UgdG8gbm90IGVuYWJsZSB0aGlzIGZs
YWcgYnkgZGVmYXVsdCBvbiBhbGwgb3RoZXIgZ3Vlc3QgQ1BVIG1vZGVscyBhcyB3ZWxsIGV4Y2Vw
dCBmb3IgRVBZQyBhbmQgRVBUQy1JQlBCPw0KDQpKdXN0IGxvb2tpbmcgYXQgdGhlIGNvZGUgdmVy
eSByZWNlbnRseSBhbmQgdGhvdWdodCBJ4oCZZCBnZXQgYW4gb3BpbmlvbiBmcm9tIHRoZSB3aXNl
ciBxZW11IGNvbW11bml0eS4NCg0KVGhhbmtzDQpBbmkNCg==

--_000_113f81748b0a45749a6445d5cfcce0ccSpark_
Content-Type: text/html; charset="utf-8"
Content-ID: <C8F27458810AB34984E10FB2952A5BAB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiPg0KPGhlYWQ+DQo8bWV0
YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11
dGYtOCI+DQo8dGl0bGU+PC90aXRsZT4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBuYW1lPSJtZXNz
YWdlQm9keVNlY3Rpb24iIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IGZvbnQtZmFtaWx5OiAtYXBw
bGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsIHNhbnMtc2VyaWY7Ij4NCkhpIDo8YnI+DQo8
YnI+DQpJIGFtIGxvb2tpbmcgYXQgYSBwYXRjaCB3aGVyZSB3ZSBkaXNhYmxlIFRPUE9FWFQgd2hl
biAtY3B1IGhvc3Qgb3IgLWNwdSBtYXggaXMgcGFzc2VkIHRvIHFlbXUgOjxicj4NCjxicj4NCmlm
IChjcHUtJmd0O21heF9mZWF0dXJlcykgezxicj4NCiZuYnNwOyAmbmJzcDtmb3IgKHcgPSAwOyB3
ICZsdDsgRkVBVFVSRV9XT1JEUzsgdyYjNDM7JiM0MzspIHs8YnI+DQombmJzcDsgJm5ic3A7ICZu
YnNwOy8qIE92ZXJyaWRlIG9ubHkgZmVhdHVyZXMgdGhhdCB3ZXJlbid0IHNldCBleHBsaWNpdGx5
PGJyPg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgKiBieSB0aGUgdXNlci48YnI+DQombmJzcDsgJm5i
c3A7ICZuYnNwOyAqLzxicj4NCiZuYnNwOyAmbmJzcDsgJm5ic3A7IGVudi0mZ3Q7ZmVhdHVyZXNb
d10gfD08YnI+DQombmJzcDsgJm5ic3A7ICZuYnNwOyB4ODZfY3B1X2dldF9zdXBwb3J0ZWRfZmVh
dHVyZV93b3JkKHcsIGNwdS0mZ3Q7bWlncmF0YWJsZSkgJmFtcDs8YnI+DQombmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7fmVudi0mZ3Q7dXNlcl9mZWF0dXJlc1t3XSAmYW1wOyBcPGJy
Pg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO35mZWF0dXJlX3dvcmRfaW5mb1t3
XS5ub19hdXRvZW5hYmxlX2ZsYWdzOzxicj4NCiZuYnNwOyAmbmJzcDsgfTxicj4NCn08YnI+DQo8
YnI+DQo8YSBocmVmPSJodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUt
ZGV2ZWwvMjAxOC0wOC9tc2cwMTY0MS5odG1sIj5odHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0wOC9tc2cwMTY0MS5odG1sPC9hPjxicj4NCjxicj4N
CldlIGFyZSB1c2luZyBhIHNldHVwIHdoZXJlIHdlIHBhc3Mg4oCca3ZtNjTigJ0gYXMgdGhlIGNw
dSBtb2RlbCBhbG9uZyB3aXRoIG90aGVyIGh5cGVydmlzb3IgQ1BJVUQgY2FwYWJpbGl0aWVzIGFz
IGRldGVjdGVkIGJ5IGxpYnZpcnQgdG8gYSBjZW50T1MgNy43IGd1ZXN0IGFuZCB0aGUgZ3Vlc3Qg
aXMgdW5hYmxlIHRvIGJvb3QuIFdlIGFyZSB1c2luZyBhIEFNRCBFUFlDIHBsYXRmb3JtIGFuZCB3
ZSBoYXZlIHRyYWNlZCBpdCBkb3duIHRvIFRPUE9FWFQgZmxhZw0KIGJlaW5nIHRoZSBvZmZlbmRp
bmcgQ1BVSUQgZnJvbSB0aGUgaG9zdCBDUFUgd2hpY2ggaXMgY2F1c2luZyB0aGUgaXNzdWUuIERv
ZXMgaXQgbWFrZXMgc2Vuc2UgdG8gbm90IGVuYWJsZSB0aGlzIGZsYWcgYnkgZGVmYXVsdCBvbiBh
bGwgb3RoZXIgZ3Vlc3QgQ1BVIG1vZGVscyBhcyB3ZWxsIGV4Y2VwdCBmb3IgRVBZQyBhbmQgRVBU
Qy1JQlBCPzxicj4NCjxicj4NCkp1c3QgbG9va2luZyBhdCB0aGUgY29kZSB2ZXJ5IHJlY2VudGx5
IGFuZCB0aG91Z2h0IEnigJlkIGdldCBhbiBvcGluaW9uIGZyb20gdGhlIHdpc2VyIHFlbXUgY29t
bXVuaXR5Ljxicj4NCjxicj4NClRoYW5rczxicj4NCkFuaTwvZGl2Pg0KPGRpdiBuYW1lPSJtZXNz
YWdlUmVwbHlTZWN0aW9uIiBzdHlsZT0iZm9udC1zaXplOiAxNHB4OyBmb250LWZhbWlseTogLWFw
cGxlLXN5c3RlbSwgQmxpbmtNYWNTeXN0ZW1Gb250LCBzYW5zLXNlcmlmOyI+DQo8ZGl2PjwvZGl2
Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_113f81748b0a45749a6445d5cfcce0ccSpark_--

