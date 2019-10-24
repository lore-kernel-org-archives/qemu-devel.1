Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2FCA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D814205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGuTgAV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D814205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNi4D-0000ar-7q
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNhWJ-0000sy-HG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNhWI-0007U6-5Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:07:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNhWH-0007Tu-VT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571940453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2PPNX5o6DQx8MjKGNnV43vBz7WlAxsKDOo/3ug5My0=;
 b=JGuTgAV1E+B7FRcpMrjbxnEdF5uf2pmBV5gXxqOSAhU/LbZCHVQA6O1tILPKIGOUrKjJHZ
 i69VIss31ktTJ0oEJclq045GK3A4KyZ9TsmuGs0pzQVwaX3SpPg0TTJSCv9XtjUR/wp797
 xdhmWLU2CHbD1ljXnn4ZnaKTzVGwJQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ITKloSrzNOmZN23P_rHAtQ-1; Thu, 24 Oct 2019 14:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47855100550E;
 Thu, 24 Oct 2019 18:07:26 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC3D4128;
 Thu, 24 Oct 2019 18:07:15 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:07:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
Message-ID: <20191024180714.GY6744@habkost.net>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
 <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
 <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
 <CAFEAcA_A4edo3fQBJux6QBxkCf_r_EdrmYgv5OPidWDdn4aD8g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_A4edo3fQBJux6QBxkCf_r_EdrmYgv5OPidWDdn4aD8g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ITKloSrzNOmZN23P_rHAtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Corey Minyard <cminyard@mvista.com>, Paul Burton <pburton@wavecomp.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 12:52:28PM +0100, Peter Maydell wrote:
> On Thu, 24 Oct 2019 at 12:48, Philippe Mathieu-Daud=E9 <philmd@redhat.com=
> wrote:
> > Just wondering, if we had a "bus_address" property to the abstract
> > SysBus class (and eventually "bus_name" for later) we could create/map
> > sysbus devices from command line?
>=20
> I don't think this is a good plan -- users shouldn't have to know
> about the memory map of their boards. Plus it doesn't deal with
> the complications of multiple address spaces, DMA, wiring up
> irq lines to an interrupt controller, SoC reset handling,
> clocks, power-managment...  Command line -device was designed
> for pluggable devices, where in the world of real hardware
> the device can be physically plugged and unplugged and there's
> a clear interface that can be modelled. You can't add an
> extra UART to an embedded board in real hardware either.
>=20
> The only plausible argument I've seen for command-line
> plugging of embedded devices is as a sort of side-effect
> of having a configuration language syntax for them for
> the purpose of being able to write board models as
> data-driven config files rather than in C code. But
> that would be a lot of design and engineering work, and
> if we want that I think we should approach it forwards,
> not arrive at it backwards by adding gradual tweaks like
> 'address' properties to devices.

The QEMU community spent years designing QOM and QMP with that
goal.  Which other pieces to you consider to be missing, to
make you reject making gradual changes towards it?

I agree we shouldn't be introducing new external interfaces
without careful thought.  But I welcome gradual internal API
changes that are helpful for our long term goals.

--=20
Eduardo


