Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEA02084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D/5UdXkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEA02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXMW-0003Cq-Ak
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdXLJ-0001Zs-3S; Tue, 26 May 2020 07:01:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdXLF-000437-Ot; Tue, 26 May 2020 07:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=HOBnHloC7mDbrWgNTssjMRdW3lfjV0fZRTG7vwb/yWg=; 
 b=D/5UdXkRCb+EP2IyLKX9eTzoJpDSQZ/CUsSJa9/aeGfb+0iGWYRHsEONm0xTqRG/MnP2IDYd2C/lHBW6F/pKRI90CdLgVVROz2w+dDRieHT0n/PPo9p1fBRfgSJfWC6hWsSu2pepZ0QDQX75juWtVI5zfjGLRkOoIQwzaaMNnnjZSn2Kq7ELRkVlKvqGxWfO8n8EBge/2I7GfZxMetMeC2DcdtXVFabiUrqe4WUb+3zsXG0aEOF6l1FJBHNtr8Vt/ml/+hWUMg2LjU+clnxzIpRYPMHIcmiKKKQozp8JsYdl2H+oADbWlI82gj57syTQR8UeM62C/zEju03UIXn38w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jdXLC-0000zJ-1d; Tue, 26 May 2020 13:01:50 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jdXLB-0007sW-M2; Tue, 26 May 2020 13:01:49 +0200
From: Alberto Garcia <berto@igalia.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
In-Reply-To: <159046168943.6628.8328464362928767250@45ef0f9c86ae>
References: <159046168943.6628.8328464362928767250@45ef0f9c86ae>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 26 May 2020 13:01:49 +0200
Message-ID: <w51blmb3qoy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:01:51
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 dereksu@qnap.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 26 May 2020 04:54:50 AM CEST, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/block/qcow2-cluster.c: In function 'qcow2_get_host_offset':
> /tmp/qemu-test/src/block/qcow2-cluster.c:473:19: error: 'expected_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>          } else if (type != expected_type) {
>                    ^

These are all false positives, these variables are never used before
they are initialized.

Berto

