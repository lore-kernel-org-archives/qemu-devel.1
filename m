Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEDC8300C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBE5206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgTwngU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBE5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQwL-0004IP-Qs
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQvH-0002d9-C0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQta-0002ZT-WD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQta-0002Z7-Iv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dWzpIFE/w8Bjg5V5yKk030wUo8PY9TZh0NLdEkfm18=;
 b=WgTwngU91YWX+2lMxUvi3Z/V1JINYr6sIMNoxT1ew4di/p1U6r6JRg1cABfjFwqLFJ5mxO
 jNRhrYrde8cWCKyYzuf325B3nekNWBvueOxU9qRdcps0OOdsWmy3yTsGjDHx3aEnp43ObV
 X8b/+hIs2yFYHQ5nExcCreHIF08QJYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-1DpqChjmMciXjTGZ7PRW0Q-1; Tue, 28 Apr 2020 10:07:31 -0400
X-MC-Unique: 1DpqChjmMciXjTGZ7PRW0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05B608064DF;
 Tue, 28 Apr 2020 14:07:31 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E704610AB;
 Tue, 28 Apr 2020 14:07:29 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
 <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
 <20200428140132.GF5789@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f9b2b26a-eacd-93db-f5c1-2682ae597e24@redhat.com>
Date: Tue, 28 Apr 2020 09:07:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428140132.GF5789@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 9:01 AM, Kevin Wolf wrote:

>> Can we please fix this to take a flags parameter?  I want to make it easier
>> for callers to request BDRV_REQ_NO_FALLBACK for distinguishing between
>> callers where the image must be made empty (read as all zeroes) regardless
>> of time spent, vs. made empty quickly (including if it is already all zero)
>> but where the caller is prepared for the operation to fail and will write
>> zeroes itself if fast bulk zeroing was not possible.
> 
> bdrv_make_empty() is not for making an image read as all zeroes, but to
> make it fully unallocated so that the backing file becomes visible.
> 
> Are you confusing it with bdrv_make_zero(), which is just a wrapper
> around bdrv_pwrite_zeroes() and does take flags?

Yes.  Although now I'm wondering if the two should remain separate or 
should just be a single driver callback where flags can include 
BDRV_REQ_ZERO_WRITE to distinguish whether exposing the backing file vs. 
reading as all zeroes is intended, or if that is merging too much.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


