Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB8AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D968B206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EYwBETts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D968B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYC4O-0002EI-WE
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYC3a-0001JM-Mm; Mon, 11 May 2020 13:17:34 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYC3Y-0002r0-Dt; Mon, 11 May 2020 13:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=pxWOO1JrtZ1jQ71eiYIPhjWSm1RyZwpEOewDmBN32M4=; 
 b=EYwBETtshP6ydLE9NRkpF13G4ufatpHfa4PO4qg/7IC4TpLAp1Hdhd/UzATeb3bVUiCDwmgypAufDrdUT6hrZ35JQXsnPT1WUcF6BTYa/4ByMdLc4EuQvqvu38s5Uk96G8/DrM7LmqtvAdHI+Kw/BREXBSD8PK3Anb2SE8s3LGQDYgpSEOtAa3emAix+CPsw4ipsM/PpKJqTIGg6ZbDYjKkQRscNtHweFYHGTXl0E7fw/bgHSl4CSXaoULwjY1pQIzAJ3hg0qM9POFHCQFXnx0/vEEHG7dAZFlvh/inMEsxagI5IyYwcRZM/dJULVub2r6wMBbtTOYXSITQvzBRc0A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jYC3R-0001Wh-Ng; Mon, 11 May 2020 19:17:25 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jYC3R-0004Sp-EZ; Mon, 11 May 2020 19:17:25 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
In-Reply-To: <20200430111033.29980-6-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-6-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 11 May 2020 19:17:25 +0200
Message-ID: <w513686o0gq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:28:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 30 Apr 2020 01:10:21 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>     compute 'int tail' via % 'int alignment' - safe

    tail = (offset + bytes) % alignment;

both are int64_t, no chance of overflow here?

Berto

