Received: from eggs.gnu.org ([2001:4830:134:3::10]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56v7-0003GT-BG
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56v6-0003JP-1e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e56v5-0003Hh-Ql
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:15:15 -0400
Date: Thu, 19 Oct 2017 10:15:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171019091507.GF8408@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1508352023-28591-1-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508352023-28591-1-git-send-email-alindsay@codeaurora.org>
Subject: Re: [Qemu-devel] [PATCH] build: Fix dtc-checkout race condition in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Oct 18, 2017 at 02:40:23PM -0400, Aaron Lindsay wrote:
> This was introduced by:
>     commit aef45d51d1204f3335fb99de6658e0c5612c2b67
>     Author: Daniel P. Berrange <berrange@redhat.com>
>     Date:   Fri Sep 29 11:11:56 2017 +0100
> 
> 	build: automatically handle GIT submodule checkout for dtc
> 
> On my system, I see the following with a fresh clone:
> 
> % ./configure --disable-gtk --target-list=aarch64-softmmu
> % make -j8
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
> mkdir -p dtc/libfdt
>   GIT     ui/keycodemapdb dtc
> mkdir -p dtc/tests
>   GEN     qemu-options.def
> [snip]
>   GEN     migration/trace.h
> make: *** [git-submodule-update] Error 1
> make: *** Waiting for unfinished jobs....
> 
> Upon closer inspection, the root cause of the error is:
> 
> % git submodule update --init ui/keycodemapdb dtc
> fatal: destination path 'dtc' already exists and is not an empty directory.
> Clone of 'git://git.qemu-project.org/dtc.git' into submodule path 'dtc' failed
> 
> This patch fixes this race condition by forcing the 'dtc/%' rule which caused
> 'dtc' to be non-empty to wait on '.git-submodule-status'.

Yes this makes sense

> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 90f91e5..ffa82e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -380,7 +380,7 @@ DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
>  subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>  	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
>  
> -dtc/%:
> +dtc/%: .git-submodule-status
>  	mkdir -p $@
>  
>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
