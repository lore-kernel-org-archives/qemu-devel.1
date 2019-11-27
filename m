Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB452C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F7820678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaKpm57I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F7820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxo6-0004sw-He
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZxOZ-00084i-SP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZxOW-0002Ja-Ik
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:30:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZxOW-0002IO-C2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574861411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZK0XOslouvF5HEpS4461vlrGpaYW4j4y6dIL3Dhr3k=;
 b=aaKpm57INgQqx4Jy0WFHCJ3PE3wRLGBGN5EwCFxrVjTLexf7KIYjYT0v0hzpes3YDhaO6y
 6LbEtVR5OsWz5S3ohoiNPQ3SQmZvtRbpWFNvEMrBSSInK1U876hE/yeeWEwKWqYzNMCn15
 P4sutOpx5yz6DOA67HBjkjrMEQVHNgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-7cT-mr9TPkeJ6WpsCUVZ9A-1; Wed, 27 Nov 2019 08:30:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F7F107B768;
 Wed, 27 Nov 2019 13:30:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FA6D5D9D6;
 Wed, 27 Nov 2019 13:30:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2DC41138606; Wed, 27 Nov 2019 14:30:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Kirillov <lekiravi@yandex-team.ru>
Subject: Re: QMP netdev_add multiple dnssearch values
References: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
 <87d0elmmdt.fsf@dusky.pond.sub.org>
 <2137591572344429@sas1-eb34c5849710.qloud-c.yandex.net>
Date: Wed, 27 Nov 2019 14:30:06 +0100
In-Reply-To: <2137591572344429@sas1-eb34c5849710.qloud-c.yandex.net> (Alex
 Kirillov's message of "Tue, 29 Oct 2019 13:20:39 +0300")
Message-ID: <87zhgha1lt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7cT-mr9TPkeJ6WpsCUVZ9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Kirillov <lekiravi@yandex-team.ru> writes:

>> What exactly goes wrong? Does the QMP command fail? Does it succeed
>> but the network backend incorrectly?
>
> QMP command succesfully creates Slirp backend, but ignore whole arguments=
:
> - `dnssearch`
> - `hostfwd`
> - `guestfwd`

You're right, QMP command netdev_add silently ignores arguments that
aren't string, number, or bool, i.e. exactly the three you quoted.  Has
always been that way, as far as I can tell.

> As example, `dnssearch` field of `NetdevUserOptions` goes straight to the=
 function `slirp_dnssearch` (net/slirp.c), where it converts to `char **`. =
But at this moment, this parameter is simply NULL, when I pass something di=
fferrent from simple string.
>
> This is very strange, because type of this parameters is `StringList` and=
 must require something like [{"str": "a"}, {"str": "b"}].

During our push to get QMP feature-complete, we took some shortcuts.
One of them is qmp_netdev_add().

Objective back then : provide a QMP command for the existing netdev
configuration machinery net_client_init().  Due to its roots in CLI,
net_client_init() takes a QemuOpts.

Proper solution: define a QAPI schema, rewrite net_client_init() to take
the resulting QAPI type instead of QemuOpts, make existing users convert
from QemuOpts to the QAPI type, have qmp_netdev_add() take the QAPI type
as argument, and pass it to net_client_init().  Too much work.

Shortcut: use 'gen': false to bypass generated marshaling, marshal by
hand into a QemuOpts, so we can call unmodified net_client_init().  That
became commit 928059a37b "qapi: convert netdev_add".

The "marshal by hand into a QemuOpts" uses qemu_opts_from_qdict(), which
goes back to similarly shortcut QMP command device_add:

    commit 01e7f18869c9ee4c84793f4a39ec1f5f4128a0aa
    Author: Markus Armbruster <armbru@redhat.com>
    Date:   Wed Feb 10 20:15:29 2010 +0100

        qemu-option: Functions to convert to/from QDict

        The functions are somewhat restricted.  Good enough for the job at
        hand.  We'll extend them when we need more.

"Good enough" was true back then.  It wasn't true when we reused it for
netdev_add: hostfwd and guestfwd are list-valued.

We did define a QAPI schema a few months later (14aa0c2de0 "qapi schema:
add Netdev types").  net_client_init() uses it to convert from QemuOpts
to QAPI type Netdev.  This took us to the crazy pipeline we still use
today:

                            CLI, HMP
                        (key=3Dvalue,...)
                               |
                               v
    QMP (JSON) -> QDict -> QemuOpts -> Netdev

We should instead use:

                          CLI, HMP
                      (key=3Dvalue,...)
                             |
                             v
                          QemuOpts
                             |
                             v
    QMP (JSON) -> QDict -> Netdev

Back in 2016, Eric (cc'ed) posted patches to get us to this pipeline.
They got stuck on backward compatibility worries: the old code accepts
all parameters as JSON strings in addition to their proper type, the new
code doesn't.  Undocumented misfeature, but we chickened out anyway.

Let's reconsider.  Eric's patches break interface misuse that may or may
not exist in the field.  They fix a correct use of interface people want
to use (or Alex wouldn't have reported this bug), and they make QMP
introspection work for netdev_add.

Eric, what do you think?


