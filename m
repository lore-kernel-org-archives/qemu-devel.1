Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF442C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9975820866
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdEZJcau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9975820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdta-0003d9-Bx
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZds2-00026E-EP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZds0-0003EB-O9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:39:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZds0-0003Ds-J2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574786360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue3VSM447oTLJvJLFRzeekPSLoGpCecWKDU4t0Arijs=;
 b=IdEZJcauu4JOfOtcZ/9SLqo9nWupv3LXUdZ1Y85lImlO4Y8GprxyY3BFe9Awr/YpnTPpYK
 t+cG0qC2MnzxT8FBBHbb+qS6/X/wtWz18vvHENzQqGhWQ80JydcswlQMqBjuCR9qg2BtgU
 MmVRyKsW5mdU7V18Zj1Mj8ZGvvYB5Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-qboYB3dZPNWlcyFhvV71TA-1; Tue, 26 Nov 2019 11:39:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A011B18BCF;
 Tue, 26 Nov 2019 16:39:15 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F3047E46D;
 Tue, 26 Nov 2019 16:39:15 +0000 (UTC)
Subject: Re: [PATCH] block: Error out on image creation with conflicting size
 options
To: Kevin Wolf <kwolf@redhat.com>
References: <20191126154835.27915-1-kwolf@redhat.com>
 <cf113754-c582-03ae-9e53-ab0213c0ccf9@redhat.com>
 <2e913e12-4819-a729-2179-2b664601087a@redhat.com>
 <20191126162640.GC5889@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a42f2815-479c-e74a-3199-8a96c7a145f1@redhat.com>
Date: Tue, 26 Nov 2019 10:39:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126162640.GC5889@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qboYB3dZPNWlcyFhvV71TA-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 10:26 AM, Kevin Wolf wrote:

>> Actually, your patch fails to diagnose:
>>
>> $ qemu-img create -o size=1m,size=2m -f qcow2 x.qcow2
>> Formatting 'x.qcow2', fmt=qcow2 size=2097152 cluster_size=65536
>> lazy_refcounts=off refcount_bits=16
>>
>> so you may want to enhance this patch to also catch the case of -o size used
>> more than once.
> 
> Hm... Isn't this something that QemuOpts should already catch? Or do we
> have callers that actually expect the same option specified multiple
> times?

QemuOpts is horrible.  It allows duplication, and leaves it up to the 
client what to do about it.  Some clients use the duplication to collect 
multiple arguments (such as specifying more than one cpu), some callers 
treat duplication by honoring only the FIRST option specified (and 
ignoring later uses - I find this ugly), and yet other callers treat 
duplication by honoring only the LAST option specified.

> 
> Somehow I'm almost sure that Markus will know an example...

Probably of all three (ab)uses of QemuOpt duplication.

> 
> But anyway, I figure the same problem exists for almost all options.
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


