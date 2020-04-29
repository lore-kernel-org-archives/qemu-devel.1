Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F1C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FD92073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB5xMltB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FD92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTo5G-0008HV-5W
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTo3t-0006YA-Pz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTo3t-0004Pw-9Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:51:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTo3s-0004Pg-QS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588171903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wodWAGD6WGAUCYF3RDzIA+/6y76z8W08pN26qZ27+VE=;
 b=eB5xMltB32+N6Cc5aEa8yix4lfJ+fsmYHNjc5byHE3lR/54ua/aZB0Om0bDGFpG57Zral4
 KH3Uce5nzKXbSUNQtfMMPnQZsK4sjJtJHJZ+TaIhQeLibYSiA0OYFemA3g3sqhsEIFvcbl
 BsgkppPsF92MDfzdTEDZBxkkaHfUPYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-kyRkLoiQNeeIk9W1VUUTbg-1; Wed, 29 Apr 2020 10:51:39 -0400
X-MC-Unique: kyRkLoiQNeeIk9W1VUUTbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAC601B18BC1;
 Wed, 29 Apr 2020 14:51:38 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A6360BF4;
 Wed, 29 Apr 2020 14:51:37 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] block: Add bdrv_make_empty()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429141126.85159-1-mreitz@redhat.com>
 <20200429141126.85159-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <138748c4-3316-ec43-00dd-22b02dac5d7c@redhat.com>
Date: Wed, 29 Apr 2020 09:51:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429141126.85159-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 9:11 AM, Max Reitz wrote:
> Right now, all users of bdrv_make_empty() call the BlockDriver method
> directly.  That is not only bad style, it is also wrong, unless the
> caller has a BdrvChild with a WRITE or WRITE_UNCHANGED permission.
> (WRITE_UNCHANGED suffices, because callers generally use this function
> to clear a node with a backing file after a commit operation.)
> 
> Introduce bdrv_make_empty() that verifies that it does.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h |  1 +
>   block.c               | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


