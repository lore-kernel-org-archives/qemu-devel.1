Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE6FCA9ECB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6932217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RlKJsTiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6932217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPqMt-000248-2i
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iPqL2-0001IJ-FS
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 11:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iPqL0-0004r8-8y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 11:56:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iPqKz-0003QY-JA; Wed, 30 Oct 2019 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=4DfVVospq7N9KYwPSrcqO0o+iSqvVTDcevN8//u331g=; 
 b=RlKJsTiXlgZAafjz1X818xIlpfpAYx6XeZaSJBQg2IobcxOkWyHl9/VI2iKzHHaoZmkQxAYTbvDlhXRAqkl2xCb9I0zhVROl0N5VN1TSVTLub+30dpy2G5Q1n6NaHx6SDsmqYOKQjSn29AIgOdGD0ZwK0g49lDXKZKH5lB8OJtO7WzeBd3dICOrOC3UqlIIbsB7NRIreGdzuey8UJVZUV0K3ZHyDMDy+75vBKdbWN62JEvZuWBzuewF3QYELpogVWxuHwoDM8YybryLCo+7YayLH5QQdgAheS06p0osYfhGezXYG1YQC1kLQ1besnywgVANNlxijz0U6HkHWaMIZmg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iPqKe-0003Po-OL; Wed, 30 Oct 2019 16:56:24 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iPqKe-0006Sn-Ly; Wed, 30 Oct 2019 16:56:24 +0100
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
In-Reply-To: <81fcd087-d4f7-173d-e6cc-53f59dbd2d45@virtuozzo.com>
References: <cover.1572125022.git.berto@igalia.com>
 <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
 <81fcd087-d4f7-173d-e6cc-53f59dbd2d45@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 30 Oct 2019 16:56:24 +0100
Message-ID: <w511ruucjmf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 28 Oct 2019 01:50:54 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> -        .cow_end = {
>> -            .offset     = nb_bytes,
>
> hmm this logic is changed.. after the patch, it would be not nb_bytes, but
>
> offset_into_cluster(s, guest_offset) + MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset))

It hasn't changed. The value of .cow_end.offset before the patch is
nb_bytes (these two lines are equivalent):

  nb_bytes = MIN(requested_bytes, avail_bytes);
  nb_bytes = MIN(*bytes + offset_into_cluster, avail_bytes);

After the patch we update *bytes to pass it to calculate_l2_meta(). Here
is the value (again, these are all equivalent):

  *bytes = MIN(*bytes, nb_bytes - offset_into_cluster)
  *bytes = MIN(*bytes, MIN(*bytes + offset_into_cluster, avail_bytes) -
           offset_into_cluster)
  *bytes = MIN(*bytes, MIN(*bytes, avail_bytes - offset_into_cluster))
  *bytes = MIN(*bytes, avail_bytes - offset_into_cluster)

And here's the value of .cow_end.offset set in calculate_l2_meta():

  cow_end_from = *bytes + offset_into_cluster
  cow_end_from = MIN(*bytes, avail_bytes - offset_into_cluster) + 
                 offset_into_cluster
  cow_end_from = MIN(*bytes + offset_into_cluster, avail_bytes)

This last definition of cow_end_from is the same as nb_bytes as used
before the patch.

Berto

