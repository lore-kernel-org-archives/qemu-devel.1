Received: from eggs.gnu.org ([2001:4830:134:3::10]:38429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfm7Y-0008Bd-1g
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfm7T-0000Za-FY
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:59:24 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfm7T-0000ZW-A0
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:59:19 -0400
Received: by mail-ua0-x243.google.com with SMTP id w45so240474uac.3
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 04:59:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170810085025.14076-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d899b2a-19a0-5b52-c63e-dba8b1d2d851@amsat.org>
Date: Thu, 10 Aug 2017 08:59:15 -0300
MIME-Version: 1.0
In-Reply-To: <20170810085025.14076-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Let "make check-help" work
 without running ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Fam,

thank for fixing this :)

I think as a bugfix it should enter 2.10
(maybe through Alex's Travis series, CC'ing him)

On 08/10/2017 05:50 AM, Fam Zheng wrote:
> Currently if you do "make check-help" in a fresh checkout, only an error
> is printed which is not nice:
> 
>      $ make check-help V=1
>      cc -nostdlib  -o check-help.mo
>      cc: fatal error: no input files
>      compilation terminated.
>      rules.mak:115: recipe for target 'check-help.mo' failed
>      make: *** [check-help.mo] Error 1
> 
> Move the config-host.mak condition into the body of
> tests/Makefile.include and always include the rule for check-help.
> 
> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile               |  2 --
>   tests/Makefile.include | 46 +++++++++++++++++++++++++---------------------
>   2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 97a58a0f4e..81447b1f08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -281,9 +281,7 @@ dummy := $(call unnest-vars,, \
>                   common-obj-m \
>                   trace-obj-y)
>   
> -ifneq ($(wildcard config-host.mak),)
>   include $(SRC_PATH)/tests/Makefile.include
> -endif
>   
>   all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
>   
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index eb4895f94a..37c1bed683 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1,3 +1,26 @@
> +
> +.PHONY: check-help
> +check-help:
> +	@echo "Regression testing targets:"
> +	@echo
> +	@echo " make check                Run all tests"
> +	@echo " make check-qtest-TARGET   Run qtest tests for given target"
> +	@echo " make check-qtest          Run qtest tests"
> +	@echo " make check-unit           Run qobject tests"
> +	@echo " make check-speed          Run qobject speed tests"
> +	@echo " make check-qapi-schema    Run QAPI schema tests"
> +	@echo " make check-block          Run block tests"
> +	@echo " make check-report.html    Generates an HTML test report"
> +	@echo " make check-clean          Clean the tests"
> +	@echo
> +	@echo "Please note that HTML reports do not regenerate if the unit tests"
> +	@echo "has not changed."
> +	@echo
> +	@echo "The variable SPEED can be set to control the gtester speed setting."
> +	@echo "Default options are -k and (for make V=1) --verbose; they can be"
> +	@echo "changed with variable GTESTER_OPTIONS."
> +
> +ifneq ($(wildcard config-host.mak),)
>   export SRC_PATH
>   
>   qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
> @@ -802,27 +825,6 @@ $(check-qtest-y): $(qtest-obj-y)
>   
>   tests/test-qga: tests/test-qga.o $(qtest-obj-y)
>   
> -.PHONY: check-help
> -check-help:
> -	@echo "Regression testing targets:"
> -	@echo
> -	@echo " make check                Run all tests"
> -	@echo " make check-qtest-TARGET   Run qtest tests for given target"
> -	@echo " make check-qtest          Run qtest tests"
> -	@echo " make check-unit           Run qobject tests"
> -	@echo " make check-speed          Run qobject speed tests"
> -	@echo " make check-qapi-schema    Run QAPI schema tests"
> -	@echo " make check-block          Run block tests"
> -	@echo " make check-report.html    Generates an HTML test report"
> -	@echo " make check-clean          Clean the tests"
> -	@echo
> -	@echo "Please note that HTML reports do not regenerate if the unit tests"
> -	@echo "has not changed."
> -	@echo
> -	@echo "The variable SPEED can be set to control the gtester speed setting."
> -	@echo "Default options are -k and (for make V=1) --verbose; they can be"
> -	@echo "changed with variable GTESTER_OPTIONS."
> -
>   SPEED = quick
>   GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
>   GCOV_OPTIONS = -n $(if $(V),-f,)
> @@ -917,3 +919,5 @@ all: $(QEMU_IOTESTS_HELPERS-y)
>   
>   -include $(wildcard tests/*.d)
>   -include $(wildcard tests/libqos/*.d)
> +
> +endif
> 
