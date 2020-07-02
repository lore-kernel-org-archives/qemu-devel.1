Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0612C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D176208FE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0I+NN2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D176208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvnN-0005I3-UY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvmR-0004iq-2c
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:45:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvmO-0001QW-QU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593683116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltJ6Ut2drQKiuoGb/5NEUmpJonUmRZcOZ5K4S9krKRo=;
 b=F0I+NN2t396uyXIvNQ63GmFa/LRwLmkcDv2h3mG0vGb62XZH0d+8irKfAU5p0Kv4ZqRk+B
 5PnElYxJZsbmt2eJc/3bzvnpqtRW2JHh1ONWJJCTUBY5h1BKlUju3ViBRzEtzYVb6yk8xC
 N7sogi6SSj2URG/rscHcKg6/57oiSGs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-BvL55a4iMxW-now3EZrx7w-1; Thu, 02 Jul 2020 05:45:14 -0400
X-MC-Unique: BvL55a4iMxW-now3EZrx7w-1
Received: by mail-wr1-f71.google.com with SMTP id s16so11477633wrv.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ltJ6Ut2drQKiuoGb/5NEUmpJonUmRZcOZ5K4S9krKRo=;
 b=rsXtK4rfMzK6aeA3CHPBVVZ1gIaTF9QzMPVXH+xNYW9VZWUN8uZnqNsYonJeCwkd34
 lsqFg07qhUiGfBbyrt3SaqHX9zpUTlBN5xuSGOLo253I/gw6aXWEpDTKiyagqgooIoIr
 /pKBNGC+VThYl6aXFKHqy4GIAn76cuNM3bqorTWexkg9r60T8g2PrxIZzkIBYx4j9pu1
 aFmlqyrGHVPCevuNQMLo1E6JbhzXyMwb9TJgH4e9nY2QcZJ8HP57PAQfhSlZpOwmG5cs
 Mdf38yPcIqH1h+WuCTaSvQ/j1yzx4AfcMHKXbw7ux3PUulWY/lJCnUwqjQkv+yiZ7xee
 7NHQ==
X-Gm-Message-State: AOAM530C9hwYMEEq0qB9zd8VBe4zTn0in2BSgSCUnRC5hFel+51GzUb3
 9EMh/IiDcYzt3GdO79Bo2EeUAYGPJlOOc34XIt4lfl42Yq8qkkBrjFWnkRg9YPF2fSq2A3sQAAW
 EAqX4HlIYzasGw4k=
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr32126704wmd.10.1593683113152; 
 Thu, 02 Jul 2020 02:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQvzl1hhcRLoQAe0R1LUGmHCKtu+ulaapJS01Pw8vLhsZb0SrTE49B5gq4MGUKFhbNxXKtFw==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr32126668wmd.10.1593683112663; 
 Thu, 02 Jul 2020 02:45:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id c20sm13000316wrb.65.2020.07.02.02.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:45:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1074ec24-513c-f754-841c-447dfa5cb5aa@redhat.com>
Date: Thu, 2 Jul 2020 11:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 02/07/20 07:49, Daniele Buono wrote:
> This patch adds a flag to enable/disable control flow integrity checks
> on indirect function calls. This feature is only provided by LLVM/Clang
> v3.9 or higher, and only allows indirect function calls to functions
> with compatible signatures.
> 
> We also add an option to enable a debugging version of cfi, with verbose
> output in case of a CFI violation.
> 
> CFI on indirect function calls does not support calls to functions in
> shared libraries (since they were not known at compile time), and such
> calls are forbidden. QEMU relies on dlopen/dlsym when using modules,
> so we make modules incompatible with CFI.
> 
> We introduce a blacklist file, to disable CFI checks in a limited number
> of TCG functions.
> 
> The feature relies on link-time optimization (lto), which requires the
> use of the gold linker, and the LLVM versions of ar, ranlib and nm.
> This patch take care of checking that all the compiler toolchain
> dependencies are met.
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>

Can you split this option in two parts, --enable-lto to enable link-time
optimization (perhaps also for GCC) and --enable-cfi which implies
--enable-lto?

This is because in the future we are considering switching to Meson,
where LTO support is built-in; having a separate switch would make it
easier to find the relevant code.

Paolo

> ---
>  cfi-blacklist.txt |  27 +++++++
>  configure         | 177 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 cfi-blacklist.txt
> 
> diff --git a/cfi-blacklist.txt b/cfi-blacklist.txt
> new file mode 100644
> index 0000000000..bf804431a5
> --- /dev/null
> +++ b/cfi-blacklist.txt
> @@ -0,0 +1,27 @@
> +# List of functions that should not be compiled with Control-Flow Integrity
> +
> +[cfi-icall]
> +# TCG creates binary blobs at runtime, with the transformed code.
> +# When it's time to execute it, the code is called with an indirect function
> +# call. Since such function did not exist at compile time, the runtime has no
> +# way to verify its signature. Disable CFI checks in the function that calls
> +# the binary blob
> +fun:cpu_tb_exec
> +
> +# TCI (Tiny Compiler Interpreter) is an interpreter for TCG pseudo code.
> +# One possible operation in the pseudo code is a call to binary code.
> +# Therefore, disable CFI checks in the interpreter function
> +fun:tcg_qemu_tb_exec
> +
> +# TCG Plugins Callback Functions. The mechanism rely on opening external
> +# shared libraries at runtime and get pointers to functions in such libraries
> +# Since these pointers are external to the QEMU binary, the runtime cannot
> +# verify their signature. Disable CFI Checks in all the functions that use
> +# such pointers.
> +fun:plugin_vcpu_cb__simple
> +fun:plugin_cb__simple
> +fun:plugin_cb__udata
> +fun:qemu_plugin_tb_trans_cb
> +fun:qemu_plugin_vcpu_syscall
> +fun:qemu_plugin_vcpu_syscall_ret
> +fun:plugin_load
> diff --git a/configure b/configure
> index 4a22dcd563..86fb0f390c 100755
> --- a/configure
> +++ b/configure
> @@ -27,6 +27,7 @@ fi
>  TMPB="qemu-conf"
>  TMPC="${TMPDIR1}/${TMPB}.c"
>  TMPO="${TMPDIR1}/${TMPB}.o"
> +TMPA="${TMPDIR1}/lib${TMPB}.a"
>  TMPCXX="${TMPDIR1}/${TMPB}.cxx"
>  TMPE="${TMPDIR1}/${TMPB}.exe"
>  TMPMO="${TMPDIR1}/${TMPB}.mo"
> @@ -134,6 +135,43 @@ compile_prog() {
>    do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $QEMU_LDFLAGS $local_ldflags
>  }
>  
> +do_run() {
> +    # Run a generic program, capturing its output to the log.
> +    # First argument is binary to execute.
> +    local program="$1"
> +    shift
> +    echo $program $@ >> config.log
> +    $program $@ >> config.log 2>&1 || return $?
> +}
> +
> +do_run_filter() {
> +    # Run a generic program, capturing its output to the log,
> +    # but also filtering the output with grep.
> +    # Returns the return value of grep.
> +    # First argument is the filter string.
> +    # Second argument is binary to execute.
> +    local filter="$1"
> +    shift
> +    local program="$1"
> +    shift
> +    echo $program $@ >> config.log
> +    $program $@ >> config.log 2>&1
> +    $program $@ 2>&1 | grep ${filter} >> /dev/null || return $?
> +
> +}
> +
> +create_library() {
> +  do_run "$ar" -rc${1} $TMPA $TMPO
> +}
> +
> +create_index() {
> +  do_run "$ranlib" $TMPA
> +}
> +
> +find_library_symbol() {
> +  do_run_filter ${1} "$nm" $TMPA
> +}
> +
>  # symbolically link $1 to $2.  Portable version of "ln -sf".
>  symlink() {
>    rm -rf "$2"
> @@ -306,6 +344,8 @@ libs_tools=""
>  audio_win_int=""
>  libs_qga=""
>  debug_info="yes"
> +cfi="no"
> +cfi_debug="no"
>  stack_protector=""
>  safe_stack=""
>  use_containers="yes"
> @@ -1285,6 +1325,14 @@ for opt do
>    ;;
>    --disable-werror) werror="no"
>    ;;
> +  --enable-cfi) cfi="yes"
> +  ;;
> +  --disable-cfi) cfi="no"
> +  ;;
> +  --enable-cfi-debug) cfi_debug="yes"
> +  ;;
> +  --disable-cfi-debug) cfi_debug="no"
> +  ;;
>    --enable-stack-protector) stack_protector="yes"
>    ;;
>    --disable-stack-protector) stack_protector="no"
> @@ -1838,6 +1886,10 @@ disabled with --disable-FEATURE, default is enabled if available:
>    module-upgrades try to load modules from alternate paths for upgrades
>    debug-tcg       TCG debugging (default is disabled)
>    debug-info      debugging information
> +  cfi             Enable Control-Flow Integrity for indirect function calls.
> +                  Depends on clang/llvm >= 3.9 and is incompatible with modules
> +  cfi-debug       In case of a cfi violation, a message containing the line that
> +                  triggered the error is written to stderr
>    sparse          sparse checker
>    safe-stack      SafeStack Stack Smash Protection. Depends on
>                    clang/llvm >= 3.7 and requires coroutine backend ucontext.
> @@ -5948,6 +6000,129 @@ if  test "$plugins" = "yes" &&
>        "for this purpose. You can't build with --static."
>  fi
>  
> +########################################
> +# cfi (Control Flow Integrity)
> +
> +if test "$cfi" = "yes"; then
> +  # Compiler/Linker Flags that needs to be added for cfi:
> +  # -fsanitize=cfi-icall to enable control-flow integrity checks on
> +  #            indirect function calls.
> +  # -fsanitize-cfi-icall-generalize-pointers to allow indirect function calls
> +  #            with pointers of a different type (i.e. pass a void* to a
> +  #            function that expects a char*). Used in some spots in QEMU,
> +  #            with compile-time type checks done by macros
> +  # -fsanitize-blacklist, to disable CFI on specific functions.
> +  #            required for some TCG functions that call runtime-created or
> +  #            runtime-linked code. More details in cfi-blacklist.txt
> +  # -flto=thin to enable link-time optimization. This is required for the
> +  #            implementation of CFI to work properly across object files
> +  # -fuse-ld=gold Since some of the objects are packed into static libraries,
> +  #               which are not supported by the bfd linker.
> +  test_cflag="-fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers -flto=thin -fsanitize-blacklist=${source_path}/cfi-blacklist.txt"
> +  test_ldflag="-fsanitize=cfi-icall -flto=thin -fuse-ld=gold -fsanitize-blacklist=${source_path}/cfi-blacklist.txt"
> +
> +  if test "$cfi_debug" = "yes"; then
> +    # Disable the default trap mechanism so that a error message is displayed
> +    # when a CFI violation happens. The code is still terminated after the
> +    # message
> +    test_cflag="${test_cflag} -fno-sanitize-trap=cfi-icall"
> +    test_ldflag="${test_ldflag} -fno-sanitize-trap=cfi-icall"
> +  fi
> +
> +  # Check that cfi is supported.
> +  # Need to check for:
> +  # - Valid compiler, that supports cfi flags
> +  # - Valid ar, ranlib and nm, able to work with intermediate code (for lto)
> +  # - Incompatible configure options (plugins and modules) that use dlsym at
> +  #   runtime (indirect function calls to shared libraries is not supported)
> +
> +  #### Check for a valid *ar* for link-time optimization.
> +  # Test it by creating a static library and linking it
> +  # Compile an object first
> +  cat > $TMPC << EOF
> +int fun(int val);
> +
> +int fun(int val) {
> +    return val;
> +}
> +EOF
> +  if ! compile_object "-Werror $test_cflag"; then
> +    error_exit "Control Flow Integrity is not supported by your compiler"
> +  fi
> +  # Create a library out of it
> +  if ! create_library "s" ; then
> +    error_exit "LTO is required for CFI, but is not supported by ar. This usually happens when using gnu ar. Try switching to LLVM ar"
> +  fi
> +  # Now create a binary using the library
> +  cat > $TMPC << EOF
> +int fun(int val);
> +
> +int main(int argc, char *argv[]) {
> +  return fun(0);
> +}
> +EOF
> +  if ! compile_prog "-Werror $test_cflag" "$test_ldflag -L${TMPDIR1} -l${TMPB}"; then
> +    error_exit "LTO is required for CFI, but is not supported by ar. This usually happens when using gnu ar. Try switching to LLVM ar"
> +  fi
> +
> +  #### Check for a valid *ranlib* for link-time optimization.
> +  # Test it by creating a static library without index, indexing and linking it
> +  cat > $TMPC << EOF
> +int fun(int val);
> +
> +int fun(int val) {
> +    return val;
> +}
> +EOF
> +  if ! compile_object "-Werror $test_cflag"; then
> +    error_exit "Control Flow Integrity is not supported by your compiler"
> +  fi
> +  # Create a library explicity without an index
> +  if ! create_library "S" ; then
> +    error_exit "LTO is required for CFI, but is not supported by ar. This usually happens when using gnu ar. Try switching to LLVM ar"
> +  fi
> +  # Now run ranlib to index it
> +  if ! create_index ; then
> +    error_exit "LTO is required for CFI, but is not supported by ranlib. This usually happens when using gnu ranlib. Try switching to LLVM ranlib"
> +  fi
> +  # If ranlib worked, we can now use the library
> +  cat > $TMPC << EOF
> +int fun(int val);
> +
> +int main(int argc, char *argv[]) {
> +  return fun(0);
> +}
> +EOF
> +  if ! compile_prog "-Werror $test_cflag" "$test_ldflag -L${TMPDIR1} -l${TMPB}"; then
> +    error_exit "LTO is required for CFI, but is not supported by ranlib. This usually happens when using gnu ranlib. Try switching to LLVM ranlib"
> +  fi
> +
> +  #### Check for a valid *nm* for link-time optimization.
> +  # nm does not return an error code if the file is unsupported, just
> +  # print a warning text. So, check if *fun* is one of the symbols found by nm
> +  # in the previously created static library
> +  if ! find_library_symbol "fun" ; then
> +    error_exit "LTO is required for CFI, but is not supported by nm. This usually happens when using gnu nm. Try switching to LLVM nm"
> +  fi
> +
> +  #### The toolchain supports CFI, let's check for incompatible options
> +
> +  if test "$modules" = "yes"; then
> +    error_exit "Control Flow Integrity is not compatible with modules"
> +  fi
> +
> +  #### All good, add the flags for CFI to our CFLAGS and LDFLAGS
> +  # Flag needed both at compilation and at linking
> +  QEMU_CFLAGS="$QEMU_CFLAGS $test_cflag"
> +  QEMU_LDFLAGS="$QEMU_LDFLAGS $test_ldflag"
> +
> +else
> +  if test "$cfi_debug" = "yes"; then
> +    error_exit "Cannot enable Control Flow Integrity debugging since CFI is not enabled"
> +  fi
> +fi
> +
> +
>  ########################################
>  # See if __attribute__((alias)) is supported.
>  # This false for Xcode 9, but has been remedied for Xcode 10.
> @@ -6856,6 +7031,8 @@ echo "gprof enabled     $gprof"
>  echo "sparse enabled    $sparse"
>  echo "strip binaries    $strip_opt"
>  echo "profiler          $profiler"
> +echo "cfi               $cfi"
> +echo "cfi debug         $cfi_debug"
>  echo "static build      $static"
>  echo "safe stack        $safe_stack"
>  if test "$darwin" = "yes" ; then
> 


