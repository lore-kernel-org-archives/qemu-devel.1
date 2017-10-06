Received: from eggs.gnu.org ([2001:4830:134:3::10]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e0T98-0000NB-UR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e0T94-00059d-0L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e0T93-000589-OR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:58:29 -0400
Date: Fri, 6 Oct 2017 14:58:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171006135822.GG26575@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171006111342.6665-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006111342.6665-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] keycodemapdb: try fix makefile deps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Fri, Oct 06, 2017 at 01:13:42PM +0200, Gerd Hoffmann wrote:
> (1) make .git-submodule-status depend on config-host.mak,
>     for GIT_SUBMODULES changes.
> 
> (2) make $(KEYCODEMAP_{GEN,CSV}) depend on .git-submodule-status
>     so make knows what to do if they are not there.
> 
> I still get errors because make tries to generate the files before they are checked out,
> but make seems to notice it has to start over and correctly generates the files on the
> second attempt.
> 
> [ ... ]
>   GEN     config-host.h
>   GEN     module_block.h
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
> python: can't open file '/home/kraxel/projects/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory
> python: can't open file '/home/kraxel/projects/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory
> python: can't open file '/home/kraxel/projects/qemu/ui/keycodemapdb/tools/keymap-gen': [Errno 2] No such file or directory

We could perhaps avoid that error message by changing the make rule to
do    "test -e $(KEYCODEMAP_GEN) && $(KEYCODEMAP_GEN) || exit 0"

> make: Leaving directory `/home/kraxel/projects/qemu/build-default'
> make: Entering directory `/home/kraxel/projects/qemu/build-default'
>   GIT     ui/keycodemapdb
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   CC      qga/main.o
> [ ... ]
> ---
>  Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1d3b31f074..c97258629e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,7 +33,7 @@ git-submodule-update:
>  endif
>  endif
>  
> -.git-submodule-status: git-submodule-update
> +.git-submodule-status: git-submodule-update config-host.mak
>  
>  Makefile: .git-submodule-status
>  
> @@ -225,7 +225,7 @@ KEYCODEMAP_FILES = \
>  
>  GENERATED_FILES += $(KEYCODEMAP_FILES)
>  
> -ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs .git-submodule-status
> +ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
>  	$(call quiet-command,\
>  	    src=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\1,") && \
>  	    dst=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\2,") && \
> @@ -235,6 +235,9 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile
>  	          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
>  	        > $@ || rm $@, "GEN", "$@")
>  
> +$(KEYCODEMAP_GEN): .git-submodule-status
> +$(KEYCODEMAP_CSV): .git-submodule-status
> +
>  # Don't try to regenerate Makefile or configure
>  # We don't generate any of them
>  Makefile: ;

This looks like a plausible solution to the problem. I've just kicked off
a travis buld with the patch applied:

https://travis-ci.org/berrange/qemu/builds/284220642

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
