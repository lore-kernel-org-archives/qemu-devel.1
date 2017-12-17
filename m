Received: from eggs.gnu.org ([2001:4830:134:3::10]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQcPr-0004Fh-Rl
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 12:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQcPo-0000O8-L4
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 12:07:55 -0500
References: <151350631739.45.12182008427471484789@5adcb62bf0d6>
	<766e1250-9930-3af7-099c-29fafd37c270@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f358f063-dcb7-84c5-97c6-010618a6e24d@redhat.com>
Date: Sun, 17 Dec 2017 18:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <766e1250-9930-3af7-099c-29fafd37c270@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: Add missing
 QEMU_NORETURN attribute (CID 1383842)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, famz@redhat.com, agraf@suse.de, rth@twiddle.net, David Hildenbrand <david@redhat.com>

On 17.12.2017 11:58, Stefan Weil wrote:
> Am 17.12.2017 um 11:25 schrieb no-reply@patchew.org:
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details b=
elow.
> [...]
>> /var/tmp/patchew-tester-tmp-e2qiwzsb/src/target/s390x/interrupt.c: In =
function =E2=80=98s390_program_interrupt=E2=80=99:
>> /var/tmp/patchew-tester-tmp-e2qiwzsb/src/target/s390x/interrupt.c:55:1=
: error: =E2=80=98noreturn=E2=80=99 function does return [-Werror]
>=20
> Obviously the s390x compiler does more checks than my x86 gcc.
>=20
> To fix the new warning, QEMU_NORETURN would have to be added to
> kvm_s390_program_interrupt and tcg_s390_program_interrupt, too.
>=20
> I am not sure about kvm_s390_program_interrupt. Is it a function which
> will never return? Then the current code (which includes a return
> statement in kvm_s390_vcpu_interrupt) is not correct.

kvm_s390_program_interrupt() returns, so adding a QEMU_NORETURN to that
function is not a good idea.

> We could also move the g_assert_not_reached in s390_program_interrupt t=
o
> the end of the function. That should satisfy the compiler as well.

That also does not work since kvm_s390_program_interrupt() returns.

> Or we could suppress the s390x compiler warning by using a compiler
> pragma. But I don't like that alternative.

I think the best solution would be to call tcg_s390_program_interrupt()
directly from helper_divs64() instead of going through the
s390_program_interrupt() wrapper. helper_divs64() is for TCG only, so it
should be fine to directly use the tcg_s390_program_interrupt() function
there.

 Thomas
