Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2FC83009
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89826206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+JlJ+vI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89826206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRFc-0004om-JD
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTREP-000337-Ln
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTRBA-0003XQ-G2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:29:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTRB9-0003X5-TM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588083942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sXYdwn3zxNdlMN3DkYHwlX93bwWqrgCPpWXcqDBqRM=;
 b=F+JlJ+vIX9BIBdsJk94HEgj5B7YTHH1VIN07XwNdPUAWbDspZDoCKMSABZSfxrDbxvYYBE
 V0pN/G2r/3bO4Y/1V9KIFcU8VHBOG+uVb5GmxANhJCwbgU/dMfNoG9RMPtmXvBXmtS6p/p
 5xru7MVqD9QMT+wHTIwQOD6WmTnA0R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-HOctJouIORu50O0_RkzVJw-1; Tue, 28 Apr 2020 10:25:38 -0400
X-MC-Unique: HOctJouIORu50O0_RkzVJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41FE610B2EC3;
 Tue, 28 Apr 2020 14:25:23 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67B9B60D3D;
 Tue, 28 Apr 2020 14:25:22 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
 <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
 <20200428140132.GF5789@linux.fritz.box>
 <f9b2b26a-eacd-93db-f5c1-2682ae597e24@redhat.com>
 <20200428141641.GH5789@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2c52cdc0-ba9b-081e-b593-fd3cf49dca12@redhat.com>
Date: Tue, 28 Apr 2020 09:25:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428141641.GH5789@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 9:16 AM, Kevin Wolf wrote:

>>
>> Yes.  Although now I'm wondering if the two should remain separate or should
>> just be a single driver callback where flags can include BDRV_REQ_ZERO_WRITE
>> to distinguish whether exposing the backing file vs. reading as all zeroes
>> is intended, or if that is merging too much.
> 
> I don't think the implementations for both things are too similar, so
> you might just end up having two if branches and then two separate
> implementations in the block drivers.
> 

Yeah, the more I think about it, the more two callbacks still make 
sense.  .bdrv_make_empty may or may not need a flag, but .bdrv_make_zero 
definitely does (because that's where we want a difference between 
making the entire image zero no matter the delay, vs. only making it all 
zero if it is is fast).

> If anything, bdrv_make_empty() is more related to discard than
> write_zeroes. But we use the discard code for it in qcow2 only as a
> fallback because in the most common cases, making an image completely
> empty means effectively just creating an entirely new L1 and refcount
> table, which is much faster than individually discarding all clusters.
> 
> For bdrv_make_zero() I don't see an opportunity for such optimisations,
> so I don't really see a reason to have a separate callback. Unless you
> do know one?

The optimization I have in mind is adding a qcow2 autoclear bit to track 
when an image is known to read as all zero - at which point 
.bdrv_make_zero instantly returns success.  For raw files, a possible 
optimization is to truncate to size 0 and then back to the full size, 
when it is known that truncation forces read-as-zero.  For NBD, I'm 
still playing with whether adding new 64-bit transactions for a bulk 
zero will be useful, and even if not, maybe special-casing 
NBD_CMD_WRITE_ZEROES with a size of 0 to do a bulk zero, if both server 
and client negotiated that particular meaning.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


