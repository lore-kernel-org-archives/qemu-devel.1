Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F39020724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QTttHJxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F39020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfk4-0006bL-M3
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1jnfiO-0005E6-KC; Tue, 23 Jun 2020 05:59:40 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:50246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1jnfiJ-0006ot-4p; Tue, 23 Jun 2020 05:59:39 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A8CB82E17B0;
 Tue, 23 Jun 2020 12:59:26 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GETtGuevOX-xHaiKNqk; Tue, 23 Jun 2020 12:59:26 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1592906366; bh=lq34GxPpe2c6C6ooW25hm9bZ9x+6Rh5Aa8JRJt82yb4=;
 h=Cc:Subject:Date:References:To:From:Message-Id;
 b=QTttHJxXJzB2mYT3Pe5fc4qZHJk70g2aurRDCoJkpwIKVMSgJtFLxE4OP1yoDxapX
 jGr++s7uTTPfWBKQUnA6NJM4gztQlonVdcXhnJBE+pSaWQJ5qxtFWm97VW+dc+uQTI
 SjPCejw0wPep6adeHAdhCzb3DEOm6oBahzLbH+TQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net (localhost [::1])
 by mxbackcorp1o.mail.yandex.net with LMTP id 1vFs6nmNIF-1upkCpTv
 for <lekiravi@yandex-team.ru>; Tue, 23 Jun 2020 12:59:07 +0300
Received: by iva4-6d0ca09d92db.qloud-c.yandex.net with HTTP;
 Tue, 23 Jun 2020 12:59:07 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>,
	Thomas Huth <huth@tuxfamily.org>
References: <20200304130656.16859-1-lekiravi@yandex-team.ru>
 <20200304130656.16859-2-lekiravi@yandex-team.ru>
 <87y2sff1qo.fsf@dusky.pond.sub.org>
 <1041781583412683@myt4-457577cc370d.qloud-c.yandex.net>
Subject: Re: [PATCH v2 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 23 Jun 2020 12:59:17 +0300
Message-Id: <126621592905028@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 05:59:27
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

Sorry, I lost a point in discussion.

As I wrote early, main reason for mix frontend and backend devices is for
easy recreation of current state of network. As we have common structure
for all netdevs (`struct NetClientState`), I think, that it'll be good
idea to iterate using `net_clients`.
There is no such trouble to split `query-netdevs` by two, for example,
`query-front-netdevs` and `query-back-netdevs`, but in my opinion it'll
break consistancy in getting links between netdevs.

05.03.2020, 17:26, "Alexey Kirillov" <lekiravi@yandex-team.ru>:
> 05.03.2020, 15:03, "Markus Armbruster" <armbru@redhat.com>:
>>  Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>
>>>   Add a qmp command that provides information about currently attached
>>>   network devices and their configuration.
>>
>>  Closes a gap in QMP; appreciated!
>>
>>>   Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>>
>>  [...]
>>>   diff --git a/qapi/net.json b/qapi/net.json
>>>   index 1cb9a7d782..4f329a1de0 100644
>>>   --- a/qapi/net.json
>>>   +++ b/qapi/net.json
>>>   @@ -750,3 +750,92 @@
>>>    ##
>>>    { 'event': 'FAILOVER_NEGOTIATED',
>>>      'data': {'device-id': 'str'} }
>>>   +
>>>   +##
>>>   +# @NetdevInfo:
>>>   +#
>>>   +# Configuration of a network device.
>>>   +#
>>>   +# @id: Device identifier.
>>>   +#
>>>   +# @type: Specify the driver used for interpreting remaining arguments.
>>>   +#
>>>   +# @peer: Connected network device.
>>
>>  @peer is optional. I assume its present when the device is connected
>>  (frontend to backend or vice versa). Correct?
>
> Yes, this field stores connected frontend/backend device @id.
>
>>>   +#
>>>   +# @queues-count: Number of queues.
>>
>>  We use plain @queues elsewhere in the schema.
>
> It can conflict with fields inside Netdev*Options, isn't it?
>
>>>   +#
>>>   +# @hub: hubid of hub, if connected to.
>>
>>  How @hub is related to @peer is not quite obvious to me. Can you give
>>  an example where @hub is present?
>
> NetdevHubPortOptions has an option @hubid. @hub gives that id, if
> netdev is connected to the hub via hubport. As example:
>
> HMP:
>
> hub 0
>  \ hub0port1: socket.0: index=0,type=socket,
>  \ hub0port0: virtio-net-pci.0: index=0,type=nic,model=virtio-net-pci,macaddr=52:54:00:12:34:56
>
> QMP:
>
> [
>   {
>     "peer": "hub0port0",
>     "netdev": "hub0port0",
>     "hub": 0,
>     "model": "virtio-net-pci",
>     "macaddr": "52:54:00:12:34:56",
>     "type": "nic",
>     "queues-count": 1,
>     "id": "virtio-net-pci.0"
>   },
>   {
>     "peer": "hub0port1",
>     "listen": "127.0.0.1:90",
>     "hub": 0,
>     "type": "socket",
>     "queues-count": 1,
>     "id": "socket.0"
>   },
>   {
>     "peer": "socket.0",
>     "netdev": "socket.0",
>     "hub": 0,
>     "hubid": 0,
>     "type": "hubport",
>     "queues-count": 1,
>     "id": "hub0port1"
>   },
>   {
>     "peer": "virtio-net-pci.0",
>     "netdev": "virtio-net-pci.0",
>     "hub": 0,
>     "hubid": 0,
>     "type": "hubport",
>     "queues-count": 1,
>     "id": "hub0port0"
>   }
> ]
>
>>>   +#
>>>   +# @perm-mac: Original MAC address.
>>
>>  What does "perm-" mean?
>>
>>  It's optional. When exactly is it present?
>
> @perm-mac is the permanent (original) MAC address. It only used
> for nic, because most of nic realizations can change MAC at
> runtime and/or reset it to default (permanent) value.
>
>>>   +#
>>>   +# Since: 5.0
>>>   +##
>>>   +{ 'union': 'NetdevInfo',
>>>   + 'base': { 'id': 'str',
>>>   + 'type': 'NetClientDriver',
>>>   + '*peer': 'str',
>>>   + 'queues-count': 'int',
>>>   + '*hub': 'int',
>>>   + '*perm-mac': 'str' },
>>>   + 'discriminator': 'type',
>>>   + 'data': {
>>>   + 'nic': 'NetLegacyNicOptions',
>>>   + 'user': 'NetdevUserOptions',
>>>   + 'tap': 'NetdevTapOptions',
>>>   + 'l2tpv3': 'NetdevL2TPv3Options',
>>>   + 'socket': 'NetdevSocketOptions',
>>>   + 'vde': 'NetdevVdeOptions',
>>>   + 'bridge': 'NetdevBridgeOptions',
>>>   + 'hubport': 'NetdevHubPortOptions',
>>>   + 'netmap': 'NetdevNetmapOptions',
>>>   + 'vhost-user': 'NetdevVhostUserOptions' } }
>>
>>  This is a copy of union 'Netdev' with a few additional common members
>>  (@peer, @queues-count, @hub, @perm-mac). I can't see how to avoid the
>>  duplication without adding nesting on the wire.
>>
>>>   +
>>>   +##
>>>   +# @query-netdevs:
>>>   +#
>>>   +# Get a list of @NetdevInfo for all virtual network devices.
>>>   +#
>>>   +# Returns: a list of @NetdevInfo describing each virtual network device.
>>>   +#
>>>   +# Since: 5.0
>>>   +#
>>>   +# Example:
>>>   +#
>>>   +# -> { "execute": "query-netdevs" }
>>>   +# <- { "return": [
>>>   +# {
>>>   +# "peer": "netdev0",
>>>   +# "netdev": "netdev0",
>>>   +# "perm-mac": "52:54:00:12:34:56"
>>>   +# "model": "virtio-net-pci",
>>>   +# "macaddr": "52:54:00:12:34:56",
>>>   +# "queues-count": 1,
>>>   +# "type": "nic",
>>>   +# "id": "net0"
>>>   +# },
>>>   +# {
>>>   +# "peer": "net0",
>>>   +# "ipv6": true,
>>>   +# "ipv4": true,
>>>   +# "host": "10.0.2.2",
>>>   +# "queues-count": 1,
>>>   +# "ipv6-dns": "fec0::3",
>>>   +# "ipv6-prefix": "fec0::",
>>>   +# "net": "10.0.2.0/255.255.255.0",
>>>   +# "ipv6-host": "fec0::2",
>>>   +# "type": "user",
>>>   +# "dns": "10.0.2.3",
>>>   +# "hostfwd": [
>>>   +# {
>>>   +# "str": "tcp::20004-:22"
>>>   +# }
>>>   +# ],
>>>   +# "ipv6-prefixlen": 64,
>>>   +# "id": "netdev0",
>>>   +# "restrict": false
>>>   +# }
>>>   +# ]
>>>   +# }
>>>   +#
>>>   +##
>>>   +{ 'command': 'query-netdevs', 'returns': ['NetdevInfo'] }
>>
>>  Like HMP "info network" and -net, this mixes frontends ("type": "nic")
>>  and backends. Unlike query-chardev and query-block. Hmm.
>>
>>  A long time ago, all we had was -net: "-net nic" for configuring
>>  frontends, "-net none" for suppressing a default frontend + backend, and
>>  "-net anything-else" for configuring backends. "info network" showed
>>  the stuff set up with -net.
>>
>>  In v0.12, we got -device for configuring frontends, and -netdev for
>>  backends. -netdev is like -net less "none", "nic", and the hub
>>  weirdness. "info network" was extended to also show all this.
>>
>>  In v2.12, we got -nic, replacing -net nic.
>>
>>  Unless I'm missing something, -net is just for backward compatibility
>>  now.
>>
>>  What's the use case for query-networks reporting frontends?
>
> In my vision, new QMP command is the replacement for old
> HMP command. It must provide information about all
> network devices, mainly for recreate similar net topology.
> Currently, there are no differrence between fronted and
> backend devices in context of my command, because
> all of them use the same interface in NetClientState.
>
>>
>
> --
> Alexey Kirillov
> Yandex.Cloud

-- 
Alexey Kirillov
Yandex.Cloud



