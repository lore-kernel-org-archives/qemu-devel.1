Received: from eggs.gnu.org ([2001:4830:134:3::10]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eQWej-0007Gj-R3
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eQWee-0005gR-WB
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:58:53 -0500
References: <151350631739.45.12182008427471484789@5adcb62bf0d6>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <766e1250-9930-3af7-099c-29fafd37c270@weilnetz.de>
Date: Sun, 17 Dec 2017 11:58:45 +0100
MIME-Version: 1.0
In-Reply-To: <151350631739.45.12182008427471484789@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x: Add missing QEMU_NORETURN attribute
 (CID 1383842)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, rth@twiddle.net, agraf@suse.de, qemu-s390x@nongnu.org

Am 17.12.2017 um 11:25 schrieb no-reply@patchew.org:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
[...]
> /var/tmp/patchew-tester-tmp-e2qiwzsb/src/target/s390x/interrupt.c: In f=
unction =E2=80=98s390_program_interrupt=E2=80=99:
> /var/tmp/patchew-tester-tmp-e2qiwzsb/src/target/s390x/interrupt.c:55:1:=
 error: =E2=80=98noreturn=E2=80=99 function does return [-Werror]

Obviously the s390x compiler does more checks than my x86 gcc.

To fix the new warning, QEMU_NORETURN would have to be added to
kvm_s390_program_interrupt and tcg_s390_program_interrupt, too.

I am not sure about kvm_s390_program_interrupt. Is it a function which
will never return? Then the current code (which includes a return
statement in kvm_s390_vcpu_interrupt) is not correct.

We could also move the g_assert_not_reached in s390_program_interrupt to
the end of the function. That should satisfy the compiler as well.

Or we could suppress the s390x compiler warning by using a compiler
pragma. But I don't like that alternative.

Regards
Stefan
