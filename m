Received: from eggs.gnu.org ([2001:4830:134:3::10]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZls-00082V-5V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZlo-0006p1-U8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:27:48 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:50849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYZlo-0006np-KH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:27:44 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e16-v6so10362632wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:27:44 -0700 (PDT)
References: <20180605160541.10664-1-alex.bennee@linaro.org>
	<20180605160541.10664-4-alex.bennee@linaro.org>
	<e52bc79e-6d12-743f-f1ae-fc1a1ac8969a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e52bc79e-6d12-743f-f1ae-fc1a1ac8969a@redhat.com>
Date: Thu, 28 Jun 2018 17:27:42 +0100
Message-ID: <87h8lmvptt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 3/6] Makefile: Rename TARGET_DIRS to
 TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/06/2018 18:05, Alex Benn=C3=A9e wrote:
>> From: Fam Zheng <famz@redhat.com>
>>
>> To be more accurate on its purpose and make code that looks for a certain
>> target out of this variable more readable.
>
> This breaks the Docker mingw build, because the full list of targets
> used on the host is passed to the container.  This includes linux-user
> targets which do not exist on non-Linux.

Ahh I hadn't noticed because we are not building the fill set on
shippable:

  https://app.shippable.com/github/qemu/qemu/runs/1046/2/console

>
> Paolo
>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/Makefile b/Makefile
>> index 6d588d1f71..023b3437ec 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -62,8 +62,8 @@ seems to have been used for an in-tree build. You can =
fix this by running \
>>  endif
>>  endif
>>
>> -CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
>> -CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
>> +CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_LIST)),y)
>> +CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_LIST)),y)
>>  CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
>>  CONFIG_ALL=3Dy
>>  -include config-all-devices.mak
>> @@ -366,8 +366,8 @@ DOCS=3D
>>  endif
>>
>>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=
=3D$(BUILD_DIR)
>> -SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
>> -SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET=
_DIRS))
>> +SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_LIST))
>> +SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGET=
_LIST))
>>
>>  ifeq ($(SUBDIR_DEVICES_MAK),)
>>  config-all-devices.mak:
>> @@ -470,7 +470,7 @@ config-host.h-timestamp: config-host.mak
>>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN",=
"$@")
>>
>> -SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
>> +SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_LIST))
>>  SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
>>
>>  $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>> @@ -514,7 +514,7 @@ ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
>>  romsubdir-%:
>>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V=3D"$(=
V)" TARGET_DIR=3D"$*/" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))",)
>>
>> -ALL_SUBDIRS=3D$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
>> +ALL_SUBDIRS=3D$(TARGET_LIST) $(patsubst %,pc-bios/%, $(ROMS))
>>
>>  recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
>>
>> @@ -772,7 +772,7 @@ distclean: clean
>>  	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
>>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
>>  	rm -f docs/qemu-block-drivers.7
>> -	for d in $(TARGET_DIRS); do \
>> +	for d in $(TARGET_LIST); do \
>>  	rm -rf $$d || exit 1 ; \
>>          done
>>  	rm -Rf .sdk
>> @@ -873,7 +873,7 @@ endif
>>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_dat=
adir)/keymaps"; \
>>  	done
>>  	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadi=
r)/trace-events-all"
>> -	for d in $(TARGET_DIRS); do \
>> +	for d in $(TARGET_LIST); do \
>>  	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; \
>>          done
>>
>> @@ -1071,9 +1071,9 @@ endif
>>  	@echo  '  ctags/TAGS      - Generate tags file for editors'
>>  	@echo  '  cscope          - Generate cscope index'
>>  	@echo  ''
>> -	@$(if $(TARGET_DIRS), \
>> +	@$(if $(TARGET_LIST), \
>>  		echo 'Architecture specific targets:'; \
>> -		$(foreach t, $(TARGET_DIRS), \
>> +		$(foreach t, $(TARGET_LIST), \
>>  		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);)=
 \
>>  		echo '')
>>  	@echo  'Cleaning targets:'
>> diff --git a/configure b/configure
>> index db8c9d8288..14b11130a7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6128,7 +6128,7 @@ qemu_version=3D$(head $source_path/VERSION)
>>  echo "VERSION=3D$qemu_version" >>$config_host_mak
>>  echo "PKGVERSION=3D$pkgversion" >>$config_host_mak
>>  echo "SRC_PATH=3D$source_path" >> $config_host_mak
>> -echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
>> +echo "TARGET_LIST=3D$target_list" >> $config_host_mak
>>  if [ "$docs" =3D "yes" ] ; then
>>    echo "BUILD_DOCS=3Dyes" >> $config_host_mak
>>  fi
>> diff --git a/scripts/create_config b/scripts/create_config
>> index d727e5e36e..58948a67a4 100755
>> --- a/scripts/create_config
>> +++ b/scripts/create_config
>> @@ -107,7 +107,7 @@ case $line in
>>      target_name=3D${line#*=3D}
>>      echo "#define TARGET_NAME \"$target_name\""
>>      ;;
>> - TARGET_DIRS=3D*)
>> + TARGET_LIST=3D*)
>>      # do nothing
>>      ;;
>>   TARGET_*=3Dy) # configuration
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 86f90c0cb0..9854e7794b 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -858,7 +858,7 @@ endif
>>
>>  # QTest rules
>>
>> -TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
>> +TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_LIST)))
>>  ifeq ($(CONFIG_POSIX),y)
>>  QTEST_TARGETS =3D $(TARGETS)
>>  check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
>>


--
Alex Benn=C3=A9e
