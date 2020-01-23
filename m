Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4827C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6728421734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DN8ZN+n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6728421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iujEP-0001r2-I6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iujDl-0001Ii-7S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 15:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iujDj-0005Go-N4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 15:36:56 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:44000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1iujDj-0005G1-Ba; Thu, 23 Jan 2020 15:36:55 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00NKWUYZ022140; Thu, 23 Jan 2020 12:36:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Tuv5jqw5QmhmQpvZ8GFUn2eYQCCsKE1BtAU0GDnO2B4=;
 b=DN8ZN+n4KuBH0AoKShICLIDwqd2bWHopjS6NKztip1WYrd6OUQdtYSPZSvnt6i5kgt0b
 uNcnYspFP3HS/MCEUT+8NuKiEKERPe1nvdmvSCuVUsR7joFTkEVILu/vsgCJNP+zXJ7p
 8zDlcC/G5gNJ+kh7ATKZ49mfJ+KXwbWFzp2lDwVg6bgpBfRJXUVnKy+CGnp0N+neEes0
 xI6DgD6CSViuVOxjsjg3Y6ZemJRYzs4e61WkwRWfX1RsgblggcM+MnoRlMdeReXGO4pC
 8uGKOXDiGUVqIp/WEziz+fq+dy+TLQbhpq3wXqbusxk0MmNoykmasAJ9HrxKfvKvMMh0 9w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xp2jm6ar0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2020 12:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToG1I9GiZCzfdDMXttTWQSF3GrQiY45kZQECZN5Q0xmAyaRImM5erH22VhGA8BjEty2Bvr+IcnnRyRe0L2AztxnNzjtEjZRlQxN6cpjcddc3zTUdJMDe3yEa6b2fcwP+XuV3n9sDusPgTOeantx4ljw2ga9mtwOrhkYrdVW8eYjh5ibXb/oFvDpPcucquIKHtCddODWyzBlivNqTtvmvY4m00ISlFFyoT2WFo2c48k4sNX1iSySxIhha1qAff6gfB2hoykvNkWJC7uN7W34RE281w/OwhNv960gYhq2klC3YWk/0gJhaJYHXqIjSOh7hZ7IGQI6fPyhfRxRoptETaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tuv5jqw5QmhmQpvZ8GFUn2eYQCCsKE1BtAU0GDnO2B4=;
 b=m9Clzz0OTAF74+WdScwM1moe0PJGKJ9gu/S2tQeJA+W7W/9MDTeUkZA5NEWn9pzGjM27rb3olpOjmwLvU8liAi+C4p35/vQBUSAMWXN1gWOUPQ3IHaH543kCRptPLvxPZqOFFRGAfAf5kdv2jmdLZ3w7s4HMod7pmIHFRNeIa3QpZuLFcQoLleklHzafJUDiyhVouioOBjcp21+gNcfKDMjkFxh7i1Hv9QXEt4xwATJna9Zgqvu7TmfKseU3xFD211oi4b1NgTsDK6g4RRMre/vpTvo4ndlHu4PAJ6g5lzR0xzDhFOX5rHgboOiMINQ+SGgGlog3b0MQf/n9rsrgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3311.namprd02.prod.outlook.com (10.164.192.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Thu, 23 Jan 2020 20:36:42 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Thu, 23 Jan
 2020 20:36:41 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Thread-Topic: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Thread-Index: AQHV0hW67ghj9TBwskeYoa3E4EVIUKf4tXeA
Date: Thu, 23 Jan 2020 20:36:41 +0000
Message-ID: <C0FB7A0D-AB62-4B99-A56D-F51A1F267793@nutanix.com>
References: <20200123170544.30117-1-kwolf@redhat.com>
In-Reply-To: <20200123170544.30117-1-kwolf@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2133d09-9018-4283-6acb-08d7a043f457
x-ms-traffictypediagnostic: MWHPR02MB3311:
x-microsoft-antispam-prvs: <MWHPR02MB331147C9BF5D1B169347B38DD70F0@MWHPR02MB3311.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(189003)(53546011)(498600001)(186003)(86362001)(8676002)(8936002)(33656002)(81166006)(26005)(81156014)(6506007)(2906002)(54906003)(4326008)(6512007)(6486002)(71200400001)(2616005)(4744005)(66556008)(76116006)(66946007)(6916009)(5660300002)(36756003)(91956017)(66476007)(66446008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3311;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQnJN57INRetwc8yIpDCNOfzSMPSpRDruY1j7B/amuhw1Xe4L8zZFUKOUW6fnA/RfqnxdpsmMo5zr+lvBbnnso3ep3vfmX1I7JWNz63CTl1Wb8Hicg1vVKLuQBIkUiK8CcX6voVEGl5b3li1Hz2rVeWQUE12922TYI9AZ848PTURoTRaDl7G3Gd0wVZLOD+uzPil9mLhPvkvoe01r167jHbcBiTFrbUKonnosKqvl+Z2G8wL7kN1v9BQJmTy7giJVZizXBGRMxviTPwZdUFMI87KVS28DcmGzAaD+CyRS+md1fpf4oSLbbiaBlB6ZHo5n6q0YhKz3oRRgm6l+u6ZDb8KQTgsf0r7CaK0VuzCyapl43IeK3PNAaecrtjx10qoE3NYsX7zxpT+08HireDB8q8+JQMR5A1gndDy/EHSS3rfYjv4dQ7jMvDkcIM1xRCX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BE031113056B54692D77331D7628DCC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2133d09-9018-4283-6acb-08d7a043f457
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 20:36:41.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lay5sD8fqGZLQq3T5GSwVPa1QimW/mcvo2ARgpy1ewCyJobRn8iVhs1pN2UDSVireIxcFrd91lnt/H2PRq8JOs14KP/4Or86qLdEVf594e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-23_12:2020-01-23,
 2020-01-23 signatures=0
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "pl@kamp.de" <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jan 23, 2020, at 5:05 PM, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> In iscsi_co_block_status(), we may have received num_descriptors =3D=3D 0
> from the iscsi server. Therefore, we can't unconditionally access
> lbas->descriptors[0]. Add the missing check.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> block/iscsi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index cbd57294ab..c8feaa2f0e 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -753,7 +753,7 @@ retry:
>     }
>=20
>     lbas =3D scsi_datain_unmarshall(iTask.task);
> -    if (lbas =3D=3D NULL) {
> +    if (lbas =3D=3D NULL || lbas->num_descriptors =3D=3D 0) {
>         ret =3D -EIO;
>         goto out_unlock;
>     }
> --=20
> 2.20.1
>=20

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>

