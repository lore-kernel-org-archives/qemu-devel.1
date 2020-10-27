Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CEC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E24221F8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kzfGbeQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E24221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOge-0007Br-6H
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kXOd1-0003Ma-Po
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:03:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:64484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kXOcy-0002ya-Si
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:03:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09RClYSt010998; Tue, 27 Oct 2020 06:03:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=LcOaBqEAVlQN2L4HNYcx7FRr9B4Q45XSocWfUDo20YQ=;
 b=kzfGbeQsJCrAoDWeOZR5HNaejulRx2yJBNhw/wARt4NFS3jN9VennaM9Hpa45MpsTAC0
 RPR86su1CRx5+HDeYRWDKd/QeOMDPDMN+QgpxDZf2CWS365Kcp38SyBnbAqCecIeG1ao
 QzLlzGkwvmmcocYDnaPXOYQGXeTWhLGbTwiTFw95dk3fFVgU8vmZZCNDaBL5Yj/cxk+m
 UGe8lkzku+Hwzp5UJ0dxRPQb+wJlUtdJl1hO00t289Gy7pkgy4U8CKPRQbxr4+H3E0xT
 lLNlstHdeq+ZGiKDoA+mTzwouHE9eYfxW/CGaHTe1WrUkYk1oKeWlcG94GcEe0EwOLEx WQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-002c1b01.pphosted.com with ESMTP id 34ckbgdsqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 06:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TffVSULqwh5ZXLimmQYyY3d13j40HoXFHAfPiKcpxC7/oQiTXdS8h3SRyLzkP8kSzfKt3OMYO6v8+AklyINud0TBAl4s6sNKYPbvTECzXnw2Ha1wKAn4liQ4ZVzHxkP2EFtRHZgiaR2/OFs30++6BEXSkdUyBwP80zbKQh7ggIMOnxc4XNORAtXvEcAVDPOmsUjVV7PUBOYFjTA4DvnKR70tLTyudWnnISrxDPxdBbOdE4NJbX1yEtNPc/gj5tkTkv7Of12ch5iJUt00Iq3B/eSQli1vpXh88aQ3EXx5gRdIkCYrqrs7Lz0IJ1rYeyRnkqM95O1NsgRhvYiy9t9lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcOaBqEAVlQN2L4HNYcx7FRr9B4Q45XSocWfUDo20YQ=;
 b=kRk9ueFgVrXR24lUp5VSa4FzF7VaB23kWQFgpvdIc8LpFwKEmb7whkE2SZSGkhXV58gjuF/TSV9rJ/oFxczahdjVZofJXq2dXyYxNnmEAuBcDn0PzGGKgNNxrukTwBoEoJ53hZGAXlIxZS2BHzIxwG6qe8ev6ASernBFiY4hm/XYkR6F78d4UysUSM4mMnxQ2VUX0i42vxMfGJKgfzQZuZuCXCb8gfe4S7mu4FW/hKAGVzTOlPFtFHFYdh67VxxCy7sVsctYp8X6jHT1nR26P1/pfbVSJIWXyEMuq4fndrmWrD1W/BSnydN0WhHEEyFnUb6d79++M4WBJNLJcaqu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BY5PR02MB6644.namprd02.prod.outlook.com (2603:10b6:a03:20b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 13:03:00 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb%6]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 13:02:59 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: skip guest index check on device load
Thread-Topic: [PATCH] virtio: skip guest index check on device load
Thread-Index: AQHWq6qTShdeDwCex0GyOhjCQ5NUC6mrUeeAgAAPXICAAAe8AIAAAMMAgAAB5oA=
Date: Tue, 27 Oct 2020 13:02:59 +0000
Message-ID: <AE57D4EC-2C3C-4C22-9203-38A61D87B31F@nutanix.com>
References: <20201026151328.77611-1-felipe@nutanix.com>
 <20201027113049.GH79063@stefanha-x1.localdomain>
 <20201027082337-mutt-send-email-mst@kernel.org>
 <12146644-5D22-4CAC-9B4F-F16E84ED56AE@nutanix.com>
 <20201027085447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201027085447-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c4068ed-ba1f-4040-9319-08d87a78a1ab
x-ms-traffictypediagnostic: BY5PR02MB6644:
x-microsoft-antispam-prvs: <BY5PR02MB66448B4FB6E39B3A5A988F82D7160@BY5PR02MB6644.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZMzYI77QxoPHJEgXxlgmC6FfUcUf11I/x51H+n5NPxtFdiSgvh2PODBRltJVYTlLcL9UkwdcZo8jVOARznkU8wjYphaGdq4DNCxTKs2mwh5JS+mj+uGd7NcgVHUkSzXuADx2JcyjqGvxHSbbeC4hKr/LabYYD4KUMZ8ZHabCsVb+0cQHyLTeGIAvzL4aSa5mDxs5YRWoRWBtQA+3F5Mp9FF31lFMmYx6/Q/s/OKFZbvt0eFzdhOCUprX9ehBC0Xvm6NZLLfw219SD1fjRSufbAGtvtU/8ZoMCW4bgvPZiW9uHYb2ug4+iea6HGkynTFlKG3LzpkklIx+he+aj/Jcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(53546011)(6512007)(316002)(8936002)(478600001)(186003)(64756008)(66556008)(66946007)(6486002)(76116006)(66476007)(91956017)(26005)(5660300002)(66446008)(83380400001)(33656002)(36756003)(6506007)(8676002)(54906003)(2906002)(2616005)(86362001)(6916009)(4326008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UJtU2aEv+EnJ0Tpk3pIogkd3UfN61h2kSISJWizA4oqD25Y4Hp8aRYr2/swM+JJhpNjoRlldaVVZ5h8DQYoCbRGRQDEaXhfmmEMfV+7PVEj/lCm/m2ChT3UhFxBlhd4aVk7HKap/mrISDxYZIPED3QqBXQrdut1Vna2HLQcOYUbsvPFn1AbNweg96/ZzxiWHq2oENxdHa4BRV40nY+F86giZbNZfjJN+w6nN6yFiKE+IeMoJQZCyxRYcfKt2knARznBi7MreW4guZBI0OCdDym8x3INkdd/GM7ZwgKBAQeDeckxkQlN8qwKAAM0WbmvBKexclyJEtMTb8Z09Q6pcbWOkH9c6jWZr50sZy7baL47L9SUG5hYXAfqrg5LkxAvI7mdQMWppZKJ5HyedrFpXwrt8O49aV2F+6f/dnRD2cAhtVSBtWjGWOwhFgsKXdJ6udUeeZn3MTL6KQRNMIZVsF1dmauzN1zhQirHMiOsly6PY1uGlzXFqOzgdVYNtUiWSq0z7r/dWAa8B50ega1Lzwz3rj4Opu93gUAJ+YCJ05hDK9E7z1zcoj9Ex1GlKMdorSdVOSARA29rPRfC9Lk5uRteIMXFotnySiywr/B3fsHnPW5Sea9PB2k1WwY3M+gASn78EHCsBbHL4UuYVCNT9yQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96CFDDED32125B469D5750700134F6B1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4068ed-ba1f-4040-9319-08d87a78a1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 13:02:59.8766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTTwKpb/a4KGEUp/2bD4cBaf5GD6kTtgqaXf9ndzLaJqJAp1NrC9MuWFrB1yvCd0FSVrk3H4hWJt2ZpMWtoGp8XLvmj1TgjUN5yl0n77njI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_05:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=felipe@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 09:03:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Oct 27, 2020, at 12:56 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Oct 27, 2020 at 12:53:29PM +0000, Felipe Franciosi wrote:
>>=20
>>=20
>>> On Oct 27, 2020, at 12:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>>>=20
>>> On Tue, Oct 27, 2020 at 11:30:49AM +0000, Stefan Hajnoczi wrote:
>>>> On Mon, Oct 26, 2020 at 03:13:32PM +0000, Felipe Franciosi wrote:
>>>>> QEMU must be careful when loading device state off migration streams =
to
>>>>> prevent a malicious source from exploiting the emulator. Overdoing th=
ese
>>>>> checks has the side effect of allowing a guest to "pin itself" in clo=
ud
>>>>> environments by messing with state which is entirely in its control.
>>>>>=20
>>>>> Similarly to what f3081539 achieved in usb_device_post_load(), this
>>>>> commit removes such a check from virtio_load(). Worth noting, the res=
ult
>>>>> of a load without this check is the same as if a guest enables a VQ w=
ith
>>>>> invalid indexes to begin with. That is, the virtual device is set in =
a
>>>>> broken state (by the datapath handler) and must be reset.
>>>>>=20
>>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>>>> ---
>>>>> hw/virtio/virtio.c | 12 ------------
>>>>> 1 file changed, 12 deletions(-)
>>>>>=20
>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>> index 6f8f865aff..0561bdb857 100644
>>>>> --- a/hw/virtio/virtio.c
>>>>> +++ b/hw/virtio/virtio.c
>>>>> @@ -3136,8 +3136,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f=
, int version_id)
>>>>>    RCU_READ_LOCK_GUARD();
>>>>>    for (i =3D 0; i < num; i++) {
>>>>>        if (vdev->vq[i].vring.desc) {
>>>>> -            uint16_t nheads;
>>>>> -
>>>>>            /*
>>>>>             * VIRTIO-1 devices migrate desc, used, and avail ring add=
resses so
>>>>>             * only the region cache needs to be set up.  Legacy devic=
es need
>>>>> @@ -3157,16 +3155,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *=
f, int version_id)
>>>>>                continue;
>>>>>            }
>>>>>=20
>>>>> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
>>>>> -            /* Check it isn't doing strange things with descriptor n=
umbers. */
>>>>> -            if (nheads > vdev->vq[i].vring.num) {
>>>>> -                error_report("VQ %d size 0x%x Guest index 0x%x "
>>>>> -                             "inconsistent with Host index 0x%x: del=
ta 0x%x",
>>>>> -                             i, vdev->vq[i].vring.num,
>>>>> -                             vring_avail_idx(&vdev->vq[i]),
>>>>> -                             vdev->vq[i].last_avail_idx, nheads);
>>>>> -                return -1;
>>>>> -            }
>>>>=20
>>>> Michael, the commit that introduced this check seems to have been for
>>>> debugging rather than to prevent a QEMU crash, so this removing the
>>>> check may be safe:
>>>>=20
>>>> commit 258dc7c96bb4b7ca71d5bee811e73933310e168c
>>>> Author: Michael S. Tsirkin <mst@redhat.com>
>>>> Date:   Sun Oct 17 20:23:48 2010 +0200
>>>>=20
>>>>     virtio: sanity-check available index
>>>>=20
>>>>     Checking available index upon load instead of
>>>>     only when vm is running makes is easier to
>>>>     debug failures.
>>>=20
>>> Agreed. Given this, let's keep the message around, just with
>>> LOG_GUEST_ERROR ?
>>=20
>> I thought about it. Happy to send a v2 which keeps the check and logs
>> without throwing an error.
>>=20
>> Separately, I'm thinking of hooking up QEMU with VRING_ERR so datapath
>> handlers can notify QEMU that something went broken and NEEDS_RESET
>> can be flipped on the status register, possibly along a configuration
>> interrupt. I can see libvhost-user supports that, but are there any
>> reasons QEMU doesn't do this already?
>=20
> Mostly because guest support isn't there. That in turn isn't easy,
> lots of synchronization is needed within guests.

Do you mean guest support to reset when seeing that bit in status
following the configuration interrupt?

It should be safe, though. I can have a stab to see if it breaks
Windows/Linux at least, and share an RFC if I get anywhere.

Unless you think it's a waste of time. Ideally guests shouldn't find
themselves in this situation to begin with, and if they did, resetting
would arguably just lead them into corruption again (for example). But
it does provide a mechanism for QEMU to find out that the vhost
backend stopped. That would help in the context of this patch.

F.

>=20
>=20
>>>=20
>>>> Felipe: Did you audit the code to make sure the invalid avail_idx valu=
e
>>>> and the fields it is propagated to (e.g. shadow_avail_idx) are always
>>>> used in a safe way?
>>>=20
>>=20
>> I did it briefly. I also wrote a mock userspace driver that creates
>> this condition in a very controlled way (so I can step half-way
>> through setting up VQs and trigger a migration, for example). But you
>> know how manual tests are... I may have missed something.
>> Your expert eyes are most welcome. :)
>>=20
>> F.
>=20


