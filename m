Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A34C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C3C206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5zM1l7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C3C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXlB-00046A-UI
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXkG-0003FW-2X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:50:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXkA-0000nL-Oh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:49:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQXkA-0000kD-8p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587394192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgvWZNf7X5BRDM+H43vuSiUPxGULY2v4mEkpg5soidw=;
 b=M5zM1l7++djI5cAbMgexaSKdPgicxTbFdelzzdK9p+b0Z92DwmQOdGa5LmmfLBDNn2KzyE
 cgv++1qg8JqqbhW8wq8F/pkIsujY+DvLhyGF6RPaywHIQb9g+OSRnyfFaAZezjwevwA9AH
 MuTa6/CmSHHWOuSxR9+la/P0BtNum6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-E43g_kjRPEKSOT7tzDIB5A-1; Mon, 20 Apr 2020 10:49:49 -0400
X-MC-Unique: E43g_kjRPEKSOT7tzDIB5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF34802689;
 Mon, 20 Apr 2020 14:49:46 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A6E5C1C5;
 Mon, 20 Apr 2020 14:49:36 +0000 (UTC)
Subject: Re: [RFC v1 2/4] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 cohuck@redhat.com, jasowang@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-3-lulu@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ba3bd2eb-9d0b-aa21-8583-40fc90b29c70@redhat.com>
Date: Mon, 20 Apr 2020 09:49:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-3-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 4:32 AM, Cindy Lu wrote:
> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is svhostdevpecified

looks like you pasted 'vhostdev' in the middle of 'specified'

> by a "vhostdev" parameter.
> 
> Author: Tiwei Bie

Should this be a 'Signed-off-by' tag?

> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

> +++ b/include/net/vhost-vdpa.h
> @@ -0,0 +1,18 @@
> +/*
> + * vhost-vdpa.h
> + *
> + * Copyright(c) 2017 Intel Corporation. All rights reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.

Claiming "All rights reserved" is at odds with claiming "GPL", which 
specifically requires that you are NOT reserving all rights but are 
instead granting various rights to others insofar as they preserve this 
code as free software.  I can overlook it on BSD licenses (as there are 
lots of examples of bad copy-and-paste on various templates that uses 
the misleading term), but not on GPL licenses.  Also, you may want to 
consider if adding 2020 to your copyright date is appropriate.


> +++ b/net/vhost-vdpa.c
> @@ -0,0 +1,211 @@
> +/*
> + * vhost-vdpa.c
> + *
> + * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.

Another inconsistent license.


> +++ b/qapi/net.json
> @@ -441,6 +441,22 @@
>       '*queues':        'int' } }
>   
>   ##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend
> +#
> +# @vhostdev: name of a mdev dev path in sysfs
> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1) (Since 2.11)

There's no need to add a 'since' tag for an individual member if...

> +#
> +# Since: 2.11

...the struct itself was introduced in the same release.  However, using 
2.11 as the release is wrong; the next release will be 5.1.

> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*queues':       'int' } }
> +##
>   # @NetClientDriver:
>   #
>   # Available netdev drivers.
> @@ -451,7 +467,7 @@
>   ##
>   { 'enum': 'NetClientDriver',

Missing documentation that 'vhost-vdpa' was added in 5.1.

>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
>   
>   ##
>   # @Netdev:
> @@ -479,7 +495,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>   
>   ##
>   # @NetLegacy:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


