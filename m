Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1300FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E0220659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItoV6Wy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E0220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTqY-0008Ul-Tp
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iMTps-0007zO-Lo
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iMTpr-0000Fe-Jl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:18:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iMTpr-0000ET-GU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571649522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1prtWWg/gW2Ft7nhMSZ17UpT3r0phABSOyHOHdriSk=;
 b=ItoV6Wy6f36zTRD0oJxWdlM8Sd+ccULykHcFTOB3TTK1LL4wm47IqTksArSuEz7czN2uzP
 PwpNgXtZLD7BlFX5l5BBSz9ihWf/jhw0h56JdU7F3RqoeIf7qmRO/xHKzbBUZCzS7yoFFf
 asbYFZAAPUXMdbUbam3VUMXTO/dFLVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-api5LrJFMzK1tbdknMyIAA-1; Mon, 21 Oct 2019 05:18:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422D3800D49;
 Mon, 21 Oct 2019 09:18:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC771001B09;
 Mon, 21 Oct 2019 09:18:30 +0000 (UTC)
Date: Mon, 21 Oct 2019 11:18:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
Message-ID: <20191021111828.157ff2b7@redhat.com>
In-Reply-To: <0eed7c18-8758-8f70-7b48-0d9c86ec929a@redhat.com>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <0eed7c18-8758-8f70-7b48-0d9c86ec929a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: api5LrJFMzK1tbdknMyIAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, rth@twiddle.net,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 10:59:56 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 10/8/19 1:33 PM, Igor Mammedov wrote:
> > Series cleans up remaining boards that call memory_region_allocate_syst=
em_memory()
> > multiple times, violating interface contract (the function should be ca=
lled only
> > once).
> >=20
> > With that cleaned up, it should be possible to switch from adhoc RAM al=
location
> > in memory_region_allocate_system_memory()->allocate_system_memory_nonnu=
ma() to
> > memory-backend based allocation, remaining roadblock for doing it is de=
precated
> > -mem-path fallback to RAM allocation, which is scheduled for removal at=
 4.3
> > merge window. So remaining patches to consolidate system RAM allocation=
 around
> > memory-backends and aliasing -mem-path/mem-prealloc to it are postponed=
 till
> > then.
> >=20
> >=20
> > Igor Mammedov (3):
> >    sparc64: use memory_region_allocate_system_memory() only for '-m'
> >      specified RAM
> >    ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
> >    hppa: drop usage of memory_region_allocate_system_memory() for ROM
> >=20
> >   hw/hppa/machine.c    |  5 ++---
> >   hw/ppc/rs6000_mc.c   | 15 ++++++++++-----
> >   hw/sparc64/niagara.c | 25 +++++++++++++------------ =20
>=20
> What about the TYPE_SUN4M_MEMORY device in hw/sparc/sun4m.c?

it has only one call site so it's not issue this series targets.
I'll take care of it in follow up series, which will deal with
converting memory_region_allocate_system_memory() to memdev only
(probably I'll drop TYPE_SUN4M_MEMORY altogether)


>=20


