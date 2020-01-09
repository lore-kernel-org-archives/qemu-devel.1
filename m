Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE74C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 03:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CBF205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 03:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rv44L5i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CBF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipO4q-0008Lr-GX
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 22:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ipO3s-0007pb-0F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 22:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ipO3m-0004Jv-PP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 22:00:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ipO3m-0004G2-1V
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 22:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578538833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O01+Udo52H5L/qd/P/ro+XqbXcxDKpi9kRJxPDt4YTg=;
 b=Rv44L5i5HZn4V9kbRVDeQ4XTszyJIwxZykiyQ6xoTzD96UnPyGOFMqS/pp1tAB4KHpvlj4
 UzABBBvmjtzIwmRSN5Z7BFeywWYAKRs2fnC589Gd7uk6wN+tSbXFt8D3Yn+4Ay8J6jSATl
 vZOWVfEeI29q41taFxQ2r7OirpMoGOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-81_wnmO8Oa6oAFEyZDL6bg-1; Wed, 08 Jan 2020 22:00:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0D92107ACC5
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 03:00:30 +0000 (UTC)
Received: from [10.72.12.226] (ovpn-12-226.pek2.redhat.com [10.72.12.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A83F5DA60;
 Thu,  9 Jan 2020 03:00:26 +0000 (UTC)
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com
References: <20200108135353.75471-1-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
Date: Thu, 9 Jan 2020 11:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200108135353.75471-1-dgilbert@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 81_wnmO8Oa6oAFEyZDL6bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/1/8 =E4=B8=8B=E5=8D=889:53, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hyperv's synic (that we emulate) is a feature that allows the guest
> to place some magic (4k) pages of RAM anywhere it likes in GPA.
> This confuses vhost's RAM section merging when these pages
> land over the top of hugepages.


Hi David:

A silly question, is this because the alignment when adding sections? If=20
yes, what's the reason for doing alignment which is not a must for vhost=20
memory table.

Thanks


>
> Since they're not normal RAM, and they shouldn't have vhost DMAing
> into them, exclude them from the vhost set.
>
> I do that by marking them as device-ram and then excluding device-ram
> from vhost.
>
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041
>
> Dr. David Alan Gilbert (2):
>    vhost: Don't pass ram device sections
>    hyperv/synic: Allocate as ram_device
>
>   hw/hyperv/hyperv.c | 14 ++++++++------
>   hw/virtio/vhost.c  |  1 +
>   2 files changed, 9 insertions(+), 6 deletions(-)
>


