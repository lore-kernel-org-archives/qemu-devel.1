Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87932C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E65206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TOu1L0fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E65206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6OF-0000Kk-FC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kD6N6-0007uv-VN; Tue, 01 Sep 2020 09:30:49 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kD6N4-000745-4W; Tue, 01 Sep 2020 09:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=bGshJ4Wk6E80fKASHaiUUME6bhrfZ3T0jtNvHRqWOVI=; 
 b=TOu1L0fcaFBOygOoYvNcOZG3BMUAoJcHmBTxsEYcXjMN4EXrUGPKdm0zlwLRMWCwdMXHjkJIJ2zBT7NS1jl8q3hd9KC0WKkewn/32PH0Eo2ru8c83VUds6B4xHuLPnxgvfYWvUMoHAO23dM+MnocK+mankxghcT0AEOgUEGtHrKVWOgYc2n4LsGLFCegO/y3E/TG5rKuc9QhWov6XPpBGVF3D1D1gSptzS0yBPy1sO68YTUEOGivMzusYUxT7JGP3sijPCFPFyn5tyTmnqRb5Sloh5jxUgZstkv48VpjVs2q2Qn49ev4uiaU3ty7dwUZow1cIvefyZ9qJF940pZ8eg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kD6N0-0002Jp-7k; Tue, 01 Sep 2020 15:30:42 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kD6Mz-0008Fr-Q9; Tue, 01 Sep 2020 15:30:41 +0200
From: Alberto Garcia <berto@igalia.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qcow2: cleanup created file when qcow2_co_create
In-Reply-To: <20200716113359.15656-1-mlevitsk@redhat.com>
References: <20200716113359.15656-1-mlevitsk@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 01 Sep 2020 15:30:41 +0200
Message-ID: <w514koh8vzy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 09:30:42
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 16 Jul 2020 01:33:59 PM CEST, Maxim Levitsky wrote:
>      if (ret < 0) {
> +
> +        Error *local_delete_err = NULL;
> +        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
> +        /*
> +         * ENOTSUP will happen if the block driver doesn't support
> +         * the 'bdrv_co_delete_file' interface. This is a predictable
> +         * scenario and shouldn't be reported back to the user.
> +         */
> +        if ((r_del < 0) && (r_del != -ENOTSUP)) {
> +            error_report_err(local_delete_err);
> +        }

I think you're leaking the error on ENOTSUP.

Berto

