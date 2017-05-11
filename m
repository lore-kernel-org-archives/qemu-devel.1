Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8r2a-000744-8s
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8r2Z-00073O-9U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8r2Z-00073C-0L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC09780489
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 16:34:09 +0000 (UTC)
Date: Thu, 11 May 2017 13:34:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170511163407.GK3482@thinpad.lan.raisama.net>
References: <20170508183205.10884-1-ehabkost@redhat.com>
	<20170511160000.277d67f7@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511160000.277d67f7@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests: Add [+-]feature and
 feature=on|off test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, May 11, 2017 at 04:00:00PM +0200, Igor Mammedov wrote:
> On Mon,  8 May 2017 15:32:05 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Add test code to ensure features are enabled/disabled correctly in the
> > command-line. The test case use the "feature-words" and
> > "filtered-features" properties to check if the features were
> > enabled/disabled correctly.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Remove explicit "accel=" option to avoid triggering warnings
> >   on "make check"
> > * Use qdict_get_*() helpers to make code shorter
> > * Rename input_eax, input_ecx to in_eax, in_ecx to make
> >   lines fit in the coding style width limit
> > * v1 was submitted as part of the series:
> >   Subject: [PATCH 0/4] x86: Support "-cpu feature=force"
> > * Coding style: split lines
> > * Style changes on code comments
> > ---
> >  tests/test-x86-cpuid-compat.c | 111 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> > 
> > diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
> [...]
> > +    add_feature_test("x86/cpuid/features/max-plus-invtsc",
> > +                     "-cpu max,+invtsc",
> > +                     0x80000007, 0, "EDX", 8, true);
> > +    add_feature_test("x86/cpuid/features/max-invtsc-on",
> > +                     "-cpu max,invtsc=on",
> > +                     0x80000007, 0, "EDX", 8, true);
> > +    add_feature_test("x86/cpuid/features/max-minus-mmx",
> > +                     "-cpu max,-mmx",
> > +                     1, 0, "EDX", 23, false);
> > +    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
> > +                     "-cpu max,mmx=off",
> > +                     1, 0, "EDX", 23, false);
> Why do you add 'max' variants in addition to 486/pentium?

Because we already had bugs in the host/max logic in the past.
See commit d4a606b38b5d4b3689b86cc1575908e82179ecfb for example.

Let's enumerate each test case and the reason for them:

+    add_feature_test("x86/cpuid/features/plus",
+                     "-cpu 486,+arat",
+                     6, 0, "EAX", 2, true);

Here I need a CPU model with level < 6. 486. pentium, pentium2,
pentium3 would work, and I chose 486. Conroe and newer won't
work, because they already have level=10.

+    add_feature_test("x86/cpuid/features/minus",
+                     "-cpu pentium,-mmx",
+                     1, 0, "EDX", 23, false);

Here I need a CPU model that has at least one feature I can
disable. I decided to test "-mmx", and use the oldest CPU model
that had MMX enabled (to increase the likelihood it is runnable
on the host).

+    add_feature_test("x86/cpuid/features/on",
+                     "-cpu 486,arat=on",
+                     6, 0, "EAX", 2, true);
+    add_feature_test("x86/cpuid/features/off",
+                     "-cpu pentium,mmx=off",
+                     1, 0, "EDX", 23, false);

Same as above, but testing feat=on|off syntax.

+    add_feature_test("x86/cpuid/features/max-plus-invtsc",
+                     "-cpu max,+invtsc",
+                     0x80000007, 0, "EDX", 8, true);
+    add_feature_test("x86/cpuid/features/max-invtsc-on",
+                     "-cpu max,invtsc=on",
+                     0x80000007, 0, "EDX", 8, true);

This is checking for the bugs fixed by commit
46c032f3afcc05a0123914609f1003906ba63fda and commit
d4a606b38b5d4b3689b86cc1575908e82179ecfb.


+    add_feature_test("x86/cpuid/features/max-minus-mmx",
+                     "-cpu max,-mmx",
+                     1, 0, "EDX", 23, false);
+    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
+                     "-cpu max,mmx=off",
+                     1, 0, "EDX", 23, false);

This is checking the bug fixed by commit
d4a606b38b5d4b3689b86cc1575908e82179ecfb, but when disabling
features.


-- 
Eduardo
