Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5985C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779D62080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OzwhtBM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779D62080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmErz-0007Mj-Jy
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jmEql-00069U-IC; Fri, 19 Jun 2020 07:06:23 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:53299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jmEqj-0005T4-9I; Fri, 19 Jun 2020 07:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=gLQXBRPd4QjG5HqHSl/q3WZAdnsaYgRPLqZHeM0jZHE=; 
 b=OzwhtBM3CvDao1+De6y2fZdERvmRcESzFv3FvCFIgxNFK7Mxzc3+FoVecfZwuMw7tH5LZgqV8lhDE2UEcLZ+VQu0Z6VlwTlkC3I+iXU46QQf7hFdOFCis9uEP1U578/1AdV7Gbolyk2ACrToCwAs5Lw1mg8N9Y18N8QbCs9LDX6SpQcfM92G67t6548enh+PRwANXrp5t0GeC/2gLeQa1vYpROHI9ApREiQfv+0WRzm6dUvTXPs07iTxAxXTM55Dc7axO+cipiQKfD9CAPwf+GFcFg0/yyXCnYE6jxuURk6fvhHGroEroszvcTWRJV3Ebj3xdSBQTGjF/rglzjx5Wg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jmEqf-0007D6-SJ; Fri, 19 Jun 2020 13:06:17 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jmEqf-0000ls-Hf; Fri, 19 Jun 2020 13:06:17 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
In-Reply-To: <80d5af9c-0b8b-472a-fba2-cace33be6053@redhat.com>
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
 <w51r1uctwc2.fsf@maestria.local.igalia.com>
 <80d5af9c-0b8b-472a-fba2-cace33be6053@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 19 Jun 2020 13:06:17 +0200
Message-ID: <w51h7v7s4ba.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 07:06:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 19 Jun 2020 09:57:27 AM CEST, Max Reitz wrote:
>> If two images have the same contents but then you compare them
>> changing the backing file of one of them you can also get a content
>> mismatch. How is this different?
>
> It=E2=80=99s different in that files with data-file-raw can=E2=80=99t hav=
e backing
> files at all.  So maybe users shouldn=E2=80=99t be allowed to give them
> backing files at runtime either.

I understand that. Ideally it should be forbidden. Perhaps that could be
fixed by turning drv->supports_backing into a function.

My point however is that forcing a different backing file is something
that is going to cause breakage unless the user really knows that
they're doing. And we don't generally forbid that, we just let the user
take responsibility. So I'm not too worried about this case.

> Or at least, if we have data-file-raw, *all* data visible on such an
> image should be taken from the raw data file, never from any backing
> file.

It should be easy to handle in qcow2_co_preadv_part() and
qcow2_co_copy_range_from(), but it feels hackish and error prone.

> With preallocation, we=E2=80=99d ensure that we always take all data from=
 the
> raw data file.  So we=E2=80=99d always ignore any potential backing file.

Preallocation has its problems (and we would also have to handle it
differently if there are subclusters, but I think that should be
easy). But I don't have a strong opinion.

Berto

