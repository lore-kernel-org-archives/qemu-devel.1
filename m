Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CAEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EB120738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA5754eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EB120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnR0L-0007Hk-E3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnQzK-0006UM-Sk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:16:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnQzI-0005Vi-Fb
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592849767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhc6lL4IS/i3EyXZIwaBTeAwdg/N6iGa7qhD3hnjDd8=;
 b=dA5754eYejFtbywsk5i9Pw043veRr4xVyTwUrN7OGbPwOTlg94DPNNHXORoPUyXjwCV6Q1
 tOQXerCkPN5BphpGJ4tmwZpkfMZrivAaWnO3M9W5v+j3uanNv0E/EUIicNNygZv25SRLs+
 rGVkuD8XZVsLCo15ZnBfKJXez64y3rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-Y8JnATNWNauac3ZcmZkYog-1; Mon, 22 Jun 2020 14:15:59 -0400
X-MC-Unique: Y8JnATNWNauac3ZcmZkYog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7186F8005AD;
 Mon, 22 Jun 2020 18:15:58 +0000 (UTC)
Received: from [10.3.114.4] (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5C7171677;
 Mon, 22 Jun 2020 18:15:57 +0000 (UTC)
Subject: Re: [PATCH] qemu-img convert: Don't pre-zero images
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200622151203.35624-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aed53e4a-dfae-fcca-3aa3-504835ed1ea2@redhat.com>
Date: Mon, 22 Jun 2020 13:15:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622151203.35624-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: nsoffer@redhat.com, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 10:12 AM, Kevin Wolf wrote:
> Since commit 5a37b60a61c, qemu-img create will pre-zero the target image
> if it isn't already zero-initialised (most importantly, for host block
> devices, but also iscsi etc.), so that writing explicit zeros wouldn't
> be necessary later.
> 
> This could speed up the operation significantly, in particular when the
> source image file was only sparsely populated. However, it also means
> that some block are written twice: Once when pre-zeroing them, and then
> when they are overwritten with actual data. On a full image, the
> pre-zeroing is wasted work because everything will be overwritten.
> 
> In practice, write_zeroes typically turns out faster than writing
> explicit zero buffers, but slow enough that first zeroing everything and
> then overwriting parts can be a significant net loss.
> 
> Meanwhile, qemu-img convert was rewritten in 690c7301600 and zero blocks
> are now written to the target using bdrv_co_pwrite_zeroes() if the
> target could be pre-zeroed. This way we already make use of the faster
> write_zeroes operation, but avoid writing any blocks twice.
> 
> Remove the pre-zeroing because these days this former optimisation has
> actually turned into a pessimisation in the common case.

Indeed, it is both data-dependent (how sparse is the source) and 
target-dependent (does the reduced I/O from a single pre-zeroing pass 
outweigh the time spent on non-zero portions).  I'm fine with dropping 
this optimization, as we do not have proper heuristics to reliably 
detect when it is actually going to be a win.  (It would be nice if we 
_could_ have reliable heuristics, but that's a story for another day)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


