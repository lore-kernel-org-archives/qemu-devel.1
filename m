Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7x22-0000ae-MN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7x1z-0003Ze-Ge
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:18:10 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:56278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7x1z-0003Z6-7w
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:18:07 -0400
Received: by mail-io0-x244.google.com with SMTP id p186so10173063ioe.12
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 22:18:06 -0700 (PDT)
References: <20171026130426.10626-1-berrange@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c66feebb-854a-f2e5-da98-7180bf42ac8f@ozlabs.ru>
Date: Fri, 27 Oct 2017 16:18:00 +1100
MIME-Version: 1.0
In-Reply-To: <20171026130426.10626-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: allow automatic git submodule
 updates to be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 27/10/17 00:04, Daniel P. Berrange wrote:
> Some people building QEMU use VPATH builds where the source directory is on a
> read-only volume. In such a case 'scripts/git-submodules.sh update' will always
> fail and users are required to run it manually themselves on their original
> writable source directory.
> 
> While this is already supported, it is nice to give users a command line flag
> to configure to permanently disable automatic submodule updates, as it means
> they won't get hard to diagnose failures from git-submodules.sh at an arbitrary
> later date.
> 
> This patch thus introduces a flag '--disable-git-update' which will prevent
> 'make' from ever running 'scripts/git-submodules.sh update'. It will still run
> the 'status' command to determine if a submodule update is needed, but when it
> does this it'll simply stop and print a message instructing the developer what
> todo. eg
> 
> $ ./configure  --target-list=x86_64-softmmu --disable-git-update
> ...snip...
> 
> $ make
>   GEN     config-host.h
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
> 
> GIT submodule checkout is out of date. Please run
>   scripts/git-submodule.sh update ui/keycodemapdb
> from the source directory checkout /home/berrange/src/virt/qemu
> 
> make: *** [Makefile:31: git-submodule-update] Error 1
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile  | 11 +++++++++++
>  configure |  9 ++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 4c9d0eaef2..cefb75dc8d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -26,12 +26,23 @@ ifeq (0,$(MAKELEVEL))
>    )
>  
>  ifeq (1,$(git_module_status))
> +ifeq (no,$(GIT_UPDATE))
> +git-submodule-update:
> +	$(call quiet-command, \
> +            echo && \
> +            echo "GIT submodule checkout is out of date. Please run" && \
> +            echo "  scripts/git-submodule.sh update $(GIT_SUBMODULES)" && \
> +            echo "from the source directory checkout $(SRC_PATH)" && \


I'd love to see this warning when $GIT_UPDATE!=no too. Now it is:

  GIT     ui/keycodemapdb dtc
./scripts/git-submodule.sh: 36: ./scripts/git-submodule.sh: cannot create
.git-submodule-status: Read-only file system
Makefile:40: recipe for target 'git-submodule-update' failed


Other than that, looks nice, thanks for fixing it.



-- 
Alexey
