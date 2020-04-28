Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403AC83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123AF206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcKh5tF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123AF206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTR0P-0002kM-5B
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQwL-0004kX-07
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQwJ-0003mG-VU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:10:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQjg-0004u4-4F
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGdWuQrx9wBpz+IGPa//brI6NrK/N1J1Jizx/S6Di6Y=;
 b=OcKh5tF2+bbfxsUvebWaAKomBs2W/Ayhciul9Y38d2BVDi+XdFb5iRd/jaiRFWgPRZoajW
 vOgAd+A/R0u4zOUHwDDIRHctnKcpXDRAhA6RNzPDpT2kkCutoUiVfoQ/SejVVNqpMzMPm7
 SAdX4P8dRVCFhK03787G4KMkJPnCba8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-bHVlgmvLPPqOxf84fRpAJw-1; Tue, 28 Apr 2020 09:57:14 -0400
X-MC-Unique: bHVlgmvLPPqOxf84fRpAJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AADFC100CCC0;
 Tue, 28 Apr 2020 13:57:13 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0D9C60D3D;
 Tue, 28 Apr 2020 13:57:12 +0000 (UTC)
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
To: qemu-devel@nongnu.org, no-reply@patchew.org, mreitz@redhat.com
References: <158808140424.30407.602092042167419410@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b02db23f-b02f-a820-556c-1552f49b04b5@redhat.com>
Date: Tue, 28 Apr 2020 08:57:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158808140424.30407.602092042167419410@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:43 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200428132629.796753-1-mreitz@redhat.com/
> 
> 

>    SIGN    pc-bios/optionrom/pvh.bin
> /tmp/qemu-test/src/qemu-img.c: In function 'img_commit':
> /tmp/qemu-test/src/qemu-img.c:1071:9: error: implicit declaration of function 'blk_new_with_bs' [-Werror=implicit-function-declaration]
>           old_backing_blk = blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM_ALL,

Ah, you forgot to tell patchew:

Based-on: <20200424190903.522087-1-eblake@redhat.com>
[PATCH v3 0/3] qcow2: Allow resize of images with internal snapshots

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


