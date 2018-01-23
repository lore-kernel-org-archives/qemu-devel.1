Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee17Q-0005BE-Lu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee17K-0002iN-KS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:08:16 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ee17K-0002hI-G6
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:08:10 -0500
Received: by mail-qt0-f193.google.com with SMTP id c2so2551062qtn.9
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 08:08:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123153842.GT490@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-11-git-send-email-pbonzini@redhat.com>
	<20180123153842.GT490@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 23 Jan 2018 17:08:08 +0100
Message-ID: <CAMxuvawOjy-gwmCcc8TYHbNNbpmAs8aMPw6dfri8tOg15Kk=SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi

On Tue, Jan 23, 2018 at 4:38 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> On Tue, Jan 16, 2018 at 03:16:52PM +0100, Paolo Bonzini wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu spec=
ific).
>>
>> Use --quiet to silence make 'is up to date' message.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Tested-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Message-Id: <20180104160523.22995-3-marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile  | 2 +-
>>  rules.mak | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> After applying it when you run 'make install' absolutely nothing is
> displayed, but it none the less does work. This is very misleading
> to devs who thing nothing is being installed...

Right, you would need V=3D1 now

> Either this needs reverting, or we need to re-write the 'install' target
> so that it generates messages of whats being installed. Perhaps something
> like this
>

Make sense to me, could you send a former patch for review?

thanks

> diff --git a/Makefile b/Makefile
> index f26ef1b1df..8ef195a0df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -697,28 +697,33 @@ ifneq ($(TOOLS),)
>  endif
>  ifneq ($(CONFIG_MODULES),)
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
> +       $(call quiet-command,\
>         for s in $(modules-m:.mo=3D$(DSOSUF)); do \
>                 t=3D"$(DESTDIR)$(qemu_moddir)/$$(echo $$s | tr / -)"; \
>                 $(INSTALL_LIB) $$s "$$t"; \
>                 test -z "$(STRIP)" || $(STRIP) "$$t"; \
> -       done
> +       done, "INSTALL", "$(modules-m)")
>  endif
>  ifneq ($(HELPERS-y),)
>         $(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
>  endif
>  ifneq ($(BLOBS),)
> +       $(call quiet-command,\
>         set -e; for x in $(BLOBS); do \
>                 $(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu=
_datadir)"; \
> -       done
> +       done, "INSTALL", "$(BLOBS)")
>  endif
>  ifeq ($(CONFIG_GTK),y)
>         $(MAKE) -C po $@
>  endif
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> +       $(call quiet-command,\
>         set -e; for x in $(KEYMAPS); do \
>                 $(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDI=
R)$(qemu_datadir)/keymaps"; \
> -       done
> -       $(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_d=
atadir)/trace-events-all"
> +       done, "INSTALL", "$(KEYMAPS)")
> +       $(call quiet-command,\
> +       $(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_d=
atadir)/trace-events-all",\
> +       "INSTALL", "trace-events-all")
>         for d in $(TARGET_DIRS); do \
>         $(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1=
 ; \
>          done
> diff --git a/rules.mak b/rules.mak
> index 5fb4951561..cd669833bf 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -147,7 +147,8 @@ set-vpath =3D $(if $1,$(foreach PATTERN,$(VPATH_SUFFI=
XES),$(eval vpath $(PATTERN)
>  # install-prog list, dir
>  define install-prog
>         $(INSTALL_DIR) "$2"
> -       $(INSTALL_PROG) $1 "$2"
> +       $(call quiet-command,\
> +           $(INSTALL_PROG) $1 "$2", "INSTALL", "$1")
>         $(if $(STRIP),$(STRIP) $(foreach T,$1,"$2/$(notdir $T)"),)
>  endef
>
>
>
>
>>
>> diff --git a/Makefile b/Makefile
>> index d86ecd2..1671db3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -277,7 +277,7 @@ else
>>  DOCS=3D
>>  endif
>>
>> -SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUILD=
_DIR)
>> +SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
>>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS)=
)
>>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET=
_DIRS))
>>
>> diff --git a/rules.mak b/rules.mak
>> index 6e94333..5fb4951 100644
>> --- a/rules.mak
>> +++ b/rules.mak
>> @@ -131,6 +131,8 @@ modules:
>>  # If called with only a single argument, will print nothing in quiet mo=
de.
>>  quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &&=
 $1, @$1))
>>
>> +MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
>> +
>>  # cc-option
>>  # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-fun=
ctions=3D0)
>>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
