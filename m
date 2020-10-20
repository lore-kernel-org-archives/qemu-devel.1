Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042C122244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PfQqGA+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C122244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqDW-0003T1-Se
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqCx-0002xl-5e; Tue, 20 Oct 2020 07:53:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUqCu-0004oq-8V; Tue, 20 Oct 2020 07:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=+3eFY5DK3hrICl9OfK26DpnDWeZWQY7sFVzxmV9IxQI=; 
 b=PfQqGA+t4+XTRL+UCCjRrUabZtlMmfck4uFw1KzArmBIvY42h3rMQC01huV0+5ok7kFQfFwfZDS6ZgMZCIbdzNqTimRHqe6g52uMKIXmqyXQeKy2C/vd6wJpWC+DPlU1zTHz9LSi5hNbNddPuVRpLhOeoamCkbWJgKxlZfzTuRTswuTEiTcnbCQrRIQ2OHcU0UOVje5yN878qZS/IlwS5SGTy9MURlpUHcNkmsZnkQmLNRlTLI4lCW7pjv5qeA9etphmQtIYKxiRo8c28I4EjM0pq+BwHvEDkFp+yFgROBPBcM8MmXXJP2SQ+9zq8H67DEJPM6kAVdudRBVqTOQYlw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUqCV-0006fS-F9; Tue, 20 Oct 2020 13:53:11 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUqCV-0001Z2-3q; Tue, 20 Oct 2020 13:53:11 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Plans to bring QMP 'x-blockdev-reopen' out of experimental?
In-Reply-To: <20201020082333.GB4452@merkur.fritz.box>
References: <20201006091001.GA64583@paraplu>
 <w51mu0ifbuf.fsf@maestria.local.igalia.com>
 <w51k0vmf9k3.fsf@maestria.local.igalia.com>
 <20201020082333.GB4452@merkur.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 20 Oct 2020 13:53:11 +0200
Message-ID: <w51mu0hm7vc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:53:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 20 Oct 2020 10:23:33 AM CEST, Kevin Wolf wrote:
>> >    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00601.html
>> 
>> I forgot to add, we still don't support changing bs->file with this
>> command, so I guess that would be one blocker?
>> 
>> There's no other way of inserting filter nodes, or is there?
>
> Not that I'm aware of.
>
> So yes, changing bs->file is the one thing I had in mind for
> implementing before we mark it stable.

Note that you can still open a new bs with a different bs->file and
replace the original one (as long as the original one is the backing
file of an existing bs, that is :)).

> I'm not entirely sure if we should make some restrictions or allow
> arbitrary changes. If it's only about filters, we could check that the
> node returned by bdrv_skip_filters() stays the same. This would be
> almost certainly safe (if the chain is not frozen, of course).
>
> If people want to dynamically insert non-filters (maybe quorum?), it
> might be more restrictive than necessary, though.

You mean replacing bs->file with a Quorum node? Quorum itself does not
use bs->file, it has the 'children' attribute.

Berto

