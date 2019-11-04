Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109DCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFCD21D7F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bmORbyLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFCD21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRc1r-0004VW-Al
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 08:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iRc0w-0003xb-9U
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iRc0u-00063V-Tj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:03:21 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:37092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iRc0u-0005rQ-A6; Mon, 04 Nov 2019 08:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=lFexXn/y398mKXRCst+o4ikT6b8QhvWk+I6kcLnVEc4=; 
 b=bmORbyLsRTSGorwdI+N2SSsQT203v7NZyhix5j3FwXmhKOpvXDUk23OnjSzdg9a5T8WFKtZrXjmEWU7gyLr6oLWXYyIrBdDQDK96p12hD1KW+5+Ew1ro1GjwfwW4mPo0lL8UFhOJ7O0gFbfeVhzKGu0KFHkhEm8q1CeenrK8EZjdI1pmshVC3i7tAiAeuur0R36UnFpqtcoeQp3tmA7W1haqSWDSn7JCT3P7oAwMEhLHN8+bmv+aLrdkb+9CKwRyDuZ6ydVIdfyYfbHN8jPg9TPc5S6XmPLsq9WcRS9C3aaYnJYlkTCucDVns67nd0JchZ3EwFYkG2l9OI03gIDq2w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iRc0a-0002OL-K9; Mon, 04 Nov 2019 14:03:00 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iRc0a-0000d2-Hc; Mon, 04 Nov 2019 14:03:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 12/26] qcow2: Handle
 QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
In-Reply-To: <78cc16f3-f8aa-9dcb-2389-4f6ed86080fd@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <2a6b34635cac78e76150a72c69669b3d9ec0fb8c.1572125022.git.berto@igalia.com>
 <78cc16f3-f8aa-9dcb-2389-4f6ed86080fd@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 04 Nov 2019 14:03:00 +0100
Message-ID: <w51tv7jssjf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 04 Nov 2019 01:57:42 PM CET, Max Reitz wrote:
> On 26.10.19 23:25, Alberto Garcia wrote:
>> In the previous patch we added a new QCow2ClusterType named
>> QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER. There is a couple of places
>> where this new value needs to be handled, and that is what this patch
>> does.
>>=20
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
> This patch deals with everything in qcow2.c.  There are more places that
> reference QCOW2_CLUSTER_* constants elsewhere, and I suppose most of
> them are handled by the following patches.
>
> But I wonder what the criterion is on where it needs to be handled and
> where it=E2=80=99s OK not to.  Right now it looks to me like it=E2=80=99s=
 a bit
> arbitrary maybe?  But I suppose I=E2=80=99ll just have to wait until afte=
r the
> next patches.

This is the part of the series that I'm the least happy about, because
the existing qcow2_get_cluster_type() can never return this new value, I
only updated the cases where this can actually happen.

I'm still considering a different approach for this.

Berto

