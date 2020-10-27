Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6336E207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="MEBO3vwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6336E207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP3E-0004UA-9p
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kXOTs-0001pN-Al
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:53:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:18202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kXOTp-00014a-F0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:53:39 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09RClAHD008213; Tue, 27 Oct 2020 05:53:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=NatonafPIRxQfz+hRZjEpjE57eMfWl58iMPhJYqQ6XY=;
 b=MEBO3vwOIy/3/DGeT8bap4jdtHDu28BfZEcxVuZqt19/qhdZGp5xAZtw0QsDxfJWucFN
 oGUGtgZOB+O4XuhwYCSFrZkkoaFcZ9edv/92RN7UIGarBs5CVm+t66oa360mdAC3EXMa
 Py8z/nBW5NDCMmUsD+5ythUF03h07Fb2JpQcy0PlFHw72P6QyTpBMTRLwb899rFrjNbV
 HKyQTfyJ8d7+PN9lBdWamnwe9lGgOfiS+gKVbZX4JzOB2jT3PgN2E+Di3tx9QG2Ntjp5
 orhg5NuaYMHCdCn0+8UAlDHDulnd6GfP1BgH6xlA3Yy/acyY3nWo0FV4DMpfo+FxUQTt 7g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by mx0b-002c1b01.pphosted.com with ESMTP id 34ckt0wsjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 05:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9HTPKwZ+bCc/WlEWzX+rbw9gJ5pbtRtFLfxe2HjVoDR2xOyPZNmnqo6Wm0eyzShgt5I8DfBmVZz4hP7SdI2+oli7FdVSlmC6kky+F/FWvTn8awHQK05H205WjOS3Z4swFYf3Ymz65FSUYiE1yE1CAffvuIt76itOAlG/c0yLwfRuOHz/GvkXT1Vguk1AariMJK//R7XLJnbHZbTAlFgB5hBiE/xiSH+Csq5VuPEzPhDo8tDqu0ao8gdBjxJgIc+5HM3WNdWoC98HEmW87Tz/71z3XB1hnGn4ljtRR/fvKIB0bj09cKhet8xVfSpFllAjxbPABmFXq0TR3K2z2VRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NatonafPIRxQfz+hRZjEpjE57eMfWl58iMPhJYqQ6XY=;
 b=Cgu2i2E+YvpfqdoB4V5aDN6TArJUtUVVo5mRHas7FefN0V+jZ8pfXDrDhM7oRxHRsm4OIPLm55BiWt8Glkm6SitD1FINLu3H4ncZc8XQUgLYtS8dqglcSY87JfVQan0N9LJzfgNXBeId8LONiItQUM5wJRO3+qlceoQebLXaHWVEI7GZfR/5YlLLQmRtYVTxKy3TR+DUj/O3ISYwUA50GXTRxIHIXRlg7YbkejsTQSODYh9OTcpxAn8ZNR2AnZOV6bGOii3oNY6Vxm4DYTDmAZD7TdiKt6gd+aGKVyGx0Mjm6PzCRXKxifNEH8MFTKkDOT+jIvuFjwLnd5WiMbLMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BY5PR02MB6721.namprd02.prod.outlook.com (2603:10b6:a03:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 12:53:29 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb%6]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 12:53:29 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: skip guest index check on device load
Thread-Topic: [PATCH] virtio: skip guest index check on device load
Thread-Index: AQHWq6qTShdeDwCex0GyOhjCQ5NUC6mrUeeAgAAPXICAAAe8AA==
Date: Tue, 27 Oct 2020 12:53:29 +0000
Message-ID: <12146644-5D22-4CAC-9B4F-F16E84ED56AE@nutanix.com>
References: <20201026151328.77611-1-felipe@nutanix.com>
 <20201027113049.GH79063@stefanha-x1.localdomain>
 <20201027082337-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201027082337-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 809eaa26-d67f-48fc-b84a-08d87a774dc3
x-ms-traffictypediagnostic: BY5PR02MB6721:
x-microsoft-antispam-prvs: <BY5PR02MB6721308574161E82A3B87FD5D7160@BY5PR02MB6721.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWrf+mzVyAxv3SNoHVt4TcLrrpmX9MvN3hvxXfHbTrt+i2u2SCIx9as9Mf3Pa3O7W2d1T0fr5szj1ybd+HW0XK19GHHn0FfznuND6U0MDqHNmXlj2i+gO0AwNU7fwdV1IY2VvcVnPyc3ZqA9NedD1u2yBUiGQNC7OlSGIqA4Tn4fqT8C1oJ1XZRTYwHcvWeLH1xrrocPJIcILjgw2tIaGLqRZ4eHOCrForrQnicJPt10ygk8zl3ko3GSzYhvWxIqUqADypE6ptwACEPfd0rvpVgjJWCeORZGsAZcFJ31Z3L1AydjFlaQ277I5H/YizD1dvGqQC9z6v0kzdbe0FhqMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(366004)(136003)(376002)(396003)(6486002)(54906003)(33656002)(86362001)(83380400001)(110136005)(4326008)(316002)(8936002)(2906002)(71200400001)(8676002)(2616005)(6506007)(66446008)(64756008)(6512007)(66556008)(26005)(5660300002)(66476007)(91956017)(36756003)(478600001)(66946007)(76116006)(53546011)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2fBtjLTlP1E/BGs+aoY3C5q+QpOVFyDJ41M48wrC1tTY2ackkq59jKJ4vf++G4yJpl02JoFEhTcKZNEdxb8Vus7GqZeGGm7dB3BSPZ/qV8JndrQenIdoS8xpp9yT2WHvQkXBclSeySc8nS+UPOaoqt5KVaQF3S84+gl0wqfTadbYkVs8XNaEbplisnXRtnWDF1O+wGbEeltGtKmuMKKmd4jbvu9pjT+BtwtmhTwYMOMEptI4z7ClNZUTp+7AjY7/QixMtDo9FmzXUpIfVk0/+rw+j4ia+N00RcNsNQc7/3lyKhU6KwKEKLrAxy96xYyXqGsL0E6p09EDr+ccYzsZ0d1c4ABs4AIE7O989qRVcsloX8BiK/YVHOikGx/9DWEd1ZPtDa3yM5Ejf5uwVLjQWGxD4kLtzvBH3DruFebMqKQiSnJfto2249Kgi2AVjKTYkTADqJFwVfgeLQgsL8h4gg1Gzj+Q0z7VPQDtMo4Jn57wCTj9HxjzKa9wmsSn5+7w13ZgTHtqKApsbrEStBgli1zfqisDJsvdS43DqIv0abZXVZ/e1E8kWDg0/RWoBkB84DoruSkMF4jOA3nvTDgk+X6aggALwt+iEILqv3nMUPZPsgOq1SA2UjEbYn4Ab9VpHQqKrQNOZ228CKTQ3380rg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96BB14D2B0211F42A9079FAF14BCFEE3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809eaa26-d67f-48fc-b84a-08d87a774dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:53:29.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf6f3FGwEg5KuurInnWnNPmPr+qMQZNvQQrsQVm3PpvW4wZpk0LZu3gP0ryeQasVNp8rWSwRPXV0a2tSfnNUk3mynVAstWGP24bV0tg6Jys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6721
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_05:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 08:53:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Oct 27, 2020, at 12:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Oct 27, 2020 at 11:30:49AM +0000, Stefan Hajnoczi wrote:
>> On Mon, Oct 26, 2020 at 03:13:32PM +0000, Felipe Franciosi wrote:
>>> QEMU must be careful when loading device state off migration streams to
>>> prevent a malicious source from exploiting the emulator. Overdoing thes=
e
>>> checks has the side effect of allowing a guest to "pin itself" in cloud
>>> environments by messing with state which is entirely in its control.
>>>=20
>>> Similarly to what f3081539 achieved in usb_device_post_load(), this
>>> commit removes such a check from virtio_load(). Worth noting, the resul=
t
>>> of a load without this check is the same as if a guest enables a VQ wit=
h
>>> invalid indexes to begin with. That is, the virtual device is set in a
>>> broken state (by the datapath handler) and must be reset.
>>>=20
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> ---
>>> hw/virtio/virtio.c | 12 ------------
>>> 1 file changed, 12 deletions(-)
>>>=20
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 6f8f865aff..0561bdb857 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -3136,8 +3136,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, =
int version_id)
>>>     RCU_READ_LOCK_GUARD();
>>>     for (i =3D 0; i < num; i++) {
>>>         if (vdev->vq[i].vring.desc) {
>>> -            uint16_t nheads;
>>> -
>>>             /*
>>>              * VIRTIO-1 devices migrate desc, used, and avail ring addr=
esses so
>>>              * only the region cache needs to be set up.  Legacy device=
s need
>>> @@ -3157,16 +3155,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f,=
 int version_id)
>>>                 continue;
>>>             }
>>>=20
>>> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].las=
t_avail_idx;
>>> -            /* Check it isn't doing strange things with descriptor num=
bers. */
>>> -            if (nheads > vdev->vq[i].vring.num) {
>>> -                error_report("VQ %d size 0x%x Guest index 0x%x "
>>> -                             "inconsistent with Host index 0x%x: delta=
 0x%x",
>>> -                             i, vdev->vq[i].vring.num,
>>> -                             vring_avail_idx(&vdev->vq[i]),
>>> -                             vdev->vq[i].last_avail_idx, nheads);
>>> -                return -1;
>>> -            }
>>=20
>> Michael, the commit that introduced this check seems to have been for
>> debugging rather than to prevent a QEMU crash, so this removing the
>> check may be safe:
>>=20
>>  commit 258dc7c96bb4b7ca71d5bee811e73933310e168c
>>  Author: Michael S. Tsirkin <mst@redhat.com>
>>  Date:   Sun Oct 17 20:23:48 2010 +0200
>>=20
>>      virtio: sanity-check available index
>>=20
>>      Checking available index upon load instead of
>>      only when vm is running makes is easier to
>>      debug failures.
>=20
> Agreed. Given this, let's keep the message around, just with
> LOG_GUEST_ERROR ?

I thought about it. Happy to send a v2 which keeps the check and logs
without throwing an error.

Separately, I'm thinking of hooking up QEMU with VRING_ERR so datapath
handlers can notify QEMU that something went broken and NEEDS_RESET
can be flipped on the status register, possibly along a configuration
interrupt. I can see libvhost-user supports that, but are there any
reasons QEMU doesn't do this already?

>=20
>> Felipe: Did you audit the code to make sure the invalid avail_idx value
>> and the fields it is propagated to (e.g. shadow_avail_idx) are always
>> used in a safe way?
>=20

I did it briefly. I also wrote a mock userspace driver that creates
this condition in a very controlled way (so I can step half-way
through setting up VQs and trigger a migration, for example). But you
know how manual tests are... I may have missed something.
Your expert eyes are most welcome. :)

F.=

