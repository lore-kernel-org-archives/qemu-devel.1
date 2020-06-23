Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C94C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27DA206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDsb/ai7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27DA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnd7l-0002dy-1C
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnd7D-0002FF-DY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:13:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnd7B-0007ZU-M0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592896384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHj1oVnI6fPsGUbAaPX2vO3gKQam6TOmDelw0DiR0b8=;
 b=HDsb/ai7FoyLPJ3OhRjOKgHJZtUq9zQ7QthmC6+Lipi0kAJpdPz5HGu/Bonr8JslSTBzqF
 XVSx5s9y5HTq7DW8NXxYjUDgUYshn9ka4CFI7eQ8Ovng2qm6ydjfGBqGnTJxi5nGSVuJGZ
 DvIAiPXle1rV4eD2lqvobJGjacREWto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-bfSvh6mHPVuUJRzDMdPv3A-1; Tue, 23 Jun 2020 03:13:02 -0400
X-MC-Unique: bfSvh6mHPVuUJRzDMdPv3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E401C1005512;
 Tue, 23 Jun 2020 07:12:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0992D19D82;
 Tue, 23 Jun 2020 07:12:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7976E113846D; Tue, 23 Jun 2020 09:12:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v1 10/10] vhost-vdpa: introduce vhost-vdpa net client
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-11-lulu@redhat.com>
Date: Tue, 23 Jun 2020 09:12:49 +0200
In-Reply-To: <20200622153756.19189-11-lulu@redhat.com> (Cindy Lu's message of
 "Mon, 22 Jun 2020 23:37:56 +0800")
Message-ID: <875zbi45n2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 armbru@redhat.com, hch@infradead.org, eperezma@redhat.com, jgg@mellanox.com,
 jasowang@redhat.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, maxime.coquelin@redhat.com,
 Tiwei Bie <tiwei.bie@intel.com>, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QAPI schema review only.

Cindy Lu <lulu@redhat.com> writes:

> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is specified
> by a "vhostdev" parameter.
>
> Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
[...]
> diff --git a/qapi/net.json b/qapi/net.json
> index cebb1b52e3..03aad67693 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -428,6 +428,24 @@
>      '*vhostforce':    'bool',
>      '*queues':        'int' } }
>  
> +##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend

Considering this ends up in QMP reference documentation, could you add a
hint on what "Vhost-vdpa" is?

> +#
> +# @vhostdev: name of a vdpa dev path in sysfs

How is this thing to be spelled in text, vdpa, VDPA or vDPA?

Avoid unnecessary abbreviations in doc text, please: write "device
path", not "dev path".

> +#            (default path:/dev/vhost-vdpa-$ID)

What's $ID?

> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1)
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*queues':       'int' } }
> +
>  ##
>  # @NetClientDriver:
>  #
> @@ -437,7 +455,7 @@
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
>  
>  ##
>  # @Netdev:
> @@ -465,7 +483,8 @@
>      'bridge':   'NetdevBridgeOptions',
>      'hubport':  'NetdevHubPortOptions',
>      'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>  
>  ##
>  # @NetLegacy:


