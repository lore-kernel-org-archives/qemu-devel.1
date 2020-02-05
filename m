Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD6C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BF620702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IocffIgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BF620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLet-0007cD-Lp
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izLdp-0006qe-Ny
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izLdo-0003Xr-79
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:26:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izLdo-0003W9-3Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVCuko74ikS6d6gAe+UeTS+zlvn2AjyzNUIvu9UQjmc=;
 b=IocffIgm0vPWlqszugfO6UrIKaBENtglKICzWA1dYEtxsUzBZ6Zy4Le1aIUtiPlDbLkKfV
 uoZ8NV69CzOyRoATpr8wBUPd/yKerE6V3N7P2Sh8Toea/FCc8lPW6q2+eHRlrZxURyppX1
 a/67j/AKoDQoHdrlntUrqLBMpI5CE9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-bKnevxXtPzOa0Oa3Rgb-Ww-1; Wed, 05 Feb 2020 09:26:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 448331882CE7;
 Wed,  5 Feb 2020 14:26:50 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA55E5C1B5;
 Wed,  5 Feb 2020 14:26:49 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8b650616-ff80-c430-5d4e-6c9311bec2f6@redhat.com>
Date: Wed, 5 Feb 2020 08:26:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bKnevxXtPzOa0Oa3Rgb-Ww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:25 AM, Vladimir Sementsov-Ogievskiy wrote:

>> 3. For qcow2
>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>> which is fully-unallocated. To understand that it is empty, we
>> need only to check all L1 entries. And for empty L1 table it is fast.
>> So we don't need any qcow2 format improvement to check it.
>>
> 
> Ah yes, I forget about preallocated case. Hmm. For preallocated clusters,
> we have zero bits in L2 entries. And with them, we even don't need
> preallocated to be filled by zeros, as we never read them (but just return
> zeros on read)..

Scanning all L2 entries is O(n), while an autoclear bit properly 
maintained is O(1).

> 
> Then, may be we want similar flag for L1 entry (this will enable large
> fast write-zero). And may be we want flag which marks the whole image
> as read-zero (it's your flag). So, now I think, my previous idea
> of "all allocated is zero" is worse. As for fully-preallocated images
> we are sure that all clusters are allocated, and it is more native to
> have flags similar to ZERO bit in L2 entry.

Right now, we don't have any L1 entry flags.  Adding one would require 
adding an incompatible feature flag (if older qemu would choke to see 
unexpected flags in an L1 entry), or at best an autoclear feature flag 
(if the autoclear bit gets cleared because an older qemu opened the 
image and couldn't maintain L1 entry flags correctly, then newer qemu 
knows it cannot trust those L1 entry flags).  But as soon as you are 
talking about adding a feature bit, then why add one that still requires 
O(n) traversal to check (true, the 'n' in an O(n) traversal of L1 tables 
is much smaller than the 'n' in an O(n) traversal of L2 tables), when 
you can instead just add an O(1) autoclear bit that maintains all_zero 
status for the image as a whole?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


