Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0805C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1D72078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I4jadP3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D72078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIK5-0007F4-Ra
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJICz-0007n7-U1; Fri, 18 Sep 2020 11:22:00 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kJICt-0003Qb-Rx; Fri, 18 Sep 2020 11:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=A42sedHFZNntDkUfHjki+maOP+qOFJ9B2R7QepJDnts=; 
 b=I4jadP3Sb28cZBV8luYu5Zr0SBpl1RCPSvM0gUnP3+jsWFarpSlscJJEMMkMNwuQmovdlBY0jilK7utrEEWQ2UlTC0u/JcF5UwXBuRsbA0tLOo2I4tFaWoDZdoBar7Zz3jM1cSo6fcPyHLTOa2Xaa9cLJne7tDOCE/2lkgQxCkFjC06RlSH8xCZpcNcNZY56f6h4ZhMec1fQhewaOm+EFkQjdjdpf3OkfDy/wr8505dRxBPzrbj8Q8MVpdFeLKD5XcMlwCDh6rwsBGJmuN/WWN2cWewBEZSGY99m3ze9m87T7X/lj8Rf9tVtpwIm+BiZAtLqYd+pN6+vRA1TQDnWGQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kJICp-0001YD-1i; Fri, 18 Sep 2020 17:21:47 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kJICo-0005MZ-OT; Fri, 18 Sep 2020 17:21:46 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 10/13] block/qcow2-bitmap: return status from
 qcow2_store_persistent_dirty_bitmaps
In-Reply-To: <20200917195519.19589-11-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-11-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 18 Sep 2020 17:21:46 +0200
Message-ID: <w51pn6j2jqt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:54:34
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, armbru@redhat.com, groug@kaod.org, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 17 Sep 2020 09:55:16 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> It's better to return status together with setting errp. It makes
> possible to avoid error propagation.
>
> While being here, put ERRP_GUARD() to fix error_prepend(errp, ...)
> usage inside qcow2_store_persistent_dirty_bitmaps() (see the comment
> above ERRP_GUARD() definition in include/qapi/error.h)
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

