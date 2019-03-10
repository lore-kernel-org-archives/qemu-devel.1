Received: from eggs.gnu.org ([209.51.188.92]:59804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h32Ao-0002Yw-AB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h32Am-0000xM-Is
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:23:42 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h32Am-0000wn-8C
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:23:40 -0400
Received: by mail-wr1-f43.google.com with SMTP id o17so2580738wrw.3
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 10:23:39 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-2-lersek@redhat.com>
	<57cc72f8-1999-94ec-8c7f-7f92cb40faa3@redhat.com>
Message-ID: <7c7aa3c9-8dd4-3a76-b508-7c7fca10364a@redhat.com>
Date: Sun, 10 Mar 2019 18:23:37 +0100
MIME-Version: 1.0
In-Reply-To: <57cc72f8-1999-94ec-8c7f-7f92cb40faa3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] roms: lift "edk2-funcs.sh" from
 "tests/uefi-test-tools/build.sh"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Hi Laszlo,

On 3/10/19 4:17 PM, Philippe Mathieu-Daudé wrote:
> On 3/9/19 1:48 AM, Laszlo Ersek wrote:
>> Extract the dense logic for architecture and toolchain massaging from
>> "tests/uefi-test-tools/build.sh", to a set of small functions. We'll reuse
>> these functions for building full platform firmware images.
>>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  roms/edk2-funcs.sh             | 240 ++++++++++++++++++++
>>  tests/uefi-test-tools/build.sh |  97 +-------
>>  2 files changed, 246 insertions(+), 91 deletions(-)
>>
>> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
>> new file mode 100644
>> index 000000000000..908c7665c6ed
>> --- /dev/null
>> +++ b/roms/edk2-funcs.sh
>> @@ -0,0 +1,240 @@
>> +# Shell script that defines functions for determining some environmental
>> +# characteristics for the edk2 "build" utility.
>> +#
>> +# This script is meant to be sourced.
>> +#
>> +# Copyright (C) 2019, Red Hat, Inc.
>> +#
>> +# This program and the accompanying materials are licensed and made available
>> +# under the terms and conditions of the BSD License that accompanies this
>> +# distribution. The full text of the license may be found at
>> +# <http://opensource.org/licenses/bsd-license.php>.
>> +#
>> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
>> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
>> +
>> +
>> +# Verify whether the QEMU system emulation target is supported by the UEFI spec
>> +# and edk2. Print a message to the standard error, and return with nonzero
>> +# status, if verification fails.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_verify_arch()
>> +{
>> +  local emulation_target="$1"
>> +  local program_name=$(basename -- "$0")
>> +
>> +  case "$emulation_target" in
>> +    (arm|aarch64|i386|x86_64)
>> +      ;;
>> +    (*)
>> +      printf '%s: unknown/unsupported QEMU system emulation target "%s"\n' \
>> +        "$program_name" "$emulation_target" >&2
>> +      return 1
>> +      ;;
>> +  esac
>> +}
>> +
>> +
>> +# Translate the QEMU system emulation target to the edk2 architecture
>> +# identifier. Print the result to the standard output.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_get_arch()
>> +{
>> +  local emulation_target="$1"
>> +
>> +  if ! qemu_edk2_verify_arch "$emulation_target"; then
>> +    return 1
>> +  fi
>> +
>> +  case "$emulation_target" in
>> +    (arm)
>> +      printf 'ARM\n'
>> +      ;;
>> +    (aarch64)
>> +      printf 'AARCH64\n'
>> +      ;;
>> +    (i386)
>> +      printf 'IA32\n'
>> +      ;;
>> +    (x86_64)
>> +      printf 'X64\n'
>> +      ;;
>> +  esac
>> +}
>> +
>> +
>> +# Translate the QEMU system emulation target to the gcc cross-compilation
>> +# architecture identifier. Print the result to the standard output.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_get_gcc_arch()
>> +{
>> +  local emulation_target="$1"
>> +
>> +  if ! qemu_edk2_verify_arch "$emulation_target"; then
>> +    return 1
>> +  fi
>> +
>> +  case "$emulation_target" in
>> +    (arm|aarch64|x86_64)
>> +      printf '%s\n' "$emulation_target"
>> +      ;;
>> +    (i386)
>> +      printf 'i686\n'
>> +      ;;
>> +  esac
>> +}
>> +
>> +
>> +# Determine the gcc cross-compiler prefix (if any) for use with the edk2
>> +# toolchain. Print the result to the standard output.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_get_cross_prefix()
>> +{
>> +  local emulation_target="$1"
>> +  local gcc_arch
>> +  local host_arch
>> +
>> +  if ! gcc_arch=$(qemu_edk2_get_gcc_arch "$emulation_target"); then
>> +    return 1
>> +  fi
>> +
>> +  host_arch=$(uname -m)
>> +
>> +  if [ "$gcc_arch" == "$host_arch" ] ||
>> +     ( [ "$gcc_arch" == i686 ] && [ "$host_arch" == x86_64 ] ); then
>> +    # no cross-compiler needed
>> +    :
>> +  else
>> +    printf '%s-linux-gnu-\n' "$gcc_arch"

Testing on Ubuntu (bionic), the gcc-arm-linux-gnueabihf provides the
arm-linux-gnueabihf-gcc binary, therefore I use:

GCC5_ARM_PREFIX="arm-linux-gnueabihf-" make -C roms efi

But this function enforce cross prefix to be arm-linux-gnu- :(

I tried with the following Linaro toolchains:

gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz
gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf.tar.xz
gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz

With the distrib toolchain or the Linaro enumerated, I get:

/bin/sh: 1: arm-linux-gnu-gcc: not found

>> +  fi
>> +}
>> +
>> +
>> +# Determine the edk2 toolchain tag for the QEMU system emulation target. Print
>> +# the result to the standard output. Print a message to the standard error, and
>> +# return with nonzero status, if the (conditional) gcc version check fails.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_get_toolchain()
>> +{
>> +  local emulation_target="$1"
>> +  local program_name=$(basename -- "$0")
>> +  local cross_prefix
>> +  local gcc_version
>> +
>> +  if ! qemu_edk2_verify_arch "$emulation_target"; then
>> +    return 1
>> +  fi
>> +
>> +  case "$emulation_target" in
>> +    (arm|aarch64)
>> +      printf 'GCC5\n'
>> +      ;;
>> +
>> +    (i386|x86_64)
>> +      if ! cross_prefix=$(qemu_edk2_get_cross_prefix "$emulation_target"); then
>> +        return 1
>> +      fi
>> +
>> +      gcc_version=$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print $3}')
>> +      # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more information on
>> +      # the mapping below.
>> +      case "$gcc_version" in
>> +        ([1-3].*|4.[0-3].*)
>> +          printf '%s: unsupported gcc version "%s"\n' \
>> +            "$program_name" "$gcc_version" >&2
>> +          return 1
>> +          ;;
>> +        (4.4.*)
>> +          printf 'GCC44\n'
>> +          ;;
>> +        (4.5.*)
>> +          printf 'GCC45\n'
>> +          ;;
>> +        (4.6.*)
>> +          printf 'GCC46\n'
>> +          ;;
>> +        (4.7.*)
>> +          printf 'GCC47\n'
>> +          ;;
>> +        (4.8.*)
>> +          printf 'GCC48\n'
>> +          ;;
>> +        (4.9.*|6.[0-2].*)
>> +          printf 'GCC49\n'
>> +          ;;
>> +        (*)
>> +          printf 'GCC5\n'
>> +          ;;
>> +      esac
>> +      ;;
>> +  esac
>> +}
>> +
>> +
>> +# Determine the name of the environment variable that exposes the
>> +# cross-compiler prefix to the edk2 "build" utility. Print the result to the
>> +# standard output.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_get_cross_prefix_var()
>> +{
>> +  local emulation_target="$1"
>> +  local edk2_toolchain
>> +  local edk2_arch
>> +
>> +  if ! edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target"); then
>> +    return 1
>> +  fi
>> +
>> +  case "$emulation_target" in
>> +    (arm|aarch64)
>> +      if ! edk2_arch=$(qemu_edk2_get_arch "$emulation_target"); then
>> +        return 1
>> +      fi
>> +      printf '%s_%s_PREFIX\n' "$edk2_toolchain" "$edk2_arch"
>> +      ;;
>> +    (i386|x86_64)
>> +      printf '%s_BIN\n' "$edk2_toolchain"
>> +      ;;
>> +  esac
>> +}
>> +
>> +
>> +# Set and export the environment variable(s) necessary for cross-compilation,
>> +# whenever needed by the edk2 "build" utility.
>> +#
>> +# Parameters:
>> +#   $1: QEMU system emulation target
>> +qemu_edk2_set_cross_env()
>> +{
>> +  local emulation_target="$1"
>> +  local cross_prefix
>> +  local cross_prefix_var
>> +
>> +  if ! cross_prefix=$(qemu_edk2_get_cross_prefix "$emulation_target"); then
>> +    return 1
>> +  fi
>> +
>> +  if [ -z "$cross_prefix" ]; then
>> +    # Nothing to do.
>> +    return 0
>> +  fi
>> +
>> +  if ! cross_prefix_var=$(qemu_edk2_get_cross_prefix_var \
>> +                            "$emulation_target"); then
>> +    return 1
>> +  fi
>> +
>> +  eval "export $cross_prefix_var=\$cross_prefix"
>> +}
>> diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build.sh
>> index 155cb75c4ddb..e2b52c855c39 100755
>> --- a/tests/uefi-test-tools/build.sh
>> +++ b/tests/uefi-test-tools/build.sh
>> @@ -38,97 +38,12 @@ if [ $ret -ne 0 ]; then
>>    exit $ret
>>  fi
>>  
>> -# Map the QEMU system emulation target to the following types of architecture
>> -# identifiers:
>> -# - edk2,
>> -# - gcc cross-compilation.
>> -# Cover only those targets that are supported by the UEFI spec and edk2.
>> -case "$emulation_target" in
>> -  (arm)
>> -    edk2_arch=ARM
>> -    gcc_arch=arm
>> -    ;;
>> -  (aarch64)
>> -    edk2_arch=AARCH64
>> -    gcc_arch=aarch64
>> -    ;;
>> -  (i386)
>> -    edk2_arch=IA32
>> -    gcc_arch=i686
>> -    ;;
>> -  (x86_64)
>> -    edk2_arch=X64
>> -    gcc_arch=x86_64
>> -    ;;
>> -  (*)
>> -    printf '%s: unknown/unsupported QEMU system emulation target "%s"\n' \
>> -      "$program_name" "$emulation_target" >&2
>> -    exit 1
>> -    ;;
>> -esac
>> -
>> -# Check if cross-compilation is needed.
>> -host_arch=$(uname -m)
>> -if [ "$gcc_arch" == "$host_arch" ] ||
>> -   ( [ "$gcc_arch" == i686 ] && [ "$host_arch" == x86_64 ] ); then
>> -  cross_prefix=
>> -else
>> -  cross_prefix=${gcc_arch}-linux-gnu-
>> -fi
>> -
>> -# Expose cross_prefix (which is possibly empty) to the edk2 tools. While at it,
>> -# determine the suitable edk2 toolchain as well.
>> -# - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which covers
>> -#   the gcc-5+ releases.
>> -# - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tags, in
>> -#   addition to GCC5. Unfortunately, the mapping between the toolchain tags and
>> -#   the actual gcc releases isn't entirely trivial. Run "git-blame" on
>> -#   "OvmfPkg/build.sh" in edk2 for more information.
>> -# And, because the above is too simple, we have to assign cross_prefix to an
>> -# edk2 build variable that is specific to both the toolchain tag and the target
>> -# architecture.
>> -case "$edk2_arch" in
>> -  (ARM)
>> -    edk2_toolchain=GCC5
>> -    export GCC5_ARM_PREFIX=$cross_prefix
>> -    ;;
>> -  (AARCH64)
>> -    edk2_toolchain=GCC5
>> -    export GCC5_AARCH64_PREFIX=$cross_prefix
>> -    ;;
>> -  (IA32|X64)
>> -    gcc_version=$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print $3}')
>> -    case "$gcc_version" in
>> -      ([1-3].*|4.[0-3].*)
>> -        printf '%s: unsupported gcc version "%s"\n' \
>> -          "$program_name" "$gcc_version" >&2
>> -        exit 1
>> -        ;;
>> -      (4.4.*)
>> -        edk2_toolchain=GCC44
>> -        ;;
>> -      (4.5.*)
>> -        edk2_toolchain=GCC45
>> -        ;;
>> -      (4.6.*)
>> -        edk2_toolchain=GCC46
>> -        ;;
>> -      (4.7.*)
>> -        edk2_toolchain=GCC47
>> -        ;;
>> -      (4.8.*)
>> -        edk2_toolchain=GCC48
>> -        ;;
>> -      (4.9.*|6.[0-2].*)
>> -        edk2_toolchain=GCC49
>> -        ;;
>> -      (*)
>> -        edk2_toolchain=GCC5
>> -        ;;
>> -    esac
>> -    eval "export ${edk2_toolchain}_BIN=\$cross_prefix"
>> -    ;;
>> -esac
>> +# Fetch some option arguments, and set the cross-compilation environment (if
>> +# any), for the edk2 "build" utility.
>> +source "$edk2_dir/../edk2-funcs.sh"
>> +edk2_arch=$(qemu_edk2_get_arch "$emulation_target")
>> +edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target")
>> +qemu_edk2_set_cross_env "$emulation_target"
>>  
>>  # Build the UEFI binary
>>  mkdir -p log
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
