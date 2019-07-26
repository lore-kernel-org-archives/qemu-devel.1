Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC454C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA70D21871
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3H6k6iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA70D21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzon-0003UP-Ir
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzoU-0002Wp-R4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzoT-0001gN-MG
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:59:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzoT-0001TP-CU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:59:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so47645401wmj.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E+YxDOjlW/6iX7vim8xVCUkcRKCyygRX2nNXvwXwMQs=;
 b=R3H6k6iDhrJMVRj8cdGmtDjgFI2pN2wYUusqpoLx26UK06g0X52hEItPvzr13X2c81
 XLObZmKn8a8xKmSDTixlWgr5mi6ebaEJESuimo69XFm++LLvWDQKNDzb8VIDmkNsas2d
 aoskdOW4RhpQE03CV1Gs0AinLIK0S6r03H5EQ+CpTTmHTusDLcr6qhm2fJYj+Tfbod7a
 Ot4/X3n4v75VCPzLQ7vyjl2hGfPR/VdQQ+bUAdER9AmxRjHXdNyD7MckEMWbjUO0Q4kk
 lnsurK44vZXOOAtB/mTrwYn5ySIXspjnAvffuVBIKKAK3wqPTTcT86BLZbXtdlJumGcU
 n2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E+YxDOjlW/6iX7vim8xVCUkcRKCyygRX2nNXvwXwMQs=;
 b=DvA6VjKGuGppTiCNUCEXhYPdQli2W1RDcsPQbEjoCXaoS4GsQhQMVWLgyThnjWqGKN
 vlRmMQUIYmlity1MtCv7N9kd1TB1PpGgly9rdD1Vwk+iDolY/+xp1e2KJAz+rFnuZhCi
 OBkkpdJJLRqQeGsa0ouMLAouzE3WyM68ZwH4olkaMH+KbJx57iw2pSdu2KJS/RC7nc9v
 FGrC92Obons3su3rI6h1LVQO5UQnAjYJ1MOVxIbhty8SGkSlZRvSYkPkjcWmaj8dKc0I
 KkXDNLqhfnX9aQwcO1BgBOtuvoZJPtQnz83wvwhbTyGJW/X1joIEoiMuinC+Jkmd0XEX
 IBWQ==
X-Gm-Message-State: APjAAAVkVoaCXd2EFMs8DWhOZ7NCalZEDEiuAsS+qzsvVpqJ4/tDaSaB
 5YzWl8RSGSQ+DkZWMQVFlpQ=
X-Google-Smtp-Source: APXvYqxCZngdBDT/rnWHHZeoWRbZgeHdwlroQNvcKKJK5RFzQOxhBrRJR/Q5lGmCQsuXv95pMVXkaw==
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr78270407wmj.61.1564145947969; 
 Fri, 26 Jul 2019 05:59:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x83sm55580915wmb.42.2019.07.26.05.59.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:59:07 -0700 (PDT)
Date: Fri, 26 Jul 2019 13:59:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190726125905.GF25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-9-alxndr@bu.edu>
 <76dc362b-ae7c-6c81-f068-c7faf00d5b05@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <76dc362b-ae7c-6c81-f068-c7faf00d5b05@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC 08/19] fuzz: add shims to intercept libfuzzer
 init
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 10:21:18AM +0200, Paolo Bonzini wrote:
> On 25/07/19 05:23, Oleinik, Alexander wrote:
> > Intercept coverage buffer registration calls and use this information to
> > copy them to shared memory, if using fork() to avoid resetting device
> > state.
> >=20
> > Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> > ---
> >  tests/fuzz/fuzzer_hooks.c | 106 ++++++++++++++++++++++++++++++++++++++
> >  tests/fuzz/fuzzer_hooks.h |   9 ++++
> >  2 files changed, 115 insertions(+)
> >  create mode 100644 tests/fuzz/fuzzer_hooks.c
> >  create mode 100644 tests/fuzz/fuzzer_hooks.h
> >=20
> > diff --git a/tests/fuzz/fuzzer_hooks.c b/tests/fuzz/fuzzer_hooks.c
> > new file mode 100644
> > index 0000000000..5a0bbec413
> > --- /dev/null
> > +++ b/tests/fuzz/fuzzer_hooks.c
> > @@ -0,0 +1,106 @@
> > +#include "qemu/osdep.h"
> > +#include "qemu/units.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "fuzzer_hooks.h"
> > +
> > +#include <dlfcn.h>
> > +#include <elf.h>
> > +
> > +
> > +extern void* _ZN6fuzzer3TPCE;
>=20
> Would it make sense to make this a C++ source, so that you can avoid
> using the mangled names (in this case, "namespace fuzzer { extern void
> *TPC; }" and then using fuzzer::TPC)?  Even if it's just a single symbol.

A proper libfuzzer API is nicest in the long term.

Alexander: Could you send a patch to libfuzzer to see if they are
willing to support this via their API?

Stefan

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06+RkACgkQnKSrs4Gr
c8hbdAf/cK7/BXiNdZptmsXnBoIZUOaTWbWp38HJa0Y4YFoqitd03lO20tI1cVqw
WilsL48VipV5eAdA9gAhPY4lRsM8CExcFsxdyWlNxmUBR6pgRCrqT5ILoZiogzyZ
UVGDL4C5B7NOKh/RvSf8w6kA+54lSIG+5iSs1HIUWd+orfcBmteu1qoIVn9Yaq3P
G6DARMWu0wcXheFoNaIXnB06U2hhGE3Vp0lPwRTOd158+4MpmDSOgVVonZOUlCNX
oxeoAAt+L+A9vqMsn83TJeT/XRXr0UxMNrSRLNV8USceSxWBLkn5cNX4C1kWkAfU
odJrHMecyWaAGeXRk5pZDwvGsk2GsA==
=Ztdz
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

