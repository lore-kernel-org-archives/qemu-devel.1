Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B6C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D29F206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdQaFi9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D29F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS4f-0007pC-E8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1isS2s-00062h-Ph
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1isS2p-0007Fk-8l
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1isS2p-0007FX-5Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ae+SmDyVjjRBGgP/TBU/WKw6gnHTbVZqJVBli1380dM=;
 b=TdQaFi9D58O9tfxbZbZfZOpv2oKwFvXiGFLnkdvOVqatNIxRqcInFnFRS2ZnKjXfb1f9bE
 eToEbr1ShgdBBx/qiszgmAPhTpWq5AVVnYUr65SPGME8izm1vSEnUrOpElCtOOBDLh2OWo
 5Qb4fyCvD/lZlU9YIw8OoUYsg9BZo78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-JBw-Jc2ONWuyxTP28N6QUg-1; Fri, 17 Jan 2020 08:52:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66FAB100550E;
 Fri, 17 Jan 2020 13:52:10 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F22460F82;
 Fri, 17 Jan 2020 13:52:09 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: Fix VM size field width in snapshot dump
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200117105859.241818-1-mreitz@redhat.com>
 <20200117105859.241818-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0383e525-aec6-d75d-1780-2811df90a878@redhat.com>
Date: Fri, 17 Jan 2020 07:52:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117105859.241818-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JBw-Jc2ONWuyxTP28N6QUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 4:58 AM, Max Reitz wrote:
> When printing the snapshot list (e.g. with qemu-img snapshot -l), the VM
> size field is only seven characters wide.  As of de38b5005e9, this is
> not necessarily sufficient: We generally print three digits, and this
> may require a decimal point.  Also, the unit field grew from something
> as plain as "M" to " MiB".  This means that number and unit may take up
> eight characters in total; but we also want spaces in front.
> 
> Considering previously the maximum width was four characters and the
> field width was chosen to be three characters wider, let us adjust the
> field width to be eleven now.
> 
> Fixes: de38b5005e946aa3714963ea4c501e279e7d3666

My patch - hmm, yet another example of an "obvious bugfix" having 
non-obvious consequences :)

> Buglink: https://bugs.launchpad.net/qemu/+bug/1859989
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qapi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


