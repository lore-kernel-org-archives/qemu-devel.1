Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8153DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B18D2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4wk6LOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B18D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqAB-00029T-UE
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDoy8-0000U9-KQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDoy7-0007OR-FR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:35:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDoy7-0007Ik-8J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwGbThKUayZFmTsEgOSli9T1zKZzRE8pFg9snwazUkk=;
 b=C4wk6LOHBL643Br33Jr1UMxkucsljg7AkD/LEEQxDKd8oM6d5MZul3ZabXUx8mMBW/jS9b
 /nlz4FevqFX2TbJmPU+qsFN/teNzHW3Rk3cZm58nxv0conVuxNsZVr1HXn2VwnSzvpV8GF
 N+iJe7J7CL9iDiZyx9fInX/Ug1/ah9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-aM25U8FNP1CrgSwCFkqf8A-1; Mon, 16 Mar 2020 08:35:40 -0400
X-MC-Unique: aM25U8FNP1CrgSwCFkqf8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EACB9DB67;
 Mon, 16 Mar 2020 12:35:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D4410027A7;
 Mon, 16 Mar 2020 12:35:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 129841138404; Mon, 16 Mar 2020 13:35:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] net: Complete qapi-fication of netdev_add
References: <20200312211440.3767626-1-eblake@redhat.com>
 <877dznewyh.fsf@dusky.pond.sub.org>
Date: Mon, 16 Mar 2020 13:35:38 +0100
In-Reply-To: <877dznewyh.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 13 Mar 2020 23:01:10 +0100")
Message-ID: <87o8swiijp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: lekiravi@yandex-team.ru, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> We better check all other uses of option group "netdev".

To the best of my grepping abilities:

=3D Definition =3D

* qemu_netdev_opts

  Option group definition, with empty .desc[].

=3D CLI =3D

Keep in mind: we finish processing CLI netdev before we start monitors
(we call net_init_clients() is mon_init_func()).  Monitor commands can
mess with CLI netdevs, but CLI cannot mess with monitor netdevs.

* main()

  - case QEMU_OPTION_netdev

    Straighforward parse of option argument; record in
    @qemu_netdev_opts.

  - case QEMU_OPTION_readconfig

    Similar.

  - case QEMU_OPTION_writeconfig

    "Unparse" of @qemu_netdev_opts.  Can contains only CLI netdevs.

* net_init_clients()

  Pass the CLI netdevs to net_client_init().

=3D Monitor =3D

* hmp_netdev_add()

  Straighforward parse of command argument (record in
  @qemu_netdev_opts), pass to net_client_init() via netdev_add().

* qmp_netdev_add()

  Before your patch: convert from JSON to QemuOpts (record in
  @qemu_netdev_opts), pass to net_client_init() via netdev_add().

  Note: net_client_init() converts QemuOpts to QAPI type Netdev, and
  passes that to net_client_init1().

  Afterwards: convert JSON straight to Netdev, pass to
  net_client_init1().  Also create in @qemu_netdev_opts, but empty apart
  from ID.

* qmp_netdev_del()
* netdev_del_completion()

  Both implement a "NetClientState is a netdev" predicate by checking
  "@qemu_netdev_opts has an entry with this name".

Looks like the only thing we do with the QemuOpts recorded in
@qemu_netdev_opts is checking existence.  Your patch preserves that.  I
doesn't preserve the option parameters, but they are not used.  Okay.

The correctness argument becomes simpler if we implement the "is a
netdev" predicate without @qemu_netdev_opts.  Could be done either
before or after this patch.


