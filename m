Received: from eggs.gnu.org ([2001:4830:134:3::10]:57585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNwoi-00033x-SV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNwod-0006Ac-VP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fNwod-0006AU-Lp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fNwoc-0006Ii-62
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2AC7C2E80C3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 May 2018 08:36:00 -0000
From: mou <arnaudalies.py@gmail.com>
Reply-To: Bug 1774149 <1774149@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152766936065.4012.2532535303592891582.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774149] [NEW] qemu-user x86_64 x86 gdb call
 function from gdb doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

While running qemu user x86_64 x86 with gdb server, calling functions
are not working.

Here is how to reproduce it:

run in a terminal:
$ qemu-x86_64 -g 12345 -L / /bin/ls

In another terminal run gdb:
(gdb) file /bin/ls
(gdb) target remote :12345
(gdb) b _init
(gdb) c
(gdb) call malloc(1)
Could not fetch register "fs_base"; remote failure reply 'E14'

In other cases we also got the error:
Could not fetch register "orig_rax"; remote failure reply 'E14'

Here is how I patched it (it is only a workaround):

diff --git a/gdbstub.c b/gdbstub.c
index 2a94030..5749efe 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -668,6 +668,11 @@ static int gdb_read_register(CPUState *cpu, uint8_t *m=
em_buf, int reg)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return r->get_reg(env, mem_buf, reg - r->base_reg);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
+#ifdef TARGET_X86_64
+    return 8;
+#elif TARGET_I386
+    return 4;
+#endif
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
=C2=A0}

(Our guess for this issue was, gdb is requesting for 'fake' registers to
know register size)

Once we patched that, we got another problem while calling functions
from gdb: We could call functions, but only once.

Here is how to reproduce it:
run in a terminal:
$ qemu-x86_64 -g 12345 -L / /bin/ls

In another terminal run gdb:
(gdb) file /bin/ls
(gdb) target remote :12345
(gdb) b _init
(gdb) c
(gdb) call malloc(1)
$1 =3D (void *) 0x620010
(gdb) call malloc(1)
Cannot access memory at address 0x40007ffb8f

Here is how we patched it to make it work:

diff --git a/exec.c b/exec.c
index 03238a3..d303922 100644
--- a/exec.c
+++ b/exec.c
@@ -2833,7 +2833,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong a=
ddr,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(flags & PAGE_VA=
LID))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return -1;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_write) {
-            if (!(flags & PAGE_WRITE))
+            if (!(flags & (PAGE_WRITE | PAGE_WRITE_ORG)))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* XXX: this code should not depend on lock_user */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (!(p =3D lock_user(VERIFY_WRITE, addr, l, 0)))

>From what we saw, there is a page which is passed to read-only after
first execution, and gdb need to write on that page to put a breakpoint.
(on the stack to get function return)

We suspect this is linked to this:
https://qemu.weilnetz.de/w64/2012/2012-06-28/qemu-tech.html#Self_002dmodify=
ing-code-and-translated-code-invalidation

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- qemu-user x86_64 x86 gdb call function not working properly
+ qemu-user x86_64 x86 gdb call function from gdb doesn't work

** Description changed:

  While running qemu user x86_64 x86 with gdb server, calling functions
  are not working.
  =

  Here is how to reproduce it:
  =

  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls
  =

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  Could not fetch register "fs_base"; remote failure reply 'E14'
  =

  In other cases we also got the error:
  Could not fetch register "orig_rax"; remote failure reply 'E14'
  =

  Here is how I patched it (it is only a workaround):
  =

  diff --git a/gdbstub.c b/gdbstub.c
  index 2a94030..5749efe 100644
  --- a/gdbstub.c
  +++ b/gdbstub.c
  @@ -668,6 +668,11 @@ static int gdb_read_register(CPUState *cpu, uint8_t =
*mem_buf, int reg)
-              return r->get_reg(env, mem_buf, reg - r->base_reg);
-          }
-      }
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return r->get_reg(env, mem_buf, reg - r->base_reg);
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  +#ifdef TARGET_X86_64
  +    return 8;
  +#elif TARGET_I386
  +    return 4;
  +#endif
-      return 0;
-  }
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
+ =C2=A0}
  =

  (Our guess for this issue was, gdb is requesting for 'fake' registers to
  know register size)
  =

  Once we patched that, we got another problem while calling functions
  from gdb: We could call functions, but only once.
  =

  Here is how to reproduce it:
  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls
  =

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  $1 =3D (void *) 0x620010
  (gdb) call malloc(1)
  Cannot access memory at address 0x40007ffb8f
  =

  Here is how we patched it to make it work:
  =

  diff --git a/exec.c b/exec.c
  index 03238a3..d303922 100644
  --- a/exec.c
  +++ b/exec.c
  @@ -2833,7 +2833,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong=
 addr,
-          if (!(flags & PAGE_VALID))
-              return -1;
-          if (is_write) {
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(flags & PAGE_=
VALID))
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return -1;
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_write) {
  -            if (!(flags & PAGE_WRITE))
  +            if (!(flags & (PAGE_WRITE | PAGE_WRITE_ORG)))
-                  return -1;
-              /* XXX: this code should not depend on lock_user */
-              if (!(p =3D lock_user(VERIFY_WRITE, addr, l, 0)))
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/* XXX: this code should not depend on lock_user */
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (!(p =3D lock_user(VERIFY_WRITE, addr, l, 0)))
  =

  From what we saw, there is a page which is passed to read-only after
  first execution, and gdb need to write on that page to put a breakpoint.
- (on the stack)
+ (on the stack to get function return)
  =

  We suspect this is linked to this:
  https://qemu.weilnetz.de/w64/2012/2012-06-28/qemu-tech.html#Self_002dmodi=
fying-code-and-translated-code-invalidation

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774149

Title:
  qemu-user x86_64 x86 gdb call function from gdb doesn't work

Status in QEMU:
  New

Bug description:
  While running qemu user x86_64 x86 with gdb server, calling functions
  are not working.

  Here is how to reproduce it:

  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  Could not fetch register "fs_base"; remote failure reply 'E14'

  In other cases we also got the error:
  Could not fetch register "orig_rax"; remote failure reply 'E14'

  Here is how I patched it (it is only a workaround):

  diff --git a/gdbstub.c b/gdbstub.c
  index 2a94030..5749efe 100644
  --- a/gdbstub.c
  +++ b/gdbstub.c
  @@ -668,6 +668,11 @@ static int gdb_read_register(CPUState *cpu, uint8_t =
*mem_buf, int reg)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return r->get_reg(env, mem_buf, reg - r->base_reg);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  +#ifdef TARGET_X86_64
  +    return 8;
  +#elif TARGET_I386
  +    return 4;
  +#endif
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
  =C2=A0}

  (Our guess for this issue was, gdb is requesting for 'fake' registers
  to know register size)

  Once we patched that, we got another problem while calling functions
  from gdb: We could call functions, but only once.

  Here is how to reproduce it:
  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  $1 =3D (void *) 0x620010
  (gdb) call malloc(1)
  Cannot access memory at address 0x40007ffb8f

  Here is how we patched it to make it work:

  diff --git a/exec.c b/exec.c
  index 03238a3..d303922 100644
  --- a/exec.c
  +++ b/exec.c
  @@ -2833,7 +2833,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong=
 addr,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(flags & PAGE_=
VALID))
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return -1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_write) {
  -            if (!(flags & PAGE_WRITE))
  +            if (!(flags & (PAGE_WRITE | PAGE_WRITE_ORG)))
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/* XXX: this code should not depend on lock_user */
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (!(p =3D lock_user(VERIFY_WRITE, addr, l, 0)))

  From what we saw, there is a page which is passed to read-only after
  first execution, and gdb need to write on that page to put a
  breakpoint. (on the stack to get function return)

  We suspect this is linked to this:
  https://qemu.weilnetz.de/w64/2012/2012-06-28/qemu-tech.html#Self_002dmodi=
fying-code-and-translated-code-invalidation

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774149/+subscriptions
