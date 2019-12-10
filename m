Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2135C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A24D2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew+48KF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A24D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecvr-0005JR-RE
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iecvE-0004ri-L6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iecvD-0008Oo-J3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:39:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iecvD-0008Oj-FW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575974355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJsB9pB2rjZe/8jduF68g74eugxbDVXXq6nQZymeRIc=;
 b=Ew+48KF/UV+TyrIHQFzjIKvctKbsG9K9OYxYDTUQdF/DBgtVgQ/tiTXGyyP7XmPV9ns59j
 DrpjLoe1P/M28JcX7Jnf3fld9kA9X95IemVtLGZwTeWho2bmBYolCdOhs23Z7+r9KJfAQv
 +266077zg+gptbfABwVUKVGQwU1zn/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-qdhaR8PVOImSaICF1bdhEw-1; Tue, 10 Dec 2019 05:39:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9771D18C35A3;
 Tue, 10 Dec 2019 10:39:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96965D72A;
 Tue, 10 Dec 2019 10:39:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0CDB11386A7; Tue, 10 Dec 2019 11:39:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH v2 1/3] cpu: Introduce CPUReset callback typedef
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <157591411864.46967.18244018296239778673.stgit@bahia.lan>
Date: Tue, 10 Dec 2019 11:39:00 +0100
In-Reply-To: <157591411864.46967.18244018296239778673.stgit@bahia.lan> (Greg
 Kurz's message of "Mon, 09 Dec 2019 18:55:18 +0100")
Message-ID: <87pngw31ob.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qdhaR8PVOImSaICF1bdhEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> Use it in include/hw/core/cpu.h and convert all targets to use it as
> well with:
>
> perl -pi \
>  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
>  $(git ls-files 'target/*.h')
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/core/cpu.h       |    4 +++-
>  target/alpha/cpu-qom.h      |    2 +-
>  target/arm/cpu-qom.h        |    2 +-
>  target/cris/cpu-qom.h       |    2 +-
>  target/hppa/cpu-qom.h       |    2 +-
>  target/i386/cpu-qom.h       |    2 +-
>  target/lm32/cpu-qom.h       |    2 +-
>  target/m68k/cpu-qom.h       |    2 +-
>  target/microblaze/cpu-qom.h |    2 +-
>  target/mips/cpu-qom.h       |    2 +-
>  target/moxie/cpu.h          |    2 +-
>  target/nios2/cpu.h          |    2 +-
>  target/openrisc/cpu.h       |    2 +-
>  target/ppc/cpu-qom.h        |    2 +-
>  target/riscv/cpu.h          |    2 +-
>  target/s390x/cpu-qom.h      |    2 +-
>  target/sh4/cpu-qom.h        |    2 +-
>  target/sparc/cpu-qom.h      |    2 +-
>  target/tilegx/cpu.h         |    2 +-
>  target/tricore/cpu-qom.h    |    2 +-
>  target/xtensa/cpu-qom.h     |    2 +-
>  21 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 77c6f0529903..047e3972ecaf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
> =20
>  struct TranslationBlock;
> =20
> +typedef void (*CPUReset)(CPUState *cpu);
> +
>  /**
>   * CPUClass:
>   * @class_by_name: Callback to map -cpu command line model name to an
> @@ -165,7 +167,7 @@ typedef struct CPUClass {
>      ObjectClass *(*class_by_name)(const char *cpu_model);
>      void (*parse_features)(const char *typename, char *str, Error **errp=
);
> =20
> -    void (*reset)(CPUState *cpu);
> +    CPUReset reset;
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
[...]

Opinion, not objection: such typedefs make the code less obvious.


