Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793BCC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454D220716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITyutuMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454D220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOmH-000064-EZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCOlX-0007Nv-FS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCOlW-0000Hu-5x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:24:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCOlW-0000Go-2b
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584023089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbZoVTcHQAQqonGG8sHUAE9VwF/9TwX3MkH6fa2Qjxg=;
 b=ITyutuMQDVN0ExjVVLvbVBppz1ObmjezmhZjvnyCEOodlE7oZCjB0XV4uDQn3pjVkXl89k
 d4LVHoF33oOiZdZQ2x4SEuJ3JrLegkfRgl4lWXb332DkT4PgdLMMvf5k97lJriFCAgtiuY
 9kn8/Ak90ltf5Q6VQZJRDCMNb62NZaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-hq-5C0cRNVyDq_aQfYvHuA-1; Thu, 12 Mar 2020 10:24:39 -0400
X-MC-Unique: hq-5C0cRNVyDq_aQfYvHuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC3E19251A3;
 Thu, 12 Mar 2020 14:24:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EE290795;
 Thu, 12 Mar 2020 14:24:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33EDB11386A6; Thu, 12 Mar 2020 15:24:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 00/10] error: auto propagated local_err part I
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
Date: Thu, 12 Mar 2020 15:24:30 +0100
In-Reply-To: <20200312085936.9552-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 12 Mar 2020 11:59:26 +0300")
Message-ID: <87y2s5ps69.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> v9
> 01: A lot of rewordings [thanks to Eric]
>     Still, keep all r-b marks, assuming that they are mostly about macro =
definition
> 02: significant changes are:
>     1. Do not match double propagation pattern in ERRP_AUTO_PROPAGATE-add=
ing rule
>     2. Introduce errp->____->errp scheme to match only functions matched =
by rule1
>        in rules inherited from rule1
>     3. Add rules to warn about unusual patterns
>
>     Also, add line to MAINTAINERS to keep error related coccinelle script=
s under
>     Error section.
> 07: add Christian's r-b
> 09: add Eric's r-b
> 10: a bit of context in xen_block_iothread_create  and qmp_object_add()
>     signature are changed. Patch change is obvious, so I keep Paul's r-b
>
> v9 is available at
>  https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-p=
artI-v9

Did you forget to push the tag?

> v8 is available at
>  https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-p=
artI-v8
[...]


