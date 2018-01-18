Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecFRr-00065M-0L
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecFRq-0005MN-1o
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:02:03 -0500
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
	<1516296842-136976-2-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fdf04c18-457e-3208-c464-11eebd142c54@redhat.com>
Date: Thu, 18 Jan 2018 20:01:35 +0100
MIME-Version: 1.0
In-Reply-To: <1516296842-136976-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v2 1/5] tests: add machine 'none'
 with -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>

On 18.01.2018 18:33, Igor Mammedov wrote:
> Check that "$QEMU -M none -cpu FOO" starts QEMU without error
[...]
> diff --git a/tests/machine-none.c b/tests/machine-none.c
> new file mode 100644
> index 0000000..d16c283
> --- /dev/null
> +++ b/tests/machine-none.c

Could you please name the file with a "-test.c" suffix, so that the
"*-test" wildcard in tests/.gitignore catches this, too? Otherwise
you've got to add "machine-none" explicitly to the gitignore file.

> @@ -0,0 +1,71 @@
> +/*
> + * Machine 'none' tests.
> + *
> + * Copyright (c) 2018 Red Hat Inc.
> + *
> + * Authors:
> + *  Igor Mammedov <imammedo@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu-common.h"
> +#include "qemu/cutils.h"
> +#include "libqtest.h"
> +#include "qapi/qmp/types.h"
> +
> +struct arch2cpu {
> +    const char *arch;
> +    const char *cpu_model;
> +};
> +
> +static struct arch2cpu cpus_map[] =3D {
> +    /* tested targets list */
> +};
> +
> +static const char *get_cpu_model_by_arch(const char *arch)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(cpus_map); i++) {
> +        if (!strcmp(arch, cpus_map[i].arch)) {
> +            return cpus_map[i].cpu_model;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void test_machine_cpu_cli(void)
> +{
> +    char *args;
> +    QDict *response;
> +    const char *arch =3D qtest_get_arch();
> +    const char *cpu_model =3D get_cpu_model_by_arch(arch);
> +
> +    if (!cpu_model) {
> +        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defin=
ed,"
> +                " add it to cpus_map\n", arch);
> +        return; /* TODO: die here to force all targets have a test */
> +    }
> +    args =3D g_strdup_printf("-machine none -cpu %s", cpu_model);
> +    qtest_start(args);

May I suggest to use qtest_startf() instead?

> +
> +    response =3D qmp("{ 'execute': 'quit' }");
> +    g_assert(qdict_haskey(response, "return"));
> +    QDECREF(response);
> +
> +    qtest_end();

... and that should be qtest_quit() if you use qtest_startf().

> +    g_free(args);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("machine/none/cpu_option", test_machine_cpu_cli);
> +
> +    return g_test_run();
> +}
>=20

 Thomas
