Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50DC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75082192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75082192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVulv-0004vr-Iy
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kVulE-0004Rk-9n; Fri, 23 Oct 2020 06:57:28 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:59285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kVulB-0000s5-IZ; Fri, 23 Oct 2020 06:57:27 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.194])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 770E96E7D246;
 Fri, 23 Oct 2020 12:57:21 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 23 Oct
 2020 12:57:20 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003a40d4afc-9108-4182-9127-6fd99cf0e981,
 C0BA1F4BE5C42AD64430581CA289E8EEBB8A5892) smtp.auth=groug@kaod.org
Date: Fri, 23 Oct 2020 12:57:19 +0200
From: Greg Kurz <groug@kaod.org>
To: <no-reply@patchew.org>
Subject: Re: [PATCH] block: End quiescent sections when a BDS is deleted
Message-ID: <20201023125719.15f8449f@bahia.lan>
In-Reply-To: <160345011823.26284.2952209122615820969@66eaa9a8a123>
References: <160344969243.4091343.14371338409686732879.stgit@bahia.lan>
 <160345011823.26284.2952209122615820969@66eaa9a8a123>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ac623cbc-b492-4c16-a0af-aa06dee87806
X-Ovh-Tracer-Id: 13191043311055706406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekfeetgfefvdeiiefgjeffveevhfdvieeivdfhveelleethfdvkeehjefggeffhfenucffohhmrghinhepphgrthgthhgvfidrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehmrhgvihhtiiesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 06:57:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 03:48:39 -0700
<no-reply@patchew.org> wrote:

> Patchew URL: https://patchew.org/QEMU/160344969243.4091343.14371338409686732879.stgit@bahia.lan/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 160344969243.4091343.14371338409686732879.stgit@bahia.lan
> Subject: [PATCH] block: End quiescent sections when a BDS is deleted
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/160344969243.4091343.14371338409686732879.stgit@bahia.lan -> patchew/160344969243.4091343.14371338409686732879.stgit@bahia.lan
>  - [tag update]      patchew/20201023101222.250147-1-kwolf@redhat.com -> patchew/20201023101222.250147-1-kwolf@redhat.com
> Switched to a new branch 'test'
> f9501f8 block: End quiescent sections when a BDS is deleted
> 
> === OUTPUT BEGIN ===
> ERROR: Use g_assert or g_assert_not_reached
> #73: FILE: block/io.c:640:
> +    g_assert_cmpint(bs->quiesce_counter, >, 0);
> 

Ah... sorry I wasn't aware of the story behind glib commit a6a875068779,
I'll post a v2 what uses g_assert() instead.

> ERROR: Use g_assert or g_assert_not_reached
> #74: FILE: block/io.c:641:
> +    g_assert_cmpint(bs->refcnt, ==, 0);
> 
> total: 2 errors, 0 warnings, 53 lines checked
> 
> Commit f9501f846de1 (block: End quiescent sections when a BDS is deleted) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/160344969243.4091343.14371338409686732879.stgit@bahia.lan/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

