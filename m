Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D946D206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqlFZLTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946D206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rRI-0003Yh-2T
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1rQa-00035K-29
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1rQY-0003ZB-6v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:47:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1rQX-0003YQ-Dk
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/VwUAgLn+spZs6ILlBGj1ShzI55w6iF8Y0rmIwao3c=;
 b=RqlFZLTC9uOstQD1IhDf1XY7g+nPeHs27/Uu/WrF8iapLnd/M0YVSs+6aBn9wsAhmimF22
 sfiAJphjXMIpQKnhxeXm1n42tU91S3JUU1YBG9/GgZxITr0bDlbUQk5SquzaNst81C9ojY
 gVX9WRfjiF2SWmnvQhwMoQqrEimTKP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-cy-EjXs4OL6K0Ll4ho03-Q-1; Wed, 12 Feb 2020 07:47:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9AEA0CBF;
 Wed, 12 Feb 2020 12:47:28 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19CD25C1BB;
 Wed, 12 Feb 2020 12:47:24 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210221234.GH3888@redhat.com>
 <cc6e1e2e-d3a9-c498-354b-d382b5623ca0@redhat.com>
 <20200210225255.GJ3888@redhat.com> <20200212072729.GA22254@grep.be>
 <278d29cd-bc0d-19f0-c2a4-0191d16a677f@redhat.com>
 <20200212123637.GX3888@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bdb320e8-edb1-9117-2044-500b395d2c11@redhat.com>
Date: Wed, 12 Feb 2020 06:47:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212123637.GX3888@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cy-EjXs4OL6K0Ll4ho03-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Wouter Verhelst <w@uter.be>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 6:36 AM, Richard W.M. Jones wrote:

>> Okay, in v2, I will start with just two bits, NBD_INIT_SPARSE
>> (entire image is sparse, nothing is allocated) and NBD_INIT_ZERO
>> (entire image reads as zero), and save any future bits for later
>> additions.  Do we think that 16 bits is sufficient for the amount of
>> initial information likely to be exposed?
> 
> So as I understand the proposal, the 16 bit limit comes about because
> we want a round 4 byte reply, 16 bits are used by NBD_INFO_INIT_STATE
> and that leaves 16 bits feature bits.  Therefore the only way to go
> from there is to have 32 feature bits but an awkward unaligned 6 byte
> structure, or 48 feature bits (8 byte structure).

In general, the NBD protocol has NOT focused on alignment issues (for 
good or for bad).  For example, NBD_INFO_BLOCK_SIZE is 18 bytes; all 
NBD_CMD_* 32-bit requests are 28 bytes except for NBD_CMD_WRITE which 
can send unaligned payload with no further padding, and so forth.

> 
> I guess given those constraints we can stick with 16 feature bits, and
> if we ever needed more then we'd have to introduce NBD_INFO_INIT_STATE2.
> 
> The only thing I can think of which might be useful is a "fully
> preallocated" bit which might be used as an indication that writes are
> fast and are unlikely to fail with ENOSPC.

and which would be mutually-exclusive with NBD_INFO_SPARSE (except for 
an image of size 0).  That bit would ALSO be an indication that the user 
may not want to punch holes into the image, but preserve the 
fully-allocated state (and thus avoid NBD_CMD_TRIM as well as passing 
NBD_CMD_FLAG_NO_HOLE to any WRITE_ZEROES request).

> 
>> Are we in agreement that
>> my addition of an NBD_INFO_ response to NBD_OPT_GO is the best way
>> to expose initial state bits?
> 
> Seems reasonable to me.
> 
> Rich.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


