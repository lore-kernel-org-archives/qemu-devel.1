Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80705C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE4121582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BPr7nc2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE4121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvBt-0005TT-HR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyuzD-0001fA-I6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyuzC-0003xV-3K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:59:15 -0500
Received: from mail-eopbgr20093.outbound.protection.outlook.com
 ([40.107.2.93]:49889 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iyuz8-0003iM-Uw; Tue, 04 Feb 2020 04:59:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP3LT5MDBVkf1GuTaWZgfHb/UPWNRozBVKdgUrDAgxy5NjFJrzEssocffO97aTOg/eKcTe9UAJB07uQIThw08LVHrQbDoJlVGdPMjz2wY/IXnogG5f8udPg3Js9LikVLMY1rDxwpaMSWaKIKtGMoqpiFCoqKt05Uk/p7MGy5MNq9FLoDEs5a/xM1tmTljUnVBlKx8pLEgf+7NZ9mCaT/0bUDivg+fi9UIC06w5QmSMtPfnKKk9Aln2N6u74DJ9Km6DNe3jJFu0Fp0QaJwDdgn4HFElsekKYNgMcrKRcLaouqS6BvLwkBmsEQkzXi/jiP1QhjF1TiVkP+tE/AMZjg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZLmSMOvUGbM85eEvzp9tQe7YVR8uYNXH6BJ69NHFFg=;
 b=F4mp6GaaXORu/jnnSRU9JOszY1VDTeQPbeR1WkRLrFWd/PXLxc/G11CD4I9J9HnGPSa1UeuHfCmCCy+souVP89k19hihffg8HbwTgwH1C/uWsY/zB9Ip5foGg6ek8JweybUQ9k1FE08iizXxItcRQn4dUjeqx2Wjw3Irg5Zr4ND7zpvsmRe5VfFOMN8QU6hDx+3HgFWJipEE/vciXnzXv2Oyq0Cdi0mjkAgUsPo1x9r5jsZZz68Q23iWUCCwWFhINBM8bbPxWhkyt2I5cLEtxzPEXiWqA402ksHS/KxOnudeRYxl5fJ9KeTEsMjNFNAgRk3hi7zLj5hoYtrHCXJYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZLmSMOvUGbM85eEvzp9tQe7YVR8uYNXH6BJ69NHFFg=;
 b=BPr7nc2A2upXwz9IfdKX5l+xLYCYBsIL68J8dBaFLSHqkwe/FABjJmlbqwcMeUaOfhvIsZhOgDHiWJgx1vFKE8Lanz/rJ4KUjBY/vtm4BHvgC06KIGk9ABBY/tsSnbP2/ge14WXAOSY7ou0J5CVFmj81G1H6MlEdq9/FpuqHXoo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3459.eurprd08.prod.outlook.com (20.177.110.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 09:59:08 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 09:59:08 +0000
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:59:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200130145840.GH180311@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.161.59) by
 HE1PR0202CA0033.eurprd02.prod.outlook.com (2603:10a6:3:e4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 09:59:06 +0000
X-Originating-IP: [178.34.161.59]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64f2a995-4d8c-4798-fb28-08d7a958e045
X-MS-TrafficTypeDiagnostic: AM0PR08MB3459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB345972F4174EFC898C266458CF030@AM0PR08MB3459.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(66476007)(66556008)(7416002)(66946007)(31686004)(5660300002)(4326008)(107886003)(16576012)(52116002)(316002)(16526019)(186003)(6486002)(26005)(6916009)(956004)(2616005)(31696002)(966005)(81166006)(53546011)(478600001)(86362001)(8936002)(36756003)(81156014)(8676002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3459;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiWho8X7v1fsjkwtzNwe4U6lFr3cY2BqblsDF7GFvZuu8k9iN8xAHBcrB3570I0NB+xj/EsmbFZIg7Wkn9emImG3Lt3EBgyhFMbTbSrukDPvONRxOraeFwbCZtatZX89Pfo0IsfJ50ZgUkYVIMnmhEeGOzRoqhGTN/f6yUdkv1/SDkWgsJhor5ve90pUPwGxjjVovVDl+kKWB/A2CUDY3vUfMuKOD3rGAnT7Z5cGisPJpqQMjy4dD7CvoC2RK7VnALKu8F1lhAWbWVwlSIkZ33Wxh+O14hOru5Mm2MdK08Fxc6eztST6tEcZ4wwc0GX48VSItHtOwkTbNm4MwvUizScabyybwpLKZw24Gylh6b29NPzbp8Lo4O5heSuUo8LnshrKYxwS9pOdxVZ2YXjD/nMavd2oMHyEYeT71PULI3X7IuBMH/ulq8hnqA3GW0MqXPjZDzs7+9Tc2TBdjSCidrBSljIr3f7BUbleZI/C/miYWEHxN9GkN6mP46ZLtybGXMMldyTMGkG/HyaGgSOy/w==
X-MS-Exchange-AntiSpam-MessageData: 30B6s7TrGzqpbLH5ztVsScVsVCw5jUf6rGhf9AfVA7NDm+RjVw0Y8oTY8NiIvA6j4opMSzgWHTW1HmOUV+8ptmKiW1w5ov8+DIyLD7tA4ozG3PJEPwtZEF9fXfclckClHY0Zn+Ldhv7yQdXhSIMg5A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f2a995-4d8c-4798-fb28-08d7a958e045
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:59:08.3082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PPEqeV+wQlgPDk1diDm0oKHhTKoZvuZOUIXUcMNE9aF6JrsnbZ8U4VEBF40SEDxK5RX6fyvCtjiVXB5A/DL1qPdkFeR5Z/CQgP8AfVLZ+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3459
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.93
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30.01.2020 17:58, Stefan Hajnoczi wrote:
> On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
>> The goal is to reduce the amount of requests issued by a guest on
>> 1M reads/writes. This rises the performance up to 4% on that kind of
>> disk access pattern.
>>
>> The maximum chunk size to be used for the guest disk accessing is
>> limited with seg_max parameter, which represents the max amount of
>> pices in the scatter-geather list in one guest disk request.
>>
>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>> size increases seg_max, which, in turn, increases the maximum size
>> of data to be read/write from guest disk.
>>
>> More details in the original problem statment:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   hw/core/machine.c          | 3 +++
>>   include/hw/virtio/virtio.h | 2 +-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 3e288bfceb..8bc401d8b7 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -28,6 +28,9 @@
>>   #include "hw/mem/nvdimm.h"
>>  =20
>>   GlobalProperty hw_compat_4_2[] =3D {
>> +    { "virtio-blk-device", "queue-size", "128"},
>> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>> +    { "vhost-blk-device", "virtqueue_size", "128"},
> vhost-blk-device?!  Who has this?  It's not in qemu.git so please omit
> this line. ;-)
So in this case the line:

{ "vhost-blk-device", "seg_max_adjust", "off"},

introduced by my patch:

commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300

 =A0=A0=A0 virtio: make seg_max virtqueue size dependent

is also wrong. It should be:

{ "vhost-scsi-device", "seg_max_adjust", "off"},

Am I right?

>
> On the other hand, do you want to do this for the vhost-user-blk,
> vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Those
> devices would benefit from better performance too.
It seems to be so. We also have the test checking those settings:
tests/acceptance/virtio_seg_max_adjust.py
For now it checks virtio-scsi-pci and virtio-blk-pci.
I'm going to extend it for the virtqueue size checking.
If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's worth
to check those devices too. But I don't know how to form a command line
for that 3 devices since they should involve some third party components as
backends (kernel modules, DPDK, etc.) and they seems to be not available=20
in the
qemu git.
Is there any way to do it with some qit.qemu available stubs or=20
something else?
If so, could you please point out the proper way to do it?

Thanks!
Denis



