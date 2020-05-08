Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EFC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF12208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU/boOKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF12208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7cw-0002qq-Ez
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7cI-0002GO-3e
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:20:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7cG-0002J4-H1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588962055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZjBRf1/O61bt+E9xxVbeqwMOKgGv5nR+POyVufS8Ks=;
 b=VU/boOKUVTHUs64wDs99b6PyVpnmcVkUsgmNmnCBZ5WKk18j49hCUfxeMOZgkmjZ7tcIZb
 5J/XOFRZDVHJ3oL5dRzK5y5T71tADG99bmHSNMknnzA7IA0YmqgyseS7Jxd49tJ/zfoHw5
 u23GamMtR1g1vKqQtF7HxURKBGu7Pko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-47Fw4iUPO0KBcUIVMjH9yA-1; Fri, 08 May 2020 14:20:39 -0400
X-MC-Unique: 47Fw4iUPO0KBcUIVMjH9yA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AB18014C1;
 Fri,  8 May 2020 18:20:35 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C886B341FF;
 Fri,  8 May 2020 18:20:29 +0000 (UTC)
Subject: Re: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d102bdad-a6aa-2153-04e7-9338e4014740@redhat.com>
Date: Fri, 8 May 2020 13:20:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 6:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths.
> 
> Main motivation is realization of 64-bit write_zeroes operation for
> fast zeroing large disk chunks, up to the whole disk.
> 
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
> 
> So, prepare bdrv_co_do_pwrite_zeroes() now.
> 
> Patch-correctness audit by Eric Blake:
> 

> 
>      use of 'num' within the loop
>      compute 'int head' via % 'int alignment' - safe
>      clamp size by 'int max_write_zeroes' - safe
>      drv->bdrv_co_pwrite_zeroes(int) - safe because of clamping
>      clamp size by 'int max_transfer' - safe
>      qemu_iovec_init_buf(size_t) - safe because of clamping
>      bdrv_driver_pwritev(uint64_t) [well, int64_t after 4/17] - safe

I know you were quoting me, but the [comment] can be dropped (I wrote my 
audit on patches in isolation while reviewing the pre-series state of 
the tree, but when this commit is finally applied, the previous patch 
will already be in place)

> 
>      So even with the wider type, we aren't exceeding the contract of
>      anything we pass it on to.  Later patches may improve
>      drv->bdrv_co_pwrite_zeroes and qemu_iovec_init_buf to be 64-bit
>      clean, at which point we would want to revisit this function to use
>      64-bit clamping rather than 32-bit clamping, but it does not have
>      to happen here.
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


