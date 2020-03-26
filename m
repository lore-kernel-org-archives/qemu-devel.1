Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ACEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F4A2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RUY1kzBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F4A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHRv8-00026c-6u
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHRu4-0001N2-Dm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHRu2-0007Zz-QD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:46:32 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com
 ([40.107.2.110]:27907 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jHRty-0007We-67; Thu, 26 Mar 2020 08:46:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp+R0dJmkpoWXKF9aHwtIoif2jEhHeD9f8HyRqrRQUQUbjh2dXD6PqgVpR9VfB/TopIUB+Yy6wBpguU5h86PM7xqDa0Bo7Wnz3FT1aMRB0fnGEaShsmz8OKHh0Jff/c18PXBrUtUflTidP2Jv5Kg9m/0E7MKF53sB/Ip3xx5ahr8QJMYhY8rsVYl8hw3/dcEn9JmqxYrX8656RU/+/wFhI9E0+5LzJY51RQrZxn2vYJLVkhCsZibuCANtK2pbyeKDVS7Qgb661+3X3SvCqQ1uL+2297Yf++D8fZHCEx3Z1fZIuwKgr4/cuasdKrfeOkihPujEKjT4rAJETvbzxLj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF14GDX1kjndkMuT3tJCNsPyE3HNGxl+bUAqPMKt2nI=;
 b=VGtGCbjmE0Z18CqOqCbmMdVIkhFKSKdMVDWdAdKLyJBCF4EVghV/14aP7YnhWhIBOuTyzhLikQGsQdzAi13bzte5wN2Oj7gu3HheKWBpxe2YM24xD1+TYZOZO655HSg/sNn2xft7asw57jgp181FZNMlRF+EhNTSvH/SqDS/yKOwBKf4sjk4fu1WIKEuPv68xir/8uyFMW8SgjCBthErVdZQz59YXB7w1wwMNzzFEF1O8HUtNCZxVo1VFSfPeOydQ3mwZ+SKGA/AfJv/j2Hn1eNU3RGG6gTrygzQbiwqBl678xmbQyBgTAu38jTMXoVs1YT1Wf6r2E/4j9RCOAL12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF14GDX1kjndkMuT3tJCNsPyE3HNGxl+bUAqPMKt2nI=;
 b=RUY1kzByA6P75CqaL71GsLO9cr8Z5T+CQG+Yg9MAclTPmPC/ZibrV3TrjwE2NOB/K42lxbTDBw1UCbJKDGJ4YhEM4CjRV891eK527FEjVwlY5nr0pIWZN56Pokif561lXYLW8O7U/qAW4RMFoeXDhBOFiX2fyY3bklv8gZCGByc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5351.eurprd08.prod.outlook.com (10.141.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Thu, 26 Mar 2020 12:46:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 12:46:20 +0000
Subject: Re: [PATCH] backup: don't acquire aio_context in backup_clean
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <76edbead-7ccf-833b-a3f2-15dff7f0748c@virtuozzo.com>
 <20200325155055.730633-1-s.reiter@proxmox.com>
 <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
 <1d1984b3-14f5-5a17-b477-d70561f75e8f@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200326154618768
Message-ID: <143bd416-c18d-669a-e569-0de3338c740a@virtuozzo.com>
Date: Thu, 26 Mar 2020 15:46:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1d1984b3-14f5-5a17-b477-d70561f75e8f@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR08CA0052.eurprd08.prod.outlook.com
 (2603:10a6:205:2::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 AM4PR08CA0052.eurprd08.prod.outlook.com (2603:10a6:205:2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 12:46:19 +0000
X-Tagtoolbar-Keys: D20200326154618768
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eeda03e-f96a-448b-dc99-08d7d183aee9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5351:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53516466E0FF1892B739C069C1CF0@AM7PR08MB5351.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(2616005)(956004)(66556008)(66476007)(36756003)(81166006)(81156014)(26005)(316002)(186003)(16526019)(5660300002)(66946007)(8676002)(8936002)(966005)(16576012)(6486002)(478600001)(4326008)(31686004)(86362001)(52116002)(31696002)(2906002)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5351;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1TLLpcVGNTZgWiHdhDho8V/vVuV9qw9xZlueUUpC+fPoIYhL5DP6foQcDRHzsFjpxVRRichbEa1dZAF20/97dGKvLdUgWAa9EwXUy3zSkNFV7W5tW2FLIlH2HpszcUdaQubQjwJk1bJoKBvo6w6sLkkY1jAPB0Sqy75uDiakN9NgDBG6zIRTWIuwYzABOH3GJnOfzNiTTAU84Po+gIiSEL/fsF1Z2THj7cqCertb3kVbNWwno6xlpP4wO8YNrNyuxORGpVqB+OfoRIxaoYKVOsT1t9PMrquTL1L+EkctHpE8PxyL7cJl3Tce5fwgaIPtvGArH8VHAFidi3YUQpL05gr0J5jOjWjnMtDqPL1lVfI2erXADK6Nb3YdoIbZG8/kN8byEDPB3bXqSbzIbYlwE6/WQZ/eR4i4cDKyPqbN4CHqXGMzzXgSHqW4qE8AOx0VsIdntdGhqF8VWu2Hpfh7Nbn6ZhoWuOR6uGkGoAyn1b2deYTUI3Xyssyvv0Ku8nz+99Q9KZfGdf33OVCli4INw==
X-MS-Exchange-AntiSpam-MessageData: /LUKYlKgDX5i15EqwlYk7O41KdU1nCU+z2bk3H9lkdD9iSmHf0L+20sDvg/MdXfpvwQ7sZfSUoft3zE8xjDR5yZ4/4fIHM91MOK+8tPZzU2mtR73nLVEHARYqtHox+JY5RrJw9nzHxV4TlXCxzcKiw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeda03e-f96a-448b-dc99-08d7d183aee9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 12:46:20.2623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tvsWw5aRoDBsxo98Z5Z/0bdMf9mlKrjzgi+sVPCio3SHTrbzX/Z013Z18PZxZ6EVydANreQoiJNnKzYAbW1vriJ6LsjnLY1/TlC8yPoufA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5351
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.2.110
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
Cc: kwolf@redhat.com, slp@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.03.2020 12:43, Stefan Reiter wrote:
> On 26/03/2020 06:54, Vladimir Sementsov-Ogievskiy wrote:
>> 25.03.2020 18:50, Stefan Reiter wrote:
>>> backup_clean is only ever called as a handler via job_exit, which
>>
>> Hmm.. I'm afraid it's not quite correct.
>>
>> job_clean
>>
>> =C2=A0=C2=A0 job_finalize_single
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_completed_txn_abort (lock aio context=
)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_do_finalize
>>
>>
>> Hmm. job_do_finalize calls job_completed_txn_abort, which cares to lock =
aio context..
>> And on the same time, it directaly calls job_txn_apply(job->txn, job_fin=
alize_single)
>> without locking. Is it a bug?
>>
>=20
> I think, as you say, the idea is that job_do_finalize is always called wi=
th the lock acquired. That's why job_completed_txn_abort takes care to rele=
ase the lock (at least of the "outer_ctx" as it calls it) before reacquirin=
g it.
>=20
>> And, even if job_do_finalize called always with locked context, where is=
 guarantee that all
>> context of all jobs in txn are locked?
>>
>=20
> I also don't see anything that guarantees that... I guess it could be ada=
pted to handle locks like job_completed_txn_abort does?
>=20
> Haven't looked into transactions too much, but does it even make sense to=
 have jobs in different contexts in one transaction?

Why not? Assume backing two disks in one transaction, each in separate io t=
hread.. (honestly, I don't know does it work)

>=20
>> Still, let's look through its callers.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_finalize
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qmp_block_job_finalize (lock aio context)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qmp_job_finalize (lock aio context)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 test_cancel_concluded (doesn't lock, but it's a test)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_complet=
ed_txn_success
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 job_completed
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_exit (lock aio context=
)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 blockdev_mark_auto_del (lock aio context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 job_user_cancel
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmp_block_job_cancel (locks context)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmp_job_cancel=C2=A0 (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 job_cancel_err
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel_sync (return job_finish_sync(j=
ob, &job_cancel_err, NULL);, job_finish_sync just calls callback)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replication=
_close (it's .bdrv_close.. Hmm, I don't see context locking, where is it ?)
> Hm, don't see it either. This might indeed be a way to get to job_clean w=
ithout a lock held.
>=20
> I don't have any testing set up for replication atm, but if you believe t=
his would be correct I can send a patch for that as well (just acquire the =
lock in replication_close before job_cancel_async?).

I don't know.. But sending a patch is good way to start a discussion)

>=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replication=
_stop (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drive_backu=
p_abort (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blockdev_ba=
ckup_abort (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel_=
sync_all (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_comm=
on (locks context)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 test_* (I don't care)
>>
>=20
> To clarify, aside from the commit message the patch itself does not appea=
r to be wrong? All paths (aside from replication_close mentioned above) gua=
rantee the job lock to be held.

I mostly worry about the case with transaction with jobs from different aio=
 contexts than about replication..

Anyway, I hope that someone who has better understanding of these things wi=
ll look at this.

It usually not good idea to send [PATCH] inside discussion thread, it'd bet=
ter be a separate thread, to be more visible.

May be you send separate series, which will include this patch, some fix fo=
r replication, and try to fix job_do_finalize in some way, and we continue =
discussion from this new series?

>=20
>>> already acquires the job's context. The job's context is guaranteed to
>>> be the same as the one used by backup_top via backup_job_create.
>>>
>>> Since the previous logic effectively acquired the lock twice, this
>>> broke cleanup of backups for disks using IO threads, since the BDRV_POL=
L_WHILE
>>> in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release the=
 lock
>>> once, thus deadlocking with the IO thread.
>>>
>>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>>
>> Just note, that this thing were recently touched by 0abf2581717a19 , so =
add Sergio (its author) to CC.
>>
>>> ---
>>>
>>> This is a fix for the issue discussed in this part of the thread:
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07639.html
>>> ...not the original problem (core dump) posted by Dietmar.
>>>
>>> I've still seen it occasionally hang during a backup abort. I'm trying =
to figure
>>> out why that happens, stack trace indicates a similar problem with the =
main
>>> thread hanging at bdrv_do_drained_begin, though I have no clue why as o=
f yet.
>>>
>>> =C2=A0 block/backup.c | 4 ----
>>> =C2=A0 1 file changed, 4 deletions(-)
>>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 7430ca5883..a7a7dcaf4c 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -126,11 +126,7 @@ static void backup_abort(Job *job)
>>> =C2=A0 static void backup_clean(Job *job)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BackupBlockJob *s =3D container_of(job, =
BackupBlockJob, common.job);
>>> -=C2=A0=C2=A0=C2=A0 AioContext *aio_context =3D bdrv_get_aio_context(s-=
>backup_top);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 aio_context_acquire(aio_context);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_backup_top_drop(s->backup_top);
>>> -=C2=A0=C2=A0=C2=A0 aio_context_release(aio_context);
>>> =C2=A0 }
>>> =C2=A0 void backup_do_checkpoint(BlockJob *job, Error **errp)
>>>
>>
>>
>=20


--=20
Best regards,
Vladimir

