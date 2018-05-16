Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIyCl-0006Z4-18
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIyCh-0003sN-QL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:19:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIyCh-0003ru-GK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:18:59 -0400
Received: by mail-wm0-x241.google.com with SMTP id a67-v6so2515235wmf.3
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:18:59 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
	<bb44b0dc-d0c2-2ff3-1815-00b80f199848@linux.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bb44b0dc-d0c2-2ff3-1815-00b80f199848@linux.ibm.com>
Date: Wed, 16 May 2018 16:18:56 +0100
Message-ID: <87r2mbeihr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: muriloo@linux.ibm.com
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:

> On 04/24/2018 12:23 PM, Alex Benn=C3=A9e wrote:
>> This allows us to specify cross compilers for our guests. This is
>> useful for building test images/programs. Currently we re-run the
>> compile test for each target. I couldn't think of a way to cache the
>> value for a given arch without getting messier configure code.
>>
>> The cross compiler for the guest is visible to each target as
>> CROSS_CC_GUEST in config-target.mak.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit...
>>   - --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D=
*}
>>   - add remaining target_compiler definitions
>> ---
>>  configure | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
>> diff --git a/configure b/configure
>> index b0ae632ee4..caa838a0d0 100755
>> --- a/configure
>> +++ b/configure
>> @@ -453,6 +453,13 @@ vxhs=3D""
>>  libxml2=3D""
>>  docker=3D"no"
>>
>> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
>> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
>> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
>> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
>
> Do we need to have default values for all targets?
>
>> +
>> +enabled_cross_compilers=3D""
>> +
>>  supported_cpu=3D"no"
>>  supported_os=3D"no"
>>  bogus_os=3D"no"
>> @@ -483,6 +490,11 @@ for opt do
>>    ;;
>>    --disable-debug-info) debug_info=3D"no"
>>    ;;
>> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FO=
O option"
>> +  ;;
>> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
>> +                eval "cross_cc_${cc_arch}=3D\$optarg"
>> +  ;;
>
> Do we need to verify if a valid --cross-cc-FOO was passed, in case of a
> typo?

How so? We do attempt to build with these options later.

>>
>> +# Do we have a cross compiler for this target?
>> +if has $target_compiler; then
>> +
>> +    cat > $TMPC << EOF
>> +#include <stdio.h>
>> +int main(void) {
>> +    printf("Hello World!\n");
>> +}
>> +EOF
>
> Can this be replaced by write_c_skeleton?

Sure. Thanks.

--
Alex Benn=C3=A9e
