Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830AD206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CuJL8E1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830AD206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8bO-0004Nt-Ol
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kD8Zn-0001lH-6Y; Tue, 01 Sep 2020 11:52:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kD8Zk-0002pC-J1; Tue, 01 Sep 2020 11:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=KNr5mbVqX0pAOpsy3E3+gsRYlh1KeJDiFVrABwAXuYo=; 
 b=CuJL8E1GxYWE4m3sU5W3/gEIaaXWR3nMr0GIsZPryy6lHg7dajCG7SQ/jRmKq1sbhtx05jX4co0FwxHwYaB6o+stNq8DkEI6uL1A3BIPwpK/kgX7n7uAPiwSW7qfQpXVHoKhFyNUoi+Om1ykwHbjG9hqNZ/jfWKce4Obp4o3HLUhovz3NAqJbFvnCkqnPEUSgWZUPVWXC4tELOCREy+XQXlEEyMcHBXIvjUGaMqYjJgEnf5mJTEp3d9fRN6FrC+D+j0k1MnHiE389K3A6bUUAixIaXQOR/m9+GQ/Z/cui/Sj8plObUGneeHGdqsp+sTHLZ3QJrMxkIy5dRLeXAzE0g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kD8Zg-0007Zu-2Z; Tue, 01 Sep 2020 17:51:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kD8Zf-0003sI-Ne; Tue, 01 Sep 2020 17:51:55 +0200
From: Alberto Garcia <berto@igalia.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] block: file-posix: Replace posix_fallocate with
 fallocate
In-Reply-To: <20200831140127.657134-3-nsoffer@redhat.com>
References: <20200831140127.657134-1-nsoffer@redhat.com>
 <20200831140127.657134-3-nsoffer@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 01 Sep 2020 17:51:55 +0200
Message-ID: <w51y2lt7aw4.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 31 Aug 2020 04:01:27 PM CEST, Nir Soffer wrote:
> If fallocate() is not supported, posix_fallocate() falls back to
> inefficient allocation, writing one byte for every 4k bytes[1]. This is
> very slow compared with writing zeros. In oVirt we measured ~400%
> improvement in allocation time when replacing posix_fallocate() with
> manually writing zeroes[2].
>
> We also know that posix_fallocated() does not work well when using OFD
> locks[3]. We don't know the reason yet for this issue yet.
>
> Change preallocate_falloc() to use fallocate() instead of
> posix_falloate(), and fall back to full preallocation if not
> supported.


>      case PREALLOC_MODE_FALLOC:
>          result = preallocate_falloc(fd, current_length, offset, errp);
> -        goto out;
> +        if (result != -ENOTSUP)
> +            goto out;
> +        /* If fallocate() is not supported, fallback to full preallocation. */

With the missing braces in this if statement,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

