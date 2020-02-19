Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A2C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A2C24654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHHFGgyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A2C24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RH9-0006lA-1l
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j4RGV-0006Ad-JI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j4RGU-0005yh-It
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:27:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j4RGU-0005xn-Ex
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582126073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftjywyc6TCGCrRJ2Lh02LFvU19nfwk5sfberfuhlBcQ=;
 b=XHHFGgyljRR0Az4pcQbo9vFdkON1yid/yCuVcmoqebJLMY3y4/hWZzZeCqR8bCXiP+4WpG
 n18o1CIFFYvucmug0DThOZMu/Php+JH3f1hzJMebWRhIagiBg9fAjxkQvkqAkMbJ69T+WF
 kfPuKytr1P//FKv3iOAFUWjf6YPZbJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Bm0JD066PtuMed1k_x_9wg-1; Wed, 19 Feb 2020 10:27:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FF818FF660;
 Wed, 19 Feb 2020 15:27:49 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C837119757;
 Wed, 19 Feb 2020 15:27:45 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:27:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200219152744.GC6464@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
 <87lfp1sc8d.fsf@dusky.pond.sub.org>
 <20200217123454.GF6309@linux.fritz.box>
 <87r1ysc7d4.fsf@dusky.pond.sub.org>
 <20200218152931.GG6157@linux.fritz.box>
 <87tv3nt0cu.fsf@dusky.pond.sub.org>
 <20200219102226.GA6464@linux.fritz.box>
 <8736b6r729.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <8736b6r729.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Bm0JD066PtuMed1k_x_9wg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.02.2020 um 15:21 hat Markus Armbruster geschrieben:
> I think we need to talk about AioContext in qapi-code-gen.txt.  PATCH 1
> now adds
>=20
>   Member 'coroutine' tells the QMP dispatcher whether the command handler
>   is safe to be run in a coroutine.  It defaults to false.  If it is true=
,
>   the command handler is called from coroutine context and may yield whil=
e
>   waiting for an external event (such as I/O completion) in order to avoi=
d
>   blocking the guest and other background operations.
>  =20
> What about "is called from a coroutine running in the main loop with
> @qemu_aio_context, and may yield"?
>=20
> Likewise for the commit message of PATCH 3:
>=20
>   This moves the QMP dispatcher to a coroutine and runs all QMP command
>   handlers that declare 'coroutine': true in coroutine context so they
>   can avoid blocking the main loop while doing I/O or waiting for other
>   events.
>=20
> "calls all ... in a coroutine running in the main loop with
> @qemu_aio_context, so they can".
>=20
> Speaking of PATCH 1:
>=20
>   It is an error to specify both 'coroutine': true and 'allow-oob': true
>   for a command.  (We don't currently have a use case for both together a=
nd
>   without a use case, it's not entirely clear what the semantics should b=
e.)
>=20
> Let's lose the parenthesis around the last sentence.
>=20
> If you agree with my proposed tweaks, and nothing else comes up, I can
> try to do them in my tree.

Works for me.

In the v5 thread, dropping patch 2 came up. I think it may not be needed
any more in the current version and 'make check' passes without it.

Kevin


