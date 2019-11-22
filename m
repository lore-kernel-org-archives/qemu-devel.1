Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A78C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF0B20706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B0KvoHOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF0B20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9di-0003fy-U1
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iY9bk-0002Gt-Et
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iY9bj-0000cb-GF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:08:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:33978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iY9bf-0000W9-Ee; Fri, 22 Nov 2019 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=8MUPZRxIDbnxMJaQ9F5GwZxbwX+OvZEPwMYduLFFVBE=; 
 b=B0KvoHOn5rBIjJvJFHnr6ECCJA5gH/jT17erF52C7KmqKjwA1t3x3hJhQCARHzsdVIqX05mEyIxG+PGvU88JplJUj4izHUTJMq/oiP7ivOzOzkuEGEs2FHszgL30nhRfDbgsdLOikgf0UzQqTzxWajqtSySeahVXK9nLSqKudO0zhnIckL0p+YQmmy29wCcwIf/tRlB2w7PzzNCePF8A8Nt0lkoTSFkL+rfYDnCc9pwA37e8e1y/ki5ZEqkTSfq9xfnKkihzMuzF1D01OJHc9Yp2lnLoRRmnQ6NQTmlT9BGd48AguyIyX9SwynLnL5T0+IfITvUwAMGFWTQuKbwdig==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iY9bE-0003oT-K5; Fri, 22 Nov 2019 15:07:52 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iY9bE-0005TI-HI; Fri, 22 Nov 2019 15:07:52 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
In-Reply-To: <20191121143331.GG6007@linux.fritz.box>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
 <20191121113405.GE6007@linux.fritz.box>
 <38b48cd4-a7b6-c2c0-db38-99c2192b6d05@redhat.com>
 <20191121143331.GG6007@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 22 Nov 2019 15:07:52 +0100
Message-ID: <w51h82w0zt3.fsf@maestria.local.igalia.com>
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 21 Nov 2019 03:33:31 PM CET, Kevin Wolf wrote:
> For commit it's an image corruptor. For resize, I'll admit that it's
> just wrong behaviour that is probably harmless in most cases, but it's
> still wrong behaviour. It would be a corruptor in the same way as
> commit if it allowed resizing intermediate nodes, but I _think_ the
> old-style op blockers still forbid this. We'd have to double-check
> this if we leave things broken for block_resize.

I tried but cannot make block_resize touch an intermediate image:

    if (!bdrv_is_first_non_filter(bs)) {
        error_setg(errp, QERR_FEATURE_DISABLED, "resize");
        goto out;
    }

Berto

