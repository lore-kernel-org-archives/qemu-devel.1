Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95162206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kWlEzzNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95162206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHCt-00056k-JS
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iVH6Y-0000M0-4o
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iVH6P-0001u1-KS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:32:15 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:60011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iVH6O-0001nF-9G; Thu, 14 Nov 2019 10:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=QyugHUn8CGEBqLjRwwDFQIZBCGJvlF3vk07di4uIjAA=; 
 b=kWlEzzNAHweFg0p4W7u3WvU/jrKqV3Jk43XRCZCftYmOsQwohonw4SUN+UKcSEE5HZ/7WroxXAhlh9jIc0R+V9NgaYRsvvd6BDrVbH8V4pOre0c2gPM1/RrYDhxrcxtMV4C340Ix5rZwYm3izIm9FV4+mFOrKac15JIt+BLm3cZUWnZ88PIgM4Fp1Q/4qe5J2EPnvpPBnkRw93InKC+yqIr5xwBrQrWfJqnbrQRLLIe5+TrLpI7CHuesw0wYqqlqzs/DBFGTLM0idwy5fNBt2HChdQkYNqeIO3rKREldKFlZp/pga3EfRledZyXX6p+okgpu7x0PsGIMGluzMg9OOA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iVH60-00054j-Og; Thu, 14 Nov 2019 16:31:44 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iVH60-0003YL-MH; Thu, 14 Nov 2019 16:31:44 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 15/26] qcow2: Add subcluster support to
 zero_in_l2_slice()
In-Reply-To: <3a42a341-367c-82b1-19c1-9ae2a9986de7@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <8f366482d2b273c26ff67cba1de898289f613fc7.1572125022.git.berto@igalia.com>
 <94b1434e-3e0f-bbce-0ba0-67309565bfec@redhat.com>
 <3a42a341-367c-82b1-19c1-9ae2a9986de7@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 14 Nov 2019 16:31:44 +0100
Message-ID: <w51v9rmeaov.fsf@maestria.local.igalia.com>
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

On Mon 04 Nov 2019 04:10:58 PM CET, Max Reitz wrote:
>>>          qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>>          if (cluster_type =3D=3D QCOW2_CLUSTER_COMPRESSED || unmap) {
>>> -            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
>>>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_R=
EQUEST);
>>=20
>> It feels wrong to me to free the cluster before updating the L2
>> entry.
>
> (Although it=E2=80=99s pre-existing, as set_l2_entry() is just an in-cache
> operation anyway :-/)

Yes, I think that if you want to do it afterwards you need to add
another loop after the qcow2_cache_put() call.

Berto

