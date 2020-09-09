Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D430C10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB19B21D43
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjckiJxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB19B21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyUW-0005Q1-Vf
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFyTg-0004yL-II
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:41:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFyTe-00004t-Ca
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599651685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFaSi3TyY2Mg3/jYdIwgy6t1T5Gt708us1+B8BywYuo=;
 b=HjckiJxWME5l7bNVgNusuxK1gbS2tUg45Furs8wOHTVPVAC7Ihsme+7vw/In+W6r+pvLKq
 mVrwOyIWlpPY2wCHplx1DxoOkwoIewChmJ7IecD0mXjkJ6yJU9mipQlMEf03Tdw0lTxlQD
 k3W8Q9NW9zcnGWVDIREfUUtRYj2WWE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-nyGpgMI4OR6630QMWjGxmQ-1; Wed, 09 Sep 2020 07:41:19 -0400
X-MC-Unique: nyGpgMI4OR6630QMWjGxmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23F8E873113;
 Wed,  9 Sep 2020 11:41:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B19E7E46E;
 Wed,  9 Sep 2020 11:41:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BA77113865F; Wed,  9 Sep 2020 13:41:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexey Kirillov <lekiravi@yandex-team.ru>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
 <871rjdrca0.fsf@dusky.pond.sub.org>
 <18211599579782@mail.yandex-team.ru>
Date: Wed, 09 Sep 2020 13:41:12 +0200
In-Reply-To: <18211599579782@mail.yandex-team.ru> (Alexey Kirillov's message
 of "Tue, 08 Sep 2020 18:52:39 +0300")
Message-ID: <87k0x3xjmv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kirillov <lekiravi@yandex-team.ru> writes:

> 07.09.2020, 15:40, "Markus Armbruster" <armbru@redhat.com>:
>> Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>
>>> =C2=A0Hi!
>>>
>>> =C2=A002.09.2020, 14:23, "Markus Armbruster" <armbru@redhat.com>:
>>>> =C2=A0Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>>>
>>>>> =C2=A0=C2=A0Add a qmp command that provides information about current=
ly attached
>>>>> =C2=A0=C2=A0backend network devices and their configuration.
>>>>>
>>>>> =C2=A0=C2=A0Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>>>>
>>>> =C2=A0[...]
>>>>> =C2=A0=C2=A0diff --git a/qapi/net.json b/qapi/net.json
>>>>> =C2=A0=C2=A0index ddb113e5e5..c09322bb42 100644
>>>>> =C2=A0=C2=A0--- a/qapi/net.json
>>>>> =C2=A0=C2=A0+++ b/qapi/net.json
>>>>> =C2=A0=C2=A0@@ -714,3 +714,71 @@
>>>>> =C2=A0=C2=A0=C2=A0##
>>>>> =C2=A0=C2=A0=C2=A0{ 'event': 'FAILOVER_NEGOTIATED',
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'data': {'device-id': 'str'} }
>>>>> =C2=A0=C2=A0+
>>>>> =C2=A0=C2=A0+##
>>>>> =C2=A0=C2=A0+# @NetdevInfo:
>>>>> =C2=A0=C2=A0+#
>>>>> =C2=A0=C2=A0+# Configuration of a network backend device (netdev).
>>>>> =C2=A0=C2=A0+#
>>>>> =C2=A0=C2=A0+# @id: Device identifier.
>>>>> =C2=A0=C2=A0+#
>>>>> =C2=A0=C2=A0+# @type: Specify the driver used for interpreting remain=
ing arguments.
>>>>> =C2=A0=C2=A0+#
>>>>> =C2=A0=C2=A0+# @peer-id: Connected frontend network device identifier=
.
>>>>> =C2=A0=C2=A0+#
>>>>> =C2=A0=C2=A0+# Since: 5.2
>>>>> =C2=A0=C2=A0+##
>>>>> =C2=A0=C2=A0+{ 'union': 'NetdevInfo',
>>>>> =C2=A0=C2=A0+ 'base': { 'id': 'str',
>>>>> =C2=A0=C2=A0+ 'type': 'NetClientDriver',
>>>>> =C2=A0=C2=A0+ '*peer-id': 'str' },
>>>>> =C2=A0=C2=A0+ 'discriminator': 'type',
>>>>> =C2=A0=C2=A0+ 'data': {
>>>>> =C2=A0=C2=A0+ 'user': 'NetdevUserOptions',
>>>>> =C2=A0=C2=A0+ 'tap': 'NetdevTapOptions',
>>>>> =C2=A0=C2=A0+ 'l2tpv3': 'NetdevL2TPv3Options',
>>>>> =C2=A0=C2=A0+ 'socket': 'NetdevSocketOptions',
>>>>> =C2=A0=C2=A0+ 'vde': 'NetdevVdeOptions',
>>>>> =C2=A0=C2=A0+ 'bridge': 'NetdevBridgeOptions',
>>>>> =C2=A0=C2=A0+ 'netmap': 'NetdevNetmapOptions',
>>>>> =C2=A0=C2=A0+ 'vhost-user': 'NetdevVhostUserOptions',
>>>>> =C2=A0=C2=A0+ 'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>>>>
>>>> =C2=A0This is union Netdev plus a common member @peer-id, less the var=
iant
>>>> =C2=A0members for NetClientDriver values 'nic' and 'hubport'.
>>>>
>>>> =C2=A0Can 'type: 'nic' and 'type': 'hubport' occur?
>>>
>>> =C2=A0No, it can't. We don't support NIC/hubport in query-netdevs, so w=
e neither create this
>>> =C2=A0structure for them, nor store config.
>>
>> Same for 'none', I guess.
>>
>> As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
>> just has no variant members for them. The fact that they can't occur is
>> not coded into the type, and therefore not visible in introspection.
>>
>> To make introspection more precise, we'd have to define a new enum type.
>> How much that would complicate the C code is unclear.
>>
>> Do we need it to be more precise? Eric, got an opinion?
>>
>> Existing type Netdev has the same issue for 'none' and 'nic'. I guess
>> this is so we can reuse the type for -net. Not sure that's a good idea,
>> but not this patch's problem.
>>
>>>> =C2=A0What's the use case for @peer-id?
>>>
>>> =C2=A0Main reason is to provide information "is this backend connected =
to frontend device".
>>> =C2=A0User also may want to know which backend used for frontend device=
.
>>>
>>>> =C2=A0Assuming we want @peer-id: its documentation is too vague. Cases=
:
>>>>
>>>> =C2=A0* Not connected to a frontend: I guess @peer-id is absent then.
>>>
>>> =C2=A0Absolutely correct.
>>>
>>>> =C2=A0* Connected to a frontend
>>>>
>>>> =C2=A0=C2=A0=C2=A0- that has a qdev ID (the thing you set with -device=
 id=3D...): I guess
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0it's the qdev ID then.
>>>
>>> =C2=A0Correct.
>>>
>>>> =C2=A0=C2=A0=C2=A0- that doesn't have a qdev ID: anyone's guess.
>>>
>>> =C2=A0We use field "name" of structure NetClientState, so if there is n=
o direct ID setting,
>>> =C2=A0there must be generated name (in format "model.id").
>>
>> Perhaps:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# @peer-id: the connected network ba=
ckend's name (absent if no
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# backend is connected)
>
> Maybe you mean:
>
> # @peer-id: The connected frontend network device name (absent if no fron=
tend
> # is connected).

Yes, I wrote backend, but meant frontend.

Aside: our naming is undisciplined: we use both "id" and "name" in QMP
for NetClientState member name.  Unfortunate.

> In any case, thanks for pointing. I'll add this in the next patch version=
.
[...]


