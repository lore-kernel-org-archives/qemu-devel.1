Received: from eggs.gnu.org ([2001:4830:134:3::10]:59097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f9Cex-00012B-Jf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f9Cet-0004Su-La
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:43:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1f9Cet-0004Sf-Fv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:43:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3JGfwTC074672
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:43:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hevc70gyt-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:43:42 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Apr 2018 12:43:41 -0400
References: <1524155983-16705-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 12:43:37 -0400
MIME-Version: 1.0
In-Reply-To: <1524155983-16705-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <272b1e45-c2ac-974a-fc8c-43a2f3963052@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test: Add test cases that use the external
 swtpm with CRB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 04/19/2018 12:39 PM, Stefan Berger wrote:
> Add a test program for testing the CRB with the external swtpm.
>
> The 1st test case extends a PCR and reads back the value and compares
> it against an expected return packet.
>
> The 2nd test case repeats the 1st test case and then migrates the
> external swtpm's state along with the VM state to a destination
> QEMU and swtpm and checks that the PCR has the expected value now.

I had previously posted this patch but had to make two fixes:

>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   tests/Makefile.include     |   3 +
>   tests/tpm-crb-swtpm-test.c | 247 ++++++++++++++++++++++++++++++++++++=
+++++++++
>   tests/tpm-util.c           | 186 ++++++++++++++++++++++++++++++++++
>   tests/tpm-util.h           |  36 +++++++
>   4 files changed, 472 insertions(+)
>   create mode 100644 tests/tpm-crb-swtpm-test.c
>   create mode 100644 tests/tpm-util.c
>   create mode 100644 tests/tpm-util.h
> diff --git a/tests/tpm-util.c b/tests/tpm-util.c
> new file mode 100644
> index 0000000..9072b6e
> --- /dev/null
> +++ b/tests/tpm-util.c
> @@ -0,0 +1,186 @@
> +/*
> + * QTest TPM utilities
> + *
> + * Copyright (c) 2018 IBM Corporation
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/acpi/tpm.h"
> +#include "libqtest.h"
> +#include "tpm-util.h"
> +
> +void tpm_util_crb_transfer(QTestState *s,
> +                           const unsigned char *req, size_t req_size,
> +                           unsigned char *rsp, size_t rsp_size)
> +{
> +    uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_C=
MD_LADDR);
> +    uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_R=
SP_ADDR);
> +
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);

^^^ Requesting access to the locality is new, which is now required due=20
to a recent addition in the CRB emulation.

> +
> +    qtest_memwrite(s, caddr, req, req_size);
> +
> [...]
> +    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
> +}
> +
> +static gboolean tpm_util_swtpm_has_tpm2(void)
This function is new to read the help screen of swtpm to check whether=20
it supports --tpm2, which is currently ionly supported n a preview branch.

> +{
> +    gint stdout;
> +    gboolean succ;
> +    unsigned i;
> +    char buffer[10240];
> +    ssize_t n;
> +    gchar *swtpm_argv[] =3D {
> +        g_strdup("swtpm"), g_strdup("socket"), g_strdup("--help"), NUL=
L
> +    };
> +
> +    succ =3D g_spawn_async_with_pipes(NULL, swtpm_argv, NULL,
> +                                    G_SPAWN_SEARCH_PATH, NULL, NULL, N=
ULL,
> +                                    NULL, &stdout, NULL, NULL);
> +    if (!succ) {
> +        goto cleanup;
> +    }
> +
> +    n =3D read(stdout, buffer, sizeof(buffer) - 1);
> +    if (n < 0) {
> +        goto cleanup;
> +    }
> +    buffer[n] =3D 0;
> +    if (!strstr(buffer, "--tpm2")) {
> +        succ =3D false;
> +    }
> +
> + cleanup:
> +    for (i =3D 0; swtpm_argv[i]; i++) {
> +        g_free(swtpm_argv[i]);
> +    }
> +
> +    return succ;
> +}
> +
