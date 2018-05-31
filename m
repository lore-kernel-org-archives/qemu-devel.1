Received: from eggs.gnu.org ([2001:4830:134:3::10]:42345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOLDT-0004Am-9L
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOLDR-0000zF-Gn
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:53:59 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fOLDR-0000yf-5O
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:53:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id r15-v6so25553257wmc.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530193548.3846786-3-stefanb@linux.vnet.ibm.com>
References: <20180530193548.3846786-1-stefanb@linux.vnet.ibm.com>
	<20180530193548.3846786-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 May 2018 12:53:55 +0200
Message-ID: <CAJ+F1CLcz9wXRGEzO9TGMFRcHa1_hTAk-Lfh=O3oqNCvCHq0-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] test: Move common TPM test functions
 to tpm-tests.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, May 30, 2018 at 9:35 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Move common TPM test functions from tpm-crb-swtpm-test.c to tpm-tests.c
> so that for example test cases with the TPM TIS interface can use the
> same code. Prefix all funcions with 'tpm_test_'.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/Makefile.include     |   2 +-
>  tests/tpm-crb-swtpm-test.c |  99 ++----------------------------------
>  tests/tpm-tests.c          | 124 +++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/tpm-tests.h          |  24 +++++++++
>  4 files changed, 153 insertions(+), 96 deletions(-)
>  create mode 100644 tests/tpm-tests.c
>  create mode 100644 tests/tpm-tests.h
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b499ba1813..1597d09bd8 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -723,7 +723,7 @@ tests/test-io-task$(EXESUF): tests/test-io-task.o $(t=
est-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
>  tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-=
emu.o \
> -       tests/tpm-util.o $(test-io-obj-y)
> +       tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
>  tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test=
-io-obj-y)
>  tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test=
-io-obj-y)
>  tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
> diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
> index 2a22b032ca..4acffff568 100644
> --- a/tests/tpm-crb-swtpm-test.c
> +++ b/tests/tpm-crb-swtpm-test.c
> @@ -16,7 +16,7 @@
>  #include <glib/gstdio.h>
>
>  #include "libqtest.h"
> -#include "tpm-util.h"
> +#include "tpm-tests.h"
>
>  typedef struct TestState {
>      char *src_tpm_path;
> @@ -26,108 +26,17 @@ typedef struct TestState {
>
>  static void tpm_crb_swtpm_test(const void *data)
>  {
> -    char *args =3D NULL;
> -    QTestState *s;
> -    SocketAddress *addr =3D NULL;
> -    gboolean succ;
> -    GPid swtpm_pid;
> -    GError *error =3D NULL;
>      const TestState *ts =3D data;
>
> -    succ =3D tpm_util_swtpm_start(ts->src_tpm_path, &swtpm_pid, &addr, &=
error);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> -        return;
> -    }
> -
> -    args =3D g_strdup_printf(
> -        "-chardev socket,id=3Dchr,path=3D%s "
> -        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
> -        "-device tpm-crb,tpmdev=3Ddev",
> -        addr->u.q_unix.path);
> -
> -    s =3D qtest_start(args);
> -    g_free(args);
> -
> -    tpm_util_startup(s, tpm_util_crb_transfer);
> -    tpm_util_pcrextend(s, tpm_util_crb_transfer);
> -
> -    unsigned char tpm_pcrread_resp[] =3D
> -        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
> -        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
> -        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> -        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> -    tpm_util_pcrread(s, tpm_util_crb_transfer, tpm_pcrread_resp,
> -                     sizeof(tpm_pcrread_resp));
> -
> -    qtest_end();
> -    tpm_util_swtpm_kill(swtpm_pid);
> -
> -    if (addr) {
> -        g_unlink(addr->u.q_unix.path);
> -        qapi_free_SocketAddress(addr);
> -    }
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer);
>  }
>
>  static void tpm_crb_swtpm_migration_test(const void *data)
>  {
>      const TestState *ts =3D data;
> -    gboolean succ;
> -    GPid src_tpm_pid, dst_tpm_pid;
> -    SocketAddress *src_tpm_addr =3D NULL, *dst_tpm_addr =3D NULL;
> -    GError *error =3D NULL;
> -    QTestState *src_qemu, *dst_qemu;
> -
> -    succ =3D tpm_util_swtpm_start(ts->src_tpm_path, &src_tpm_pid,
> -                                &src_tpm_addr, &error);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> -        return;
> -    }
> -
> -    succ =3D tpm_util_swtpm_start(ts->dst_tpm_path, &dst_tpm_pid,
> -                                &dst_tpm_addr, &error);
> -    /* succ may be false if swtpm is not available */
> -    if (!succ) {
> -        goto err_src_tpm_kill;
> -    }
> -
> -    tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
> -                                  src_tpm_addr, dst_tpm_addr,
> -                                  ts->uri);
> -
> -    tpm_util_startup(src_qemu, tpm_util_crb_transfer);
> -    tpm_util_pcrextend(src_qemu, tpm_util_crb_transfer);
> -
> -    unsigned char tpm_pcrread_resp[] =3D
> -        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
> -        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
> -        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> -        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> -    tpm_util_pcrread(src_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
> -                     sizeof(tpm_pcrread_resp));
> -
> -    tpm_util_migrate(src_qemu, ts->uri);
> -    tpm_util_wait_for_migration_complete(src_qemu);
> -
> -    tpm_util_pcrread(dst_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
> -                     sizeof(tpm_pcrread_resp));
> -
> -    qtest_quit(dst_qemu);
> -    qtest_quit(src_qemu);
> -
> -    tpm_util_swtpm_kill(dst_tpm_pid);
> -    if (dst_tpm_addr) {
> -        g_unlink(dst_tpm_addr->u.q_unix.path);
> -        qapi_free_SocketAddress(dst_tpm_addr);
> -    }
>
> -err_src_tpm_kill:
> -    tpm_util_swtpm_kill(src_tpm_pid);
> -    if (src_tpm_addr) {
> -        g_unlink(src_tpm_addr->u.q_unix.path);
> -        qapi_free_SocketAddress(src_tpm_addr);
> -    }
> +    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts=
->uri,
> +                                  tpm_util_crb_transfer);
>  }
>
>  int main(int argc, char **argv)
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> new file mode 100644
> index 0000000000..adf2c618c8
> --- /dev/null
> +++ b/tests/tpm-tests.c
> @@ -0,0 +1,124 @@
> +/*
> + * QTest TPM commont test code
> + *
> + * Copyright (c) 2018 IBM Corporation
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "libqtest.h"
> +#include "tpm-tests.h"
> +
> +void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx)
> +{
> +    char *args =3D NULL;
> +    QTestState *s;
> +    SocketAddress *addr =3D NULL;
> +    gboolean succ;
> +    GPid swtpm_pid;
> +    GError *error =3D NULL;
> +
> +    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &erro=
r);
> +    /* succ may be false if swtpm is not available */
> +    if (!succ) {
> +        return;
> +    }
> +
> +    args =3D g_strdup_printf(
> +        "-chardev socket,id=3Dchr,path=3D%s "
> +        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
> +        "-device tpm-crb,tpmdev=3Ddev",
> +        addr->u.q_unix.path);
> +
> +    s =3D qtest_start(args);
> +    g_free(args);
> +
> +    tpm_util_startup(s, tx);
> +    tpm_util_pcrextend(s, tx);
> +
> +    unsigned char tpm_pcrread_resp[] =3D
> +        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
> +        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
> +        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> +        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> +    tpm_util_pcrread(s, tx, tpm_pcrread_resp,
> +                     sizeof(tpm_pcrread_resp));
> +
> +    qtest_end();
> +    tpm_util_swtpm_kill(swtpm_pid);
> +
> +    if (addr) {
> +        g_unlink(addr->u.q_unix.path);
> +        qapi_free_SocketAddress(addr);
> +    }
> +}
> +
> +void tpm_test_swtpm_migration_test(const char *src_tpm_path,
> +                                   const char *dst_tpm_path,
> +                                   const char *uri, tx_func *tx)
> +{
> +    gboolean succ;
> +    GPid src_tpm_pid, dst_tpm_pid;
> +    SocketAddress *src_tpm_addr =3D NULL, *dst_tpm_addr =3D NULL;
> +    GError *error =3D NULL;
> +    QTestState *src_qemu, *dst_qemu;
> +
> +    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
> +                                &src_tpm_addr, &error);
> +    /* succ may be false if swtpm is not available */
> +    if (!succ) {
> +        return;
> +    }
> +
> +    succ =3D tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
> +                                &dst_tpm_addr, &error);
> +    /* succ may be false if swtpm is not available */
> +    if (!succ) {
> +        goto err_src_tpm_kill;
> +    }
> +
> +    tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
> +                                  src_tpm_addr, dst_tpm_addr, uri);
> +
> +    tpm_util_startup(src_qemu, tx);
> +    tpm_util_pcrextend(src_qemu, tx);
> +
> +    unsigned char tpm_pcrread_resp[] =3D
> +        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
> +        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
> +        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
> +        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> +    tpm_util_pcrread(src_qemu, tx, tpm_pcrread_resp,
> +                     sizeof(tpm_pcrread_resp));
> +
> +    tpm_util_migrate(src_qemu, uri);
> +    tpm_util_wait_for_migration_complete(src_qemu);
> +
> +    tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
> +                     sizeof(tpm_pcrread_resp));
> +
> +    qtest_quit(dst_qemu);
> +    qtest_quit(src_qemu);
> +
> +    tpm_util_swtpm_kill(dst_tpm_pid);
> +    if (dst_tpm_addr) {
> +        g_unlink(dst_tpm_addr->u.q_unix.path);
> +        qapi_free_SocketAddress(dst_tpm_addr);
> +    }
> +
> +err_src_tpm_kill:
> +    tpm_util_swtpm_kill(src_tpm_pid);
> +    if (src_tpm_addr) {
> +        g_unlink(src_tpm_addr->u.q_unix.path);
> +        qapi_free_SocketAddress(src_tpm_addr);
> +    }
> +}
> diff --git a/tests/tpm-tests.h b/tests/tpm-tests.h
> new file mode 100644
> index 0000000000..377f184c77
> --- /dev/null
> +++ b/tests/tpm-tests.h
> @@ -0,0 +1,24 @@
> +/*
> + * QTest TPM commont test code
> + *
> + * Copyright (c) 2018 IBM Corporation
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TESTS_TPM_TESTS_H
> +#define TESTS_TPM_TESTS_H
> +
> +#include "tpm-util.h"
> +
> +void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx);
> +
> +void tpm_test_swtpm_migration_test(const char *src_tpm_path,
> +                                   const char *dst_tpm_path,
> +                                   const char *uri, tx_func *tx);
> +
> +#endif /* TESTS_TPM_TESTS_H */
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
