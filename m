Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B1D215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2YOKQ8V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B1D215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92tD-0003U1-4Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1j92sY-00031h-RA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1j92sX-0001Te-7K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:26:14 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:57238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1j92sW-0001TR-Tw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:26:13 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0238Lgho013372; Tue, 3 Mar 2020 00:26:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=6v7oik001p5XngFt46kzYJtq3SdsIXs6oMO/AQPW8C0=;
 b=2YOKQ8V1GO1R9SzdNOTYK5+drf8rMwl6FXY7mMaNs7ZjNjXmnMp4T7vaP7OOhlCWjot7
 S3ybxZJt95Rkgsa7eUQyUwRMmQWqgTSpqayXMwJD9Col4gmhEZY/fjFPUdE+XyPhwwyn
 A5lt2bz5sjnMp9RdKCW3Lzduzu3P8SerKtyCdET8eeeB9JUYnES9k3nUvHFXdPy9eR6x
 TaWrsdEBPxDDlUSMK2viuSFkRuernXlEFvOEJiQCFgZ478DlVJRA56IhflglZyPSREGy
 k6VjTcR7jJM45ePChYK+V5J7nRE0404fc2vszr/PcXJSZhlr5OBF7cFjAlgwPe6ZnCNR ZA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2yfrd4x71y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2020 00:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4+s3fa6XImjV9LvAREtG044CUqnrB9P1NHLDrCrCuZSAiwn9DkyTiZUMPHsYKNZziCpT2hx0iuOAkSCZ6RUIl/9s+YSYvhhnpgq2PdP6CKVsnRu/Y6IdhKg0FoyHD9v9gBMIhltJN88ChXGehjb2rI/IgmlGBCUN3wumenGWHTGA8BGJm6Tu+o98YxjvdG6CdrjD/NlXQ8h8vfUwDbhTUNzf6vpeMNtKUFJZTdRZcQmddCsjYzHNetv9I+tPuh7OWNCGOa8nZTZ4lDP1991+WMPeupvPxFWW2DCXv96jH6PJvkRTwQZ2poUX6FEOePtwIG42RMsMAT5skwtBTfESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v7oik001p5XngFt46kzYJtq3SdsIXs6oMO/AQPW8C0=;
 b=OmVUANpSStwVw5PsCogngOiMCZcNflhUj8/KRTaCR4QY0PMtfS59+K7yVI1KFv1Hld3kXhaP5ZLNcSGrpV8+eXY3qnKdVJnXGlrRM01fNmODD2V4yli2zYlXrSB1Q0hJlzEGW5ROjSZt2+JgDQjY3Np9EFhtsfOun4ai/vgthQhL+fqybuTcS+FFX9OB9gwmN38DTrJIF2IjuVYIef1cpv103t9lvZAreBWc+G+L8m/eliq3sB+7FykP10xT7MDtfACaeZtvzP73mpQ/dbzEv0L1tPXAnW5E4/DLqKmoTiltiZfUgzY27ZSUogEfKkER7FLAcDHI9en+Wk4epigheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (2603:10b6:300:45::14)
 by MWHPR02MB2493.namprd02.prod.outlook.com (2603:10b6:300:43::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 08:26:09 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 08:26:09 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v6 0/4] Improve default object property_add uint helpers
Thread-Index: AQHV211IMbV0oM7QCkSeM+CVGLRnMKgLCu6AgCujaYCAAAVugIAAAEcA
Date: Tue, 3 Mar 2020 08:26:09 +0000
Message-ID: <709777EC-83C6-4633-9C55-3ADA9AF9D295@nutanix.com>
References: <20200204131601.125677-1-felipe@nutanix.com>
 <CAJ+F1CJLvKtSnFFurBUy4LcP+DqNTtqHd4oevJADfW8JEVuXXA@mail.gmail.com>
 <64CA08E4-01C2-4BB8-B2B0-163406E1CD6F@nutanix.com>
 <1976a1de-f02d-6ddb-f020-e2609618bea7@redhat.com>
In-Reply-To: <1976a1de-f02d-6ddb-f020-e2609618bea7@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b23524d-363d-46a2-d958-08d7bf4c8689
x-ms-traffictypediagnostic: MWHPR02MB2493:
x-microsoft-antispam-prvs: <MWHPR02MB249396843B9F5853113442D8D7E40@MWHPR02MB2493.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(478600001)(6486002)(6506007)(558084003)(26005)(4326008)(8676002)(81166006)(36756003)(6512007)(8936002)(81156014)(186003)(53546011)(86362001)(71200400001)(316002)(33656002)(91956017)(54906003)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(6916009)(5660300002)(2906002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2493;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT2UdIe1xfwKJfSVUkYvZOWyZVisUJ98o1ZK4Kv5Ge6ABsjcPsJRbvnUBuMML0m2UaPOuZfzcfxi8tSJIA5zFqJwruKK5fjF5h8f4d3ra8zn+HW1P2aNmdOOl57iNdsIXXfN7bjSAb9QTYdVofi6rnacPL+Gz8W/A1kplZHrpbJkkUF154YCbGi/NXN088YeV3+D/1QLlathx9iQpzjn1ZeUFtpxyTHYuvfmjsOAcSmqCWpN4JV0hok5aTPj/CyVXFzayUSjFRYxzhENV9FqEfjXZYxgZxw2xphSnMQpuJ/4acEbDixQlbUpSyBkc7fyH3eU/HYvoC7cyD4GIEttsX5qagq4MuluqOGIMg5ySBHfDndkdWhLLlpnGdH+XZ48GBOvFNhNdd2LntgaZ+83l5Acaw3CVNBsZfBlsnGK7pXeQftEchYdFT3G+SfEpDAw
x-ms-exchange-antispam-messagedata: BlhHXg/qo/l1DrP6MdHkiMCryGRNeQAEu0VdrOePVoeZWKZmveJcmRCMLv2BvXDZQCLZEDwX7sxvl9nt+LJ6Lp+dqUCV2H0QJFdcqJtRdset0BQwfjGZCYmRIkHu6MYs+fAQySA1TaieZVj0c9d+OQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D51956CB1460E84F97B53D2758C9AAB1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b23524d-363d-46a2-d958-08d7bf4c8689
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 08:26:09.0665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkZeE95c5qg3FpFmJhelfkJupcE6MPhNj9/IeNRVWiffMRcvfzXo53HFfGQaYezExyb4XebsXjX+4fj87jI8yOJf27Ryhz+d6RiMaHZ7zco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2493
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-03_02:2020-03-03,
 2020-03-03 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Mar 3, 2020, at 8:25 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 03/03/20 09:05, Felipe Franciosi wrote:
>>>=20
>>> Paolo, would you queue it?
>> Ping: did this get lost?
>=20
> Yes, I have queued it now and fixed the conflicts.
>=20
> Paolo
>=20

Thanks! Sorry for conflicts, I should have pinged sooner.

F.

