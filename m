Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7DC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247E9214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Navu5h7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247E9214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShfk-000532-Bk
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iShf6-0004bG-6o
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iShf5-00062X-48
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:17:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iShf4-00062K-S7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:17:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id e6so3037692wrw.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/wt/ZJ5Iyr74j8Urm4LOKYt6n2yGXUeBiupEIgOKJyw=;
 b=Navu5h7RdVdSy7CqLF8ihhU+hJuIyOd/UONTWESIxsalB2vu0lhiB2NM4mOxYF7szd
 M8Whui9h2K9Y1WJiKv527z0hr1qzhOwD5ybj2QnM9UbvGR6g2O7Ysr3Nh7RqXiqV3Zr2
 XyMVFoC2llsJXI7DC5lcVgfrvBX0wosDzwqYTmUU768qEIqTmmTaANNuVZ9zCgwU1Jyo
 el+fAY7Irkbwz96GnYIzzN7jj54EIF6gMt1xh8i8TN8lTicY8UgJR3rqjsyo7RezdYmK
 fngGX2lTZkYAsI54iiApRvYXsvpsys8Xu+VFtLJNgBrikZXY/K/2TB3pfWKJO1aR/Wno
 waMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/wt/ZJ5Iyr74j8Urm4LOKYt6n2yGXUeBiupEIgOKJyw=;
 b=DXgDfGKUJ8X4btbtXE9pPgHR+hfFein44vfxVRD+2G1++o+XcU91JGgGWJArPbU8Gd
 n8qdBZBeSIaNKW2IHlZyAWnLUTKpmXABWYfbgFEqHGQZ/UKHDeRDxfny/H83IPeRxFvm
 T2BmbWPZoCVIqDaanwBxtYXlf+VItN3X+QdD1J35ZtIRCqKmMN1BQm2Jz7XmvoZUEw5U
 6TVvn4YgKiN2KSzDDlCQGspQ5vPYEeqKGYya6vXs0V2JGeshXtg1VVl9fCBle8HKXTzg
 ncDVuqdGJSCi/cCxdpMIPEaz1M/yBTB1KYTOIxMM9sw6jkYWbqqTXLlOgBtuOx/AWxEq
 Z1rg==
X-Gm-Message-State: APjAAAV4d0CAZXb8OickG5boSHoUzR1LqnIv7a62B/CVdNk4PgHTLTeU
 /FSdDk1MCfyZIRCOXZ1wkks=
X-Google-Smtp-Source: APXvYqwlugfL1eMMpoesWbkv3jxMG/uKnyEa9S4htNsisSjku3lZacddbx1KohANd89CXYU0cOUA2w==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr2998874wro.392.1573132637457; 
 Thu, 07 Nov 2019 05:17:17 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id b66sm2248789wmh.39.2019.11.07.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 05:17:16 -0800 (PST)
Date: Thu, 7 Nov 2019 14:17:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 16/20] fuzz: add support for fork-based fuzzing.
Message-ID: <20191107131705.GB365089@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-17-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-17-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:50:01PM +0000, Oleinik, Alexander wrote:
> diff --git a/tests/fuzz/fork_fuzz.c b/tests/fuzz/fork_fuzz.c
> new file mode 100644
> index 0000000000..4c4d00b034
> --- /dev/null
> +++ b/tests/fuzz/fork_fuzz.c
> @@ -0,0 +1,51 @@
> +/*
> + * Fork-based fuzzing helpers
> + *
> + * Copyright Red Hat Inc., 2019
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "fork_fuzz.h"
> +
> +uintptr_t feature_shm;

Where is this variable used?

> +
> +void counter_shm_init(void)
> +{
> +    int fd = shm_open("/qemu-fuzz-cntrs", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

It must be possible to run multiple fuzzer instances simultaneously on
one host.  Please use a unique shmem path for each parent process (e.g.
getpid() in the parent and getppid() in the child).

> +    if (fd == -1) {
> +        perror("Error: ");
> +        exit(1);
> +    }
> +    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) == -1) {
> +        perror("Error: ");
> +        exit(1);
> +    }
> +    /* Copy what's in the counter region to the shm.. */
> +    void *rptr = mmap(NULL ,
> +            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> +            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +    memcpy(rptr,
> +           &__FUZZ_COUNTERS_START,
> +           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +
> +    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
> +
> +    /* And map the shm over the counter region */
> +    rptr = mmap(&__FUZZ_COUNTERS_START,
> +            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
> +            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);

fd can be closed here to prevent leaking it.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EGVEACgkQnKSrs4Gr
c8g2OwgAlg5KlZGryfuFL6u8TmiWNq1PUlCqr7K/AFS8asQUAWsUcM5F6gePBeze
0QB7gJd1tIT48GnP/r58Qz7NBxeFacDBPzTobRQT7qNraPqPFglJyvmlO9PHGfML
HCVNBttRKhUMB7mzMgGcja1zlkbodNBmBaYSUJCSBXjK1AQgkuyzeXdHrdwlSPpJ
O7+5EWsS1am/yUZ9mTpIPL+vSP5wKi3VU9rhOwprgAFpgCoCM9T+6AVqjrfCEhJn
vtkMqXaVB3dH7AFvW8hz/A+ni/Kn0FZHz3oRO7vz74GUtu0UjF0xsSjNXMBKBD5b
DY0bmEcpyO+fb5o/en2kUUhJ0eEEeA==
=Ll9q
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

