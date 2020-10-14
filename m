Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ABAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5045320878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gfb2hSlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5045320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeln-0005VR-7h
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSekV-0004pR-6N; Wed, 14 Oct 2020 07:15:15 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com
 ([40.107.8.93]:19566 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSekQ-00046W-Oc; Wed, 14 Oct 2020 07:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPxrnD42PDORgsm2kVAJ9yEjeZTIwU/9jKphIwWGDYNJ12vWrX1ZMGsT5sPn0oHw7sdHic4ZYrUPwzGYLko6tZ+/eFh7QC8DTnFJUuRn/ac18vXX26cBEzdnRytUzL7qIo9pGwHOus5Da39O/kSmj6SfywZ7cazIEyJ4RK1ujio6YJ+c1ohCG5GxU+lWZuQ2wdjrerRI+OUE/Lf9R1RFndv9ARamT2rcV++LFmnynMlJGG0EeE/3YPt9mYm5RRfMX4X765pRKuAxO8ZvxGa1r2s1CdZ359eEhV3erR67HTCs4N/3RKyY6sSJ8wXWEeHUsaKGhpGepiYY4k035o6sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiVNc/OzEHyIvO28tlpbLVbFXYQn7FfUFuh2XOs0Wsg=;
 b=F4s+O72gz9hSyb9KInoO0x0WEKUTrMouFQOZSpvXQ7zWsgy2P5FBPMrVu+XyXGkTb9M/1VMlZbhJMHo0WdKctKL/wKILrk/5LOCM65N6Z4onJwjJNwzbbscfX26ajs5I3JOUVy+1myF4wq0etBynQ26y4/bZdCldKKxBo1KVtNlUsstLNTUriAlb2Vq3qQ/+V7w4J03xc4kxxuFykjEVEyTxeQmxa98jkNbaJ42bdHSDvhnsMauBd/4aU0tsh7lad3Nx+b3Rv7TlkzMUOC7evM+zvfakYVoSJs0sYF6P88GTwkcF4xEfcGOtgaIBuoVCfg/LYTxHkAjg5D1NTJz5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiVNc/OzEHyIvO28tlpbLVbFXYQn7FfUFuh2XOs0Wsg=;
 b=Gfb2hSlxxgGotd1Lxyd7qQMk+MeyEqw6M/2RRK/h8lvJiHdBHjxekPGbwPf0jW54Mu+PcBYPE7bT5WRCUUVt/6+SbeK9nE7zTuVSrEbWKRnUVRXg4pMqJ6S0Ynwr6Jpcf5jCTX1qQphPfT22hK3lmjG1hT+s29OZokGpP5Mo678=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4279.eurprd08.prod.outlook.com (2603:10a6:20b:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 11:15:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 11:15:06 +0000
Subject: Re: [PATCH v4 1/7] nbd: Utilize QAPI_CLONE for type conversion
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a480be79-dd71-1006-f2a6-5b7b8cca725e@virtuozzo.com>
Date: Wed, 14 Oct 2020 14:15:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:208:122::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:208:122::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 14 Oct 2020 11:15:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dab6172-aa42-49e3-6daf-08d8703267ce
X-MS-TrafficTypeDiagnostic: AM6PR08MB4279:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4279258D34CD632C2874ED94C1050@AM6PR08MB4279.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkomCAvb5szKOJdL++jMaOLh0+yfjlrJMIyxpemwRl9w8ND7JBguYwyF4xW0fmoePa8MG5SKL3m2iV7EDrjrmXShxDmwwPumGqXPIgqU75OSGbbt00R9F3roKRjBk4NqyeO8k5cttiqIjFWA8XZ+30fzCly2RRgHPhc1wZo68rIUQvDUOVHx+q+QXW+oT02B3Dz5o1iwnBv1vSfvjaEvwAzYI6KU9R8mMd/TjEjqMRzKdGHuBwhSDFFVv5gh8/2CgfWQ5HqQ1VE6f2w4FEpj43PTP5G3SMNNlKmWeL2vTQd7JPKG/KTYv+VkTej2LfO4xCIvOb5jk7QpfQyGAS667ZCJw9AIO79qnU8FscS2+rfSmHRDksERJtCVCWdw8RHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39840400004)(366004)(346002)(66946007)(6486002)(4744005)(16526019)(26005)(8676002)(478600001)(31686004)(83380400001)(31696002)(5660300002)(8936002)(36756003)(186003)(52116002)(86362001)(66556008)(66476007)(16576012)(2906002)(2616005)(316002)(956004)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FR2oQ47pguE0oMGg7WzhHWi9WMXtrleqv7KuGuoqaUvQFDpfAvBQsy4rNLJqM0SjiRY4B7w5P4v1iAx3BENFvEiuHuOsWdZvv/J8MxXbfudS8wuqE48milifAdstYkv5t7BmOuABQtipW0fN78+41/S2pPI8neIebLAT33Spof7wq8swwzc0Wg+BmcEmAtzuNUUcDwANhIhgwUVlItp35DcUsTv3LqLENuSkrFQ8JE0mGH/p+fNednSTA2aRTFrwKMf94GE/vEPVDZmj4vDDkWU1prUoQJKMbTGtIuvyQCFQmj5UpGmt0IVuJfhxBFh6m9fJE3yxyXVjluP5tW6eCXTp7wSxAmAHwpqjDEdQthB3kosOt9ZqfjnZ3y2lT46ZJcCJrbn6R2wtUo3L1L0jFvHJzHlJInk+Pmxm4c57RthzPUWJ08kUy8xI7J7cCbMbwSN1Y+nQa9kPsS2VGutqDvqmuh9Y4sstvjXd8GK9oto86YX99q+W38+VGivLmd74dRsNrG2GaUD3JTBjAAerOziRlda/98qc+S95HPTz3mMoRn1gAGVi1xSL0AvO9Y3hbmbWFcvufHZ0ZWF8g73k2VEDOpYCCDJPRRsyp6r5Dk1KvTQ30A596DA//zKiSvV1YPvggdUnl+7kbQm+GpbEMQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dab6172-aa42-49e3-6daf-08d8703267ce
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 11:15:06.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahpCxildIDm9FqIC1sloekS6ksUV9/E8DBx+WlyOq3yEq8grzxnhCKtkvE0ezXIMDBc8st/SO9FIKJxlrX1/PKNQLKAn4/F2aB8SHjHMsgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4279
Received-SPF: pass client-ip=40.107.8.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:15:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.10.2020 00:55, Eric Blake wrote:
> Rather than open-coding the translation from the deprecated
> NbdServerAddOptions type to the preferred BlockExportOptionsNbd, it's
> better to utilize QAPI_CLONE_MEMBERS.  This solves a couple of issues:
> first, if we do any more refactoring of the base type (which an
> upcoming patch plans to do), we don't have to revisit the open-coding.
> Second, our assignment to arg->name is fishy: the generated QAPI code
> currently does not visit it if arg->has_name is false, but if it DID
> visit it, we would have introduced a double-free situation when arg is
> finally freed.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

