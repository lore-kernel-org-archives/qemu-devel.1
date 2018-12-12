Received: from eggs.gnu.org ([2001:4830:134:3::10]:50307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWtOF-0001xG-U9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWtOB-0001rn-FB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWtOB-0001mn-3M
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 20:32:39 -0500
Date: Tue, 11 Dec 2018 23:32:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181212013222.GQ7141@habkost.net>
References: <20181211162846.31149-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211162846.31149-1-wainersm@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, crosa@redhat.com, ccarrara@redhat.com

On Tue, Dec 11, 2018 at 11:28:46AM -0500, Wainer dos Santos Moschetta wrote:
> The x86_cpu_class_check_missing_features() returns a list
> of unavailable features compared to the host CPU. Currently it may
> return empty strings for unnamed features as well as duplicated
> names.
> 
> For example, the qmp "query-cpu-definitions" below shows one empty
> string and repeated "mpx" entries:
> 
> (...)
> {"execute": "query-cpu-definitions"}
> (...)
>         {
>             "name": "Cascadelake-Server",
>             "typename": "Cascadelake-Server-x86_64-cpu",
>             "unavailable-features": [
>                 "hle",
>                 "rtm",
>                 "mpx",
>                 "avx512f",
>                 "avx512dq",
>                 "rdseed",
>                 "adx",
>                 "smap",
>                 "clflushopt",
>                 "clwb",
>                 "intel-pt",
>                 "avx512cd",
>                 "avx512bw",
>                 "avx512vl",
>                 "pku",
>                 "",

I just noticed one thing: we probably want to find out the cause
of this empty entry, instead of ignoring it in the code.  Named
CPU models must only refer to named CPU features.

I think this is caused by CPUID_7_0_ECX_OSPKE, I will
investigate.  But this doesn't make your patch incorrect.


>                 "avx512vnni",
>                 "spec-ctrl",
>                 "ssbd",
>                 "3dnowprefetch",
>                 "xsavec",
>                 "xgetbv1",
>                 "mpx",
>                 "mpx",
>                 "avx512f",
>                 "avx512f",
>                 "avx512f",
>                 "pku"
>             ],
> (...)
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> ---
> v2:
>  * Fixed typos. [eblake]
>  * Removed unwanted manual test case. [ccarrara, ehabkost]
>  * Not passing 'accel=kvm' on test's VM. [ehabkost]
>  * Removed unneeded g_strdup() call. [ehabkost]
>  * Formatted comment according to QEMU's coding style. [ehabkost]
> 
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg579404.html
> ---
>  target/i386/cpu.c                   | 11 ++++++++-
>  tests/acceptance/cpu_definitions.py | 35 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 tests/acceptance/cpu_definitions.py
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f9..014b91e608 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3615,19 +3615,28 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  
>      x86_cpu_filter_features(xc);
>  
> +    /* Auxiliary dictionary to avoid duplicate entries in the list. */
> +    QDict *unique_feats_dict = qdict_new();
> +
>      for (w = 0; w < FEATURE_WORDS; w++) {
>          uint32_t filtered = xc->filtered_features[w];
>          int i;
>          for (i = 0; i < 32; i++) {
>              if (filtered & (1UL << i)) {
> +                const char *fname = x86_cpu_feature_name(w, i);
> +                if (!fname || qdict_haskey(unique_feats_dict, fname)) {
> +                    continue;
> +                }
>                  strList *new = g_new0(strList, 1);

I like mixed declarations, but unfortunately they are not allowed
by CODING_STYLE:

	5. Declarations

	Mixed declarations (interleaving statements and declarations within
	blocks) are generally not allowed; declarations should be at the beginning
	of blocks.


The logic now looks good, though.

> -                new->value = g_strdup(x86_cpu_feature_name(w, i));
> +                new->value = g_strdup(fname);
>                  *next = new;
>                  next = &new->next;
> +                qdict_put_null(unique_feats_dict, new->value);
>              }
>          }
>      }
>  
> +    g_free(unique_feats_dict);
>      object_unref(OBJECT(xc));
>  }
>  
> diff --git a/tests/acceptance/cpu_definitions.py b/tests/acceptance/cpu_definitions.py
> new file mode 100644
> index 0000000000..4edad86799
> --- /dev/null
> +++ b/tests/acceptance/cpu_definitions.py
> @@ -0,0 +1,35 @@
> +# CPU definitions tests.
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado import skip
> +from avocado_qemu import Test
> +
> +
> +class CPUDefinitions(Test):
> +    """
> +    Tests for the CPU definitions.
> +
> +    :avocado: enable
> +    :avocado: tags=x86_64
> +    """
> +    def test_unavailable_features(self):
> +        self.vm.add_args("-machine", "q35")

I thought the explicit -machine option was here only because of
the old accel=kvm option, and the whole line would be removed.
Why do you need to explicitly ask for a Q35 machine to test this?


> +        self.vm.launch()
> +        cpu_definitions = self.vm.command('query-cpu-definitions')
> +        self.assertTrue(len(cpu_definitions) > 0)
> +        for cpu_model in cpu_definitions:
> +            name = cpu_model.get('name')
> +            unavailable_features = cpu_model.get('unavailable-features')
> +
> +            self.assertNotIn("", unavailable_features,
> +                             name + " has unamed feature")

"unnamed"

> +            self.assertEqual(len(unavailable_features),
> +                             len(set(unavailable_features)),
> +                             name + " has duplicate feature")
> -- 
> 2.19.1
> 

-- 
Eduardo
