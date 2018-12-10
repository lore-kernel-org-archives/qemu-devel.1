Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gWA2D-0008Qx-KF
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gWA2A-00039L-FG
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:06:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gWA2A-00038f-58
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 20:06:54 -0500
Date: Sun, 9 Dec 2018 23:06:44 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20181210010643.GA11705@localhost.localdomain>
References: <20181207221417.5152-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207221417.5152-1-wainersm@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixes to the check missing
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com

On Fri, Dec 07, 2018 at 05:14:17PM -0500, Wainer dos Santos Moschetta wrote:
> The x86_cpu_class_check_missing_features() returns a list
> of unavailable features compared to the host CPU. Currently it may
> return empty strings for unamed features as well as duplicated
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
> ---
> Note: the skipped testcase was used to test fix in my system so it has
> assumptions about the host CPU. It's impracticial to change it to allow
> running on any system though. Therefore, I am okay on either leave or remove
> it. Opinions?

I disagree with this test. This is an always skipping test that
tend to become easily a meaningless dead code. If your real tests that is
not being skipped have proper coverage than it should be enough.

> ---
>  target/i386/cpu.c                   | 12 +++++-
>  tests/acceptance/cpu_definitions.py | 61 +++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 tests/acceptance/cpu_definitions.py
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f9..2502a3adda 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3615,19 +3615,29 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  
>      x86_cpu_filter_features(xc);
>  
> +    /* Uses an auxiliar dictionary to ensure the list of features has not
> +       repeated name. */
> +    QDict *unique_feats_dict = qdict_new();
> +
>      for (w = 0; w < FEATURE_WORDS; w++) {
>          uint32_t filtered = xc->filtered_features[w];
>          int i;
>          for (i = 0; i < 32; i++) {
>              if (filtered & (1UL << i)) {
> +                const char *fname = g_strdup(x86_cpu_feature_name(w, i));
> +                if (!fname || qdict_haskey(unique_feats_dict, fname)) {
> +                    continue;
> +                }
>                  strList *new = g_new0(strList, 1);
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
> index 0000000000..65cea0427e
> --- /dev/null
> +++ b/tests/acceptance/cpu_definitions.py
> @@ -0,0 +1,61 @@
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
> +        self.vm.add_args("-machine", "q35,accel=kvm")
> +        self.vm.launch()
> +        cpu_definitions = self.vm.command('query-cpu-definitions')
> +        self.assertTrue(len(cpu_definitions) > 0)
> +        for cpu_model in cpu_definitions:
> +            name = cpu_model.get('name')
> +            unavailable_features = cpu_model.get('unavailable-features')
> +
> +            self.assertNotIn("", unavailable_features,
> +                             name + " has unamed feature")
> +            self.assertEqual(len(unavailable_features),
> +                             len(set(unavailable_features)),
> +                             name + " has duplicate feature")
> +
> +    @skip("Have assumptions about the host CPU")
> +    def test_unavailable_features_manual(self):
> +        """
> +        This test is meant for manual testing only because the list of expected
> +        unavailable features depend on the actual host CPU knowledge.
> +        """
> +        expected_cpu = 'Cascadelake-Server'
> +        expected_unavailable_features = ["hle", "rtm", "mpx", "avx512f",
> +                                         "avx512dq", "rdseed", "adx", "smap",
> +                                         "clflushopt", "clwb", "intel-pt",
> +                                         "avx512cd", "avx512bw", "avx512vl",
> +                                         "pku", "avx512vnni", "spec-ctrl",
> +                                         "ssbd", "3dnowprefetch", "xsavec",
> +                                         "xgetbv1"]
> +
> +        self.vm.add_args("-machine", "q35,accel=kvm")
> +        self.vm.launch()
> +        cpu_definitions = self.vm.command('query-cpu-definitions')
> +        self.assertTrue(len(cpu_definitions) > 0)
> +
> +        cpus = [cpu_model for cpu_model in cpu_definitions
> +                if cpu_model['name'] == expected_cpu]
> +        actual_unavailable_features = cpus[0]['unavailable-features']
> +        self.assertCountEqual(expected_unavailable_features,
> +                              actual_unavailable_features)
> -- 
> 2.19.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
