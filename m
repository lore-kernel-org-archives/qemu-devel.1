Received: from eggs.gnu.org ([2001:4830:134:3::10]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1en5ql-0005Jo-Kc
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1en5qi-0006rw-In
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:00:35 -0500
Received: from mout.web.de ([212.227.15.3]:47157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1en5qi-0006rU-5z
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:00:32 -0500
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
	<3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
	<acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
	<87k1vb7nkw.fsf@linaro.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <1ade39bb-3573-e0e0-6b9f-9d23264b9f06@web.de>
Date: Sat, 17 Feb 2018 18:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <87k1vb7nkw.fsf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DBG15VKyqusbmk9ztjr1e1CouawepY4N7"
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBG15VKyqusbmk9ztjr1e1CouawepY4N7
From: Jan Kiszka <jan.kiszka@web.de>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-ID: <1ade39bb-3573-e0e0-6b9f-9d23264b9f06@web.de>
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
 <1487255507-106654-10-git-send-email-pbonzini@redhat.com>
 <3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
 <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de> <87k1vb7nkw.fsf@linaro.org>
In-Reply-To: <87k1vb7nkw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-17 14:27, Alex Benn=C3=A9e wrote:
>=20
> Jan Kiszka <jan.kiszka@web.de> writes:
>=20
>> On 2018-02-17 09:56, Jan Kiszka wrote:
>>> On 2017-02-16 15:31, Paolo Bonzini wrote:
>>>> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>>>
>>>> When GDB issues a "vCont", QEMU was not handling it correctly when
>>>> multiple VCPUs are active.
>>>> For vCont, for each thread (VCPU), it can be specified whether to
>>>> single step, continue or stop that thread. The default is to stop a
>>>> thread.
>>>> However, when (for example) "vCont;s:2" is issued, all VCPUs continu=
e
>>>> to run, although all but VCPU nr 2 are to be stopped.
>>>>
>>>> This patch completely rewrites the vCont parsing code.
>>>>
>>>> Please note that this improvement only works in system emulation mod=
e,
>>>> when in userspace emulation mode the old behaviour is preserved.
>>>>
>>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>>> Message-Id: <1487092068-16562-3-git-send-email-imbrenda@linux.vnet.i=
bm.com>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>  gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++---=
-----------
>>>>  1 file changed, 162 insertions(+), 47 deletions(-)
>>>>
> <snip>
>>>
>>> Seems like no one is doing guest debugging with kvm on x86 except me,=

>>> and I'm only doing it too infrequently now: This one broke that use c=
ase
>>> for SMP guests long ago. How was it tested?
>>>
>>> To reproduce the bug: set up an x86-64 guest kernel with > 1 core, br=
eak
>>> on some prominent syscall entry (e.g. sys_execve), continue the guest=
 on
>>> hit and it will quickly lock up, even after disabling the breakpoint
>>> again. Kernel version doesn't matter (was my first guess), gdb is
>>> 7.7.50.20140604-cvs (OpenSUSE) here.
>=20
> I thought I fixed this with 5a6a1ad181c658b810041d852b290ac836965aca
>=20
> FWIW I do periodically test ARM TCG and KVM guest debug using:
>=20
>   tests/guest-debug/test-gdbstub.py
>=20
> But we are missing a nice integration to get an appropriate guest image=

> to automate this process. If we can fix that we should be able to turn
> on the test as part of make check.
>=20

If that test above is extended with more interesting setups, that should
be enough. E.g., you can reproduce this issue by running qemu with -smp
4 and the following test modifications.

diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-g=
dbstub.py
index 31ba6c943a..a55782fa9a 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -15,6 +15,7 @@ def report(cond, msg):
         print ("PASS: %s" % (msg))
     else:
         print ("FAIL: %s" % (msg))
+        global failcount
         failcount +=3D 1
=20
=20
@@ -33,6 +34,7 @@ def check_break(sym_name):
     bp =3D gdb.Breakpoint(sym_name)
=20
     gdb.execute("c")
+    gdb.execute("c 100")
=20
     # hopefully we came back
     end_pc =3D gdb.parse_and_eval('$pc')
@@ -138,12 +140,12 @@ def run_test():
     # Can't set this up until we are in the kernel proper
     # if we make it to run_init_process we've over-run and
     # one of the tests failed
-    print ("Setup catch-all for run_init_process")
-    cbp =3D CatchBreakpoint("run_init_process")
-    cpb2 =3D CatchBreakpoint("try_to_run_init_process")
+    #print ("Setup catch-all for run_init_process")
+    #cbp =3D CatchBreakpoint("run_init_process")
+    #cpb2 =3D CatchBreakpoint("try_to_run_init_process")
=20
     print ("Checking Normal breakpoint works")
-    break_ok =3D check_break("wait_for_completion")
+    break_ok =3D check_break("SyS_execve")
     report(break_ok, "break @ wait_for_completion")
=20
     print ("Checking watchpoint works")


With -smp 1, check_break succeeds.

Jan


--DBG15VKyqusbmk9ztjr1e1CouawepY4N7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqIX5sACgkQitSsb3rl5xRzsQCfRIdeAmf0ziADglEwkcFA2rTR
yk8An2SfnINLrTZOaUfA8c9Cwhv8NcRI
=ZhnY
-----END PGP SIGNATURE-----

--DBG15VKyqusbmk9ztjr1e1CouawepY4N7--
