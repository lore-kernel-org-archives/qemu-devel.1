Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CFC2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F3B24648
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlaV72So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F3B24648
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icu7t-0004Gw-SO
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icu6m-0003Jr-FF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icu6k-0007Ny-Fg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:36:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icu6k-0007K9-7L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575563761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPugjQC///p0WaF1oB51BWp4AagreqleCL+IitzXn34=;
 b=ZlaV72So9Rs3XmJhhZmgxkKGkraK1njsojDWuyuBmEVXiSOnKJnAzLJDAugkh5gOnmA/EL
 Vy1JlcQP9mwDqVlW+iICHSsulPDWR57JCRMOiigyG7v2xsP2+tHNz3ZViYUGFSVgVQ3X4d
 JGtOA8Wp+G/e2EmiAEoqLBPrl7F+NM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-AdzpPovAPUSH9A1lqVJ_EA-1; Thu, 05 Dec 2019 11:35:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4FAB189F5F3;
 Thu,  5 Dec 2019 16:35:58 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC41E600D1;
 Thu,  5 Dec 2019 16:35:55 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: fix info --backing-chain --image-opts
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191205134646.445427-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b4b24003-4327-2bbf-dbc8-cd911d730043@redhat.com>
Date: Thu, 5 Dec 2019 10:35:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205134646.445427-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AdzpPovAPUSH9A1lqVJ_EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 12/5/19 7:46 AM, Stefan Hajnoczi wrote:
> Only apply --image-opts to the topmost image when listing an entire
> backing chain.  It is incorrect to treat backing filenames as image
> options.  Assuming we have the backing chain t.IMGFMT.base <-
> t.IMGFMT.mid <- t.IMGFMT, qemu-img info fails as follows:
> 
>    $ qemu-img info --backing-chain --image-opts \
>        driver=qcow2,file.driver=file,file.filename=t.IMGFMT
>    qemu-img: Could not open 'TEST_DIR/t.IMGFMT.mid': Cannot find device=TEST_DIR/t.IMGFMT.mid nor node_name=TEST_DIR/t.IMGFMT.mid

Cute failure.  Yes, the fix seems right.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   qemu-img.c                 |  3 ++
>   tests/qemu-iotests/279     | 56 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/279.out | 35 ++++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   4 files changed, 95 insertions(+)
>   create mode 100755 tests/qemu-iotests/279
>   create mode 100644 tests/qemu-iotests/279.out

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


