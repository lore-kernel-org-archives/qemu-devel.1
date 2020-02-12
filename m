Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3112C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1DF20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8w3mv80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1DF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sq7-0000Mq-Sl
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1spS-00086m-71
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1spR-0001MT-56
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:17:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41307
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1spR-0001Lz-1J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581517044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/iUy82X5r7HbCjMmblb7acra4wJrxhekZ1y07ZlhZ4=;
 b=F8w3mv80/ITyvmm4PB4wVuw0hsAB2xu9Pq4BtIeenibwxHQznyB7BcaW9z1zFOc8jqlcOT
 hkpKvBlS6q8Nt5FuKAKlYOOw+aNJkJ1E9geCTYN1G+R2hMCvMXByaUQrR8Ht2d/A4CwqsJ
 QWCPwxPWlj8oRxyFKTvordBssh1161E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-wzyQgIo5O2SmRLx8TCH6gQ-1; Wed, 12 Feb 2020 09:17:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA7B107ACC7;
 Wed, 12 Feb 2020 14:17:19 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2480489E6F;
 Wed, 12 Feb 2020 14:17:14 +0000 (UTC)
Subject: Re: [PATCH v2 13/16] qmp/hmp: Expose "managed-size" for memory
 backends
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200212133601.10555-1-david@redhat.com>
 <20200212133601.10555-14-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7558ab36-9d4f-9251-6c9d-a79167c2b74d@redhat.com>
Date: Wed, 12 Feb 2020 08:17:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212133601.10555-14-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wzyQgIo5O2SmRLx8TCH6gQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 7:35 AM, David Hildenbrand wrote:
> Expose it, and document what it means and when it was added.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/core/machine-hmp-cmds.c | 2 ++
>   hw/core/machine-qmp-cmds.c | 3 +++
>   qapi/machine.json          | 6 ++++++
>   3 files changed, 11 insertions(+)

> +++ b/qapi/machine.json
> @@ -758,6 +758,9 @@
>   #
>   # @prealloc: enables or disables memory preallocation
>   #
> +# @managed-size: the owner manages the actual size, 'size' is an upper limit
> +#                (since 5.1)
> +#

There's still time to get this in 5.0, if the series is accepted before 
soft freeze.

>   # @host-nodes: host nodes for its memory policy
>   #
>   # @policy: memory policy of memory backend
> @@ -771,6 +774,7 @@
>       'merge':      'bool',
>       'dump':       'bool',
>       'prealloc':   'bool',
> +    'managed-size': 'bool',
>       'host-nodes': ['uint16'],
>       'policy':     'HostMemPolicy' }}
>   
> @@ -793,6 +797,7 @@
>   #          "merge": false,
>   #          "dump": true,
>   #          "prealloc": false,
> +#          "manmaged-size": false,

typo, managed-size

>   #          "host-nodes": [0, 1],
>   #          "policy": "bind"
>   #        },
> @@ -801,6 +806,7 @@
>   #          "merge": false,
>   #          "dump": true,
>   #          "prealloc": true,
> +#          "manmaged-size": false,

and again

>   #          "host-nodes": [2, 3],
>   #          "policy": "preferred"
>   #        }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


