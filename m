Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4644C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96832054F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0x/chfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96832054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGS6-0001OP-P5
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFGRX-0000tF-30
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFGRV-0002b6-5G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599482415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mNb1hbrQhaxxtqcvC4gqkFHYjYXEgZAlmLgw21BcEw=;
 b=A0x/chfSFfLL41Exn2PZqDc/1s+OA1fmXc57x/BAun+K0KtIjMk4HSzMDdNpA3YO/hHdV5
 mBVueG965cjNu0aQ9p4Pfr0O+S7G62RwVEDonspwKt+/RVKy+2PT7LvSJ9jSuWtQ2whA/N
 LHtR6uI0kHGSAT6SAyoUksaC2O3VhGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-bZuU8-USN36TRvMkhOQk7g-1; Mon, 07 Sep 2020 08:39:58 -0400
X-MC-Unique: bZuU8-USN36TRvMkhOQk7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E001017DC1;
 Mon,  7 Sep 2020 12:39:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0CED5C1BB;
 Mon,  7 Sep 2020 12:39:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C6A11132B59; Mon,  7 Sep 2020 14:39:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexey Kirillov <lekiravi@yandex-team.ru>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
Date: Mon, 07 Sep 2020 14:39:51 +0200
In-Reply-To: <37711599469320@mail.yandex-team.ru> (Alexey Kirillov's message
 of "Mon, 07 Sep 2020 13:37:37 +0300")
Message-ID: <871rjdrca0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kirillov <lekiravi@yandex-team.ru> writes:

> Hi!
>
> 02.09.2020, 14:23, "Markus Armbruster" <armbru@redhat.com>:
>> Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>
>>> =C2=A0Add a qmp command that provides information about currently attac=
hed
>>> =C2=A0backend network devices and their configuration.
>>>
>>> =C2=A0Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>>
>> [...]
>>> =C2=A0diff --git a/qapi/net.json b/qapi/net.json
>>> =C2=A0index ddb113e5e5..c09322bb42 100644
>>> =C2=A0--- a/qapi/net.json
>>> =C2=A0+++ b/qapi/net.json
>>> =C2=A0@@ -714,3 +714,71 @@
>>> =C2=A0=C2=A0##
>>> =C2=A0=C2=A0{ 'event': 'FAILOVER_NEGOTIATED',
>>> =C2=A0=C2=A0=C2=A0=C2=A0'data': {'device-id': 'str'} }
>>> =C2=A0+
>>> =C2=A0+##
>>> =C2=A0+# @NetdevInfo:
>>> =C2=A0+#
>>> =C2=A0+# Configuration of a network backend device (netdev).
>>> =C2=A0+#
>>> =C2=A0+# @id: Device identifier.
>>> =C2=A0+#
>>> =C2=A0+# @type: Specify the driver used for interpreting remaining argu=
ments.
>>> =C2=A0+#
>>> =C2=A0+# @peer-id: Connected frontend network device identifier.
>>> =C2=A0+#
>>> =C2=A0+# Since: 5.2
>>> =C2=A0+##
>>> =C2=A0+{ 'union': 'NetdevInfo',
>>> =C2=A0+ 'base': { 'id': 'str',
>>> =C2=A0+ 'type': 'NetClientDriver',
>>> =C2=A0+ '*peer-id': 'str' },
>>> =C2=A0+ 'discriminator': 'type',
>>> =C2=A0+ 'data': {
>>> =C2=A0+ 'user': 'NetdevUserOptions',
>>> =C2=A0+ 'tap': 'NetdevTapOptions',
>>> =C2=A0+ 'l2tpv3': 'NetdevL2TPv3Options',
>>> =C2=A0+ 'socket': 'NetdevSocketOptions',
>>> =C2=A0+ 'vde': 'NetdevVdeOptions',
>>> =C2=A0+ 'bridge': 'NetdevBridgeOptions',
>>> =C2=A0+ 'netmap': 'NetdevNetmapOptions',
>>> =C2=A0+ 'vhost-user': 'NetdevVhostUserOptions',
>>> =C2=A0+ 'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>>
>> This is union Netdev plus a common member @peer-id, less the variant
>> members for NetClientDriver values 'nic' and 'hubport'.
>>
>> Can 'type: 'nic' and 'type': 'hubport' occur?
>
> No, it can't. We don't support NIC/hubport in query-netdevs, so we neithe=
r create this
> structure for them, nor store config.

Same for 'none', I guess.

As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
just has no variant members for them.  The fact that they can't occur is
not coded into the type, and therefore not visible in introspection.

To make introspection more precise, we'd have to define a new enum type.
How much that would complicate the C code is unclear.

Do we need it to be more precise?  Eric, got an opinion?

Existing type Netdev has the same issue for 'none' and 'nic'.  I guess
this is so we can reuse the type for -net.  Not sure that's a good idea,
but not this patch's problem.

>> What's the use case for @peer-id?
>
> Main reason is to provide information "is this backend connected to front=
end device".
> User also may want to know which backend used for frontend device.
>
>> Assuming we want @peer-id: its documentation is too vague. Cases:
>>
>> * Not connected to a frontend: I guess @peer-id is absent then.
>
> Absolutely correct.
>
>> * Connected to a frontend
>>
>> =C2=A0=C2=A0- that has a qdev ID (the thing you set with -device id=3D..=
.): I guess
>> =C2=A0=C2=A0=C2=A0=C2=A0it's the qdev ID then.
>
> Correct.
>
>> =C2=A0=C2=A0- that doesn't have a qdev ID: anyone's guess.
>
> We use field "name" of structure NetClientState, so if there is no direct=
 ID setting,
> there must be generated name (in format "model.id").

Perhaps:

      # @peer-id: the connected network backend's name (absent if no
      #           backend is connected)

>>> =C2=A0+
>>> =C2=A0+##
>>> =C2=A0+# @query-netdevs:
>>> =C2=A0+#
>>> =C2=A0+# Get a list of @NetdevInfo for all virtual network backend devi=
ces (netdevs).
>>> =C2=A0+#
>>> =C2=A0+# Returns: a list of @NetdevInfo describing each netdev.
>>> =C2=A0+#
>>> =C2=A0+# Since: 5.2
>>> =C2=A0+#
>>> =C2=A0+# Example:
>>> =C2=A0+#
>>> =C2=A0+# -> { "execute": "query-netdevs" }
>>> =C2=A0+# <- { "return": [
>>> =C2=A0+# {
>>> =C2=A0+# "ipv6": true,
>>> =C2=A0+# "ipv4": true,
>>> =C2=A0+# "host": "10.0.2.2",
>>> =C2=A0+# "ipv6-dns": "fec0::3",
>>> =C2=A0+# "ipv6-prefix": "fec0::",
>>> =C2=A0+# "net": "10.0.2.0/255.255.255.0",
>>> =C2=A0+# "ipv6-host": "fec0::2",
>>> =C2=A0+# "type": "user",
>>> =C2=A0+# "peer-id": "net0",
>>> =C2=A0+# "dns": "10.0.2.3",
>>> =C2=A0+# "hostfwd": [
>>> =C2=A0+# {
>>> =C2=A0+# "str": "tcp::20004-:22"
>>> =C2=A0+# }
>>> =C2=A0+# ],
>>> =C2=A0+# "ipv6-prefixlen": 64,
>>> =C2=A0+# "id": "netdev0",
>>> =C2=A0+# "restrict": false
>>> =C2=A0+# }
>>> =C2=A0+# ]
>>> =C2=A0+# }
>>> =C2=A0+#
>>> =C2=A0+##
>>> =C2=A0+{ 'command': 'query-netdevs', 'returns': ['NetdevInfo'] }
>
>
> --=C2=A0
> Alexey Kirillov
> Yandex.Cloud


