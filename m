Received: from eggs.gnu.org ([2001:4830:134:3::10]:54514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1coYxd-0006Xs-ON
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1coYxZ-0004Yj-I3
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:13:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1coYxZ-0004Wq-4C
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:13:09 -0400
Date: Thu, 16 Mar 2017 13:13:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170316171305.GA26528@flamenco>
References: <20170310012339.GA7400@flamenco> <20170310114531.GB2480@work-vm>
	<20170311021851.GA26530@flamenco> <20170314170656.GO2445@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314170656.GO2445@work-vm>
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Mar 14, 2017 at 17:06:57 +0000, Dr. David Alan Gilbert wrote:
> * Emilio G. Cota (cota@braap.org) wrote:
> > It seems that a good benchmark to take translation overhead into account
> > would be gcc/perlbench from SPEC (see [1]; ~20% of exec time is spent
> > on translation). Unfortunately, none of them can be redistributed.
> > 
> > I'll consider other options. For instance, I looked today at using golang's
> > compilation tests, but they crash under qemu-user. I'll keep looking
> > at other options -- the requirement is to have something that is easy
> > to build (i.e. gcc is not an option) and that it runs fast.
> 
> Yes, needs to be self contained but large enough to be interesting.
> Isn't SPECs perlbench just a variant of a standard free benchmark
> that can be used?
> (Select alternative preferred language).

SPEC takes an old Perl distribution and a few standard Perl benchmarks.
These sources (with SPEC's modifications) are of course redistributable.
However, SPEC also adds scripts that are propietary.

What I've ended up doing is selecting a small subset of the tests in the
Perl distribution with a profile under QEMU similar to that of
SPEC's perlbench (see patch below). This requires building (and testing)
Perl, which takes a few minutes on a modern machine (ouch) but fortunately
it is only done once. After that, the tests themselves take only a
few seconds.

The bummer is that cross-compiling the Perl distro is not officially
supported. But well at least we have now an easy-to-run "compiler-like"
benchmark, if only for the host's ISA.

I updated the README with profile data -- I'm pasting that update below.
Grab the changes from https://github.com/cota/dbt-bench

Here are the numbers for the Perl benchmark, from QEMU v1.7 -> v2.8.
The Y axis is Execution Time in seconds, so lower is better:

                       x86_64 Perl Compilation Performance                     
                 Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz                
                                                                               
   10 +-+---+------+-----+-----+-----+------+-----+----***----+------+---+-+   
      |     +      +     +     +     +      +     +     *     +      +     |   
  9.8 +-+                                              #A                +-+   
      |                                          *** ## *#                 |   
  9.6 +-+                                         *##  ***#              +-+   
  9.4 +-+                                         A        #             +-+   
      |                                          #*         #***           |   
  9.2 +-+                                       #***         #*          +-+   
      |                                        #              A##          |   
    9 +-+  ***          ***         ***        #              *  #       +-+   
      |     A#####***    *    ***    *     ***#              ***  #        |   
  8.8 +-+   *     #*  ###A#####A#####*      *#                     #***  +-+   
  8.6 +-+  ***     A##   *     *     A######A                        *   +-+   
      |           ***   ***   ***    *     ***                       A     |   
  8.4 +-+                            *                               *   +-+   
      |     +      +     +     +    ***     +     +     +     +     ***    |   
  8.2 +-+---+------+-----+-----+-----+------+-----+-----+-----+------+---+-+   
         v1.7.0 v2.0.0v2.1.0v2.2.0v2.3.0 v2.4.0v2.5.0v2.6.0v2.7.0 v2.8.0       
                                  QEMU version 
PNGs for Perl + NBench here: http://imgur.com/a/LlpxE

Thanks,

		Emilio

commit f4ca2537bffe544779aa3f1814cec9d66dd9a17e
Author: Emilio G. Cota <cota@braap.org>
Date:   Thu Mar 16 12:48:44 2017 -0400

    README: document and quantify the difference between NBench and Perl
    
    While at it, also show how Perl's perf is very similar to SPEC06's perlbench.
    
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/README.md b/README.md
index b6d4037..b4578d6 100644
--- a/README.md
+++ b/README.md
@@ -61,3 +61,111 @@ Other output formats are possible, see `Makefile`.
   valuable files that were never meant to be committed (e.g. scripts). For
   this reason it is best to just clone a fresh QEMU repo to be used with
   DBT-bench rather than using your development tree.
+
+## What is the difference between the benchmarks?
+
+NBench programs are small, with execution time dominated by small code loops. Thus,
+when run under a DBT engine, the resulting performance depends almost entirely
+on the quality of the output code.
+
+The Perl benchmarks compile Perl code. As is common for compilation workloads,
+they execute large amounts of code and show no particular code execution
+hotspots. Thus, the resulting DBT performance depends largely on code
+translation speed.
+
+Quantitatively, the differences can be clearly seen under a profiler. For QEMU
+v2.8.0, we get:
+
+* NBench:
+
+```
+# Samples: 1M of event 'cycles:pp'
+# Event count (approx.): 1111661663176
+#
+# Overhead  Command       Shared Object        Symbol
+# ........  ............  ...................  .........................................
+#
+     6.26%  qemu-x86_64   qemu-x86_64          [.] float64_mul
+     6.24%  qemu-x86_64   qemu-x86_64          [.] roundAndPackFloat64
+     4.18%  qemu-x86_64   qemu-x86_64          [.] subFloat64Sigs
+     2.72%  qemu-x86_64   qemu-x86_64          [.] addFloat64Sigs
+     2.29%  qemu-x86_64   qemu-x86_64          [.] cpu_exec
+     1.29%  qemu-x86_64   qemu-x86_64          [.] float64_add
+     1.12%  qemu-x86_64   qemu-x86_64          [.] float64_sub
+     0.79%  qemu-x86_64   qemu-x86_64          [.] object_class_dynamic_cast_assert
+     0.71%  qemu-x86_64   qemu-x86_64          [.] helper_mulsd
+     0.66%  qemu-x86_64   perf-23090.map       [.] 0x000055afd37d0b8a
+     0.64%  qemu-x86_64   perf-23090.map       [.] 0x000055afd377cd8f
+     0.59%  qemu-x86_64   perf-23090.map       [.] 0x000055afd37d019a
+     [...]
+```
+
+* Perl:
+
+```
+# Samples: 90K of event 'cycles:pp'
+# Event count (approx.): 97757063053
+#
+# Overhead  Command       Shared Object            Symbol
+# ........  ............  .......................  ...........................................
+#
+   22.93%  qemu-x86_64   [kernel.kallsyms]        [k] isolate_freepages_block
+    9.38%  qemu-x86_64   qemu-x86_64              [.] cpu_exec
+    5.69%  qemu-x86_64   qemu-x86_64              [.] tcg_gen_code
+    5.30%  qemu-x86_64   qemu-x86_64              [.] tcg_optimize
+    3.45%  qemu-x86_64   qemu-x86_64              [.] liveness_pass_1
+    3.24%  qemu-x86_64   [kernel.kallsyms]        [k] isolate_migratepages_block
+    2.39%  qemu-x86_64   qemu-x86_64              [.] object_class_dynamic_cast_assert
+    1.48%  qemu-x86_64   [kernel.kallsyms]        [k] unlock_page
+    1.29%  qemu-x86_64   [kernel.kallsyms]        [k] pageblock_pfn_to_page
+    1.29%  qemu-x86_64   qemu-x86_64              [.] tcg_out_opc.isra.13
+    1.11%  qemu-x86_64   qemu-x86_64              [.] tcg_gen_op2
+    0.98%  qemu-x86_64   [kernel.kallsyms]        [k] migrate_pages
+    0.87%  qemu-x86_64   qemu-x86_64              [.] qht_lookup
+    0.83%  qemu-x86_64   qemu-x86_64              [.] tcg_temp_new_internal
+    0.77%  qemu-x86_64   qemu-x86_64              [.] tcg_out_modrm_sib_offset.constprop.37
+    0.76%  qemu-x86_64   qemu-x86_64              [.] disas_insn.isra.49
+    0.70%  qemu-x86_64   [kernel.kallsyms]        [k] __wake_up_bit
+    0.55%  qemu-x86_64   [kernel.kallsyms]        [k] __reset_isolation_suitable
+    0.47%  qemu-x86_64   qemu-x86_64              [.] tcg_opt_gen_mov
+    [...]
+```
+
+### Why don't you just run SPEC06?
+
+SPEC's source code cannot be redistributed. Some of its benchmarks are based
+on free software, but the SPEC authors added on top of it non-free code
+(usually scripts) that cannot be redistributed.
+
+For this reason we use here benchmarks that are freely redistributable,
+while capturing different performance profiles: NBench represents "hotspot
+code" and Perl represents a typical "compiler" workload. In fact, Perl's
+performance profile under QEMU is very similar to that of SPEC06's perlbench;
+compare Perl's profile above with SPEC06 perlbench's below:
+
+```
+# Samples: 14K of event 'cycles:pp'
+# Event count (approx.): 15657871399
+#
+# Overhead  Command      Shared Object            Symbol
+# ........  ...........  .......................  ...........................................
+#
+   16.93%  qemu-x86_64  qemu-x86_64              [.] cpu_exec
+    9.16%  qemu-x86_64  [kernel.kallsyms]        [k] isolate_freepages_block
+    5.47%  qemu-x86_64  qemu-x86_64              [.] tcg_gen_code
+    4.82%  qemu-x86_64  qemu-x86_64              [.] tcg_optimize
+    4.15%  qemu-x86_64  qemu-x86_64              [.] object_class_dynamic_cast_assert
+    3.25%  qemu-x86_64  qemu-x86_64              [.] liveness_pass_1
+    1.55%  qemu-x86_64  qemu-x86_64              [.] qht_lookup
+    1.23%  qemu-x86_64  qemu-x86_64              [.] tcg_gen_op2
+    1.04%  qemu-x86_64  [kernel.kallsyms]        [k] copy_page
+    1.00%  qemu-x86_64  qemu-x86_64              [.] tcg_out_opc.isra.13
+    0.82%  qemu-x86_64  qemu-x86_64              [.] tcg_temp_new_internal
+    0.78%  qemu-x86_64  qemu-x86_64              [.] tcg_out_modrm_sib_offset.constprop.37
+    0.72%  qemu-x86_64  qemu-x86_64              [.] tb_cmp
+    0.69%  qemu-x86_64  [kernel.kallsyms]        [k] isolate_migratepages_block
+    0.67%  qemu-x86_64  qemu-x86_64              [.] disas_insn.isra.49
+    0.53%  qemu-x86_64  qemu-x86_64              [.] object_get_class
+    0.52%  qemu-x86_64  [kernel.kallsyms]        [k] __wake_up_bit
+    [...]
+```
--
2.7.4
