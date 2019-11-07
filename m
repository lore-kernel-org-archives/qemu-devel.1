Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ABCC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE842085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KQLtqh8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE842085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSn59-0000ux-MR
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iSn2v-0008J9-CX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iSn2t-0004Jn-4G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:02:16 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:36812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iSn2s-0004JO-TJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:02:15 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xA7J09bT002493; Thu, 7 Nov 2019 11:02:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=QS0RN9Zlv3sY28ulznXkHp1cDPEPugfCZ1ek6UcmFLQ=;
 b=KQLtqh8EXEaWFtxuAycmQbzBg3tAIhMrMjV3DD+jX35Kvr7T4LzIvr0y0woXGyZdawqY
 OEHZmf9b6yCtmK18wYwdW/Gn0H1GJbUuE/iDsTvaiQjcTB4jIyXhUCNJcAFgrDY4fddX
 hx5lEYOmFH6yrxn1hbG3BXxX19I394L4wfoZ6af1flFM+FLOQwyDs2T1GZyJQK/j5CJr
 sVcL88kYlZcZaiTtxw7L+xKriuL06jGogMGrknX6pA3dDod+1fH+EBVx+nvAagPC8o/l
 FsmBQp/xLVmqHVhpOKXEM3yKtsCLXZxdoFQdwtPbG4WO8Ud/Y6c+UsULj1M7hKCxtlU1 Hg== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam01lp2055.outbound.protection.outlook.com [104.47.33.55])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2w4qt306dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2019 11:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVteST2C5ULDOQY/aFVPrdSV5KqK/O7p5UQJcZRCXxLCUdH7gwecV5C7IblMnA/DwRdviCop10ufah5jmQhPbvC7WprMM9MrGkGxBK+O5afGtheqThB19YzBosoHHEAe6+TDeqlDem5kxp8vCViBa38ZRPoSFcA/tHQlY89MgoRj0PPAqxzeqbxDLoz9P1YO7KlepTbnaar17x/uE3nhpcUDUZ5JC8Bdtt8vPQgGa3dyO+rxr2hVpR+ZqDu4IO1cuzTzQIGx51NPC4lXFjR8VKLM/sKXdXd2kQc4fGydfbUkSkNqG8eorGIhqgxcMqgcI+ZPRCbbGmi6jYGwLjvvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS0RN9Zlv3sY28ulznXkHp1cDPEPugfCZ1ek6UcmFLQ=;
 b=eTC6Xe5OF7pv5s6aXa8fNGYZ/aHCeHd4AuBZpAVH5GF2qwZaf9DrEIXz5Qztih1v+O16TfwaGKOFttDUJgtgzyeFkJdGjE73rkwmUVo0YE0IpbyzozPdZNtkZKmc7PN7TO1qwe25BSPIfuadsRaMjbri/wZJ7w0QAKQinGu5ghDomwYEvdOfeAhtccDTWs+K83EFjTvstVuG+1YlsfBzrgPH2GKrDyp+BPFNrS3oSY91kKBngedcvYo3dprwvEoGg5TK+++m/mRuzr5qFfER3TfFbOZgKxS+JqkvyGKLULlUBbGwgQHs8ofdulYvL0OIPpjaKWRkO+nHIBcxEc43Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3168.namprd02.prod.outlook.com (10.164.133.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 19:02:09 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 19:02:08 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio: notify virtqueue via host notifier when
 available
Thread-Topic: [PATCH v2] virtio: notify virtqueue via host notifier when
 available
Thread-Index: AQHVk+K3eQebuztoTkGZACHISuEn9ad+BFqAgAIPlAA=
Date: Thu, 7 Nov 2019 19:02:08 +0000
Message-ID: <87FB1532-A070-4C81-A9C2-52EC462983BA@nutanix.com>
References: <20191105140946.165584-1-stefanha@redhat.com>
 <20191106063344-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191106063344-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4908a2cc-7108-4055-e680-08d763b4fd30
x-ms-traffictypediagnostic: MWHPR02MB3168:
x-microsoft-antispam-prvs: <MWHPR02MB3168E5C754A6711DC11BDDEBD7780@MWHPR02MB3168.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(3846002)(305945005)(2906002)(66446008)(2616005)(53546011)(54906003)(6116002)(66476007)(6506007)(14444005)(256004)(64756008)(8936002)(33656002)(66556008)(66066001)(6246003)(6486002)(71200400001)(5660300002)(7736002)(81166006)(478600001)(102836004)(71190400001)(4326008)(99286004)(6512007)(8676002)(229853002)(76176011)(26005)(86362001)(11346002)(446003)(476003)(91956017)(76116006)(81156014)(36756003)(486006)(66946007)(110136005)(316002)(14454004)(25786009)(186003)(6436002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3168;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rw0cBOTaD4k+mRaSMDqsiDfQ0YQOVak3iSdyN4yGRfk7rJBSlU83p1MP5P9uHGkXJ5N95p0zHKFpVaHA4fOZbspkXLJ0yzTfUAxgqhiDFYq74ppCmFiMs49k689tMPZ9qNDzqWgOXv9euDDbR1u0WAFHvEOxYB43H4PbdrRfY85d9ZulkZBrp+OSAZF6yqphKAYcHga4gTU+syIA6lqxSv0OjgXIkeLh4GkAR8J2ruz6qWuldK/7s9QigjPN4Olwkt5nUAYRsvLB4dVX1G0t2oFJALBLNtfC4SY2Q7veVAsrw15stUBajTVlzjGv3M19UBKByfwHToUCTjiN1jx8Gn/1Jz0cL9qF22dX0twg8k69kyhfwtw8+u1dV9iC7eT1Tx424f9GAUhyCwJjILagLcJbhoxWSCNTvKKQFjrmZQ0qXNUn8Q4sL2tZUOuogkQs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA0B01D7E29ACF45BCA0C4A3E76DEE52@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4908a2cc-7108-4055-e680-08d763b4fd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 19:02:08.8318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJtJu+5tNbnBL+mIKvwymIYJr2+qtE3PWv5Sq88EDyG35n2RPPMOV8i/McHoiXHzN52dip40WAWJ7dJgsSMhcBIkbp3G2UEZHW0QWYOeRVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
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
Cc: Yongji Xie <elohimes@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Stefan for the quick fix! Sorry for not adding a Tested-by.
It's implicit. :)

F.

> On Nov 6, 2019, at 11:33 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Nov 05, 2019 at 03:09:46PM +0100, Stefan Hajnoczi wrote:
>> Host notifiers are used in several cases:
>> 1. Traditional ioeventfd where virtqueue notifications are handled in
>>   the main loop thread.
>> 2. IOThreads (aio_handle_output) where virtqueue notifications are
>>   handled in an IOThread AioContext.
>> 3. vhost where virtqueue notifications are handled by kernel vhost or
>>   a vhost-user device backend.
>>=20
>> Most virtqueue notifications from the guest use the ioeventfd mechanism,
>> but there are corner cases where QEMU code calls virtio_queue_notify().
>> This currently honors the host notifier for the IOThreads
>> aio_handle_output case, but not for the vhost case.  The result is that
>> vhost does not receive virtqueue notifications from QEMU when
>> virtio_queue_notify() is called.
>>=20
>> This patch extends virtio_queue_notify() to set the host notifier
>> whenever it is enabled instead of calling the vq->(aio_)handle_output()
>> function directly.  We track the host notifier state for each virtqueue
>> separately since some devices may use it only for certain virtqueues.
>>=20
>> This fixes the vhost case although it does add a trip through the
>> eventfd for the traditional ioeventfd case.  I don't think it's worth
>> adding a fast path for the traditional ioeventfd case because calling
>> virtio_queue_notify() is rare when ioeventfd is enabled.
>>=20
>> Reported-by: Felipe Franciosi <felipe@nutanix.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> queued, thanks!
>=20
>> ---
>> v2:
>> * Track host notifier enabled/disabled state per virtqueue [Yongji Xie]
>> * Tested with contrib/vhost-user-blk and contrib/vhost-user-scsi
>>=20
>> hw/virtio/virtio-bus.c     | 4 ++++
>> hw/virtio/virtio.c         | 9 ++++++++-
>> include/hw/virtio/virtio.h | 1 +
>> 3 files changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index b2c804292e..d6332d45c3 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -288,6 +288,10 @@ int virtio_bus_set_host_notifier(VirtioBusState *bu=
s, int n, bool assign)
>>         k->ioeventfd_assign(proxy, notifier, n, false);
>>     }
>>=20
>> +    if (r =3D=3D 0) {
>> +        virtio_queue_set_host_notifier_enabled(vq, assign);
>> +    }
>> +
>>     return r;
>> }
>>=20
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 762df12f4c..04716b5f6c 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -128,6 +128,7 @@ struct VirtQueue
>>     VirtIODevice *vdev;
>>     EventNotifier guest_notifier;
>>     EventNotifier host_notifier;
>> +    bool host_notifier_enabled;
>>     QLIST_ENTRY(VirtQueue) node;
>> };
>>=20
>> @@ -2271,7 +2272,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n=
)
>>     }
>>=20
>>     trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
>> -    if (vq->handle_aio_output) {
>> +    if (vq->host_notifier_enabled) {
>>         event_notifier_set(&vq->host_notifier);
>>     } else if (vq->handle_output) {
>>         vq->handle_output(vdev, vq);
>> @@ -3145,6 +3146,7 @@ void virtio_init(VirtIODevice *vdev, const char *n=
ame,
>>         vdev->vq[i].vector =3D VIRTIO_NO_VECTOR;
>>         vdev->vq[i].vdev =3D vdev;
>>         vdev->vq[i].queue_index =3D i;
>> +        vdev->vq[i].host_notifier_enabled =3D false;
>>     }
>>=20
>>     vdev->name =3D name;
>> @@ -3436,6 +3438,11 @@ EventNotifier *virtio_queue_get_host_notifier(Vir=
tQueue *vq)
>>     return &vq->host_notifier;
>> }
>>=20
>> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled=
)
>> +{
>> +    vq->host_notifier_enabled =3D enabled;
>> +}
>> +
>> int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
>>                                       MemoryRegion *mr, bool assign)
>> {
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 3448d67d2a..c32a815303 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -312,6 +312,7 @@ int virtio_device_grab_ioeventfd(VirtIODevice *vdev)=
;
>> void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>> bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>> EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
>> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled=
);
>> void virtio_queue_host_notifier_read(EventNotifier *n);
>> void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContex=
t *ctx,
>>                                                 VirtIOHandleAIOOutput ha=
ndle_output);
>> --=20
>> 2.23.0


