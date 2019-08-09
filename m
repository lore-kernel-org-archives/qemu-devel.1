Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D3C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027E92171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/rGCzUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027E92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1Rn-0002lX-Bm
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw1RL-0002Ln-0W
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw1RK-0000ds-0A
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:44:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw1RJ-0000db-PO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:44:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so5030692wmj.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=P6om2TQYUbcFqR6dxC+G1nAVIWKbro9g5OzKVWI3OmA=;
 b=H/rGCzUWizaP2oZ643UXupHytkXI1qU//eUZywzHLioouUQzXamtCwEMSWkWgXoXLg
 rvNv8Qe0EEebxsS05ecnX7WiO9vZUH/sAehnSaAvUH1WBoDDzSJd2GR4vywRp5MN/8DI
 hwU6VE3PcX2CyQ9f2OaJBHtONI4q2gRmmNgBUJHj0CzyMJFezVMHFFXdw0/A34wKKvhC
 DdbpfGTsBxRprc9p1yUv+d79DY/fHQ+I8WVosip64cv+J4Lhpag9qbgn7ARSxXVdnnN1
 3bbmZLOK/ck62Pz9dS53cjG0YC4hGssxl4nbzErG8WzPpy74cZ3cWEJxd/4/+j8RM21v
 5jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P6om2TQYUbcFqR6dxC+G1nAVIWKbro9g5OzKVWI3OmA=;
 b=izvhSkQY3h2xrHMyviD+kcvzrhgjJIQ4pZgXZ9yOQ5yz+wC0376tlsfKlJGkYpc8Hm
 HfHEHWCcmU6CPQr19b9gp7EymftQpMaS3683bweihpAwfsOFSXkkNQbrNJdPOsG/rzLb
 uK/O5+dWSAqLbTQMmYlyXNccvrxPxYDDX2PCWe1J93AtuFE0XQjxWNOvBMkOXEYlMHUP
 7mSdTVxvEvfHSaEBx6MBTfDA+yiedIhaL1fG84hs9NRPfExzg03zktz+eAkggbZYRsAf
 WBi/4Odfa/S6Zk8cxXbfM7/DjsMH/CWMWbq2nMCFPBShovOQQndv48Zn59LzXziPa/Ee
 VGGg==
X-Gm-Message-State: APjAAAWF3Puu6w79Y2cxSfzxd8ynyAa2esWWJMpzC2vF7IvPMPUBuSPN
 BUZ0yINV3eaxrevcRKQ7OB8=
X-Google-Smtp-Source: APXvYqyk32FAcChxQSF6ohxhkdJiMHyCbxDI5ilzNp1BV6qfY6E2nMFUPQYXbfcIJrqHM467JgAZ1Q==
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr9574892wmc.17.1565343840626; 
 Fri, 09 Aug 2019 02:44:00 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a2sm4404973wmj.9.2019.08.09.02.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:43:59 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:43:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809094358.GL25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-13-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-13-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH v2 12/17] fuzz: Add fuzzer skeleton
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 07:11:13AM +0000, Oleinik, Alexander wrote:
> diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
> new file mode 100644
> index 0000000000..9e03e15d7b
> --- /dev/null
> +++ b/tests/fuzz/fuzz.c
> @@ -0,0 +1,245 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/iov.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "migration/qemu-file.h"
> +
> +#include "migration/qemu-file.h"
> +#include "migration/global_state.h"
> +#include "migration/savevm.h"
> +#include "tests/libqtest.h"
> +#include "migration/migration.h"
> +#include "fuzz.h"
> +#include "tests/libqos/qgraph.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/userfaultfd.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/ioctl.h>

There's a lot of stuff going on here, the qemu-file.h include is
duplicated, system headers should be before application headers (see
./HACKING), and some of the headers aren't used.  Please clean these
includes up.

> +/* Save the entire vm state including RAM */
> +void save_vm_state(void)
> +{
> +    writefile = qemu_fopen_ram(&rd);
> +    vm_stop(RUN_STATE_SAVE_VM);
> +    global_state_store();
> +    qemu_savevm_state(writefile, NULL);
> +    qemu_fflush(writefile);
> +    ramfile = qemu_fopen_ro_ram(rd);
> +}
> +
> +/* Reset state by rebooting */
> +void reboot()

Please use void foo(void) in C.  Unlike C++, where void foo() is
equivalent to void foo(void), void foo() means that the arguments are
unspecified and not checked by the compiler!

> +void qtest_setup()
> +{
> +    s = qtest_fuzz_init(NULL, NULL);
> +    global_qtest = s;

Is global_qtest used by any fuzz tests?  Thomas Huth (qtest maintainer)
wants to get rid of it soon.  Perhaps it's possible to avoid it in fuzz
tests so it never needs to be introduced.

> diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
> new file mode 100644
> index 0000000000..46ec38d4ea
> --- /dev/null
> +++ b/tests/fuzz/fuzz.h
> @@ -0,0 +1,70 @@
> +#ifndef FUZZER_H_
> +#define FUZZER_H_

There are a bunch of global variables in this file.  It's not clear to
me yet at this point in the patch series that they need to be global...
Have you checked that they need to be global?

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NQF4ACgkQnKSrs4Gr
c8jY8wf+Picx+Np7UY/8+QSd0xT1/EAP0kTZg/K2j8S3Dsh6cAIVq4aT4xo67Q7S
BTboxOSWaoe/XGPGlmouekl4hgZg/ESPXN61v8CBp35xQyC6FJoN65uHRU/Ewvxu
JQZTP88jQi8MN5hqCaKVq6FrVDN1IdwOZYAQy1dJrvf7Pt2uYqvoVpZKK722R00Y
vfGwkf22nH1aJMaftXFN7JA695kaHelIiVkdbVNPKv1CU//ixIF++pBJlKC7Ft/R
pHaCUrmjJdRBg5CeXw5Kbd2I/o5nNEKGfLBs/bviOKbiHqgEPWFFIYNJ+WdOlHAq
F9NSF7H2C9IDG58q46iTMWx5IspDCg==
=U6Rn
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--

