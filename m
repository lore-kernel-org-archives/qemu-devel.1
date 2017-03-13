Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4u-00010j-Qa
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4t-0002gK-Sm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4t-0002fP-LZ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A83943D967
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:47 -0500
Message-Id: <20170313195547.21466-31-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 30/30] trace: Force compiler warnings on
 trace parameter type mismatches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Our traces are processed through a function call (even though the
function is static inline).  While we could turn up compiler
warnings to flag cases of implicit narrowing through a function
parameter (such as a caller doing foo(my_uint64_t) to a function
prototyped as void foo(int)), it would make the build very noisy
as we have a lot of code that relies on that C-mandated behavior.
Using the attribute printf marking of qemu_log_mask (when the log
trace backend is enabled) is too late to catch scalar type changes
(it does catch that the format string matches the parameters of
the trace_foo() function, but does not detect format mismatches at
the callsite).  Completely emitting the traces as a macro is a
possibility since they are already marked static inline, but doing
so in a way that does not evaluate side effects more than once, and
uses proper \ line continuation for a (lengthy) macro, is a more
invasive change to the generator than I'm willing to make.

So this patch introduces a compromise solution: almost[1] every
trace_foo() is generated both as an inline function (unchanged
from before, with the bulk of the code) and a forwarding macro (new
in this patch) that uses a dead-code call to printf to trigger
-Wformat type mismatch warnings from the compiler.  The end result
does not change the size of emitted code, but does enable us to get
better checking; particularly useful since the format string in
trace-events is distant from the callsites to trace_foo in the
normal .c files.  Note that the generated macro has to insert a
trailing "\n" to shut up gcc's warning about an empty format
string, and we have to use the gcc/clang extension of ##__VA_ARGS__
for comma elision since there are a few 0-arg traces.

[1]The macro trick is NOT done for vcpu traces, because those
trace calls are special; the format string associated with those
events is in a different order than the resulting parameters to
the function call, due to the additional logic generated for
determining whether the vcpu needs filtering.

Earlier patches show scenarios that this patch was able to catch,
most of which just needed a tweak to the parameter types declared
in trace-events, but some which were actual bugs in the code being
traced.

Note that there is a missing dependency in the makefiles;
although trace/Makefile.objs defines $(tracetool-y) to include
all .py files, the change to h.py does NOT force a rebuild
of any of the generated trace.h files; and it probably has
something to do with how our trace files are themselves
considered a prerequisite of Makefile being up-to-date.  I was
unable to figure out the Makefile magic necessary to fix the
dependency, but was able to manually work around the problem
by running

make -B block/trace.h-timestamp

which forced a rerun of the tracetool, and therefore regenerated
all of the trace.h files.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

RFC for two reasons:
1. the Makefile issue documented above means that incremental
builds won't benefit from this patch without manual intervention
(fresh builds, including docker, manage to test it, though)
2. there are still failures under 'make docker-test-mingw@fedora'
due to more type mismatches that still need to be squashed. I'm
still working on fixing those, but wanted to at least post this
series for initial review, especially so the maintainer can weigh
in on how much (or little) belongs in 2.9

 scripts/tracetool/format/h.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 3682f4e..491fd6e 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -73,6 +73,19 @@ def generate(events, backend, group):
         out('    }',
             '}')

+        if "vcpu" not in e.properties:
+            out('',
+                '#define %(api)s(...) \\',
+                '    do { \\',
+                '        if (0) { \\',
+                '            printf(%(fmt)s "\\n", ## __VA_ARGS__); \\',
+                '        } \\',
+                '        %(api)s(__VA_ARGS__); \\',
+                '    } while (0)',
+                api=e.api(),
+                fmt=e.fmt.rstrip("\n")
+            )
+
     backend.generate_end(events, group)

     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
-- 
2.9.3
