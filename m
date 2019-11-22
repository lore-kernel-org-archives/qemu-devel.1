Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D416C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684902071C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLY3EVJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684902071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYC3p-00043y-FS
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iYBzo-0002Bs-8M
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iYBzm-0000gP-JW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:41:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iYBzm-0000gD-GG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574440882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liVD6sDjUk+e5LedLW+Y8/uYozgIvLmpV+Kni3aGZMg=;
 b=WLY3EVJmFfAPpeH2OSGaswKLKM1fH4+caLYKSOCjZfnws3z3efrI6TLAlBIUWUAy0Tra+s
 wlhZnEWRVXuvB0otiFArBQpGxj8VjhetBErIzKR+sO17+o7i/j9OyGK0aamiIkEkUrwwAM
 72zaxwjvIgEq3RTxL6D+lu23rbi5SZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-0-19wFRkO0yip1ZIp4aL1w-1; Fri, 22 Nov 2019 11:41:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58BC1107ACCD;
 Fri, 22 Nov 2019 16:41:17 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B534177009;
 Fri, 22 Nov 2019 16:41:13 +0000 (UTC)
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <CAFEAcA_JU9GfNYDuD2K0MKmAD7GZ7vBUHsXU+WS-6mvPCvf8ig@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <713adac7-b997-6723-6b07-f527d0b804ac@redhat.com>
Date: Fri, 22 Nov 2019 10:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JU9GfNYDuD2K0MKmAD7GZ7vBUHsXU+WS-6mvPCvf8ig@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0-19wFRkO0yip1ZIp4aL1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 10:17 AM, Peter Maydell wrote:
> On Fri, 22 Nov 2019 at 16:08, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> See patch 4 for the description of the bug fixed.
> 
> I guess my questions for trying to answer the "for-4.2?"
> question in the subject are:
>   1) is this a security (leaking data into the guest) bug ?
>   2) is this a regression?
>   3) is this something a lot of people are likely to run into?

My thoughts (although Kevin's may be more definitive):

1) yes, there is a security aspect: certain resize or commit actions can 
result in the guest seeing a revival of stale data that the guest may 
have thought that it previously scrubbed.  Similarly, the tail end of 
the series proves via iotests that we have an actual case of data 
corruption after a block commit without this patch

2) no, this is a long-standing bug, we've only recently noticed it

3) no, it is uncommon to have an overlay with a size shorter than its 
backing file (it's not even all that common to have an overlay longer 
than the backing file), so this is a corner case not many people will 
hit.  It's even less common to have the difference in overlay sizes also 
coincide with formats that introduce the speed penalty of a longer 
blocking due to the added zeroing.

> 
> Eyeballing of the diffstat plus the fact we're on v4 of
> the patchset already makes me a little uneasy about
> putting it into rc3, but if the bug we're fixing matters
> enough we can do it.

In terms of diffstat, the v3 series was much smaller in impact.  Both 
versions add robustness, where the difference between v3 and v4 is 
whether we introduce a speed penalty on an unlikely setup (v3) or reject 
any operation where it would require a speed penalty to avoid data 
problems (v4).  I think all the patches in v3 were reviewed, but I'll go 
ahead and review v4 as well.

Because of point 1, I am leaning towards some version of this patch 
series (whether 3 or 4) making -rc3; but point 2 (it is not a 4.2 
regression) also seems to be a reasonable justification for slipping 
this to 5.0.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


