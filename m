Received: from eggs.gnu.org ([2001:4830:134:3::10]:47629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5BTD-0002vV-8X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5BT9-0001Dw-Ut
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:47 -0400
Received: from smtp.citrix.com ([66.165.176.89]:29562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5BT9-0001DK-NX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:06:43 -0400
Date: Thu, 19 Oct 2017 15:05:45 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171019140545.GA30324@perard.uk.xensource.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171016131644.9565-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/11] build: automatically handle GIT
 submodule checkout for dtc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 03:16:34PM +0200, Gerd Hoffmann wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Currently if DTC is required by configure and not available in the host
> OS install, we exit with an error message telling the user to checkout a
> git submodule or install the library.
> 
> This introduces automatic handling of the git submodule checkout process
> and enables it for dtc. This only runs if building from GIT, so users of
> release tarballs still need the system library install. The current state
> of the git checkout is stashed in .git-submodule-status, and a helper
> program is used to determine if this state matches the desired submodule
> state. A dependency against 'Makefile' ensures that the submodule state
> is refreshed at the start of the build process
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Message-id: 20170929101201.21039-2-berrange@redhat.com
> 
> [ kraxel: use /bin/sh not bash for scripts/git-submodule.sh ]
> [ kraxel: fix Makefile dependencies ]
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> [fixup] Makefile dep
> ---

> diff --git a/Makefile b/Makefile
> index 97b4508d7d..9866909e08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,6 +14,27 @@ ifneq ($(wildcard config-host.mak),)
>  all:
>  include config-host.mak
>  
> +git-submodule-update:
> +
> +.PHONY: git-submodule-update
> +
> +ifeq (0,$(MAKELEVEL))

Hi,

this new patch, and especialy the use MAKELEVEL here does not work when
we build Xen, since we build QEMU when building Xen.

When Xen is built, a clone of qemu.git is made, and then configure/make
is called. At this point, MAKELEVEL would already be set so
the makefile rule git-submodule-update would be empty.

Is it possible to do things differently in the QEMU makefiles? (Or do we
have to simply unset MAKELEVEL in xen makefiles before building qemu.)

A build log of Xen (with the build failure of QEMU near the end):
http://logs.test-lab.xenproject.org/osstest/logs/114667/build-amd64/6.ts-xen-build.log

Thanks,

> +  git_module_status := $(shell \
> +    cd '$(SRC_PATH)' && \
> +    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> +    echo $$?; \
> +  )
> +
> +ifeq (1,$(git_module_status))
> +git-submodule-update:
> +	$(call quiet-command, \
> +          (cd $(SRC_PATH) && ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> +          "GIT","$(GIT_SUBMODULES)")
> +endif
> +endif
> +
> +.git-submodule-status: git-submodule-update
> +
>  # Check that we're not trying to do an out-of-tree build from
>  # a tree that's been used for an in-tree build.
>  ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> @@ -84,6 +105,7 @@ endif
>  GENERATED_FILES += $(TRACE_HEADERS)
>  GENERATED_FILES += $(TRACE_SOURCES)
>  GENERATED_FILES += $(BUILD_DIR)/trace-events-all
> +GENERATED_FILES += .git-submodule-status
>  
>  trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
>  
> @@ -330,7 +352,7 @@ DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_src
>  DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
>  DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
>  
> -subdir-dtc:dtc/libfdt dtc/tests
> +subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>  	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
>  
>  dtc/%:

-- 
Anthony PERARD
