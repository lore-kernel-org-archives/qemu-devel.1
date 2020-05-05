Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D04C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47086206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L70PHBju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47086206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVthy-0000c8-FV
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVth1-0007l6-Ec; Tue, 05 May 2020 05:16:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVtgz-0002L9-Cy; Tue, 05 May 2020 05:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=OJ9QUH5erwhAaGS8241h5qZu1gDOQSLXDgNz561Lh3g=; 
 b=L70PHBjufhWhovPlITiZff3n+wHo0eSCd7wTV7U69Q/pGYdnimO2E700rb98WqqWQvEHhpAFQM1Y9+JPB+v+8rFfeiFTVgCMurP8nAt9Zs9zet9nGpUfP4gHaYuWoBXhKfzeMesPeI0g8MxQCFK+qQ1osFDQWl62QgZJiwgntwdaRnicmr5HBOeMI9il9A0uQniZznYL40Ha7Wc1cY0KEly3dUiu0qoUGSMK47sQIsogr0l3euTSPc6e/5B4z9mgCikk2Hvft2LBZ+svFH0EO99eYEWMsej36hHl7VJk41veyYXqYrEGd1JRA/0Af//nDRmnhGfMHM//EveO8D3aZw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jVtgu-0005Mc-Hc; Tue, 05 May 2020 11:16:40 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jVtgu-0001wk-88; Tue, 05 May 2020 11:16:40 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
In-Reply-To: <20200505085412.GD5759@linux.fritz.box>
References: <20200504155217.10325-1-berto@igalia.com>
 <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
 <w51368fiq7k.fsf@maestria.local.igalia.com>
 <20200505085412.GD5759@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 05 May 2020 11:16:40 +0200
Message-ID: <w514ksuvj0n.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:23:43
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 May 2020 10:54:12 AM CEST, Kevin Wolf wrote:
> But I think there is a more important problem with the test: It seems
> to pass even with old binaries that don't have the fix. Is this only
> on my system or do you get the same?

With old binaries when qcow2_cluster_zeroize() is called it receives
bytes = (UINT64_MAX - 9216), however that number is then used to
calculate the number of affected clusters, so it's rounded up, wraps
around again and back to zero. There's no visible sign of the error, it
just happens to work fine.

If there was a raw data file then we would try to write UINT64_MAX-9216
bytes to it, but in this case there's no backing file allowed and
therefore the image is not zeroed, so qcow2_cluster_zeroize() never
happens.

Why the test case then? There was a mistake with my first patch and
there it crashed (due to an assertion), that's why Eric thought it would
be a good idea to add a test case anyway, in case we have to change that
code in the future and we screw up.

Berto

