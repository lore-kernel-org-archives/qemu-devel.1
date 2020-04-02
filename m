Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A4F206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdIcYd+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A4F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyct-0006bJ-Dm
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJycH-00062R-KT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJycG-00037e-Cg
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:06:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJycG-00037J-8x
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585829195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jZstrZEBLB7fCi60mnWmI/3b+IWfp7Ac6W5X904tds4=;
 b=LdIcYd+fAJcxjs1OmZquTXlYNqe+oST7VmcYWV1FjUlQCqufeVWY80GURWbqwqW985BCzb
 JGxrPmnqyqxWM/ufyKju8wgKMJoiZzGUV5/Aziu/TkWqDya0JDi++Bb8Tyu0oKqIAAXnMX
 t6FvtAcBWo+bK+CL5TNE9OcvbRdadlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-jkVZklw2MAyTUmewgxPO-g-1; Thu, 02 Apr 2020 08:06:33 -0400
X-MC-Unique: jkVZklw2MAyTUmewgxPO-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA10918A8C85;
 Thu,  2 Apr 2020 12:06:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 994A55D9CA;
 Thu,  2 Apr 2020 12:06:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2263C11385E2; Thu,  2 Apr 2020 14:06:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Function-like macro with the same name as a typedef confuses
 Coccinelle
Date: Thu, 02 Apr 2020 14:06:30 +0200
Message-ID: <87k12y5by1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I discovered that Vladimir's auto-propagated-errp.cocci leaves
hw/arm/armsse.c unchanged, even though it clearly should change it.
Running spatch with --debug prints (among lots of other things)

    let's go
    -----------------------------------------------------------------------
    -----------------------------------------------------------------------
    parse error=20
     =3D error in hw/arm/armsse.c; set verbose_parsing for more info
    badcount: 7
    bad: }
    bad:=20
    bad: static void nsccfg_handler(void *opaque, int n, int level)
    bad: {
    BAD:!!!!!     ARMSSE *s =3D ARMSSE(opaque);
    bad:=20
    bad:     s->nsccfg =3D level;
    bad: }
    parse error=20

Alright, what's wrong with this?  ARMSSE is both a function-like macro
and a typedef:

    #define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)

    typedef struct ARMSSE {
        ...
    } ARMSSE;

This appears to spook Coccinelle badly enough to skip code using ARMSSE.

If I rename the macro to ARMSSE_() just for testing, it produces the
transformation I'd expect.

Grepping for typedef names is bothersome, so I used ctags -x to build a
cross reference table, and searched that for function-like macros
clashing with typedefs.  Result:

include/hw/arm/armsse.h:#define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYP=
E_ARMSSE)
include/hw/arm/armsse.h:} ARMSSE;
include/hw/block/swim.h:#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SW=
IM)
include/hw/block/swim.h:} SWIM;
target/rx/cpu-qom.h:#define RXCPU(obj) \
target/rx/cpu.h:typedef struct RXCPU RXCPU;
target/s390x/translate.c:#define BD(N, BB, BD) { BB,  4, 0, FLD_C_b##N, FLD=
_O_b##N }, \
hw/audio/ac97.c:} BD;

The last one is a name clash in unrelated files; should not bother
Coccinelle.

The first three are due to QOM.  By convention, the name of the
function-like macro to convert to the QOM type is the QOM type in
ALL_CAPS.  Clash when the QOM type is ALL_CAPS already.

Clearly, Coccinelle is getting spooked to easily.  Regardless, three
questions:

1. Are ALL_CAPS typedef names a good idea?  We shout macros to tell
readers "beware, possibly magic".  Shouting other stuff as well
undermines that.

2. The compiler is quite cool with us using the same name for a
function-like macro and a not-function-like non-macro.  But is it a good
idea?

3. Do we want to work around Coccinelle's parsing flaw?  Having it skip
so much code is clearly suboptimal, and potentially dangerous.  The
obvious work-around is to rename the three problematic types so they
contain at least one lower-case letter.


