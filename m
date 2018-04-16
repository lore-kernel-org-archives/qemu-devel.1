Received: from eggs.gnu.org ([2001:4830:134:3::10]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81P9-0000yn-Ox
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81P5-0007QZ-NY
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:30:35 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81P5-0007PZ-Gg
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:30:31 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so14658550qti.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:30:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-4-alex.bennee@linaro.org>
	<82169d34-1570-2f5c-07e4-8556e64e5b11@amsat.org>
	<877ep7bk2s.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e81e28ba-9ccd-bcde-8e74-0e9b52a01835@amsat.org>
Date: Mon, 16 Apr 2018 07:30:28 -0300
MIME-Version: 1.0
In-Reply-To: <877ep7bk2s.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 03/24] configure: move i386_cc to
 cross_cc_i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org

On 04/16/2018 06:02 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Hi Alex,
>>
>> On 04/10/2018 04:38 PM, Alex Bennée wrote:
>>> We should still be able to use the system cross compiler with the
>>> appropriate flags on x86_64 hosts.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  configure | 23 +++++++++++++++--------
>>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index b5f3b3fe29..add87ff4d4 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -284,7 +284,6 @@ libs_softmmu=""
>>>  libs_tools=""
>>>  audio_pt_int=""
>>>  audio_win_int=""
>>> -cc_i386=i386-pc-linux-gnu-gcc
>>>  libs_qga=""
>>>  debug_info="yes"
>>>  stack_protector=""
>>> @@ -457,6 +456,8 @@ docker="no"
>>>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
>>>  cross_cc_arm="arm-linux-gnueabihf-gcc"
>>>  cross_cc_powerpc="powerpc-linux-gnu-gcc"
>>> +cross_cc_i386="i386-pc-linux-gnu-gcc"
>>> +cross_cc_i386_cflags=""
>>
>> Can you keep this sorted? (arm < i386 < powerpc)
> 
> Sure.
> 
>>
>> Thanks :)
>>
>>>  
>>>  enabled_cross_compilers=""
>>>  
>>> @@ -687,12 +688,10 @@ case "$cpu" in
>>
>> What do you think about renaming $cpu -> host_cpu/target_cpu?
> 
> I'd rather avoid too much churn in configure. Maybe a separate clean-up
> patch?

Yeah me neither :S This is probably not be as trivial as it seems.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>>
>>>    i386|i486|i586|i686|i86pc|BePC)
>>>      cpu="i386"
>>>      supported_cpu="yes"
>>> -    cross_cc_i386=gcc
>>>    ;;
>>>    x86_64|amd64)
>>>      cpu="x86_64"
>>>      supported_cpu="yes"
>>> -    cross_cc_x86_64=gcc
>>>    ;;
>>>    armv*b|armv*l|arm)
>>>      cpu="arm"
>>> @@ -1435,7 +1434,6 @@ case "$cpu" in
>>>      i386)
>>>             CPU_CFLAGS="-m32"
>>>             LDFLAGS="-m32 $LDFLAGS"
>>> -           cc_i386='$(CC) -m32'
>>>             ;;
>>>      x86_64)
>>>             # ??? Only extremely old AMD cpus do not have cmpxchg16b.
>>> @@ -1443,12 +1441,14 @@ case "$cpu" in
>>>             # runtime and generate the fallback to serial emulation.
>>>             CPU_CFLAGS="-m64 -mcx16"
>>>             LDFLAGS="-m64 $LDFLAGS"
>>> -           cc_i386='$(CC) -m32'
>>> +           cross_cc_i386=$cc
>>> +           cross_cc_i386_cflags="-m32"
>>>             ;;
>>>      x32)
>>>             CPU_CFLAGS="-mx32"
>>>             LDFLAGS="-mx32 $LDFLAGS"
>>> -           cc_i386='$(CC) -m32'
>>> +           cross_cc_i386=$cc
>>> +           cross_cc_i386_cflags="-m32"
>>>             ;;
>>>      # No special flags required for other host CPUs
>>>  esac
>>> @@ -6664,7 +6664,6 @@ echo "CC=$cc" >> $config_host_mak
>>>  if $iasl -h > /dev/null 2>&1; then
>>>    echo "IASL=$iasl" >> $config_host_mak
>>>  fi
>>> -echo "CC_I386=$cc_i386" >> $config_host_mak
>>>  echo "HOST_CC=$host_cc" >> $config_host_mak
>>>  echo "CXX=$cxx" >> $config_host_mak
>>>  echo "OBJCC=$objcc" >> $config_host_mak
>>> @@ -6783,6 +6782,7 @@ case "$target" in
>>>  esac
>>>  
>>>  target_compiler=""
>>> +target_compiler_cflags=""
>>>  
>>>  mkdir -p $target_dir
>>>  echo "# Automatically generated by configure - do not modify" > $config_target_mak
>>> @@ -6799,10 +6799,13 @@ TARGET_ABI_DIR=""
>>>  case "$target_name" in
>>>    i386)
>>>      gdb_xml_files="i386-32bit.xml i386-32bit-core.xml i386-32bit-sse.xml"
>>> +    target_compiler=$cross_cc_i386
>>> +    target_compiler_cflags=$cross_cc_i386_cflags
>>>    ;;
>>>    x86_64)
>>>      TARGET_BASE_ARCH=i386
>>>      gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
>>> +    target_compiler=$cross_cc_x86_64
>>>    ;;
>>>    alpha)
>>>      mttcg="yes"
>>> @@ -6947,7 +6950,7 @@ int main(void) {
>>>  }
>>>  EOF
>>>  
>>> -    if ! do_compiler $target_compiler -o $TMPE $TMPC -static ; then
>>> +    if ! do_compiler $target_compiler $target_compiler_cflags -o $TMPE $TMPC -static ; then
>>>          target_compiler=""
>>>      else
>>>          enabled_cross_compilers="${enabled_cross_compilers} ${target_compiler}"
>>> @@ -7033,6 +7036,10 @@ if test -n "$target_compiler"; then
>>>    echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
>>>  fi
>>>  
>>> +if test -n "$target_compiler_cflags"; then
>>> +  echo "CROSS_CC_GUEST_CFLAGS=$target_compiler_cflags" >> $config_target_mak
>>> +fi
>>> +
>>>  # generate QEMU_CFLAGS/LDFLAGS for targets
>>>  
>>>  cflags=""
>>>
> 
> 
