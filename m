Received: from eggs.gnu.org ([2001:4830:134:3::10]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuM1-0007vr-5z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuLx-0002as-4i
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:56:21 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuLw-0002ao-VH
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:56:17 -0400
Received: by mail-wm0-x233.google.com with SMTP id m125so76078951wmm.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:56:16 -0700 (PDT)
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170616161334.7492-5-f4bug@amsat.org>
Date: Mon, 19 Jun 2017 11:56:56 +0100
Message-ID: <8760fsutxj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/11] tests: add rule to compile many
 objects used by tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> all those objects can get compiled simultaneously
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/Makefile.include | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f42f3dfa72..3773f9d8d2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -804,6 +804,7 @@ check-help:
>  	@echo " make check-qapi-schema    Run QAPI schema tests"
>  	@echo " make check-block          Run block tests"
>  	@echo " make check-report.html    Generates an HTML test report"
> +	@echo " make check-compile        Compile objects used by tests"
>  	@echo " make check-clean          Clean the tests"
>  	@echo
>  	@echo "Please note that HTML reports do not regenerate if the unit tests"
> @@ -887,7 +888,7 @@ check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
>
>  # Consolidated targets
>
> -.PHONY: check-qapi-schema check-qtest check-unit check check-clean
> +.PHONY: check-qapi-schema check-qtest check-unit check check-clean check-compile
>  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  check-unit: $(patsubst %,check-%, $(check-unit-y))
> @@ -897,7 +898,10 @@ check-clean:
>  	$(MAKE) -C tests/tcg clean
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> -
> +check-compile: $(check-qtest-generic-y) $(check-unit-y) $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) $(chardev-obj-y) $(QEMU_IOTESTS_HELPERS-y)
> +ifeq ($(CONFIG_SOFTMMU),y)
> +check-compile: $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)))
> +endif
>  clean: check-clean
>
>  # Build the help program automatically

Something has gone wrong here:

  11:54 alex@zen taken:111, git:review/travis-speedup, [/home/alex/lsrc/qemu/qemu.git]> make check-compile
          CHK version_gen.h
    LINK    tests/ac97-test
  tests/ac97-test.o: In function `main':
  /home/alex/lsrc/qemu/qemu.git/tests/ac97-test.c:23: undefined reference to `qtest_add_func'
  tests/ac97-test.o: In function `qtest_start':
  /home/alex/lsrc/qemu/qemu.git/tests/libqtest.h:521: undefined reference to `qtest_init'
  /home/alex/lsrc/qemu/qemu.git/tests/libqtest.h:521: undefined reference to `global_qtest'
  tests/ac97-test.o: In function `qtest_end':
  /home/alex/lsrc/qemu/qemu.git/tests/libqtest.h:532: undefined reference to `global_qtest'
  /home/alex/lsrc/qemu/qemu.git/tests/libqtest.h:532: undefined reference to `qtest_quit'
  /home/alex/lsrc/qemu/qemu.git/tests/libqtest.h:533: undefined reference to `global_qtest'
  collect2: error: ld returned 1 exit status
  /home/alex/lsrc/qemu/qemu.git/rules.mak:121: recipe for target 'tests/ac97-test' failed
  make: *** [tests/ac97-test] Error 1

Yet "make check" completes without issue.

Also I would expect the check: target to have check-compile as one of
its pre-requisites otherwise this target will bit rot.

--
Alex Bennée
