Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D511320684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlU2ymvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D511320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQsa-0006u7-Ud
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDQrw-0006UZ-Bg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:24:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDQrt-00038P-QJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599045835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOxR34VEP3Q2JwEaEXVTlZmVMTCcbCpmsRWNRD9V1Sk=;
 b=VlU2ymvz7NBQyFfOFnLFpjwzVxuAaJ49oYcA+NOTTo6jzxop+BfroEIV8KQD1+5PmZ5Ug2
 4j+snVB3lEcsfmUiTkJ//REcSMi5p1Cjs1i1hp9fJMhtFOGvRJXcTVMRLNaqaFDZmNWGg9
 y0OYvABvZr/qwvlDtHCHJk+uPvjgiDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ei0Ebo6KPnCloFFSG5qcDg-1; Wed, 02 Sep 2020 07:23:41 -0400
X-MC-Unique: ei0Ebo6KPnCloFFSG5qcDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B17D10ABDB1;
 Wed,  2 Sep 2020 11:23:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872C71002D4C;
 Wed,  2 Sep 2020 11:23:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBD13113C418; Wed,  2 Sep 2020 13:23:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexey Kirillov <lekiravi@yandex-team.ru>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
Date: Wed, 02 Sep 2020 13:23:32 +0200
In-Reply-To: <20200901182326.59633-2-lekiravi@yandex-team.ru> (Alexey
 Kirillov's message of "Tue, 1 Sep 2020 21:23:23 +0300")
Message-ID: <87lfhsjubv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 yc-core@yandex-team.ru, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kirillov <lekiravi@yandex-team.ru> writes:

> Add a qmp command that provides information about currently attached
> backend network devices and their configuration.
>
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
[...]
> diff --git a/qapi/net.json b/qapi/net.json
> index ddb113e5e5..c09322bb42 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -714,3 +714,71 @@
>  ##
>  { 'event': 'FAILOVER_NEGOTIATED',
>    'data': {'device-id': 'str'} }
> +
> +##
> +# @NetdevInfo:
> +#
> +# Configuration of a network backend device (netdev).
> +#
> +# @id: Device identifier.
> +#
> +# @type: Specify the driver used for interpreting remaining arguments.
> +#
> +# @peer-id: Connected frontend network device identifier.
> +#
> +# Since: 5.2
> +##
> +{ 'union': 'NetdevInfo',
> +  'base': { 'id': 'str',
> +            'type': 'NetClientDriver',
> +            '*peer-id': 'str' },
> +  'discriminator': 'type',
> +  'data': {
> +      'user':       'NetdevUserOptions',
> +      'tap':        'NetdevTapOptions',
> +      'l2tpv3':     'NetdevL2TPv3Options',
> +      'socket':     'NetdevSocketOptions',
> +      'vde':        'NetdevVdeOptions',
> +      'bridge':     'NetdevBridgeOptions',
> +      'netmap':     'NetdevNetmapOptions',
> +      'vhost-user': 'NetdevVhostUserOptions',
> +      'vhost-vdpa': 'NetdevVhostVDPAOptions' } }

This is union Netdev plus a common member @peer-id, less the variant
members for NetClientDriver values 'nic' and 'hubport'.

Can 'type: 'nic' and 'type': 'hubport' occur?

What's the use case for @peer-id?

Assuming we want @peer-id: its documentation is too vague.  Cases:

* Not connected to a frontend: I guess @peer-id is absent then.

* Connected to a frontend

  - that has a qdev ID (the thing you set with -device id=...): I guess
    it's the qdev ID then.

  - that doesn't have a qdev ID: anyone's guess.

> +
> +##
> +# @query-netdevs:
> +#
> +# Get a list of @NetdevInfo for all virtual network backend devices (netdevs).
> +#
> +# Returns: a list of @NetdevInfo describing each netdev.
> +#
> +# Since: 5.2
> +#
> +# Example:
> +#
> +# -> { "execute": "query-netdevs" }
> +# <- { "return": [
> +#          {
> +#              "ipv6": true,
> +#              "ipv4": true,
> +#              "host": "10.0.2.2",
> +#              "ipv6-dns": "fec0::3",
> +#              "ipv6-prefix": "fec0::",
> +#              "net": "10.0.2.0/255.255.255.0",
> +#              "ipv6-host": "fec0::2",
> +#              "type": "user",
> +#              "peer-id": "net0",
> +#              "dns": "10.0.2.3",
> +#              "hostfwd": [
> +#                  {
> +#                      "str": "tcp::20004-:22"
> +#                  }
> +#              ],
> +#              "ipv6-prefixlen": 64,
> +#              "id": "netdev0",
> +#              "restrict": false
> +#          }
> +#      ]
> +#    }
> +#
> +##
> +{ 'command': 'query-netdevs', 'returns': ['NetdevInfo'] }


