Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9733420578
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbN/Zx6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9733420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Wk-0000gl-UT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19Pl-0006ez-VC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:20:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19Pi-0005bA-Td
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+VimS9LqF5IxW0BnvNLwag4qkt0Zv5i66LhsFaP3tw=;
 b=bbN/Zx6YkWvYjPCVDpb/IMKa6iNm4n1I+A6i+jgGqtx7BpwzGrvtrnah9tf8VgmwcGGezs
 wAnmUMTLzSdJv8zUUvTh/eu1opSpSFdqiEwi6WKqUurhzJBKhWopFgwrs3YGICFVhEcfPa
 9iTqdJWdwC72KJaly7cysFd1A8DGfJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-5Ly6-oqWODu27J0up0f8mg-1; Thu, 30 Jul 2020 10:20:00 -0400
X-MC-Unique: 5Ly6-oqWODu27J0up0f8mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E83800597;
 Thu, 30 Jul 2020 14:19:59 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 117285DA7A;
 Thu, 30 Jul 2020 14:19:59 +0000 (UTC)
Subject: Re: [PATCH 0/2] qcow2: Release read-only bitmaps when inactivated
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200730120234.49288-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c6a84a92-d2f2-cdfb-154d-470dbb24ed8e@redhat.com>
Date: Thu, 30 Jul 2020 09:19:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730120234.49288-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 7:02 AM, Max Reitz wrote:
> Hi,
> 
> When beginning migration, the qcow2 driver syncs all persistent bitmaps
> to disk and then releases them.  If the user decides to continue on the
> source after migration, those bitmaps are re-loaded from the qcow2
> image.
> 
> However, we only do this for bitmaps that were actively synced, i.e. R/W
> bitmaps.  RO bitmaps (those on backing images) are not written and thus
> not released.  However, we still try to re-load them when continuing,
> and that will then fail.
> 
> To fix this problem, I think we should just consider RO bitmaps to be in
> sync from the beginning, so we can release them just like bitmaps that
> we have actively written back to the image.  This is done by patch 1.
> 
> However, there’s a catch: Peter Krempa noted that it isn’t in libvirt’s
> interest for the bitmaps to be released before migration at all, because
> this makes them disappear from query-named-block-node’s dirty-bitmaps
> list, but libvirt needs the bitmaps to be there:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1858739#c3

And that is enough to make me think this series is -rc3 material. 
Although I'm not yet sure whether the solution is this series as 
written, or to patch libvirt to look elsewhere for bitmap information, 
or to patch qemu on incoming migration to not complain when reloading a 
RO bitmap, or something else.

> 
> If it’s really not feasible to keep the bitmaps around, then I suppose
> what might work for libvirt is to query
> image/format-specific/data/bitmaps in addition to dirty-bitmaps (every
> bitmap that we released before migration must be a persistent bitmap).
> 
> What are your thoughts on this?

I'd really like to hear from Virtuozzo on the topic before committing to 
this series, but I will at least review it in the meantime.

> 
> 
> Max Reitz (2):
>    qcow2: Release read-only bitmaps when inactivated
>    iotests/169: Test source cont with backing bmap
> 
>   block/qcow2-bitmap.c       | 23 +++++++++++---
>   tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++-
>   tests/qemu-iotests/169.out |  4 +--
>   3 files changed, 84 insertions(+), 7 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


