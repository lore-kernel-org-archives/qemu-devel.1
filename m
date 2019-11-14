Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D113C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3719B206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KT5wZI9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3719B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFe4-0000Rq-7Q
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iVFdJ-0008P6-QF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iVFdH-0004A4-JX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:58:01 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:57489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iVFdH-000492-19; Thu, 14 Nov 2019 08:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=iX6s0FXqkxyOZd6CQdacGX2N7XpV3jWSVFXTPEjWKfA=; 
 b=KT5wZI9KhI0uVyllotT+nscpSZDVWqJzZZPSUEYn+vJVkdXgLfSDcY1wyU7GaIxTfScE7DWMcOHnvib+2nHgnLZXPMIvSWxuJf0E71lE0yTJ6UUXZJUqzjMv+fbzBrQUr/kvDB391zXxjPVZMdo+BXZ8MDB0yFlo/EdL+Lzn5Uwuksa1g2N5WC6AJ/MJeBNLu95p6zLlnssFxgKzRJbAjK7Tvdrs3Bjt2ULLnZMxvHIhk9ElWSSkzCBGpOyUieAHe4nsyVHTn602Uj8yjEiGuxFyZ0eHXEXzLYvWDEOeRFOxFhD2qbfzeUkl5wiZ+C6/pg7pb1/Be12V3SDuc91U/w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iVFdC-0004Ol-Ln; Thu, 14 Nov 2019 14:57:54 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iVFdC-0002bQ-J5; Thu, 14 Nov 2019 14:57:54 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 10/26] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
In-Reply-To: <012198da-55cd-b176-5cb0-0002fc3b92b1@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <2d4de1dee301cd772fce97c90e08a390edbe2830.1572125022.git.berto@igalia.com>
 <012198da-55cd-b176-5cb0-0002fc3b92b1@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 14 Nov 2019 14:57:54 +0100
Message-ID: <w51y2wief19.fsf@maestria.local.igalia.com>
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

On Wed 30 Oct 2019 05:55:04 PM CET, Max Reitz wrote:
>> This patch also adds the get/set_l2_bitmap() functions that are used
>> to access the bitmaps. For convenience, these functions are no-ops
>> when used in traditional qcow2 images.
>
> Granted, I haven=E2=80=99t seen the following patches yet, but if these
> functions are indeed called for images that don=E2=80=99t have subcluster=
s,
> shouldn=E2=80=99t they return 0x0*0f*f then? (i.e. everything allocated)
>
> If they aren=E2=80=99t, they should probably just abort().  Well,
> set_l2_bitmap() should probably always abort() if there aren=E2=80=99t any
> subclusters.

Yeah, set_l2_bitmap() should abort (I had this changed already).

About get_l2_bitmap() ... I decided not to abort for convenience, for
cases like this one:

    uint64_t l2_entry =3D get_l2_entry(s, l2_slice, l2_index);
    uint64_t l2_bitmap =3D get_l2_bitmap(s, l2_slice, l2_index);
    type =3D qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc);

Here the value of l2_bitmap is going to be ignored anyway so it doesn't
matter what we return, but perhaps for consistency we should return
QCOW_OFLAG_SUB_ALLOC(0), which means that the first (and only, in this
case) subcluster is allocated.

Berto

