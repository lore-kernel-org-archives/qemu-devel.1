Received: from eggs.gnu.org ([2001:4830:134:3::10]:36484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVyyo-0004az-Fz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVyyn-0001eU-Ls
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVyyn-0001dP-CO
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:53 -0400
Date: Fri, 14 Jul 2017 19:41:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714114149.GB10205@lemon>
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>, patches@linaro.org

On Fri, 07/14 11:45, Peter Maydell wrote:
> In various places in our test makefiles and scripts we use the
> shell $RANDOM to create a random number. This is a bash
> specific extension, and doesn't work on other shells.
> With dash the shell doesn't complain, it just effectively
> always evaluates $RANDOM to 0:
>   echo $((RANDOM + 32768))     => 32768
> 
> However, on NetBSD the shell will complain:
>   "-sh: arith: syntax error: "RANDOM + 32768"
> 
> which means that "make check" fails.
> 
> Switch to using "${RANDOM:-0}" instead of $RANDOM,
> which will portably either give us a random number or zero.
> This means that on non-bash shells we don't get such
> good test coverage via the MALLOC_PERTURB_ setting, but
> we were already in that situation for non-bash shells.
> 
> Our only other uses of $RANDOM (in tests/qemu-iotests/check
> and tests/qemu-iotests/162) are in shell scripts which use
> a #!/bin/bash line so they are always run under bash.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 6d6cb74..f6310d2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -826,7 +826,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
> -		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
> +		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
>  		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
>  	  echo Gcov report for $$f:;\
> @@ -837,7 +837,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
>  $(patsubst %, check-%, $(check-unit-y)): check-%: %
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command, \
> -		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
> +		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \

The whitespaces before $${RANDOM:-0} look a bit strange (unusual and unpaired).
Otherwise looks good. (I guess it provides a tiny bit of more readability given
how many non-whitespaces are already there before it.)

Regardlessly:

Reviewed-by: Fam Zheng <famz@redhat.com>

>  		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(gcov-files-generic-y); do \
>  	  echo Gcov report for $$f:;\
> -- 
> 2.7.4
> 
> 
