Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9V8H-0002qy-Eq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9V8C-0001iI-WE
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:59:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36054)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9V89-0001fE-5R
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:59:28 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-20-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-20-alex.bennee@linaro.org>
Date: Mon, 8 Oct 2018 15:59:22 +0300
Message-ID: <005c01d45f06$bbd7c6b0$33875410$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 19/21] plugins: add an example
 hotblocks plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, 'Stefan Hajnoczi' <stefanha@redhat.com>

I guess this one is too tcg-dependent.
It count TB's, but breaking code into TBs may depend on many things,
like breakpoints, record/replay, ...

I mean that this measuring approach may be used only in some specific
cases, and not ok as an example.

Pavel Dovgalyuk

> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Friday, October 05, 2018 6:49 PM
> To: qemu-devel@nongnu.org
> Cc: Pavel.Dovgaluk@ispras.ru; vilanova@ac.upc.edu; cota@braap.org; =
Alex Benn=C3=A9e; Stefan
> Hajnoczi
> Subject: [RFC PATCH 19/21] plugins: add an example hotblocks plugin
>=20
> This plugin attempts to track hotblocks by total execution count and
> average time to return to block. It is intended to be lower impact
> than saving a long log file and post-processing it.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  trace/plugins/hotblocks/hotblocks.c | 69 =
+++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 trace/plugins/hotblocks/hotblocks.c
>=20
> diff --git a/trace/plugins/hotblocks/hotblocks.c =
b/trace/plugins/hotblocks/hotblocks.c
> new file mode 100644
> index 0000000000..e9166ad1a5
> --- /dev/null
> +++ b/trace/plugins/hotblocks/hotblocks.c
> @@ -0,0 +1,69 @@
> +/*
> + * Execution Hotblocks Plugin
> + *
> + * Copyright (c) 2018
> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
> + *
> + * This code is licensed under the GNU GPL v2.
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <glib.h>
> +#include <time.h>
> +#include "plugins.h"
> +
> +/* Plugins need to take care of their own locking */
> +GMutex lock;
> +GHashTable *hotblocks;
> +
> +typedef struct {
> +    uintptr_t pc;
> +    unsigned int hits;
> +    struct timespec last;
> +    unsigned long total_time;
> +} ExecCount;
> +
> +bool plugin_init(const char *args)
> +{
> +    hotblocks =3D g_hash_table_new(NULL, g_direct_equal);
> +    return true;
> +}
> +
> +char *plugin_status(void)
> +{
> +    GString *report =3D g_string_new("We have ");
> +    char *r;
> +    g_mutex_lock(&lock);
> +    g_string_append_printf(report, "%ud entries in the hash table\n",
> +                           g_hash_table_size(hotblocks));
> +    g_mutex_unlock(&lock);
> +    r =3D report->str;
> +    g_string_free(report, FALSE);
> +    return r;
> +}
> +
> +bool exec_tb(void *tb, uintptr_t pc)
> +{
> +    ExecCount *cnt;
> +    struct timespec current;
> +    clock_gettime(CLOCK_MONOTONIC, &current);
> +
> +    g_mutex_lock(&lock);
> +    cnt =3D (ExecCount *) g_hash_table_lookup(hotblocks, =
(gconstpointer) pc);
> +    if (cnt) {
> +        cnt->hits++;
> +        cnt->total_time +=3D current.tv_nsec - cnt->last.tv_nsec;
> +        cnt->last =3D current;
> +    } else {
> +        cnt =3D g_new0(ExecCount, 1);
> +        cnt->pc =3D pc;
> +        cnt->last =3D current;
> +        cnt->hits =3D 1;
> +        g_hash_table_insert(hotblocks, (gpointer) pc, (gpointer) =
cnt);
> +    }
> +    g_mutex_unlock(&lock);
> +
> +    /* As we are collecting up samples no reason to continue tracing =
*/
> +    return false;
> +}
> --
> 2.17.1
