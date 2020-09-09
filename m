Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBCAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C7F20757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OM82t9bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C7F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzUH-0003Xb-4F
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFzTV-00034N-Sb
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:45:22 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:36314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFzTR-0008CZ-3B
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:45:20 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9C3282E14DF;
 Wed,  9 Sep 2020 15:45:11 +0300 (MSK)
Received: from localhost (localhost [::1])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 JZ3FDGe1VO-j8wO7n37; Wed, 09 Sep 2020 15:45:11 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599655511; bh=q2/Xo3hYkUskM6y73Q7UfUktCBpGkA4PYAsuZdMjrFs=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=OM82t9bmoU0SSyuhzMUZXY9sn4/WNYmj0mxZoJTVHS6VMiyTF4HJGt9ObhDwwVSKP
 eSPguoLc+DYJn1K1HGMBcsL5FfkvAvWn7jfv9Niw5/lJFsVeUUbezclTMPLGt+MOBE
 JmBSxr3mYigdKuh/fuQ79dfDH5Q9xwC+CxCphnA4=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
Received: by myt4-457577cc370d.qloud-c.yandex.net with HTTP;
 Wed, 09 Sep 2020 15:45:08 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87k0x3xjmv.fsf@dusky.pond.sub.org>
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
 <871rjdrca0.fsf@dusky.pond.sub.org>
 <18211599579782@mail.yandex-team.ru> <87k0x3xjmv.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 09 Sep 2020 15:45:08 +0300
Message-Id: <35731599654153@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 08:45:12
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.09.2020, 14:41, "Markus Armbruster" <armbru@redhat.com>:
> Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>
>>  07.09.2020, 15:40, "Markus Armbruster" <armbru@redhat.com>:
>>>  Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>>
>>>>   Hi!
>>>>
>>>>   02.09.2020, 14:23, "Markus Armbruster" <armbru@redhat.com>:
>>>>>   Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>>>>
>>>>>>    Add a qmp command that provides information about currently attached
>>>>>>    backend network devices and their configuration.
>>>>>>
>>>>>>    Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>>>>>
>>>>>   [...]
>>>>>>    diff --git a/qapi/net.json b/qapi/net.json
>>>>>>    index ddb113e5e5..c09322bb42 100644
>>>>>>    --- a/qapi/net.json
>>>>>>    +++ b/qapi/net.json
>>>>>>    @@ -714,3 +714,71 @@
>>>>>>     ##
>>>>>>     { 'event': 'FAILOVER_NEGOTIATED',
>>>>>>       'data': {'device-id': 'str'} }
>>>>>>    +
>>>>>>    +##
>>>>>>    +# @NetdevInfo:
>>>>>>    +#
>>>>>>    +# Configuration of a network backend device (netdev).
>>>>>>    +#
>>>>>>    +# @id: Device identifier.
>>>>>>    +#
>>>>>>    +# @type: Specify the driver used for interpreting remaining arguments.
>>>>>>    +#
>>>>>>    +# @peer-id: Connected frontend network device identifier.
>>>>>>    +#
>>>>>>    +# Since: 5.2
>>>>>>    +##
>>>>>>    +{ 'union': 'NetdevInfo',
>>>>>>    + 'base': { 'id': 'str',
>>>>>>    + 'type': 'NetClientDriver',
>>>>>>    + '*peer-id': 'str' },
>>>>>>    + 'discriminator': 'type',
>>>>>>    + 'data': {
>>>>>>    + 'user': 'NetdevUserOptions',
>>>>>>    + 'tap': 'NetdevTapOptions',
>>>>>>    + 'l2tpv3': 'NetdevL2TPv3Options',
>>>>>>    + 'socket': 'NetdevSocketOptions',
>>>>>>    + 'vde': 'NetdevVdeOptions',
>>>>>>    + 'bridge': 'NetdevBridgeOptions',
>>>>>>    + 'netmap': 'NetdevNetmapOptions',
>>>>>>    + 'vhost-user': 'NetdevVhostUserOptions',
>>>>>>    + 'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>>>>>
>>>>>   This is union Netdev plus a common member @peer-id, less the variant
>>>>>   members for NetClientDriver values 'nic' and 'hubport'.
>>>>>
>>>>>   Can 'type: 'nic' and 'type': 'hubport' occur?
>>>>
>>>>   No, it can't. We don't support NIC/hubport in query-netdevs, so we neither create this
>>>>   structure for them, nor store config.
>>>
>>>  Same for 'none', I guess.
>>>
>>>  As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
>>>  just has no variant members for them. The fact that they can't occur is
>>>  not coded into the type, and therefore not visible in introspection.
>>>
>>>  To make introspection more precise, we'd have to define a new enum type.
>>>  How much that would complicate the C code is unclear.
>>>
>>>  Do we need it to be more precise? Eric, got an opinion?
>>>
>>>  Existing type Netdev has the same issue for 'none' and 'nic'. I guess
>>>  this is so we can reuse the type for -net. Not sure that's a good idea,
>>>  but not this patch's problem.
>>>
>>>>>   What's the use case for @peer-id?
>>>>
>>>>   Main reason is to provide information "is this backend connected to frontend device".
>>>>   User also may want to know which backend used for frontend device.
>>>>
>>>>>   Assuming we want @peer-id: its documentation is too vague. Cases:
>>>>>
>>>>>   * Not connected to a frontend: I guess @peer-id is absent then.
>>>>
>>>>   Absolutely correct.
>>>>
>>>>>   * Connected to a frontend
>>>>>
>>>>>     - that has a qdev ID (the thing you set with -device id=...): I guess
>>>>>       it's the qdev ID then.
>>>>
>>>>   Correct.
>>>>
>>>>>     - that doesn't have a qdev ID: anyone's guess.
>>>>
>>>>   We use field "name" of structure NetClientState, so if there is no direct ID setting,
>>>>   there must be generated name (in format "model.id").
>>>
>>>  Perhaps:
>>>
>>>        # @peer-id: the connected network backend's name (absent if no
>>>        # backend is connected)
>>
>>  Maybe you mean:
>>
>>  # @peer-id: The connected frontend network device name (absent if no frontend
>>  # is connected).
>
> Yes, I wrote backend, but meant frontend.
>
> Aside: our naming is undisciplined: we use both "id" and "name" in QMP
> for NetClientState member name. Unfortunate.

Well, I was looking at netdev_add/netdev_del when choosing member's name.
Looks like "name" more often used for NICs when "id" is for common netdevs.

It seems to me that the "id" is more suitable for network devices, since
it is uniquely define them when calling QMP commands.

>>  In any case, thanks for pointing. I'll add this in the next patch version.
>
> [...]


-- 
Alexey Kirillov
Yandex.Cloud

