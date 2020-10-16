Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD21C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09905207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hcyp2SWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09905207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKSo-0001xw-Ti
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKRx-0001W5-IV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKRu-0003jS-9J
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602834406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FJpgc/IkJOJFdaJeS0fsXL3lwNzTQx7a98Vjb6gt30=;
 b=Hcyp2SWjWOBdT2w74tisOkcKSvJb+pAibQL6Ucv0XjLPZXmxof7ge5rEWvW2KB1p3uhWP0
 gwzh4u6bRXBcuDbPMLmQDVRkzmVHmzMcJ67cEMwglko9APvSf42+vWlWXI0KxRS4JSucC5
 qEsfr8MEM0twd/ZTL6bD3wNFkjqIRgo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-5iluIV_gP_-5rdGwbkrQ3w-1; Fri, 16 Oct 2020 03:46:43 -0400
X-MC-Unique: 5iluIV_gP_-5rdGwbkrQ3w-1
Received: by mail-wm1-f70.google.com with SMTP id g71so319042wmg.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 00:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7FJpgc/IkJOJFdaJeS0fsXL3lwNzTQx7a98Vjb6gt30=;
 b=ttut0wcvC/6z8/S4oIoHGwRY4z85OqUxaWeS5p3z0BhJ109U1a2OGUWz++ZY1R73he
 lCyoPZSjeVZAuJOEKSyvH2eRuXxV19NaWWxr6zyeLJdyr5qDtpEybU4Y6G5A1E8MXCVg
 Eqf8KyRX+WIJcliODxzyW9zpBs0/oCw64KU4eX5uuXWR4xJFkiIzEissMdGfNGEtKcYq
 ehY8v/GdnDYQwdgQdSNrHnjZt7x4ikyR1gRJxcjLmpv/uvVW0l0eoOmuwotdIDZJfbv1
 7YMeOXAvD7C0CjRJm7Kc0hces5XYcl0Ir9n5M38LMVJ5F+Q2hC4Cmvj+D9LX50+pfVii
 /aNQ==
X-Gm-Message-State: AOAM533jEt6NX3dJ7wtYbuR1ICrC6fyGjgEO08expQMY7smyrNkjiMn6
 ayeA78OBcQL+DM8CKDz7qE0VjQVSr9Uu0/rQ2utjUVDl5CZNVTmbvBKzIXfWpUejoFODHnvAhwG
 J8J9XjLXnRBpyz3M=
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr2457915wrs.9.1602834402460;
 Fri, 16 Oct 2020 00:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtlBr4Y2NNiTwTYkk47dyiMSa+SVNvO20MfigsTqSIJqSueTF9HQT5BktM3b3Kfwk2djiPZQ==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr2457881wrs.9.1602834402079;
 Fri, 16 Oct 2020 00:46:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id a15sm2390106wro.3.2020.10.16.00.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 00:46:41 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] meson: Move the detection logic for sphinx to meson
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-4-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd01bce-7409-26f9-5401-8f5ddd4f924c@redhat.com>
Date: Fri, 16 Oct 2020 09:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015220626.418-4-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is a better way to write the meson test:

if get_option('sphinx_build') == ''
  sphinx_build = find_program(['sphinx-build-3', 'sphinx-build'],
                              required: get_option('docs'))
else
  sphinx_build = find_program(get_option('sphinx_build'),
                              required: get_option('docs'))
endif

SPHINX_ARGS = [sphinx_build]
# If we're making warnings fatal, apply this to Sphinx runs as well
if get_option('werror')
  SPHINX_TEST_ARGS += [ '-W' ]
endif

# Check if tools are available to build documentation.
build_docs = false
if sphinx_build.found()
  # This is a bit awkward but works: create a trivial document and
  # try to run it with our configuration file (which enforces a
  # version requirement). This will fail if sphinx-build is too old.
  run_command('mkdir', ['-p', tmpdir / 'sphinx'])
  run_command('touch', [tmpdir / 'sphinx/index.rst'])
  sphinx_build_test_out = run_command(SPHINX_ARGS + [
    '-c', meson.current_source_dir() / 'docs',
    '-b', 'html', tmpdir / 'sphinx',
    tmpdir / 'sphinx/out'])
  build_docs = (sphinx_build_test_out.returncode() == 0)
endif

if not build_docs
  if sphinx_build_option != ''
    warning('@0@ exists but it is either too old or uses too old a Python version'.format(sphinx_build_option))
  endif
  if get_option('docs').enabled()
    error('Install a Python 3 version of python-sphinx')
  endif
endif



On 16/10/20 00:06, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure                     | 59 +++-------------------------------
>  docs/meson.build              |  4 +--
>  meson.build                   | 60 +++++++++++++++++++++++++++++++----
>  meson_options.txt             |  5 ++-
>  tests/qapi-schema/meson.build |  2 +-
>  5 files changed, 64 insertions(+), 66 deletions(-)
> 
> diff --git a/configure b/configure
> index 1ce31f97b4..ff593a8542 100755
> --- a/configure
> +++ b/configure
> @@ -297,7 +297,7 @@ brlapi=""
>  curl=""
>  iconv="auto"
>  curses="auto"
> -docs=""
> +docs="auto"
>  fdt="auto"
>  netmap="no"
>  sdl="auto"
> @@ -822,15 +822,6 @@ do
>      fi
>  done
>  
> -sphinx_build=
> -for binary in sphinx-build-3 sphinx-build
> -do
> -    if has "$binary"
> -    then
> -        sphinx_build=$(command -v "$binary")
> -        break
> -    fi
> -done
>  
>  # Check for ancillary tools used in testing
>  genisoimage=
> @@ -1226,9 +1217,9 @@ for opt do
>    ;;
>    --disable-crypto-afalg) crypto_afalg="no"
>    ;;
> -  --disable-docs) docs="no"
> +  --disable-docs) docs="disabled"
>    ;;
> -  --enable-docs) docs="yes"
> +  --enable-docs) docs="enabled"
>    ;;
>    --disable-vhost-net) vhost_net="no"
>    ;;
> @@ -4413,45 +4404,6 @@ if check_include linux/btrfs.h ; then
>      btrfs=yes
>  fi
>  
> -# If we're making warnings fatal, apply this to Sphinx runs as well
> -sphinx_werror=""
> -if test "$werror" = "yes"; then
> -    sphinx_werror="-W"
> -fi
> -
> -# Check we have a new enough version of sphinx-build
> -has_sphinx_build() {
> -    # This is a bit awkward but works: create a trivial document and
> -    # try to run it with our configuration file (which enforces a
> -    # version requirement). This will fail if either
> -    # sphinx-build doesn't exist at all or if it is too old.
> -    mkdir -p "$TMPDIR1/sphinx"
> -    touch "$TMPDIR1/sphinx/index.rst"
> -    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
> -                    -b html "$TMPDIR1/sphinx" \
> -                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
> -}
> -
> -# Check if tools are available to build documentation.
> -if test "$docs" != "no" ; then
> -  if has_sphinx_build; then
> -    sphinx_ok=yes
> -  else
> -    sphinx_ok=no
> -  fi
> -  if test "$sphinx_ok" = "yes"; then
> -    docs=yes
> -  else
> -    if test "$docs" = "yes" ; then
> -      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
> -        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
> -      fi
> -      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
> -    fi
> -    docs=no
> -  fi
> -fi
> -
>  # Search for bswap_32 function
>  byteswap_h=no
>  cat > $TMPC << EOF
> @@ -6087,9 +6039,6 @@ qemu_version=$(head $source_path/VERSION)
>  echo "PKGVERSION=$pkgversion" >>$config_host_mak
>  echo "SRC_PATH=$source_path" >> $config_host_mak
>  echo "TARGET_DIRS=$target_list" >> $config_host_mak
> -if [ "$docs" = "yes" ] ; then
> -  echo "BUILD_DOCS=yes" >> $config_host_mak
> -fi
>  if test "$modules" = "yes"; then
>    # $shacmd can generate a hash started with digit, which the compiler doesn't
>    # like as an symbol. So prefix it with an underscore
> @@ -6794,7 +6743,6 @@ fi
>  echo "ROMS=$roms" >> $config_host_mak
>  echo "MAKE=$make" >> $config_host_mak
>  echo "PYTHON=$python" >> $config_host_mak
> -echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
>  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
>  echo "MESON=$meson" >> $config_host_mak
>  echo "CC=$cc" >> $config_host_mak
> @@ -7076,6 +7024,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
>          -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
>          -Diconv=$iconv -Dcurses=$curses \
> +        -Ddocs=$docs -Dsphinx_build=$sphinx_build \
>          $cross_arg \
>          "$PWD" "$source_path"
>  
> diff --git a/docs/meson.build b/docs/meson.build
> index 0340d489ac..f566809a6a 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -37,7 +37,7 @@ if build_docs
>                  input: [files('conf.py'), files(manual / 'conf.py')],
>                  depfile: manual + '.d',
>                  depend_files: sphinx_extn_depends,
> -                command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
> +                command: SPHINX_ARGS + ['-Ddepfile=@DEPFILE@',
>                            '-Ddepfile_stamp=@OUTPUT0@',
>                            '-b', 'html', '-d', private_dir,
>                            input_dir, output_dir])
> @@ -59,7 +59,7 @@ if build_docs
>                           input: this_manual,
>                           install: build_docs,
>                           install_dir: install_dirs,
> -                         command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
> +                         command: SPHINX_ARGS + ['-b', 'man', '-d', private_dir,
>                                     input_dir, meson.current_build_dir()])
>      endif
>    endforeach
> diff --git a/meson.build b/meson.build
> index 8156df8b71..8940468208 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,7 +17,13 @@ cc = meson.get_compiler('c')
>  config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
>  enable_modules = 'CONFIG_MODULES' in config_host
>  enable_static = 'CONFIG_STATIC' in config_host
> -build_docs = 'BUILD_DOCS' in config_host
> +
> +# Temporary directory used for files created while
> +# configure runs. Since it is in the build directory
> +# we can safely blow away any previous version of it
> +# (and we need not jump through hoops to try to delete
> +# it when configure exits.)
> +tmpdir = meson.current_build_dir() / 'config-temp'
>  
>  if get_option('qemu_suffix').startswith('/')
>    error('qemu_suffix cannot start with a /')
> @@ -1235,12 +1241,52 @@ foreach d : hx_headers
>  endforeach
>  genh += hxdep
>  
> -SPHINX_ARGS = [config_host['SPHINX_BUILD'],
> -               '-Dversion=' + meson.project_version(),
> -               '-Drelease=' + config_host['PKGVERSION']]
> +sphinx_build = not_found
> +sphinx_build_option = get_option('sphinx_build')
> +if sphinx_build_option == ''
> +  sphinx_build = find_program('sphinx-build', required: false)
> +else
> +  sphinx_build = find_program(sphinx_build_option, required: false)
> +endif
>  
> +SPHINX_TEST_ARGS = []
> +# If we're making warnings fatal, apply this to Sphinx runs as well
>  if get_option('werror')
> -  SPHINX_ARGS += [ '-W' ]
> +  SPHINX_TEST_ARGS += [ '-W' ]
> +endif
> +
> +build_docs = false
> +docs_option = get_option('docs')
> +# Check if tools are available to build documentation.
> +if sphinx_build.found() and not docs_option.disabled()
> +    # This is a bit awkward but works: create a trivial document and
> +    # try to run it with our configuration file (which enforces a
> +    # version requirement). This will fail if either
> +    # sphinx-build doesn't exist at all or if it is too old.
> +    run_command('mkdir', ['-p', tmpdir / 'sphinx'])
> +    run_command('touch', [tmpdir / 'sphinx/index.rst'])
> +    sphinx_build_test_out = run_command(sphinx_build, SPHINX_TEST_ARGS + [
> +      '-c', meson.current_source_dir() / 'docs',
> +      '-b', 'html', tmpdir / 'sphinx',
> +      tmpdir / 'sphinx/out'])
> +    if sphinx_build_test_out.returncode() == 0
> +      build_docs = true
> +    else
> +      if docs_option.enabled()
> +        if sphinx_build_option != ''
> +          warning('Warning: @0@ exists but it is either too old or uses too old a Python version'.format(sphinx_build_option))
> +        endif
> +        error('Warning: Install a Python 3 version of python-sphinx')
> +      endif
> +      # do not building docs
> +    endif
> +endif
> +
> +SPHINX_ARGS = []
> +if build_docs
> +  SPHINX_ARGS = [sphinx_build]
> +  SPHINX_ARGS += SPHINX_TEST_ARGS
> +  SPHINX_ARGS += ['-Dversion=' + meson.project_version(), '-Drelease=' + config_host['PKGVERSION']]
>  endif
>  
>  sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
> @@ -1918,7 +1964,7 @@ summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
>  summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
>  summary_info += {'make':              config_host['MAKE']}
>  summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
> -summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
> +summary_info += {'sphinx-build':      sphinx_build.found()}
>  summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
>  # TODO: add back version
>  summary_info += {'slirp support':     slirp_opt == 'disabled' ? false : slirp_opt}
> @@ -1986,7 +2032,7 @@ if config_host.has_key('CONFIG_XEN_BACKEND')
>    summary_info += {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
>  endif
>  summary_info += {'brlapi support':    config_host.has_key('CONFIG_BRLAPI')}
> -summary_info += {'Documentation':     config_host.has_key('BUILD_DOCS')}
> +summary_info += {'Documentation':     build_docs}
>  summary_info += {'PIE':               get_option('b_pie')}
>  summary_info += {'vde support':       config_host.has_key('CONFIG_VDE')}
>  summary_info += {'netmap support':    config_host.has_key('CONFIG_NETMAP')}
> diff --git a/meson_options.txt b/meson_options.txt
> index e6cb1e589b..0e3fa7136b 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,8 +1,11 @@
>  option('qemu_suffix', type : 'string', value: 'qemu',
>         description: 'Suffix for QEMU data/modules/config directories (can be empty)')
> +option('docs', type : 'feature', value : 'auto',
> +       description: 'Documentations build support')
>  option('docdir', type : 'string', value : 'doc',
>         description: 'Base directory for documentation installation (can be empty)')
> -
> +option('sphinx_build', type : 'string', value : '',
> +       description: 'Use specified sphinx-build [$sphinx_build] for building document (default to be empty)')
>  option('gettext', type : 'boolean', value : true,
>         description: 'Localization of the GTK+ user interface')
>  option('sparse', type : 'feature', value : 'auto',
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index 1f222a7a13..961b8367a9 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -237,7 +237,7 @@ qapi_doc_out = custom_target('QAPI rST doc',
>                               # we want it to always really run the QAPI doc
>                               # generation code. It also means we don't
>                               # clutter up the build dir with the cache.
> -                             command: [SPHINX_ARGS,
> +                             command:  SPHINX_ARGS + [
>                                         '-b', 'text', '-E',
>                                         '-c', meson.source_root() / 'docs',
>                                         '-D', 'master_doc=doc-good',
> 


