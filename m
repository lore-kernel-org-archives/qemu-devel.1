Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A715C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0586221882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcRJWjuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0586221882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6Pq-0007gl-U8
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT6JI-0007b9-Sp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT6JH-0006V4-PN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT6JH-0006Ur-Lw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g++Exd2DWJ1NcfVD1rs7GQslVMB/MVUHEm3VTU7xIpo=;
 b=NcRJWjuIrZd1Gm3mcD+EJVv4XtRDgwmjGisXHvMGi56Fw2ef1AOi9vAKddQKrjtRoKUMxC
 2kE+HIFpTpMXmG7GDgtQOEw8KNF9jWwlsUVtvTksrnOZ1b3O+EIiZbPzF69hmiEK0AqLPj
 zWDgy1ihVldpBgsEho4ed7V2yM/Y2jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-YkkxOV1wMeCN1ijhqhDf-w-1; Fri, 08 Nov 2019 10:36:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D4F1005500;
 Fri,  8 Nov 2019 15:36:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD193CC6;
 Fri,  8 Nov 2019 15:36:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5884611385C9; Fri,  8 Nov 2019 16:36:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
Date: Fri, 08 Nov 2019 16:36:21 +0100
In-Reply-To: <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com> (Max Reitz's
 message of "Wed, 6 Nov 2019 13:51:42 +0100")
Message-ID: <87d0e2753e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YkkxOV1wMeCN1ijhqhDf-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 17.10.19 15:01, Kevin Wolf wrote:
>> Add a --nbd-server option to qemu-storage-daemon to start the built-in
>> NBD server right away. It maps the arguments for nbd-server-start to the
>> command line.
>
> Well, it doesn=E2=80=99t quite, because nbd-server-start takes a
> SocketAddressLegacy, and this takes a SocketAddress.
>
> On one hand I can understand why you would do it differently (especially
> for command-line options), but on the other I find it a bit problematic
> to have --nbd-server be slightly different from nbd-server-start when
> both are intended to be the same.
>
> My biggest problem though lies in the duplication in the QAPI schema.
> If NbdServerOptions.addr were a SocketAddressLegacy, we could let
> nbd-server-start=E2=80=99s options just be of type NbdServerOptions and t=
hus get
> rid of the duplication.
>
> I suspect in practice it=E2=80=99s all not that big of a problem.  I can=
=E2=80=99t call
> it bad if --nbd-server is just nicer to use.  And the biggest problem
> with duplication in the QAPI schema is that nbd-server-start and
> --nbd-server might get out of sync.  But realistically, I don=E2=80=99t s=
ee that
> happen, because if nbd-server-start changes, nbd_server_start() will
> change, too, so we=E2=80=99ll get compile errors in nbd_server_start_opti=
ons().
>
> *shrug*

Two good reasons for making new --nbd-server differ from existing
nbd-server-start:

1. The nesting sucks.  The CLI's dotted key syntax makes it suck harder.

2. New interfaces should not use SocketAddressLegacy (or any other
   "simple" union) if we can help it.

The duplication is the price we pay for getting it right om the second
try.

> But I do think the commit message should explain why we can=E2=80=99t jus=
t use
> NbdServerOptions for nbd-server-start.

Yes, and throw in a comment.


