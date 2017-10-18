Received: from eggs.gnu.org ([2001:4830:134:3::10]:58098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w5b-00033S-Qw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w5X-0005Ml-Lg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:41:23 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4w5X-0005MN-HX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:41:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id f199so8101036qke.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:41:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508352023-28591-1-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47498c6b-31ee-b227-1f0d-4e7fabf75261@amsat.org>
Date: Wed, 18 Oct 2017 18:41:15 -0300
MIME-Version: 1.0
In-Reply-To: <1508352023-28591-1-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Aaron Lindsay <alindsay@codeaurora.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On 10/18/2017 03:40 PM, Aaron Lindsay wrote:
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
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
