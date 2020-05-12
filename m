Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA42C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3076B20643
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1mNxJJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3076B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVyl-0001eY-D4
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVy9-00019I-8X
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:33:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYVy7-0000DP-LL
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589293994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5Uhq+RFEFyZBHd9uuICDZqzfpG8LjmcJ/yhOW8MB3U=;
 b=h1mNxJJ4aiLz8gozobRVtecUbT7hJg6WQT2nh6qmzEwMTcn2gmEf0gHbsMCWE2tvP1iiR9
 ACcCSYLBXJdsGQViWeOXcP0hicmL/L5IbLZ36SnoZcpJteErjjxFvMJji5XmXSKMJ1MR0L
 CLK3IIvsnVLal9EHDIXxzancLLWSgrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-MXIsRBJlM6SqLQvHa3jIqQ-1; Tue, 12 May 2020 10:33:04 -0400
X-MC-Unique: MXIsRBJlM6SqLQvHa3jIqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4D81005510
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 14:33:03 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC2C7D8EE;
 Tue, 12 May 2020 14:33:02 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] net: Drop the NetLegacy structure, always use
 Netdev instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20200512123149.30207-1-thuth@redhat.com>
 <20200512123149.30207-3-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a2bcb19-5ba3-0023-8733-d945ee40aeeb@redhat.com>
Date: Tue, 12 May 2020 09:32:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512123149.30207-3-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 7:31 AM, Thomas Huth wrote:
> Now that the "name" parameter is gone, there is hardly any difference
> between NetLegacy and Netdev anymore. Drop NetLegacy and always use
> Netdev to simplify the code quite a bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

> +++ b/net/net.c
> @@ -967,13 +967,14 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
>   
>   static int net_client_init1(const void *object, bool is_netdev, Error **errp)

Why do we still need the 'is_netdev' parameter?  If all callers are 
passing in a netdev, then either this parameter needs to be renamed to 
capture the actual difference between callers, or it can be dropped 
altogether.

>   {
> -    Netdev legacy = {0};
> -    const Netdev *netdev;
> +    const Netdev *netdev = object;
>       NetClientState *peer = NULL;
>   
>       if (is_netdev) {
> -        netdev = object;
> -
> +        if (!netdev->has_id) {
> +            error_setg(errp, QERR_MISSING_PARAMETER, "id");
> +            return -1;
> +        }

You wouldn't need this if 'id' remained mandatory.

> @@ -981,56 +982,11 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
>               return -1;
>           }
>       } else {
> -        const NetLegacy *net = object;
> -        const NetLegacyOptions *opts = net->opts;
> -        legacy.id = net->id;
> -        netdev = &legacy;
> -
> -        /* Map the old options to the new flat type */
> -        switch (opts->type) {
> -        case NET_LEGACY_OPTIONS_TYPE_NONE:
> +        if (netdev->type == NET_CLIENT_DRIVER_NONE) {
>               return 0; /* nothing to do */


> -
> -        if (!net_client_init_fun[netdev->type]) {
> +        if (netdev->type == NET_CLIENT_DRIVER_HUBPORT ||
> +            !net_client_init_fun[netdev->type]) {
>               error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
>                          "a net backend type (maybe it is not compiled "
>                          "into this binary)");

So maybe we still want this legacy-handling code, but renaming 
'is_netdev' to 'legacy_handling' may make more sense.

> @@ -1039,7 +995,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
>   
>           /* Do not add to a hub if it's a nic with a netdev= parameter. */
>           if (netdev->type != NET_CLIENT_DRIVER_NIC ||
> -            !opts->u.nic.has_netdev) {
> +            !netdev->u.nic.has_netdev) {
>               peer = net_hub_add_port(0, NULL, NULL);
>           }
>       }
> @@ -1143,21 +1099,13 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>           }
>       }
>   
> -    if (is_netdev) {
> -        visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
> -    } else {
> -        visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
> -    }
> +    visit_type_Netdev(v, NULL, (Netdev **)&object, &err);

Why do we need to cast?  If all callers are passing a Netdev, can't we 
just give 'object' the correct type to begin with?


> +++ b/qapi/net.json
> @@ -453,7 +453,7 @@
>   #        'l2tpv3' - since 2.1
>   ##
>   { 'union': 'Netdev',
> -  'base': { 'id': 'str', 'type': 'NetClientDriver' },
> +  'base': { '*id': 'str', 'type': 'NetClientDriver' },

I don't think we need to make 'id' optional.

>     'discriminator': 'type',
>     'data': {
>       'nic':      'NetLegacyNicOptions',
> @@ -467,52 +467,6 @@
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
> -##
> -{ 'struct': 'NetLegacy',
> -  'data': {
> -    '*id':   'str',
> -    'opts':  'NetLegacyOptions' } }
> -
> -##
> -# @NetLegacyOptionsType:
> -#
> -# Since: 1.2
> -##
> -{ 'enum': 'NetLegacyOptionsType',
> -  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'bridge', 'netmap', 'vhost-user'] }

NetLegacyOptionsType differs from NetClientDriver only by missing 
'hubport', which your code above special-cased, so on that front, the 
simplification makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


