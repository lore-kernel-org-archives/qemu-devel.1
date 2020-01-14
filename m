Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440AC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA902187F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLmvJNSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA902187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRCl-0007dJ-3v
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irRBu-0006nM-Bc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irRBr-0006hz-0N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:45:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irRBq-0006hP-SZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579027522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKpunJze+C9cZvOhKsQI06tomFmhPa6nzDdjGaFsKqY=;
 b=NLmvJNSKjofsE/vRGyql9AVgPcuC6qDUgBuZdgBoZbKKb0jGtsvVCvxP/Po27Jdr96nIOB
 RKkQtnjqdecB6AScG//GmSU/h99LMVn1O1GpkT9TsBDAqwpAfQsXLOcg8GXUhkjIo0l/EH
 MGHP7axtoVULiKB6BCxE+e5dI7GZDrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-8oWsMM--ORudGQW5sVBycw-1; Tue, 14 Jan 2020 13:45:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FBFB10054E3;
 Tue, 14 Jan 2020 18:45:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A22F060C18;
 Tue, 14 Jan 2020 18:45:11 +0000 (UTC)
Date: Tue, 14 Jan 2020 18:45:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 0/4] qmp: Optionally run handlers in coroutines
Message-ID: <20200114184508.GT4071034@redhat.com>
References: <20200114182735.5553-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114182735.5553-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8oWsMM--ORudGQW5sVBycw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 07:27:31PM +0100, Kevin Wolf wrote:
> Some QMP command handlers can block the main loop for a relatively long
> time, for example because they perform some I/O. This is quite nasty.
> Allowing such handlers to run in a coroutine where they can yield (and
> therefore release the BQL) while waiting for an event such as I/O
> completion solves the problem.

Am I right that with this approach, there's no functional difference
to QMP from a mgmt app POV ? ie this is purely focused on avoiding
stalls in the main event loop which impact the guest OS and other
parts of QEMU ?

IOW, the response to the QMP command being executed will get sent
back to the mgmt app as normal when the command completes, and the
QMP monitor still serializes execution of commands ?

> This series adds the infrastructure to allow this and switches
> block_resize to run in a coroutine as a first example.
>=20
> This is an alternative solution to Marc-Andr=C3=A9's "monitor: add
> asynchronous command type" series.

Where as this is an actual functional improvement to QMP from
the mgmt app POV in allowing background commands & thus
concurrent execution ?

If this is correct, then the two proposals are somewhat
complementary=20

>=20
> v2:
> - Fix typo in a commit message [Eric]
> - Use hyphen instead of underscore for the test command [Eric]
> - Mark qmp_block_resize() as coroutine_fn [Stefan]
>=20
>=20
> Kevin Wolf (4):
>   qapi: Add a 'coroutine' flag for commands
>   vl: Initialise main loop earlier
>   qmp: Move dispatcher to a coroutine
>   block: Mark 'block_resize' as coroutine
>=20
>  qapi/block-core.json                    |  3 +-
>  tests/qapi-schema/qapi-schema-test.json |  1 +
>  docs/devel/qapi-code-gen.txt            |  4 ++
>  include/qapi/qmp/dispatch.h             |  3 +
>  monitor/monitor-internal.h              |  5 +-
>  blockdev.c                              |  6 +-
>  monitor/monitor.c                       | 24 ++++---
>  monitor/qmp.c                           | 83 ++++++++++++++++---------
>  qapi/qmp-dispatch.c                     | 38 ++++++++++-
>  tests/test-qmp-cmds.c                   |  4 ++
>  vl.c                                    | 10 +--
>  scripts/qapi/commands.py                | 17 +++--
>  scripts/qapi/doc.py                     |  2 +-
>  scripts/qapi/expr.py                    |  4 +-
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  |  9 ++-
>  tests/qapi-schema/qapi-schema-test.out  |  2 +
>  tests/qapi-schema/test-qapi.py          |  7 ++-
>  18 files changed, 158 insertions(+), 66 deletions(-)
>=20
> --=20
> 2.20.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


