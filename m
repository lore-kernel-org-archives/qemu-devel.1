Received: from eggs.gnu.org ([2001:4830:134:3::10]:40252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gGTj1-0003ol-Mb
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 14:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gGTj0-0000sQ-Lt
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 14:54:19 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gGTj0-0000rr-A9
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 14:54:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id e9so2545259oti.1
	for <qemu-devel@nongnu.org>; Sat, 27 Oct 2018 11:54:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181025215914-mutt-send-email-mst@kernel.org>
References: <20181025005110.249256-1-mst@redhat.com>
	<CAFEAcA9zqAOr7F_Pu1tqxJYd=4JMHa3XgR703Mb4B9LibOGB-w@mail.gmail.com>
	<20181025215914-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Oct 2018 19:53:56 +0100
Message-ID: <CAFEAcA9-g-h8S7wucyMw+kmrZLnkeCSqnXc8ohNW_KhNxLv7hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2018 at 03:00, Michael S. Tsirkin <mst@redhat.com> wrote:
> OK  I fixed 32 bit issues. Could not reproduce the test issues,
> could it be that it was a side effect of build issues maybe?
>
> Could you retyr?
> If it still ails I will drop the test for now.

Compiles OK, but still asserts
ERROR:/home/pm215/qemu/tests/bios-tables-test.c:398:load_expected_aml: assertion
 failed: (exp_sdt.aml_file)

on Linux/aarch64, Linux/arm32, Linux/SPARC, Linux/s390x.

pm215@gcc113:~/qemu/build/all$
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
./tests/bios-tables-test
/i386/acpi/piix4: OK
/i386/acpi/q35: ^[[AOK
/i386/acpi/piix4/bridge: OK
/i386/acpi/piix4/ipmi: OK
/i386/acpi/piix4/cpuhp: OK
/i386/acpi/piix4/memhp: OK
/i386/acpi/piix4/numamem: OK
/i386/acpi/piix4/dimmpxm: OK
/i386/acpi/q35/bridge: OK
/i386/acpi/q35/mmio64: **
ERROR:/home/pm215/qemu/tests/bios-tables-test.c:398:load_expected_aml:
assertion failed: (exp_sdt.aml_file)
Aborted (core dumped)

With V=1 it says
/i386/acpi/q35/mmio64:
Looking for expected file 'tests/acpi-test-data/q35/DSDT.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/DSDT'

Using expected file 'tests/acpi-test-data/q35/DSDT'

Looking for expected file 'tests/acpi-test-data/q35/FACP.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/FACP'

Using expected file 'tests/acpi-test-data/q35/FACP'

Looking for expected file 'tests/acpi-test-data/q35/APIC.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/APIC'

Using expected file 'tests/acpi-test-data/q35/APIC'

Looking for expected file 'tests/acpi-test-data/q35/HPET.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/HPET'

Using expected file 'tests/acpi-test-data/q35/HPET'

Looking for expected file 'tests/acpi-test-data/q35/SRAT.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/SRAT'
**
ERROR:/home/pm215/qemu/tests/bios-tables-test.c:398:load_expected_aml:
assertion failed: (exp_sdt.aml_file)

ET'

On an x86-64 host which works it says
/i386/acpi/q35/mmio64:
Looking for expected file 'tests/acpi-test-data/q35/DSDT.mmio64'

Using expected file 'tests/acpi-test-data/q35/DSDT.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/FACP.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/FACP'

Using expected file 'tests/acpi-test-data/q35/FACP'

Looking for expected file 'tests/acpi-test-data/q35/APIC.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/APIC'

Using expected file 'tests/acpi-test-data/q35/APIC'

Looking for expected file 'tests/acpi-test-data/q35/HPET.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/HPET'

Using expected file 'tests/acpi-test-data/q35/HPET'

Looking for expected file 'tests/acpi-test-data/q35/SRAT.mmio64'

Using expected file 'tests/acpi-test-data/q35/SRAT.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/MCFG.mmio64'

Looking for expected file 'tests/acpi-test-data/q35/MCFG'

Using expected file 'tests/acpi-test-data/q35/MCFG'
OK

So the difference is that the failing setup doesn't use
the SRAT.mmio64, and there is no SRAT file available for
fallback. (It also doesn't use DSDT.mmio64, but there there
is a fallback DSDT file in the tests/acpi-test-data/ directory.)

It looks like the test/acpi-test-data/ in the build directory
has not been populated with the MCFG.mmio64 file -- some of
the data files have symlinks from that directory back to the
source directory, but some do not. This seems to be done in
configure, but there is nothing in the makefile rules which
causes configure to be rerun because there is a new file
in your test data directory. A manual rerun of configure
adds the missing symlinks and causes the test to pass.

So I would characterise this as a makefile issue.

(PS: can we fix the extraneous extra blank lines in the test output
when run with V=1, please?)

thanks
-- PMM
