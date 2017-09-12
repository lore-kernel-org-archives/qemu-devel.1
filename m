Received: from eggs.gnu.org ([2001:4830:134:3::10]:49657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drnKq-0001A8-8K
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drnKo-00028N-5D
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drnKn-00027y-Rx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:42:46 -0400
Date: Tue, 12 Sep 2017 17:42:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912174237.2b994ef5@Igors-MacBook-Pro.local>
In-Reply-To: <20170904185622.24520-1-ehabkost@redhat.com>
References: <20170904185622.24520-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Use designated initializers on
 feat_names arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon,  4 Sep 2017 15:56:22 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Using designated initializers for feat_names allows us to omit
> NULL entries, and makes mistakes easier to spot (especially when
> cherry-picking or merging commits).
> 
> Arrays that have very few entries were changed to have a
> designator for every element.  Arrays that have almost every item
> present were changed to have one designator every 4 entries.
> Arrays that had only NULL entries had the initializers completely
> removed.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
I'm getting build errors with it on MacOS,
here is one for example:

qemu/target/i386/cpu.c:342:14: error: use of undeclared identifier 'KVM_FEATURE_CLOCKSOURCE'
            [KVM_FEATURE_CLOCKSOURCE] = "kvmclock",

>  target/i386/cpu.c | 215 ++++++++++++++++++------------------------------------
>  1 file changed, 73 insertions(+), 142 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69676e13e1..9da5915dde 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -268,28 +268,28 @@ typedef struct FeatureWordInfo {
>  static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_1_EDX] = {
>          .feat_names = {
> -            "fpu", "vme", "de", "pse",
> -            "tsc", "msr", "pae", "mce",
> -            "cx8", "apic", NULL, "sep",
> -            "mtrr", "pge", "mca", "cmov",
> -            "pat", "pse36", "pn" /* Intel psn */, "clflush" /* Intel clfsh */,
> -            NULL, "ds" /* Intel dts */, "acpi", "mmx",
> -            "fxsr", "sse", "sse2", "ss",
> -            "ht" /* Intel htt */, "tm", "ia64", "pbe",
> +            [0] = "fpu", "vme", "de", "pse",
> +            [4] = "tsc", "msr", "pae", "mce",
> +            [8] = "cx8", "apic", NULL, "sep",
> +            [12] = "mtrr", "pge", "mca", "cmov",
> +            [16] = "pat", "pse36", "pn", "clflush",
> +            [20] = NULL, "ds" /* Intel dts */, "acpi", "mmx",
> +            [24] = "fxsr", "sse", "sse2", "ss",
> +            [28] = "ht", "tm", "ia64", "pbe",
>          },
>          .cpuid_eax = 1, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_FEATURES,
>      },
>      [FEAT_1_ECX] = {
>          .feat_names = {
> -            "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
> -            "ds-cpl", "vmx", "smx", "est",
> -            "tm2", "ssse3", "cid", NULL,
> -            "fma", "cx16", "xtpr", "pdcm",
> -            NULL, "pcid", "dca", "sse4.1",
> -            "sse4.2", "x2apic", "movbe", "popcnt",
> -            "tsc-deadline", "aes", "xsave", "osxsave",
> -            "avx", "f16c", "rdrand", "hypervisor",
> +            [0] = "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
> +            [4] = "ds-cpl", "vmx", "smx", "est",
> +            [8] = "tm2", "ssse3", "cid", NULL,
> +            [12] = "fma", "cx16", "xtpr", "pdcm",
> +            [16] = NULL, "pcid", "dca", "sse4.1",
> +            [20] = "sse4.2", "x2apic", "movbe", "popcnt",
> +            [24] = "tsc-deadline", "aes", "xsave", "osxsave",
> +            [28] = "avx", "f16c", "rdrand", "hypervisor",
>          },
>          .cpuid_eax = 1, .cpuid_reg = R_ECX,
>          .tcg_features = TCG_EXT_FEATURES,
> @@ -301,131 +301,87 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>       */
>      [FEAT_8000_0001_EDX] = {
>          .feat_names = {
> -            NULL /* fpu */, NULL /* vme */, NULL /* de */, NULL /* pse */,
> -            NULL /* tsc */, NULL /* msr */, NULL /* pae */, NULL /* mce */,
> -            NULL /* cx8 */, NULL /* apic */, NULL, "syscall",
> -            NULL /* mtrr */, NULL /* pge */, NULL /* mca */, NULL /* cmov */,
> -            NULL /* pat */, NULL /* pse36 */, NULL, NULL /* Linux mp */,
> -            "nx", NULL, "mmxext", NULL /* mmx */,
> -            NULL /* fxsr */, "fxsr-opt", "pdpe1gb", "rdtscp",
> -            NULL, "lm", "3dnowext", "3dnow",
> +            [11] = "syscall",
> +            [20] = "nx",
> +            [22] = "mmxext",
> +            [25] = "fxsr-opt",
> +            [26] = "pdpe1gb",
> +            [27] = "rdtscp",
> +            [29] = "lm",
> +            [30] = "3dnowext",
> +            [31] = "3dnow",
>          },
>          .cpuid_eax = 0x80000001, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_EXT2_FEATURES,
>      },
>      [FEAT_8000_0001_ECX] = {
>          .feat_names = {
> -            "lahf-lm", "cmp-legacy", "svm", "extapic",
> -            "cr8legacy", "abm", "sse4a", "misalignsse",
> -            "3dnowprefetch", "osvw", "ibs", "xop",
> -            "skinit", "wdt", NULL, "lwp",
> -            "fma4", "tce", NULL, "nodeid-msr",
> -            NULL, "tbm", "topoext", "perfctr-core",
> -            "perfctr-nb", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [0] = "lahf-lm", "cmp-legacy", "svm", "extapic",
> +            [4] = "cr8legacy", "abm", "sse4a", "misalignsse",
> +            [8] = "3dnowprefetch", "osvw", "ibs", "xop",
> +            [12] = "skinit", "wdt", NULL, "lwp",
> +            [16] = "fma4", "tce", NULL, "nodeid-msr",
> +            [20] = NULL, "tbm", "topoext", "perfctr-core",
> +            [24] = "perfctr-nb", NULL, NULL, NULL,
>          },
>          .cpuid_eax = 0x80000001, .cpuid_reg = R_ECX,
>          .tcg_features = TCG_EXT3_FEATURES,
>      },
>      [FEAT_C000_0001_EDX] = {
>          .feat_names = {
> -            NULL, NULL, "xstore", "xstore-en",
> -            NULL, NULL, "xcrypt", "xcrypt-en",
> -            "ace2", "ace2-en", "phe", "phe-en",
> -            "pmm", "pmm-en", NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [0] = NULL, NULL, "xstore", "xstore-en",
> +            [4] = NULL, NULL, "xcrypt", "xcrypt-en",
> +            [8] = "ace2", "ace2-en", "phe", "phe-en",
> +            [12] = "pmm", "pmm-en", NULL, NULL,
>          },
>          .cpuid_eax = 0xC0000001, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_EXT4_FEATURES,
>      },
>      [FEAT_KVM] = {
>          .feat_names = {
> -            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
> -            "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            "kvmclock-stable-bit", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [KVM_FEATURE_CLOCKSOURCE] = "kvmclock",
> +            [KVM_FEATURE_NOP_IO_DELAY] = "kvm-nopiodelay",
> +            [KVM_FEATURE_MMU_OP] = "kvm-mmu",
> +            [KVM_FEATURE_CLOCKSOURCE2] = "kvmclock",
> +            [KVM_FEATURE_ASYNC_PF] = "kvm-asyncpf",
> +            [KVM_FEATURE_STEAL_TIME] = "kvm-steal-time",
> +            [KVM_FEATURE_PV_EOI] = "kvm-pv-eoi",
> +            [KVM_FEATURE_PV_UNHALT] = "kvm-pv-unhalt",
> +            [KVM_FEATURE_CLOCKSOURCE_STABLE_BIT] = "kvmclock-stable-bit",
>          },
>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
>          .tcg_features = TCG_KVM_FEATURES,
>      },
>      [FEAT_HYPERV_EAX] = {
> -        .feat_names = {
> -            NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_refcount_access */,
> -            NULL /* hv_msr_synic_access */, NULL /* hv_msr_stimer_access */,
> -            NULL /* hv_msr_apic_access */, NULL /* hv_msr_hypercall_access */,
> -            NULL /* hv_vpindex_access */, NULL /* hv_msr_reset_access */,
> -            NULL /* hv_msr_stats_access */, NULL /* hv_reftsc_access */,
> -            NULL /* hv_msr_idle_access */, NULL /* hv_msr_frequency_access */,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -        },
>          .cpuid_eax = 0x40000003, .cpuid_reg = R_EAX,
>      },
>      [FEAT_HYPERV_EBX] = {
> -        .feat_names = {
> -            NULL /* hv_create_partitions */, NULL /* hv_access_partition_id */,
> -            NULL /* hv_access_memory_pool */, NULL /* hv_adjust_message_buffers */,
> -            NULL /* hv_post_messages */, NULL /* hv_signal_events */,
> -            NULL /* hv_create_port */, NULL /* hv_connect_port */,
> -            NULL /* hv_access_stats */, NULL, NULL, NULL /* hv_debugging */,
> -            NULL /* hv_cpu_power_management */, NULL /* hv_configure_profiler */,
> -            NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -        },
>          .cpuid_eax = 0x40000003, .cpuid_reg = R_EBX,
>      },
>      [FEAT_HYPERV_EDX] = {
> -        .feat_names = {
> -            NULL /* hv_mwait */, NULL /* hv_guest_debugging */,
> -            NULL /* hv_perf_monitor */, NULL /* hv_cpu_dynamic_part */,
> -            NULL /* hv_hypercall_params_xmm */, NULL /* hv_guest_idle_state */,
> -            NULL, NULL,
> -            NULL, NULL, NULL /* hv_guest_crash_msr */, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -        },
>          .cpuid_eax = 0x40000003, .cpuid_reg = R_EDX,
>      },
>      [FEAT_SVM] = {
>          .feat_names = {
> -            "npt", "lbrv", "svm-lock", "nrip-save",
> -            "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
> -            NULL, NULL, "pause-filter", NULL,
> -            "pfthreshold", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [0] = "npt", "lbrv", "svm-lock", "nrip-save",
> +            [4] = "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
> +            [8] = NULL, NULL, "pause-filter", NULL,
> +            [12] = "pfthreshold", NULL, NULL, NULL,
> +
>          },
>          .cpuid_eax = 0x8000000A, .cpuid_reg = R_EDX,
>          .tcg_features = TCG_SVM_FEATURES,
>      },
>      [FEAT_7_0_EBX] = {
>          .feat_names = {
> -            "fsgsbase", "tsc-adjust", NULL, "bmi1",
> -            "hle", "avx2", NULL, "smep",
> -            "bmi2", "erms", "invpcid", "rtm",
> -            NULL, NULL, "mpx", NULL,
> -            "avx512f", "avx512dq", "rdseed", "adx",
> -            "smap", "avx512ifma", "pcommit", "clflushopt",
> -            "clwb", NULL, "avx512pf", "avx512er",
> -            "avx512cd", "sha-ni", "avx512bw", "avx512vl",
> +            [0] = "fsgsbase", "tsc-adjust", NULL, "bmi1",
> +            [4] = "hle", "avx2", NULL, "smep",
> +            [8] = "bmi2", "erms", "invpcid", "rtm",
> +            [12] = NULL, NULL, "mpx", NULL,
> +            [16] = "avx512f", "avx512dq", "rdseed", "adx",
> +            [20] = "smap", "avx512ifma", "pcommit", "clflushopt",
> +            [24] = "clwb", NULL, "avx512pf", "avx512er",
> +            [28] = "avx512cd", "sha-ni", "avx512bw", "avx512vl",
>          },
>          .cpuid_eax = 7,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> @@ -434,14 +390,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>      [FEAT_7_0_ECX] = {
>          .feat_names = {
> -            NULL, "avx512vbmi", "umip", "pku",
> -            "ospke", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, "avx512-vpopcntdq", NULL,
> -            "la57", NULL, NULL, NULL,
> -            NULL, NULL, "rdpid", NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [1] = "avx512vbmi",
> +            [2] = "umip",
> +            [3] = "pku",
> +            [4] = "ospke",
> +            [14] = "avx512-vpopcntdq",
> +            [16] = "la57",
> +            [22] = "rdpid",
>          },
>          .cpuid_eax = 7,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> @@ -450,14 +405,8 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>      [FEAT_7_0_EDX] = {
>          .feat_names = {
> -            NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [2] = "avx512-4vnniw",
> +            [3] = "avx512-4fmaps",
>          },
>          .cpuid_eax = 7,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> @@ -466,14 +415,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>      [FEAT_8000_0007_EDX] = {
>          .feat_names = {
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            "invtsc", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [8] = "invtsc",
>          },
>          .cpuid_eax = 0x80000007,
>          .cpuid_reg = R_EDX,
> @@ -482,14 +424,10 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>      [FEAT_XSAVE] = {
>          .feat_names = {
> -            "xsaveopt", "xsavec", "xgetbv1", "xsaves",
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [0] = "xsaveopt",
> +            [1] = "xsavec",
> +            [2] = "xgetbv1",
> +            [3] = "xsaves",
>          },
>          .cpuid_eax = 0xd,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 1,
> @@ -498,14 +436,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>      [FEAT_6_EAX] = {
>          .feat_names = {
> -            NULL, NULL, "arat", NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            [2] = "arat",
>          },
>          .cpuid_eax = 6, .cpuid_reg = R_EAX,
>          .tcg_features = TCG_6_EAX_FEATURES,
