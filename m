Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee0f5-0003mS-Ij
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee0f1-0001GC-MC
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:38:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ee0f1-0001B6-9p
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:38:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C25DD554D
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 15:38:52 +0000 (UTC)
Date: Tue, 23 Jan 2018 15:38:42 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180123153842.GT490@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-11-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516112253-14480-11-git-send-email-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 10/51] build-sys: silence make by default or
 V=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jan 16, 2018 at 03:16:52PM +0100, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu spe=
cific).
>=20
> Use --quiet to silence make 'is up to date' message.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20180104160523.22995-3-marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile  | 2 +-
>  rules.mak | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

After applying it when you run 'make install' absolutely nothing is
displayed, but it none the less does work. This is very misleading
to devs who thing nothing is being installed...

Either this needs reverting, or we need to re-write the 'install' target
so that it generates messages of whats being installed. Perhaps something
like this

diff --git a/Makefile b/Makefile
index f26ef1b1df..8ef195a0df 100644
--- a/Makefile
+++ b/Makefile
@@ -697,28 +697,33 @@ ifneq ($(TOOLS),)
 endif
 ifneq ($(CONFIG_MODULES),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
+	$(call quiet-command,\
 	for s in $(modules-m:.mo=3D$(DSOSUF)); do \
 		t=3D"$(DESTDIR)$(qemu_moddir)/$$(echo $$s | tr / -)"; \
 		$(INSTALL_LIB) $$s "$$t"; \
 		test -z "$(STRIP)" || $(STRIP) "$$t"; \
-	done
+	done, "INSTALL", "$(modules-m)")
 endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
 ifneq ($(BLOBS),)
+	$(call quiet-command,\
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
-	done
+	done, "INSTALL", "$(BLOBS)")
 endif
 ifeq ($(CONFIG_GTK),y)
 	$(MAKE) -C po $@
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
+	$(call quiet-command,\
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_data=
dir)/keymaps"; \
-	done
-	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir=
)/trace-events-all"
+	done, "INSTALL", "$(KEYMAPS)")
+	$(call quiet-command,\
+	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir=
)/trace-events-all",\
+	"INSTALL", "trace-events-all")
 	for d in $(TARGET_DIRS); do \
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; \
         done
diff --git a/rules.mak b/rules.mak
index 5fb4951561..cd669833bf 100644
--- a/rules.mak
+++ b/rules.mak
@@ -147,7 +147,8 @@ set-vpath =3D $(if $1,$(foreach PATTERN,$(VPATH_SUFFI=
XES),$(eval vpath $(PATTERN)
 # install-prog list, dir
 define install-prog
 	$(INSTALL_DIR) "$2"
-	$(INSTALL_PROG) $1 "$2"
+	$(call quiet-command,\
+	    $(INSTALL_PROG) $1 "$2", "INSTALL", "$1")
 	$(if $(STRIP),$(STRIP) $(foreach T,$1,"$2/$(notdir $T)"),)
 endef
=20



>=20
> diff --git a/Makefile b/Makefile
> index d86ecd2..1671db3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -277,7 +277,7 @@ else
>  DOCS=3D
>  endif
> =20
> -SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUIL=
D_DIR)
> +SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS=
))
>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGE=
T_DIRS))
> =20
> diff --git a/rules.mak b/rules.mak
> index 6e94333..5fb4951 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -131,6 +131,8 @@ modules:
>  # If called with only a single argument, will print nothing in quiet m=
ode.
>  quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &=
& $1, @$1))
> =20
> +MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
> +
>  # cc-option
>  # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-fu=
nctions=3D0)
> =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
