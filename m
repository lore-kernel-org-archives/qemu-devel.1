Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D72C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDB6208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZlR76o2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDB6208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58gX-00068L-97
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j588p-0002YV-Rp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j588o-0007tv-S1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:14:51 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:36745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j588o-0007s0-8Z; Fri, 21 Feb 2020 08:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=no1DbETEWhMW6npcRQzOXoK6Q2LhSgagtjp6OpZ4D5o=; 
 b=ZlR76o2/L8RDKu2kYV4IHiNL5ArMd2vvOIBmxdZLBZqk8UFc0bkHgoEDrQr+2OsQ+RW87mUwRAWisPBz51R+UBRRSYerqFL+n+b155JPPZBN4yiQZ2Xq1gXW1Spq7L1cY9SWZW0g7gIB6ZH9kodl7AHp46xP6AZ/nTqpcvAXP05ectToM4K2Tv/bjYmt1459n+8XWW4ePG41D4jW6oPj8c7CDUqJnvXj3GmU4hbIZuBsNvFFf0yM0I9PwX5BuP40I+sGp+XTRUDFRMw/foBCSrKCrO+8nzz69u/OL1s1+Y1+9X415ABtZZRLsZXnoYEjkjPPnbUUEAPDGHL6HTG8IA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j588l-0001FI-1Z; Fri, 21 Feb 2020 14:14:47 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j588k-0003Sh-O1; Fri, 21 Feb 2020 14:14:46 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 07/27] qcow2: Add subcluster-related fields to
 BDRVQcow2State
In-Reply-To: <1471f80d-b289-713b-2525-29832720087b@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <b04e7e26cea16892a7f209b37d931c489ef17bd9.1577014346.git.berto@igalia.com>
 <bc469fab-244c-6b26-c5b4-55cc42a7d8cc@redhat.com>
 <w51blptb4lc.fsf@maestria.local.igalia.com>
 <1471f80d-b289-713b-2525-29832720087b@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 21 Feb 2020 14:14:46 +0100
Message-ID: <w51blpsqdyx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 20 Feb 2020 05:48:25 PM CET, Eric Blake wrote:
>>> The qcow2 spec changes earlier in the series made it sound like your
>>> choices are exactly 1 or 32,
>> 
>>>> +#define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
>>>> +
>>>
>>> ...but this name sounds like other values (2, 4, 8, 16) might be
>>> possible?
>> 
>> I guess I didn't want to call it QCOW_SUBCLUSTERS_PER_CLUSTER because
>> there's already BDRVQcow2State.subclusters_per_cluster. And that one can
>> have two possible values (1 and 32) so 32 would be the maximum.
>> 
>> I get your point, however, and I'm open to suggestions.
>
> Maybe QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER
>
> since it is a hard-coded property of the EXTL2 feature.

Sounds good.

Berto

