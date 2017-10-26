Received: from eggs.gnu.org ([2001:4830:134:3::10]:34695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iHa-0004eq-TM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iHW-0004mS-HO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:33:14 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:56680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iHW-0004mD-CG
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:33:10 -0400
Received: by mail-qt0-x241.google.com with SMTP id z28so4225875qtz.13
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:33:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171026130426.10626-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5670f64b-15e5-0747-8ab0-c329a83537ee@amsat.org>
Date: Thu, 26 Oct 2017 10:33:01 -0300
MIME-Version: 1.0
In-Reply-To: <20171026130426.10626-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>

On 10/26/2017 10:04 AM, Daniel P. Berrange wrote:
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

Clean :)

> 
> make: *** [Makefile:31: git-submodule-update] Error 1
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> +            echo && \
> +            exit 1)
> +else
>  git-submodule-update:
>  	$(call quiet-command, \
>            (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
>            "GIT","$(GIT_SUBMODULES)")
>  endif
>  endif
> +endif
>  
>  .git-submodule-status: git-submodule-update config-host.mak
>  
> diff --git a/configure b/configure
> index ce5a2d0105..2e3b5fc145 100755
> --- a/configure
> +++ b/configure
> @@ -267,8 +267,10 @@ stack_protector=""
>  
>  if test -e "$source_path/.git"
>  then
> +    git_update=yes
>      git_submodules="ui/keycodemapdb"
>  else
> +    git_update=no
>      git_submodules=""
>  fi
>  git="git"
> @@ -1297,11 +1299,15 @@ for opt do
>    ;;
>    --with-git=*) git="$optarg"
>    ;;
> +  --enable-git-update) git_update=yes
> +  ;;
> +  --disable-git-update) git_update=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
>        exit 1
> -  ;;
> +      ;;
>    esac
>  done
>  
> @@ -5534,6 +5540,7 @@ echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
>  echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
>  echo "GIT=$git" >> $config_host_mak
>  echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
> +echo "GIT_UPDATE=$git_update" >> $config_host_mak
>  
>  echo "ARCH=$ARCH" >> $config_host_mak
>  
> 
