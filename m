Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E32C11D20
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F0920801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="0G0UsF0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F0920801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4tM6-0000DE-8B
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 16:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j4tJK-0007WN-G4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j4tJJ-0003bv-8I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:24:42 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j4tJI-0003at-Oy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:24:41 -0500
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 2FAC096EF0;
 Thu, 20 Feb 2020 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582233878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2+GvqGgc0KF8tC4g5IqXNm00U4cG1gjzvVSOGO/rJk=;
 b=0G0UsF0J3UFloF2ZvQnpv+Acqfg4TQ7XJ4GWBL5nSXn/w56fG7KccBBpOn+b0VTipwMGb5
 4nSaQ+OUHTZVPVh+cfTtobFV+NhlXmgu+zgRXbLKyl1PcAhXOI9ZbvY1waMwKn1nzTWS3x
 pqTtzfZYQbgllYRYU8EjjogU8OhiNA8=
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: Changbin Du <changbin.du@gmail.com>, alex.bennee@linaro.org,
 philmd@redhat.com
References: <20200220155834.21905-1-changbin.du@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
Date: Thu, 20 Feb 2020 22:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220155834.21905-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582233878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2+GvqGgc0KF8tC4g5IqXNm00U4cG1gjzvVSOGO/rJk=;
 b=ZcbEvze2stqntpqjfLubrXJoSeWgfmah2NYJVZoka1OTycf7kLKVV7Fu5nahcXK6zMQo/5
 PtNb92rpELgUMD5MoA5MRE253cNUhSM1gAJzesHveXYRnycJhjnmcYFbd3vvu9HNiivUOq
 Q8WDNsvd0paGNlZM5cRQRuQC9vlr5/w=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582233878; a=rsa-sha256; cv=none;
 b=HEL4p1dejSyLnFQJqigSto0KlHvWcqqpWAJHOfK47oj+DDN+oL3VXVS7+aW/Pe8xjO3xj4
 RYtQybQQWTb1s9VtZZn5neCBB9lOsVrRzAYUvgNszp55VcTfWGK3bXw+jOnMnNYHruaWyn
 tcYx+6MhUOttkx7kQ9EgSBjmMimeEDc=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 2/20/20 4:58 PM, Changbin Du wrote:
> Recently when debugging an arm32 system on qemu, I found sometimes the
> single-step command (stepi) is not working. This can be reproduced by
> below steps:
>  1) start qemu-system-arm -s -S .. and wait for gdb connection.
>  2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>     (0x60) for PC.
>  3) After connected, type 'stepi' and expect it will stop at next ins.
>=20
> But, it has never stopped. This because:
>  1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature to gdb e=
xplicitly and gdb
>     think we do not support it. In this case, gdb use a software breakp=
oint
>     to emulate single-step.
>  2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>     breakpoint to wrong place (PC+4).
>=20
> Since we do support =E2=80=98vContSupported=E2=80=99 query command, so =
let's tell gdb that
> we support it.
>=20
> Before this change, gdb send below 'Z0' packet to implement single-step=
:
> gdb_handle_packet: Z0,4,4
>=20
> After this change, gdb send "vCont;s.." which is expected:
> gdb_handle_packet: vCont?
> put_packet: vCont;c;C;s;S
> gdb_handle_packet: vCont;s:p1.1;c:p1.-1
I'm curious, I never experienced this behaviour from GDB. What GDB and
QEMU versions are you using?

On my side (GDB 9.1), even without 'vContSupported+' in the 'qSupported'
answer, GDB sends a 'vCont?' packet on the first stepi:

0x00000000 in ?? ()
(gdb) si
Sending packet: $m0,4#fd...Ack
Packet received: 00000000
Sending packet: $vCont?#49...Ack
Packet received: vCont;c;C;s;S
Packet vCont (verbose-resume) is supported
Sending packet: $vCont;s:p1.1;c:p1.-1#f7...Ack
Packet received: T05thread:p01.01;

Your second issue (wrong PC value) should be investigated though. Does
it happen on QEMU vanilla? Do you have a way to reproduce this bug?

Anyway after re-reading the GDB remote protocol documentation, I think
your patch is right, the feature should be advertised.

However I think your commit message needs some modifications. This fix
is not specific to ARM or TCG, but to the gdbstub itself. You also
mention this bug you have with PC, which is not related to the bug you
are fixing here. Could you rewrite it in a more generic way? You simply
need to emphasis the effect of advertising the 'vContSupported+' feature
on GDB.

Thanks.

--=20
Luc

