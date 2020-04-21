Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA57C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76E820663
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e3mHWt7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqGt-0003EX-0b
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQqG2-0002ad-Ic
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQqG0-0004Ts-9O
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:36:01 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1jQqFz-0004Mr-9F
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From;
 bh=kv+2wD/YocAsLmzwvLaldiYbhcvS5dqkZiOZxeWuRg4=; 
 b=e3mHWt7emIxLWMYOnAATrH4zeJtBaK9HZ2Jb/HW0U23qkPfkfV8EbkQCIHMwfUwVeBsY5h80vO+nP+vTdAu8oxMB4XyZZGRgFCx9F2rPne4AZwqpRsxEUVasAf1wsGnrCLcx2JhDWZsncal6NiZUpHfZ+vNLdlRtIKuiTkUPkgd1Isvymf/p4WgpFSgSB+rWwyWZ6RnaJWlEG7BtQt7J3YuxSP/MMc6RoPA1rEc+9LZZuXyflJTGqdONzaEnkdnflGaxITDAi+w2d+ftDgkJYxlkZlBeCSzJSRsn1sbfsSpqU6LKOF6Aad0o2N3QinjlDy6QH3qhTDG8umj8iqh8hw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jQqFu-0001LJ-Um; Tue, 21 Apr 2020 12:35:54 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jQqFu-0002MG-LZ; Tue, 21 Apr 2020 12:35:54 +0200
From: Alberto Garcia <berto@igalia.com>
To: Derek Su <dereksu@qnap.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/30] Add subcluster allocation to qcow2
In-Reply-To: <d27d16e3-f6c7-a960-5531-d3ed71b5b92a@qnap.com>
References: <cover.1584468723.git.berto@igalia.com>
 <d27d16e3-f6c7-a960-5531-d3ed71b5b92a@qnap.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 21 Apr 2020 12:35:54 +0200
Message-ID: <w51368xazxx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 06:35:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 21 Apr 2020 07:06:42 AM CEST, Derek Su <dereksu@qnap.com> wrote:
> Hello,
>
> This work is promising and interesting.
> I'd like to try this new feature.
> Could you please export a branch because the patches cannot be applied
> to current master?

Hi,

you can apply v4 on top of 3189e9d38c82266ea5750a81255fd229c7ddf1e6

I also plan to publish v5 this week.

Any feedback is very much appreciated.

Thanks!

Berto

