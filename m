Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BBFC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C18206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y7hA0FhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C18206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLUJQ-0004Pb-2I
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jLUIj-0003ll-1b
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jLUIh-0004Er-PX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:08:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jLUIh-0004DS-8Y; Mon, 06 Apr 2020 12:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=rvdi1WJL0rhzVRcQLgWSo0PHnO0W5bfre42mIhqB0s0=; 
 b=Y7hA0FhYQ9g174o26glCPg69bf0r1sSOHFMYo4dBph3V6O2Vv9HQcN9ZHMw/Cm+TjeM0cOlabTSO7iSkCxOYPf0654W1iApXAyz70ojtmgyhrvgwc4S+OKaHO+IyEJiWKnyhH3+n7f2KzB8PmSIdkZZhMsja2ovvoeleqkHrSC9IMAEoJK/UHSaSybxXaCE5Vt92y/9qLoZl+/Z5zrJpeRkK9PS/IKfG8KonYQvErvQn8nvDjzj6YtnxkKb7kCwfwrgrfQRqdJHWsd8jf8oU1lOhCPM+w6XLoYSrgmlylJ16JowVJvA2LTR/+oP3I5cLpmRrOWgdIrETYhmDrHu9+Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jLUIe-0000BN-Cp; Mon, 06 Apr 2020 18:08:36 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jLUIe-0002Zj-3E; Mon, 06 Apr 2020 18:08:36 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
In-Reply-To: <20200406143401.26854-1-berto@igalia.com>
References: <20200406143401.26854-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 06 Apr 2020 18:08:36 +0200
Message-ID: <w518sj8ppff.fsf@maestria.local.igalia.com>
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to add the "for-5.0" tag in the subject, do I need to resend
the patch?

Berto

