Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65310C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3395921582
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ND8ppR1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3395921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbSS-0002od-Ti
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVbR4-0001qF-LE
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:47:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVbR3-0001sV-DS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588600024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVzoYTBkpuEMtiIwn43tdSK1RfQId169JP0YYdSF+ss=;
 b=ND8ppR1+KdOZ5x7vbM3eWdzNGg7rVH4H+gQ/tMQyAfRSCUE19F8RUoxg9pjpa3OcsIBhBi
 o1WufB8/6G0fHjJpoUlJEZgJk7DaqNlFmxi89+f8KiW/PtaEZG7wzWAKjug5s4KFx19C3v
 vUYUg1JvOj/Kme0C0z1Om8hiVJv2SUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-nxwJxhQeOOyjIBgZRrPxnA-1; Mon, 04 May 2020 09:47:00 -0400
X-MC-Unique: nxwJxhQeOOyjIBgZRrPxnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 612B0100A61E;
 Mon,  4 May 2020 13:46:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6600310013D9;
 Mon,  4 May 2020 13:46:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3553D17477; Mon,  4 May 2020 15:46:52 +0200 (CEST)
Date: Mon, 4 May 2020 15:46:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 15/15] acpi: simplify build_isa_devices_aml()
Message-ID: <20200504134652.fdyxndske6u5f4yy@sirius.home.kraxel.org>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-16-kraxel@redhat.com>
 <64d04e82-c516-c85d-be6a-19a1eb9b8c1f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <64d04e82-c516-c85d-be6a-19a1eb9b8c1f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 08:48:31AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing IPMI maintainer.
>=20
> On 4/29/20 4:00 PM, Gerd Hoffmann wrote:
> > x86 machines can have a single ISA bus only.
>=20
> I disagree with the comment.
> Machines can have multiple ISA bus.

Note *x86* machines.  Given x86 has a global io address space I still
think this is true.

On some !x86 archs where a mmio window on the bridge is used for the io
address space multiple isa busses are possible.  I'm not sure whenever
this is purely theoretical or whenever such machines exist in practice
and in case of the latter whenever qemu can emulate one.

> >   hw/i386/acpi-build.c | 15 +++++----------
         ^^^^
But in any case !x86 doesn't matter here ;)

take care,
  Gerd


