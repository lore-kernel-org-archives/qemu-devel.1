Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D920EC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47CC2073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE9zRoLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CC2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVqN-0006pX-Sv
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icVpf-0006NP-MG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icVpe-0005ue-BR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:40:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icVpe-0005uS-7O
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575470445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvtTJYrbjbwO91U395O3sgiN6iIm3SEg9gxK4+ReG3A=;
 b=IE9zRoLU5yIkYuLerUAtVoDftIW5+61hEze88XurSZJM/2RiA5fBCbvrU1H3Ca+Ah5LzBB
 Pt2Ix03ioEH62JQwtxxRFocOdA4YySmZlKx8xbOEBIYcacrSJb0HlnyEeQ2eR76solNJl4
 e9FbJzv9+5qGcKBxF08dC+p8RNxOVkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-Banfa7MYMnWOPpswzxXcAQ-1; Wed, 04 Dec 2019 09:40:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3C35100EC2F;
 Wed,  4 Dec 2019 14:40:40 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E41AF5D6C5;
 Wed,  4 Dec 2019 14:40:36 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
To: pannengyuan@huawei.com, mst@redhat.com
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <40c11e5e-60a0-9407-4ebe-52d23d70ea85@redhat.com>
Date: Wed, 4 Dec 2019 08:40:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Banfa7MYMnWOPpswzxXcAQ-1
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 1:31 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Devices tend to maintain vq pointers, allow deleting them trough a vq pointer.

through

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---

Also, don't forget to send a 0/3 cover letter (any series longer than 
one patch should have a cover letter; it is possible to configure git to 
do this automatically: https://wiki.qemu.org/Contribute/SubmitAPatch has 
this tip and others)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


