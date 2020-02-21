Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C1C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68983208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 06:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="at0MQCKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68983208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j51rW-00071E-Ji
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 01:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j51qI-0006Ys-F9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j51qG-0005jr-O3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:31:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j51qG-0005fv-EI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 01:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582266675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bejW9W78OuIHRx0tVUTMDFA33x2UKfUN6LOoW6YpgF8=;
 b=at0MQCKMscBhk80WaCshIvXu8kOrL/YiyPkrmV50ijtxUF7wtAVWz/yja0m2jF06OoukF1
 6cNue5T9ZrJBQ4C/o0QTOBDx6rYnzm8nkTtrJMaGDvkorBmvhD1yvJlzJLLM6thaL2TRGo
 fGATncJw4GdZE6IW1ly2T97mW3Q8SR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-RVHNvhNfM2uvDNjuMP19vQ-1; Fri, 21 Feb 2020 01:31:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED882801E66;
 Fri, 21 Feb 2020 06:31:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54FB060BE0;
 Fri, 21 Feb 2020 06:31:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C440611386A6; Fri, 21 Feb 2020 07:31:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org> <20200220201155.GJ2836@work-vm>
Date: Fri, 21 Feb 2020 07:31:06 +0100
In-Reply-To: <20200220201155.GJ2836@work-vm> (David Alan Gilbert's message of
 "Thu, 20 Feb 2020 20:11:55 +0000")
Message-ID: <87k14ga1ud.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RVHNvhNfM2uvDNjuMP19vQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
[...]
>> Collecting several users before building infrastructure makes sense when
>> the design of the infrastructure isn't obvious, or when the need for it
>> is in doubt.
>>=20
>> Neither is the case for running QMP handlers in a coroutine: QMP
>> commands blocking the main loop is without doubt a problem we need to
>> solve, and the way to solve it was obvious enough for Kevin to do it
>> with one user: block_resize.  A second one quickly followed: screendump.
>>=20
>> The only part that's different for HMP, I think, is "need".
>>=20
>> Is HMP blocking the main loop a problem?
>>=20
>> If yes, is it serious enough to justify solving it?
>
> I don't mind if HMP blocks for a small time while doing something, but
> not if it can hang if the guest (or something else like it) misbehaves.
> Not if it's something you might need to issue another command to recover
> from.

The issue isn't HMP being unavailable while a command executes.  The
issue is HMP stopping the main loop while a command executes.

Stopping the main loop not only stops everything running there, it can
also stop other threads when they synchronize with the main loop via the
Big QEMU Lock.

The obvious example is a command accessing a remote filesystem.  Special
case: NFS with the hard option can hang indefinitely.

screendump does that, and also waits for asynchronous gfx_update() with
qxl devices.  Networking again, with a different peer.

We already decided that QMP commands stopping the main loop is serious.

To say it's not serious for HMP amounts to "don't do that then, use
QMP".  Which may be fair.  Not for me to decide, though.


