Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oAU-0003AE-S6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oAQ-0004st-Sa
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4oAQ-0004sI-Lz
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B67CB96CA
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 13:13:49 +0000 (UTC)
Date: Wed, 18 Oct 2017 14:13:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171018131342.GH9719@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: allow running from srcdir !=
 builddir build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On Wed, Oct 18, 2017 at 03:06:29PM +0200, Paolo Bonzini wrote:
> The new script uses "git submodule", which is picky about being invoked
> from the top of the git checkout.  Invoke the script from $(SRC_PATH)
> to avoid git's wrath.

I wonder if there's interest in being "evil" and flat out refusing to
ever build with srcdir==builddir. We have a never ending stream of
bugs where we forget to consider one of the two possible scenarios.

> 
> Fixes: b7f404201e45e99da23b9764dec27ce5f965cdcd
> Cc: Fam Zheng <famz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> ---
>  tests/docker/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 6f9ea19..b6d9fa3 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -18,11 +18,11 @@ TESTS ?= %
>  IMAGES ?= %
>  
>  CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
> -DOCKER_SRC_COPY := docker-src.$(CUR_TIME)
> +DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
>  
>  $(DOCKER_SRC_COPY):
>  	@mkdir $@
> -	$(call quiet-command, $(SRC_PATH)/scripts/archive-source.sh $@/qemu.tar, \
> +	$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/qemu.tar, \
>  		"GEN", "$@/qemu.tar")
>  	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
>  		"COPY","RUNNER")

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
