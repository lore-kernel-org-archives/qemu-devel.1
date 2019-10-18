Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D417BCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118920854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="nmCq8gpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQDn-0006gi-Q6
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iLQD6-0006C0-0x
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iLQD4-0007Ca-2S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:14:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:56644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iLQD3-0007CK-OJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:14:18 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9IBAKN7027746; Fri, 18 Oct 2019 04:14:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=S15Jl9Ri+QtpkQXNZaSRLIX5l6ZsXnVYrmAPKj99EpI=;
 b=nmCq8gpf/5Y+bk9kNzRNCN0yYFPj7DQvv4xBCnHFcG404QULXyP34cQfPW+pCVsFS+Ed
 lHp+KwfpROLlF5WHdilqrdcsUBBIEiTCvF5rk4tXn1Eq+Kl4m+lkXIPaVWpXrd9Zatcd
 RSzm+TwqBbhu3c3kGclB/GkjBDm7SeT7w9mVCtrf5TCCKS6qPgruWSadP6QFIIv6eOB7
 ONq80iZFzo30IJhigU1Ezl5tJBvvBXoX4rGOdQpKhwRjQnMXkdAtQELrnzeV+szyqkzZ
 fsMK/Ndv6KgakB33Xe10AbnUteVgLNIeB8iWtkTAGzVUyoO0WbT4vLxskiJoMsEk6RVZ HA== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2vkdwgntjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2019 04:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9b486+hax5acNpueKSSMC1cGk51hE3YWeX+0owjLD9UsQHzDJoAyEx2K0v7seq4IKjEgu0yq9UR/oOYwvu7dWEGO3FO4b4Im1b1QxXb+CzlQ22cI0vBlxruL1QFUqFbKHyh7qTmwXPbnhUOVUGUkmIpeyLlUUmxWDzfrWWXamMV1B46EXpCn5q6iTsuWRwV+zpU3RjWP9V3F25OrIWlxHdc2mU3oruk7yZGRVDrj/z2//Ugv5J1PjnVmau3S6/QhcIAcOARsp9n5rcBSbAx4YcWf9GuTy5agQH/J/MVm6ViMCEnRHJCVoV67k/pEGfiafcyZ47cIJy0z1IGiKgBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S15Jl9Ri+QtpkQXNZaSRLIX5l6ZsXnVYrmAPKj99EpI=;
 b=fYd4sCOtYCmsqlDSgTDWCCC/bf6ZgQcCLjhsER3bClKzTQboQzkEFYpfY92inkr/yTgcjcGKGa3dEhHdi/Sl8uT80T0LVj1mfjHD92hxM/vdsHDLV6nvuP4LGEDKPMmJKD3UYAD3yBTwvucXHT3NOpr+6ta/CmKEyZAXXsQbjhWSG2mm4MmDhgGJzMgxJxOktuj7RvtrxftrxQ0El+wjGvazT0o5AIhxI1KhRe9FcPCVpoI61S2PgwVc60HSXJTlPqEhDZd/uUMQhYe2i6dw7OcuFZvC10tBa3z2NPD3gHc7Vi2vARNhCpKT6p/Y3UrhB92YpO5L5SKhuakkPR3gDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2510.namprd02.prod.outlook.com (10.168.205.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 11:14:12 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 11:14:12 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Yongji Xie <elohimes@gmail.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
Thread-Topic: [PATCH] vhost-user-scsi: implement handle_output
Thread-Index: AQHVhQl71p+KRszYckq7k3pyTpDK5adftgOAgACKQAA=
Date: Fri, 18 Oct 2019 11:14:12 +0000
Message-ID: <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
In-Reply-To: <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1ebc7b-69e3-4ea0-0a61-08d753bc4e3c
x-ms-traffictypediagnostic: MWHPR02MB2510:
x-microsoft-antispam-prvs: <MWHPR02MB2510EE2D5C26691831BC28A8D76C0@MWHPR02MB2510.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(478600001)(316002)(6506007)(81166006)(25786009)(53546011)(99286004)(102836004)(71190400001)(8676002)(81156014)(71200400001)(26005)(33656002)(76176011)(256004)(14444005)(54906003)(36756003)(8936002)(186003)(1411001)(86362001)(6512007)(5660300002)(6116002)(3846002)(229853002)(6436002)(6486002)(4326008)(6246003)(76116006)(66476007)(66946007)(91956017)(66556008)(64756008)(66446008)(486006)(7736002)(305945005)(11346002)(476003)(2616005)(6916009)(2906002)(446003)(66066001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2510;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVins3XX7M2P/s5oCxGkhL9by81oMoxSf3E4NzgYU/Sf45xxawdm62iGHBbvr1DY8hEAXLWWOTZkvgYMTJtbuK3jgFFEASUzw1B8vKpiETm+l8FXEan7+XkL9+2JrUT8CjCM/ktv9efXvSXL12b0yXocBhIj3BMAApiSq5LWihBtpTc+lPibBUtkKKPXUGl33MpFxPPLiTSQ4BUnSvFV9Aog1mANUVJ/MWAoW1xmyaY8W1f/fAtjZFGfVf/sBeLdQZ5S7pnezrEKnkkS2WdZb77BQVtcWjxfs5N7TziJq2paz3SbhFVaufkKCd8C52FMvDVBwt7xEG9TfV3wp7P3lqzT5M9OdhB08ZFGxGMKoC2IJ0ruxAzAp8BBnQSFsk7ADP0u++AjDLMlnDU0bGismr9OyzYvTfnBAyz8/nyvieA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CAC89C96EA11C4884DAE3391FCB9D0D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1ebc7b-69e3-4ea0-0a61-08d753bc4e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 11:14:12.6859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HP+EyYyKTd8Pk1PBqhhOG1DS+wt8ufHaNfLZhJ9894PoCbVCaPYFJlF9IWBkHso7MKqzu5I81AaO2eekfqr9Yc3azUo1B3dpXuO2//n8JwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2510
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_03:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Oct 18, 2019, at 3:59 AM, Yongji Xie <elohimes@gmail.com> wrote:
>=20
> On Fri, 18 Oct 2019 at 01:17, Felipe Franciosi <felipe@nutanix.com> wrote=
:
>>=20
>> Originally, vhost-user-scsi did not implement a handle_output callback
>> as that didn't seem necessary. Turns out it is.
>>=20
>> Depending on which other devices are presented to a VM, SeaBIOS may
>> decide to map vhost-user-scsi devices on the 64-bit range of the address
>> space. As a result, SeaBIOS will kick VQs via the config space. Those
>> land on Qemu (not the vhost backend) and are missed, causing the VM not
>> to boot. This fixes the issue by getting Qemu to post the notification.
>>=20
> Should we fix this in vhost-user-blk too?

I'm not sure vhost-user-blk suffers from the same problem. Certainly
vhost-scsi does, but I'd prefer to tackle that separately because I
can't trivially test it. If it breaks something there, we can revert
it without affecting a valid fix for vhost-user-scsi.

I can send that patch immediately after this is queued (or resend a v2
including both patches separately if maintainers prefer that).

F.

>=20
> Thanks,
> Yongji
>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> ---
>> hw/scsi/vhost-user-scsi.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index 6a6c15dd32..13278ed151 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -62,8 +62,9 @@ static void vhost_user_scsi_set_status(VirtIODevice *v=
dev, uint8_t status)
>>     }
>> }
>>=20
>> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq=
)
>> +static void vhost_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>> {
>> +    event_notifier_set(virtio_queue_get_host_notifier(vq));
>> }
>>=20
>> static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>> @@ -80,9 +81,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, =
Error **errp)
>>         return;
>>     }
>>=20
>> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output,
>> -                               vhost_dummy_handle_output, &err);
>> +    virtio_scsi_common_realize(dev, vhost_handle_output,
>> +                               vhost_handle_output,
>> +                               vhost_handle_output, &err);
>>     if (err !=3D NULL) {
>>         error_propagate(errp, err);
>>         return;
>> --
>> 2.20.1
>>=20


