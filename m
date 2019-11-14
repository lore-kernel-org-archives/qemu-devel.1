Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BBAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49DA2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FnVuxjsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49DA2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59557 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVI2Q-0003Ie-HG
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 11:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iVI1H-0002lh-Rt
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 11:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iVI1G-0008Uj-Q6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 11:30:55 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:45938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iVI1G-0008UX-8j; Thu, 14 Nov 2019 11:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=f1RirJvvUeLJsnKNfUMaLgYUeQF0wiRTlL9EblNuzKg=; 
 b=FnVuxjsjTHJulSaxNRcykbA7+JQLce54J/ea5BZybO1tvkYW0kJAGqA/bf2l1Wb3a3hyBvimpyZLuUo6VmgfCrUSTktGvzbvzJ4ycYvmEos/h4FPL4NNKTHLI5Qa0pL602EpRgSWsFWBf/+IqmDpffZN1QSTAgZokFavmhmeZ1OlNI20NQGehu8pjSBClPONItArrM2rFdWL0/83f2JOgk9dlnRBg4lZZMXhrJeV5mTGUj5kzzVBWyx8pMr91SpaXyo/sOWUR8Bc7mxidcDQ78ClJjl4Teu/zvyKjq65SDdTXOdISID7zYYXwZwwLjAzPPNoXYfLvW5VLhJsauAXYQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iVI1D-0002OC-OH; Thu, 14 Nov 2019 17:30:51 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iVI1D-0002hX-L3; Thu, 14 Nov 2019 17:30:51 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 20/26] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
In-Reply-To: <389b5cbb-2278-86c1-034a-05621a7b4c71@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <289ea5edc3f1530787c8fe905b1a524cc48945a9.1572125022.git.berto@igalia.com>
 <389b5cbb-2278-86c1-034a-05621a7b4c71@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 14 Nov 2019 17:30:51 +0100
Message-ID: <w51mucye7yc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 Nov 2019 12:43:16 PM CET, Max Reitz wrote:

> Speaking of handle_copied(); both elements of Qcow2COWRegion are of
> type unsigned.  handle_copied() doesn=E2=80=99t look like it takes any
> precautions to limit the range to even UINT_MAX (and it should
> probably limit it to INT_MAX).

Or rather, both handle_copied() and handle_alloc() should probably limit
it to BDRV_REQUEST_MAX_BYTES.

Berto

