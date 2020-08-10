Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E6EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572102070B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHts4wyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572102070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k58fk-0001uN-Ei
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k58f1-0001LB-GE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k58ey-00072B-DS
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 10:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597069218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oE/+WGvOhunvUgqJClrW4xATLmF1g/Wvot2LvgE164U=;
 b=VHts4wyQSD7qzYVtxa17FRz6ISEYjJdrRzp2oPeDUFzrXYgFj3R0DC4642VaGukWATIZH5
 91wn0k9w+LMqmH95MMdqbmgkzjGoUXp5fliWB6pgU9hdOVbheddtVV0oGcORSlGCFpq3tx
 Lbp7g1dbDDq8Bl60RYVubWE+oAMDNGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-u4H1aEowO8-qABvdIDZTdw-1; Mon, 10 Aug 2020 10:20:12 -0400
X-MC-Unique: u4H1aEowO8-qABvdIDZTdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0955E100AA24;
 Mon, 10 Aug 2020 14:20:11 +0000 (UTC)
Received: from [10.3.112.157] (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A98819C71;
 Mon, 10 Aug 2020 14:20:10 +0000 (UTC)
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200810123555.30481-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d01f2684-e17e-c1b9-1e43-3b6ff57ddf10@redhat.com>
Date: Mon, 10 Aug 2020 09:20:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810123555.30481-1-den@openvz.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:35:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 7:35 AM, Denis V. Lunev wrote:
> The problem this patch is trying to address is libguestfs behavior on the
> appliance startup. It starts supporting to use root=UUID definition in
> the kernel command line of its root filesystem using
>      file --  /usr/lib64/guestfs/appliance/root
> This works fine with RAW image, but we are using QCOW2 as a storage to
> save a bit of file space and in this case we get
>      QEMU QCOW Image (v3), 1610612736 bytes
> instead of UUID of the root filesystem.
> 
> The solution is very simple - we should dump first 256k of the image file
> like the follows
>      qemu-io -c "read -V 0 256k" appliance | file -
> which will provide correct result for all possible types of the appliance
> storage.

Is 'appliance' a qcow2 file?  If so, another way to accomplish this 
could include:

nbdkit streaming --run 'qemu-img convert --image-opts 
driver=raw,size=256,file.driver=qcow2,file.file.driver=file,file.file.filename=appliance 
"$uri"' | file -

which says to use qemu-img to open a length-limited view of the file, 
and stream the entire thing to an NBD server, where nbdkit then provides 
a way to convert that to a pipeline to feed into file (since qemu's NBD 
server doesn't directly like writing into a pipe).

I'm also wondering if the 'nbdcopy' program (not yet released in a 
stable version, but available in libnbd.git) could be put to use on this 
front, with some way to quickly combine it with qemu-nbd serving 
appliance.qcow2.

> 
> Unfortunately, additional option for qemu-io is the only and the simplest
> solution as '-v' creates very specific output, which requires to be
> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
> much more intrusive.

'qemu-img dd' _should_ be merely syntactic sugar for 'qemu-img convert', 
but it isn't yet.  Until we rectify that feature parity (there are 
things that dd can't do like better output control and skipping, and 
there are things that convert can't do like length limiting and offset 
selection), hacking up 'qemu-io' (which is for debugging use only) is a 
tolerable short-term solution; but qemu-io was NEVER intended for stable 
use cases.  If adding this makes debugging qemu easier, then go for it; 
but if the real problem is that qemu-img is missing functionality, we 
should instead be focusing on fixing qemu-img.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


