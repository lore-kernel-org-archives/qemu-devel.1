Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269FFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E425D20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I45g5i2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E425D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWGp-0004lQ-0o
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izWEk-0003Rd-Hn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izWEi-0002Zy-FI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:45:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izWEi-0002Tr-55
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580953542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Uqz30hoaa5iJuXtZDEdpoq+vfR+s2EyhrOC6OyBeqA=;
 b=I45g5i2zzRpkOq+yBLfMfZKnsnhmtb5ygNdevpO4LdL4cThsrG4Z9n/M0pdjhPQkxe9ZUq
 oIukbmDXPO5Ft8weXTaGeoh9zq7AO/XC/FpLasLF91yWa2sfFzz3Gcvp7lTjiOaCKBsROb
 FPK3K7UBAn+E0l6UrOd3i5+1zNy5Q2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-7yfkDo-zOHuxRIUruct2xw-1; Wed, 05 Feb 2020 20:45:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D8D8018C8;
 Thu,  6 Feb 2020 01:45:37 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D449186C4A;
 Thu,  6 Feb 2020 01:45:36 +0000 (UTC)
Subject: Re: [PATCH v4 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200205110248.2009589-1-david.edmondson@oracle.com>
 <20200205110248.2009589-2-david.edmondson@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <973eb8bc-fafa-a31f-e4b4-eb4e8ee868f0@redhat.com>
Date: Wed, 5 Feb 2020 19:45:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205110248.2009589-2-david.edmondson@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7yfkDo-zOHuxRIUruct2xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:02 AM, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (reads as zero). In this situation
> there is no requirement for qemu-img to wastefully zero out the entire
> device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device will return zeros for all reads.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   docs/interop/qemu-img.rst |  9 ++++++++-
>   qemu-img-cmds.hx          |  4 ++--
>   qemu-img.c                | 26 +++++++++++++++++++++++---
>   3 files changed, 33 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


