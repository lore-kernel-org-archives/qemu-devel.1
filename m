Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCR2B-0007PP-2b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCR24-0006Ej-Mi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:08:50 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:47460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCR24-0006EJ-I6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:08:44 -0500
Received: by mail-qt0-x242.google.com with SMTP id z50so3419550qtj.4
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 06:08:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <e457d4e906dceea4de6c3431813a06b137c1ab9c.1510103351.git.alistair.francis@xilinx.com>
	<67091b7c-7518-e9af-5171-1232e7c09bdf@amsat.org>
Message-ID: <49816f25-a810-286e-4520-55b6c78f1750@amsat.org>
Date: Wed, 8 Nov 2017 11:08:39 -0300
MIME-Version: 1.0
In-Reply-To: <67091b7c-7518-e9af-5171-1232e7c09bdf@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] Makefile: Capstone: Add support for
 cross compile ranlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com, kraxel@redhat.com, dgilbert@redhat.com

On 11/08/2017 02:00 AM, Philippe Mathieu-Daudé wrote:
> Hi Alistair,
> 
> On 11/07/2017 10:10 PM, Alistair Francis wrote:
>> When cross compiling QEMU for Windows we need to specify the cross
> 
> What toolchain do you use?
> 
>> version of ranlib to avoid build errors when buildling capstone. This
> 
> "building"
> 
>> patch ensures we use the same cross prefix on ranlib as other toolchain
>> components.

Please add this extra info in the commit (take from the mail thread)
which may be useful if we add a continuous integration test for these
toolchains/distribs.

- Fedora23 mingw
- RHEL-7 with mingw packages from epel:

   LINK    qemu-img.exe
 build-win64/capstone/capstone.lib: error adding symbols: Archive has no
index; run ranlib to add one
 collect2: error: ld returned 1 exit status

$ x86_64-w64-mingw32-ar --version
GNU ar (GNU Binutils) 2.25

- RHEL7.2

>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> MXE:
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> ---
>>
>>  Makefile  | 2 +-
>>  configure | 3 +++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0496c5057a..814f6820d9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -405,7 +405,7 @@ CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
>>  CAP_CFLAGS += -DCAPSTONE_HAS_X86
>>  
>>  subdir-capstone: .git-submodule-status
>> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
>> +	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
>>  
>>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
>>  	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>> diff --git a/configure b/configure
>> index a6055c0710..0e856bbc04 100755
>> --- a/configure
>> +++ b/configure
>> @@ -482,6 +482,7 @@ ccas="${CCAS-$cc}"
>>  cpp="${CPP-$cc -E}"
>>  objcopy="${OBJCOPY-${cross_prefix}objcopy}"
>>  ld="${LD-${cross_prefix}ld}"
>> +ranlib="${RANLIB-${cross_prefix}ranlib}"
>>  nm="${NM-${cross_prefix}nm}"
>>  strip="${STRIP-${cross_prefix}strip}"
>>  windres="${WINDRES-${cross_prefix}windres}"
>> @@ -6288,6 +6289,7 @@ echo "CCAS=$ccas" >> $config_host_mak
>>  echo "CPP=$cpp" >> $config_host_mak
>>  echo "OBJCOPY=$objcopy" >> $config_host_mak
>>  echo "LD=$ld" >> $config_host_mak
>> +echo "RANLIB=$ranlib" >> $config_host_mak
>>  echo "NM=$nm" >> $config_host_mak
>>  echo "WINDRES=$windres" >> $config_host_mak
>>  echo "CFLAGS=$CFLAGS" >> $config_host_mak
>> @@ -6782,6 +6784,7 @@ for rom in seabios vgabios ; do
>>      echo "OBJCOPY=objcopy" >> $config_mak
>>      echo "IASL=$iasl" >> $config_mak
>>      echo "LD=$ld" >> $config_mak
>> +    echo "RANLIB=$ranlib" >> $config_mak
>>  done
>>  
>>  # set up tests data directory
>>
