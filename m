Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIvQX-0006rf-Si
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIvQT-0004pQ-RJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:16:33 -0400
Date: Thu, 8 Jun 2017 19:16:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170608111616.GA14424@lemon.lan>
References: <1496907604-2393-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496907604-2393-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Makefile: Do not generate files if
 "configure" has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, 06/08 09:40, Thomas Huth wrote:
> When doing a "make -j10" in the vanilla QEMU source tree (without
> running "configure first), the Makefile currently generates two
> files already, qemu-version.h and qemu-options.def. This should not
> happen, so let's make these targets depend on config-host.mak.
> Also the targets that use python  can not be executed without the
> $(PYTHON) from config-host.mak, so these should depend on the config-
> host.mak file, too (these targets generate some ugly error messages
> otherwise during "make -j10").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Add the dependency to the targets that use $(PYTHON) instead of
>    adding it to $(qapi-py)
> 
>  Makefile | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c830d7a..b5e0731 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -286,7 +286,7 @@ endif
>  
>  all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules

Is it enough to add a

    $(filter-out $(GENERATED_FILES),config-host.mak): config-host.mak

after the variable is fully built?  (Seems config-host.mak is not included, but
filtering out is safer.)

Fam

>  
> -qemu-version.h: FORCE
> +qemu-version.h: config-host.mak FORCE
>  	$(call quiet-command, \
>  		(cd $(SRC_PATH); \
>  		printf '#define QEMU_PKGVERSION '; \
> @@ -312,6 +312,7 @@ qemu-version.h: FORCE
>  
>  config-host.h: config-host.h-timestamp
>  config-host.h-timestamp: config-host.mak
> +qemu-options.def: config-host.mak
>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> @@ -394,17 +395,17 @@ gen-out-type = $(subst .,-,$(suffix $@))
>  qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
>  
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
>  		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
>  qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h :\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
>  		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
>  qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c :\
> -$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
> +$(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
>  		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
>  		"GEN","$@")
> @@ -416,27 +417,27 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/trace.json
>  
>  qapi-types.c qapi-types.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
>  		$(gen-out-type) -o "." -b $<, \
>  		"GEN","$@")
>  qapi-visit.c qapi-visit.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
>  		$(gen-out-type) -o "." -b $<, \
>  		"GEN","$@")
>  qapi-event.c qapi-event.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
>  		$(gen-out-type) -o "." $<, \
>  		"GEN","$@")
>  qmp-commands.h qmp-marshal.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
>  		$(gen-out-type) -o "." $<, \
>  		"GEN","$@")
>  qmp-introspect.h qmp-introspect.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
> +$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
>  		$(gen-out-type) -o "." $<, \
>  		"GEN","$@")
> @@ -703,10 +704,10 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
>  
>  docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
>  
> -docs/qemu-qmp-qapi.texi: $(qapi-modules)
> +docs/qemu-qmp-qapi.texi: $(qapi-modules) config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
>  
> -docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
> +docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json config-host.mak
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
>  
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
> -- 
> 1.8.3.1
> 
> 
