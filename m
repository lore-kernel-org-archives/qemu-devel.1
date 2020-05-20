Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03725C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7962070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CAvbe2v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7962070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLNG-0001y6-Vu
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jbLMh-0001KW-GE; Wed, 20 May 2020 05:50:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jbLMf-0002JY-Qw; Wed, 20 May 2020 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=SNF8ioayuiPXAqwZzTi+VSULlTHIQra8oecC8zxcsG8=; 
 b=CAvbe2v/ngve/QM///+Fa7QfVFHCpf4QZuAFWMtPlaVApsLAsQkyNx2PErIwj0EPwdcaOjoDNc8662RPQ8CfA3hi8r+A2L9e3yoEKl3tBU4XPkf0boShZSvUnE4SYShhGnnbGG8ETJ1qVoTmAQs4MV8N0/SPuU6SDjXtF3hSE5oV8UJcJh+wm0FXrdyQykJi5XzN9lFjGK4lJ0PK5vaTw2jqbrU5Bl1MjCvMaSvUhgFHpN58tkZXfT5iiE8x6QqHFqhmm7mGxO5I9VNit75oHHuQanRb/CWWyydrJzUioViqP5jMd5JRovbbqujWy52/VNIVoPRQvZhM9L3emRkU0A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jbLMa-0000hK-Qj; Wed, 20 May 2020 11:50:12 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jbLMa-0006gG-Gt; Wed, 20 May 2020 11:50:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: Derek Su <dereksu@qnap.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/31] Add subcluster allocation to qcow2
In-Reply-To: <896bdfbc-8651-9bff-32ac-975b58beee0d@qnap.com>
References: <cover.1588699789.git.berto@igalia.com>
 <896bdfbc-8651-9bff-32ac-975b58beee0d@qnap.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 20 May 2020 11:50:12 +0200
Message-ID: <w518shndjfv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 05:50:13
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 20 May 2020 11:35:09 AM CEST, Derek Su wrote:
> Hi, Berto
>
> Excuse me, I'd like to test v5, but I failed to apply the series to 
> master branch. Which commit can I use?

Try applying the patches on top of commit e4d7019e1a

Berto

