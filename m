Received: from eggs.gnu.org ([2001:4830:134:3::10]:53956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcOP-0007ZC-Jh
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcOK-0001aq-An
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:56:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAcOG-0001XC-Ij
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:56:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so10070083wrs.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:56:39 -0700 (PDT)
References: <20181011144751.2724218-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6941b20-2612-4347-03d4-4655dadd03d5@redhat.com>
Date: Thu, 11 Oct 2018 16:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181011144751.2724218-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Prevent more accidental test
 disabling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 11/10/2018 16:47, Eric Blake wrote:
> GNU make is perfectly happy to use 'check-FOO-y += bar' to
> initialize check-FOO-y.  (GNU Automake strictly insists that
> you cannot use += until after an initial = per variable, but
> thankfully we aren't using automake).
> 
> As we have had more than one instance where copy-and-paste of
> 'check-FOO-y = bar' from a first test under category FOO into
> an additional test, which ends up disabling the first (see
> commits 992159c7 and 4429532b), it's better to just always use
> the form that survives copy-and-paste, even for categories that
> don't currently add more than one test.
> 
> Done with s/^\(check-[a-z]*-y \)=/\1+=/g
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/Makefile.include | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8264af64a86..fa6d30e26f7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -38,7 +38,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
>  SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
>     $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
> 
> -check-unit-y = tests/check-qdict$(EXESUF)
> +check-unit-y += tests/check-qdict$(EXESUF)
>  gcov-files-check-qdict-y = qobject/qdict.c
>  check-unit-y += tests/check-block-qdict$(EXESUF)
>  gcov-files-check-block-qdict-y = qobject/block-qdict.c
> @@ -181,7 +181,7 @@ check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
>  # All QTests for now are POSIX-only, but the dependencies are
>  # really in libqtest, not in the testcases themselves.
> 
> -check-qtest-generic-y = tests/qmp-test$(EXESUF)
> +check-qtest-generic-y += tests/qmp-test$(EXESUF)
>  gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
>  check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
> 
> @@ -324,13 +324,13 @@ check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
>  gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
> 
> -check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
> +check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
> 
> -check-qtest-hppa-y = tests/boot-serial-test$(EXESUF)
> +check-qtest-hppa-y += tests/boot-serial-test$(EXESUF)
> 
>  check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
> 
> -check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
> +check-qtest-microblaze-y += tests/boot-serial-test$(EXESUF)
> 
>  check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> 
> @@ -338,7 +338,7 @@ check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> 
>  check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> 
> -check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
> +check-qtest-moxie-y += tests/boot-serial-test$(EXESUF)
> 
>  check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
> @@ -348,7 +348,7 @@ check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
>  gcov-files-ppc-y += hw/timer/m48t59.c
> 
> -check-qtest-ppc64-y = $(check-qtest-ppc-y)
> +check-qtest-ppc64-y += $(check-qtest-ppc-y)
>  gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
>  check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
>  gcov-files-ppc64-y += ppc64-softmmu/hw/ppc/spapr_pci.c
> @@ -377,7 +377,7 @@ check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> 
>  check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> 
> -check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
> +check-qtest-sparc-y += tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
>  gcov-files-sparc-y = hw/timer/m48t59.c
>  check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
> @@ -386,7 +386,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
>  check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
> 
> -check-qtest-arm-y = tests/tmp105-test$(EXESUF)
> +check-qtest-arm-y += tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y += tests/pca9552-test$(EXESUF)
>  check-qtest-arm-y += tests/ds1338-test$(EXESUF)
>  check-qtest-arm-y += tests/m25p80-test$(EXESUF)
> @@ -403,9 +403,9 @@ check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> 
> -check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
> +check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
> 
> -check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
> +check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
> 
>  check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
>  check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
> 
