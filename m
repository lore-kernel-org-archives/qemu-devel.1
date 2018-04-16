Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tLC-00071u-V3
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tLB-0003D9-VM
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:53:59 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tLB-0003D5-Qz
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:53:57 -0400
Received: by mail-qt0-x243.google.com with SMTP id d12so1004032qtp.7
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:53:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-25-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8264b7be-b16f-75e8-1462-88b3d197933d@amsat.org>
Date: Sun, 15 Apr 2018 22:53:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 24/24] tests/Makefile.include: add
 (clean-)check-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> This will ensure all linux-user targets build their guest test
> programs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/Makefile.include | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3d2f0458ab..c402de901e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -10,6 +10,7 @@ check-help:
>  	@echo " $(MAKE) check-speed          Run qobject speed tests"
>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>  	@echo " $(MAKE) check-block          Run block tests"
> +	@echo " $(MAKE) check-tcg            Run TCG tests"
>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>  	@echo " $(MAKE) check-clean          Clean the tests"
>  	@echo
> @@ -916,6 +917,23 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
>  check-report.html: check-report.xml
>  	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
>  
> +# Per guest TCG tests
> +
> +LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
> +BUILD_TCG_TARGET_RULES=$(patsubst %,tcg-tests-%, $(LINUX_USER_TARGETS))
> +CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
> +
> +tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
> +
> +clean-tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
> +
> +.PHONY: check-tcg
> +check-tcg: $(BUILD_TCG_TARGET_RULES)
> +
> +.PHONY: clean-tcg
> +clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  
>  # Other tests
>  
> @@ -958,7 +976,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  check: check-qapi-schema check-unit check-qtest check-decodetree
>  check-clean:
> -	$(MAKE) -C tests/tcg clean
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>  	rm -f tests/test-qapi-gen-timestamp
> 
