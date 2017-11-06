Received: from eggs.gnu.org ([2001:4830:134:3::10]:51431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBgUr-0008C6-L8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBgUm-0000NT-Ot
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:27:21 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:49205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBgUm-0000K0-II
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:27:16 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 312DCA571F
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 13:27:07 +0100 (CET)
Date: Mon, 6 Nov 2017 13:26:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106132657.7fc49cdb@bahia>
In-Reply-To: <20171106114134.10125-1-berrange@redhat.com>
References: <20171106114134.10125-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: remove use of MAKELEVEL
 optimization in submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon,  6 Nov 2017 11:41:34 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> The Makefile attempts to optimize the handling of submodules by using MAKELEVEL
> to only check the submodule status when running from the top level make
> invokation. This causes problems for people who are using a makefile of their
> own to in turn invoke QEMU's makefile, as MAKELEVEL is already set to 1 (or
> more) when QEMU's makefile runs.
> 
> This optimization should not really be needed, since the git-submodule.sh
> script is already used to detect if a submodule update is required. This by
> removing the MAKELEVEL check, we at most add an extra 'git-submodule.sh status'
> call to each make level, the overhead of which is lost in noise of building
> QEMU.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 

Heh, I had come up with a similar patch based on master and nearly the
same commit message. :)

Reviewed-by: Greg Kurz <groug@kaod.org>

> NB this is on top of https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00449.html
> 

I could check that this patch applied on top of the series mentioned above
fixes the issue for me.

Tested-by: Greg Kurz <groug@kaod.org>

>  Makefile | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a92d7b8e14..0496c5057a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -18,12 +18,11 @@ git-submodule-update:
>  
>  .PHONY: git-submodule-update
>  
> -ifeq (0,$(MAKELEVEL))
> -  git_module_status := $(shell \
> -    cd '$(SRC_PATH)' && \
> -    GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> -    echo $$?; \
> -  )
> +git_module_status := $(shell \
> +  cd '$(SRC_PATH)' && \
> +  GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> +  echo $$?; \
> +)
>  
>  ifeq (1,$(git_module_status))
>  ifeq (no,$(GIT_UPDATE))
> @@ -42,7 +41,6 @@ git-submodule-update:
>            "GIT","$(GIT_SUBMODULES)")
>  endif
>  endif
> -endif
>  
>  .git-submodule-status: git-submodule-update config-host.mak
>  
