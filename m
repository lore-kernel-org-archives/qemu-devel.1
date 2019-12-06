Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2942920659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YocE1FrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2942920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40893 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGUF-0000IR-Pd
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1idFJf-00083q-4H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1idFJc-0001Nq-86
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:14:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1idFJa-0001J8-FI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575645279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWDV7be2Kv50jYQ8XUT69/pNTpVWUw7Kc0buKkax9ns=;
 b=YocE1FrXY0WUovDX21Jp//kUjrT4Y39zalSX5g/V0s9L+l5k5UUpQNqf1UIAhb6tm3nXAu
 wsHIqmkiTxNS3qVSHUwcsHfo7LrwlhW7VuUJ/F3OkSUOMLmugpxQIINo+RaXGJB0bGH5b8
 KFVEN+AcSke+t09uQTGvTcyG+l1kuHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-aszIaQYKM5mcRdU3WlFUag-1; Fri, 06 Dec 2019 10:14:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64EB6800EB9
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 15:14:37 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F208A60BF4;
 Fri,  6 Dec 2019 15:14:34 +0000 (UTC)
Subject: Re: [PATCH 2/2] net: Drop the NetLegacy structure, always use Netdev
 instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
 <20191206053640.29368-3-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bac8635c-b38c-51e0-2478-ec14d96aedbb@redhat.com>
Date: Fri, 6 Dec 2019 09:14:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206053640.29368-3-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: aszIaQYKM5mcRdU3WlFUag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 11:36 PM, Thomas Huth wrote:
> Now that the "name" parameter is gone, there is hardly any difference
> between NetLegacy and Netdev anymore. Drop NetLegacy and always use
> Netdev to simplify the code quite a bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Initial focus on the QAPI change:

> +++ b/qapi/net.json
> @@ -467,7 +467,7 @@
>   # 'l2tpv3' - since 2.1
>   ##
>   { 'union': 'Netdev',
> -  'base': { 'id': 'str', 'type': 'NetClientDriver' },
> +  'base': { '*id': 'str', 'type': 'NetClientDriver' },

Making id optional here...

>     'discriminator': 'type',
>     'data': {
>       'nic':      'NetLegacyNicOptions',
> @@ -481,55 +481,6 @@
>       'netmap':   'NetdevNetmapOptions',
>       'vhost-user': 'NetdevVhostUserOptions' } }
>   
> -##
> -# @NetLegacy:
> -#
> -# Captures the configuration of a network device; legacy.
> -#
> -# @id: identifier for monitor commands
> -#
> -# @opts: device type specific properties (legacy)
> -#
> -# Since: 1.2
> -#
> -# 'vlan': dropped in 3.0
> -# 'name': dropped in 5.0
> -##
> -{ 'struct': 'NetLegacy',
> -  'data': {
> -    '*id':   'str',
> -    'opts':  'NetLegacyOptions' } }

to match how it was here.  Should 'id' have been made mandatory in 1/2, 
when deleting 'name' (after all, id was optional only when name was in use)?

> -
> -##
> -# @NetLegacyOptionsType:
> -#
> -# Since: 1.2
> -##
> -{ 'enum': 'NetLegacyOptionsType',
> -  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'bridge', 'netmap', 'vhost-user'] }

Comparing this to the branches of Netdev:

We are losing 'none', while gaining 'hubport'.  The gain is not 
problematic, and I guess you are declaring that the use of 'none' has 
been deprecated long enough to not be a problem.

> -
> -##
> -# @NetLegacyOptions:
> -#
> -# Like Netdev, but for use only by the legacy command line options
> -#
> -# Since: 1.2
> -##
> -{ 'union': 'NetLegacyOptions',
> -  'base': { 'type': 'NetLegacyOptionsType' },
> -  'discriminator': 'type',
> -  'data': {
> -    'nic':      'NetLegacyNicOptions',

Should we rename this to NetdevNicOptions, now that we are getting rid 
of other NetLegacy names?

> -    'user':     'NetdevUserOptions',
> -    'tap':      'NetdevTapOptions',
> -    'l2tpv3':   'NetdevL2TPv3Options',
> -    'socket':   'NetdevSocketOptions',
> -    'vde':      'NetdevVdeOptions',
> -    'bridge':   'NetdevBridgeOptions',
> -    'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }

But I concur that all branches of the Netdev union have the same types 
as what you are removing here from NetLegacyOptions, so the 
consolidation looks sane.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


