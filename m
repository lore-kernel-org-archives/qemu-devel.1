Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E9020768
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIiC4hUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E9020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMa86-0006lS-3C
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMa7Q-0006L1-TG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMa7P-0004M1-87
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:33:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMa7P-0004Lm-0W
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586450010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e4qS9NYmcGx6l5M1QXrgjPKDpJNuprUUdFLE6DLajA=;
 b=NIiC4hUXeWU/zcywdzbnG75DkhYw2nVSg7aJhZ8osT9pIOUgl1iR1q29lWnAKHc0VF91aL
 S5UBh9qs7270gjBWKCsMkV80vWiIm1+8wij/YBDZoWE/1eRafip8w02Y8va+UX9gP29P9f
 qtV0uY9ujQODPaJSJRUC2uCb1ecVSuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-B-OGCsVrMb-QcblvsScfwQ-1; Thu, 09 Apr 2020 12:33:26 -0400
X-MC-Unique: B-OGCsVrMb-QcblvsScfwQ-1
Received: by mail-ed1-f71.google.com with SMTP id j10so398609edy.21
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 09:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0e4qS9NYmcGx6l5M1QXrgjPKDpJNuprUUdFLE6DLajA=;
 b=K7yfAt4a0LjTqxo0zlPZhg1ybRsfn41mlCzcLrfnAsLwrB7HDrFIY7GGBqap5joCsB
 YZ3ncIHBegVumVJmWASZ6ykYkW0/ZjaB7D2g77fn08nUvaRibb4NC5SSX0aSd3NlxmQO
 BVpwLCEQPaE8q6uyw1SwlouJ8jH9yqwqP10Wz0MttsZfIkeEWSy4ZmldXZ3g5cQYvBhr
 OWuOi/OXZ17bxO7e7up8xsdDgWrKJkoJwpIBvkYk8kjTGZVQxXtN6YefUdWVUl+9OjKW
 BgW74s2Fk1Z33Ftyx5W6zG3bTQfhuuvsDAIzJf3nNEdgC8wuMSIZu6oPtJ7nS8PAH22G
 6O7w==
X-Gm-Message-State: AGi0PubYkSrqLAGlhFLnsmmQUT+FheJm0c6/B5PCXa7Gt3T1iX+wlmqI
 vvAg16uY1xThRl9opfi61gJW0G7hlpbHLRSGzqoqiCiwpY0EqbD0KufdvcwBdSFsWxftPjqO5S/
 MScJes7YooGBkDe4=
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr804244edu.321.1586450005160; 
 Thu, 09 Apr 2020 09:33:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJJ+KAMy8VYioXfvaVlwHRx3+HtsqUgML18Y7a804z24RnEfaxkZB0ecahJ1WqSZO06Y9XzEg==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr804218edu.321.1586450004895; 
 Thu, 09 Apr 2020 09:33:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u2sm3104842edj.21.2020.04.09.09.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 09:33:24 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: libfdt: build only the strict necessary
To: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200409124337.32134-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a5ea4be-96bb-b686-1683-52269bd518ff@redhat.com>
Date: Thu, 9 Apr 2020 18:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409124337.32134-1-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Claudio,

On 4/9/20 2:43 PM, Claudio Fontana wrote:
> when building dtc/libfdt, we were previously using dtc/Makefile,
> which tries to build some artifacts that are not needed,
> and can complain on stderr about the absence of tools that
> are not required to build just libfdt.
> 
> Instead, build only the strict necessary to get libfdt.a .
> 
> Remove the subdir-dtc "compatibility gunk" for recursion,
> since we are not recursing anymore.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   Makefile  | 23 +++++++++++++----------
>   configure |  6 +-----
>   rules.mak |  2 ++
>   3 files changed, 16 insertions(+), 15 deletions(-)
> 
> v1 -> v2:
> 
> * fix error generated when running UNCHECKED_GOALS without prior configure,
>    for example during make docker-image-fedora. Without configure, DSOSUF is
>    empty, and the module pattern rule in rules.mak that uses this variable
>    can match too much; provide a default in the Makefile to avoid it.
> 
> * only attempt to build the archive when there is a non-empty list of objects.
>    This could be done in general for the %.a: pattern in rules.mak, but maybe
>    there are valid reasons to build an empty .a?
> 
> * removed some intermediate variables that did not add much value
>    (LIBFDT_srcdir, LIBFDT_archive)
> 
> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
> and with docker-image-fedora, docker-test-debug@fedora that failed before.
> 
> diff --git a/Makefile b/Makefile
> index 84ef881600..92bc853b5f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,6 +4,10 @@ ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>     $(error main directory cannot contain spaces nor colons)
>   endif
>   
> +# some pattern rules in rules.mak are confused by an empty DSOSUF,
> +# and UNCHECKED_GOALS for testing (docker-) can run without prior configure.
> +DSOSUF ?= ".so"
> +
>   # Always point to the root of the build tree (needs GNU make).
>   BUILD_DIR=$(CURDIR)
>   
> @@ -526,15 +530,16 @@ $(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
>   $(TARGET_DIRS_RULES):
>   	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
>   
> -DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
> -DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
> -DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
> -
> -.PHONY: dtc/all
> -dtc/all: .git-submodule-status dtc/libfdt dtc/tests

I'm getting:

config-host.mak is out-of-date, running configure
make: *** No rule to make target 'dtc/all', needed by 'config-host.h'. 
Stop.

On second try it works.

Instead of alarming users, we could keep this target as a silent no-op, 
then remove it after some time.

For the rest, patch looks good, nice cleanup!

Regards,

Phil.

> -	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
> +LIBFDT_objdir = dtc/libfdt
> +-include $(SRC_PATH)/dtc/libfdt/Makefile.libfdt
> +LIBFDT_objects = $(addprefix $(LIBFDT_objdir)/, $(LIBFDT_OBJS))
> +.PHONY: libfdt
> +libfdt: .git-submodule-status $(LIBFDT_objdir)/libfdt.a
> +$(LIBFDT_objdir)/libfdt.a: $(LIBFDT_objects)
> +	$(if $(LIBFDT_objects),$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@"),)
>   
> -dtc/%: .git-submodule-status
> +$(LIBFDT_objects): | $(LIBFDT_objdir)
> +$(LIBFDT_objdir): .git-submodule-status
>   	@mkdir -p $@
>   
>   # Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> @@ -563,7 +568,6 @@ slirp/all: .git-submodule-status
>   
>   # Compatibility gunk to keep make working across the rename of targets
>   # for recursion, to be removed some time after 4.1.
> -subdir-dtc: dtc/all
>   subdir-capstone: capstone/all
>   subdir-slirp: slirp/all
>   
> @@ -821,7 +825,6 @@ distclean: clean
>   	rm -rf $$d || exit 1 ; \
>           done
>   	rm -Rf .sdk
> -	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
>   
>   KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
>   ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
> diff --git a/configure b/configure
> index 233c671aaa..36f83ffc5a 100755
> --- a/configure
> +++ b/configure
> @@ -4278,10 +4278,6 @@ EOF
>         if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
>             fdt=git
>             mkdir -p dtc
> -          if [ "$pwd_is_source_path" != "y" ] ; then
> -              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> -              symlink "$source_path/dtc/scripts" "dtc/scripts"
> -          fi
>             fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
>             fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
>             fdt_libs="$fdt_libs"
> @@ -8151,7 +8147,7 @@ echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
>   echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
>   
>   if [ "$fdt" = "git" ]; then
> -  echo "config-host.h: dtc/all" >> $config_host_mak
> +  echo "config-host.h: libfdt" >> $config_host_mak
>   fi
>   if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
>     echo "config-host.h: capstone/all" >> $config_host_mak
> diff --git a/rules.mak b/rules.mak
> index 694865b63e..61eb474ba4 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -105,6 +105,8 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
>   
>   DSO_OBJ_CFLAGS := -fPIC -DBUILD_DSO
>   module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
> +
> +# Note: DSOSUF must not be empty, or these rules will try to match too much
>   %$(DSOSUF): QEMU_LDFLAGS += $(LDFLAGS_SHARED)
>   %$(DSOSUF): %.mo
>   	$(call LINK,$^)
> 


