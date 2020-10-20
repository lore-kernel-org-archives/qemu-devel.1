Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE9121741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iOJrK/kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE9121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUt1I-0004L1-IS
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUswr-000870-UW; Tue, 20 Oct 2020 10:49:14 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUswp-0003E4-JY; Tue, 20 Oct 2020 10:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=LbMiPL9FFt0EQVo9WJDMUq62Xsx5XI3dp90IFeWpWq4=; 
 b=iOJrK/knkDlQQ4fJwPydnCeTCnteg5g6rvKXRA8L2TtMZpf/+rpK8Vpjq2dK1dfvSQ3NvlzSbu/D6u38KlbC29zqnyNxmGLZkGU196bMyn4Q4e12HbrrRZRu2/d1LMVGfeSC3ETj3CmjBUA5xDnC3VlaWlvtRgD26mmOVs0lZxlSxDI7pk8ysojTwCeN6wSwkJpmuyH9oeWFf/cxQgb4csfh6JqvRYXvEyylPd5FUpZefbDpbWBlg9UQFrW+3nWtmJvo0QRN42x73XHaBObrLM7nRHDCgb5RNtR9qy3jWgPwKGPDmBNmWjskBhH5fOnszUFJdxb+JaPLCR4H485TJw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUswg-0008M1-Kg; Tue, 20 Oct 2020 16:49:02 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUswg-00059k-B5; Tue, 20 Oct 2020 16:49:02 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, "Wang\, Wei W" <wei.w.wang@intel.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: Question on Compression for Raw Image
In-Reply-To: <ec72d814-109c-4ed9-cb26-32b9d903f8c2@redhat.com>
References: <516589845d6f42d0b00784d16b59b5dc@intel.com>
 <20201020080051.GA4452@merkur.fritz.box>
 <6124d55766e4477299a5796a002276a0@intel.com>
 <ec72d814-109c-4ed9-cb26-32b9d903f8c2@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 20 Oct 2020 16:49:02 +0200
Message-ID: <w51blgxlzq9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 10:36:44
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
Cc: "lersek@redhat.com" <lersek@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 20 Oct 2020 04:32:23 PM CEST, Eric Blake wrote:
> My recommendation would be implementing a new BDS filter that does
> uncompression.  Then, you could do things like:
>
> raw -> decompress -> file.xz

This would work, although read-only and you would need a compression
format that supports random access (I think that's the case with xz, at
least if you compress it using small blocks).

Berto

