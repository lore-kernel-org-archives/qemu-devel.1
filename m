Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED4820708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pA/tvVtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED4820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6Kj-000372-Mt
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jb6K2-0002Kj-BD; Tue, 19 May 2020 13:46:34 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jb6K0-0001ig-Mf; Tue, 19 May 2020 13:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Zadscc7D63iuEnLFSZIr6zq5NpgqGYYZu75/ekvaA9E=; 
 b=pA/tvVtAvaQ4Hhzehl4Iz2uIdWQtf2btCStJ9k4LOSCWugKlzoCkqHjz93AxP1UgZKEItp5K2I02Tllj4J0I4JuC34tjSc8fEfxcfCVeWF7mFhPMYAXOKgqWhOvs/iACf6z+Rl1H5/InFQZ3Sjbg5KCpPA4DuQu1Rw9v0pCvf5OST7rjYQjFM4gq6397Or07TtWMW9tR8fxBM9yozJLyUQr1KRTJ8IPIB3P3IMBahc9KY5wM1EYt8Rtc+FjBXggoJDf5KIIqucTMPJbrZhjcw7XYfg88XgX4BRDhtLfutDGfLbws2XJJN+nbELvWBnZLVfYPJ1ddbGa/03Jm4LgNaA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jb6Jw-0006gM-NJ; Tue, 19 May 2020 19:46:28 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jb6Jw-0001kT-Dt; Tue, 19 May 2020 19:46:28 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
In-Reply-To: <20200415190207.21118-1-berto@igalia.com>
References: <20200415190207.21118-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 19 May 2020 19:46:28 +0200
Message-ID: <w51367vu8az.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 13:46:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Wed 15 Apr 2020 09:02:07 PM CEST, Alberto Garcia wrote:
> Although we cannot create these images with qemu-img it is still
> possible to do it using an external tool. QEMU should refuse to open
> them until the data-file-raw bit is cleared with 'qemu-img check'.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

