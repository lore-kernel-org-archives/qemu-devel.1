Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1952071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bOUYs3nN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1952071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHuQj-0000fQ-8k
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jHuQ9-0000Bf-Bs
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 15:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jHuQ8-0007TP-Db
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 15:13:33 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jHuQ7-0007PZ-Qk; Fri, 27 Mar 2020 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hW7AipdSyKUbVimxJIQSvcalLeKcftRta23V3faFWBQ=; 
 b=bOUYs3nNcNY6gGTmbaZg/lLYQWku256ASHsc36cTbg2nMP214Q0uz/9sbGkmApGzHm2N+b0ggYV/lKWMGLKdZtVfJVbrycIGRFUOtsTWDUdp1scdR9FEMkW1yyjPCispZ0RsuuVhQVLjwBS9eBI71+4wkEg8f3ELB4vuABhZ/pk7x8OhneTL2vLWW8EzUDQvTw3XWgN/q68RD9Xe+7yUgv3AvbvzBcDauKxsoILJR9iUL0sxhH0B3ILRqLKv9iTrKSVXyOVm962A4VeYO2U5odmjxMwYKw1q+SXjK8uAAUNtIxiGX9jh05+zOXNbpoAcxjhrVZ4zOBP7yhzyk0HSsQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jHuQ4-0005h3-DO; Fri, 27 Mar 2020 20:13:28 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jHuQ4-0005nh-31; Fri, 27 Mar 2020 20:13:28 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qcow2: Forbid discard in qcow2 v2 images with backing
 files
In-Reply-To: <1871e816-ef2f-379a-93da-9b1a825fa876@redhat.com>
References: <20200327164857.31415-1-berto@igalia.com>
 <1871e816-ef2f-379a-93da-9b1a825fa876@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 27 Mar 2020 20:13:28 +0100
Message-ID: <w51blohhaqv.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 27 Mar 2020 07:57:40 PM CET, Eric Blake wrote:
>> +    /* If the image does not support QCOW_OFLAG_ZERO then discarding
>> +     * clusters could expose stale data from the backing file. */
>> +    if (s->qcow_version < 3 && bs->backing) {
>> +        return -ENOTSUP;
>> +    }
>
> Hmm. Should we blindly always fail for v2, or can we be a little bit
> smarter and still discard a cluster in the top layer if the backing
> layer does not also have it allocated?

Not sure if that's worth it. I only wanted to fix what looks like a
potential security bug so I prefer to keep it simple. qcow2 v3 has been
out for many years already.

Berto

