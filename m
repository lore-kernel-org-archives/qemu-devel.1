Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96045C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5492D20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN2jT5eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5492D20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iedPD-0004p1-GY
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iedOZ-0004QE-L2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iedOU-00061M-NZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:09:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iedOU-000615-KA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575976169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF2EAoRnH7Zk6En+wnujpU0WtI9JqWpxOzHgsFlWBFA=;
 b=FN2jT5eQm0cWmXD1EsSqYhopYna1oK/mfr+oX8Lz3DSMqOYhw5SU+hCoIYeAYQMcdx1V/v
 moUg0cm5mNQDrsz685GsSVFVGJGHTnxFWEatFHf5lpFEpQAvzKzLewynGBFfHai758vrmQ
 XSNmdZec4lbJgug6+DhAl+b72JUQDD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-h2320vPUOPK4eUb88tlFsA-1; Tue, 10 Dec 2019 06:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8AB018A6EC0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:09:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D0F95D9D6;
 Tue, 10 Dec 2019 11:09:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0FA511386A7; Tue, 10 Dec 2019 12:09:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] net: Drop the NetLegacy structure,
 always use Netdev instead
References: <20191206053640.29368-1-thuth@redhat.com>
 <20191206053640.29368-3-thuth@redhat.com>
Date: Tue, 10 Dec 2019 12:09:23 +0100
In-Reply-To: <20191206053640.29368-3-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 6 Dec 2019 06:36:40 +0100")
Message-ID: <874ky8309o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: h2320vPUOPK4eUb88tlFsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> Now that the "name" parameter is gone, there is hardly any difference
> between NetLegacy and Netdev anymore. Drop NetLegacy and always use
> Netdev to simplify the code quite a bit.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Took me a minute to see the actual difference.

Here's Netdev:

    { 'union': 'Netdev',
      'base': { 'id': 'str', 'type': 'NetClientDriver' },
      'discriminator': 'type',
      'data': {
        'nic':      'NetLegacyNicOptions',
        'user':     'NetdevUserOptions',
        'tap':      'NetdevTapOptions',
        'l2tpv3':   'NetdevL2TPv3Options',
        'socket':   'NetdevSocketOptions',
        'vde':      'NetdevVdeOptions',
        'bridge':   'NetdevBridgeOptions',
        'hubport':  'NetdevHubPortOptions',
        'netmap':   'NetdevNetmapOptions',
        'vhost-user': 'NetdevVhostUserOptions' } }

    { 'enum': 'NetClientDriver',
      'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
                'bridge', 'hubport', 'netmap', 'vhost-user' ] }

Here's NetLegacy:

    { 'struct': 'NetLegacy',
      'data': {
        '*id':   'str',
        'opts':  'NetLegacyOptions' } }

    { 'union': 'NetLegacyOptions',
      'base': { 'type': 'NetLegacyOptionsType' },
      'discriminator': 'type',
      'data': {
        'nic':      'NetLegacyNicOptions',
        'user':     'NetdevUserOptions',
        'tap':      'NetdevTapOptions',
        'l2tpv3':   'NetdevL2TPv3Options',
        'socket':   'NetdevSocketOptions',
        'vde':      'NetdevVdeOptions',
        'bridge':   'NetdevBridgeOptions',
        'netmap':   'NetdevNetmapOptions',
        'vhost-user': 'NetdevVhostUserOptions' } }

    { 'enum': 'NetLegacyOptionsType',
      'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
               'bridge', 'netmap', 'vhost-user'] }

Difference: NetLegacy wraps the union in @opts.


