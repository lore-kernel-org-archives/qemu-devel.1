Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE0C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823EE20659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BTf5jMc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823EE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oRC-0001PH-LE
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j4oNQ-0002zQ-3p
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j4oNP-0005Bu-44
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:35 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:40872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j4oNO-0005AG-Qk; Thu, 20 Feb 2020 11:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hHLDK0HiF64asg23VXQhJ6lsflpkSRdjEezE2oT1vUo=; 
 b=BTf5jMc649kbt07iinXk9MnqqstsHz5Y3vK4xlzvMP6QHb2zNc78f0hn33KWUzxTfB9PzGo07sq1wo/H1YCOlxscaeL8qizNXW4mOVQ7xqg5mPB/lnR7HosH7MHP5JptPn8afus49RDSzKLl8hjzpO+kH0ZhhFemZAuebKxvDVM/t8o6M974wP4YakExmESIuXPIxAEn98+Nk8w0xwlFs8yQvUcUG7dy3n92dW+wJksQVOGaplsmfAasSaBH0aro5IGftH7FQIDS3MLmvW06ktRN2G4BOFvkjDg1Itea+G9qEMgkVYx3fA8hZVP40r15BnUwY3Ytm05tI4i0x8Qcaw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j4oNM-0005LQ-Go; Thu, 20 Feb 2020 17:08:32 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j4oNM-0005To-5H; Thu, 20 Feb 2020 17:08:32 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 04/27] qcow2: Add get_l2_entry() and set_l2_entry()
In-Reply-To: <aca66606-11df-56df-e20a-a966d9c151c3@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <a1be1f4311da643b439cb5e1924b0ddfb052f338.1577014346.git.berto@igalia.com>
 <aca66606-11df-56df-e20a-a966d9c151c3@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 20 Feb 2020 17:08:32 +0100
Message-ID: <w51h7zlb5rz.fsf@maestria.local.igalia.com>
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

On Thu 20 Feb 2020 04:22:24 PM CET, Eric Blake wrote:
>> +++ b/block/qcow2.h
>
> scripts/git.orderfile can be used to hoist this part of the patch to
> the front of the message (as it is more valuable to review first).

I didn't know that git had this feature, thanks for the tip!

Berto

