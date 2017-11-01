Received: from eggs.gnu.org ([2001:4830:134:3::10]:37049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yt7-0000Gv-Sb
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yt3-0001Ey-R1
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:41:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36910
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yt3-0001EL-L9
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:41:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1JVVDU027180
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:41:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dykuytf1w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:41:14 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:41:14 -0400
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
	<81734112-f8f6-bd49-f43d-77dbdfc34c46@amsat.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 17:41:09 -0200
MIME-Version: 1.0
In-Reply-To: <81734112-f8f6-bd49-f43d-77dbdfc34c46@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b1249dd1-9efc-1502-09c5-af63c8b1f4e1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] configure: do CC check before verifying
 host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com



On 11/01/2017 05:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Maybe "configure: check $CC available before verifying host CPU" ?

If the maintainer is willing to amend the patch before pushing, works=20
for me!


Daniel

>
> On 11/01/2017 04:31 PM, Daniel Henrique Barboza wrote:
>> When executing 'configure' in a fresh QEMU clone, in a fresh
>> OS install running in a ppc64le host, this is the error
>> shown:
>>
>> -----
>>
>> ../configure --enable-trace-backend=3Dsimple --enable-debug
>>      --target-list=3Dppc64-softmmu
>>
>> ERROR: Unsupported CPU =3D ppc64le, try --enable-tcg-interpreter
>>
>> -----
>>
>> This isn't true, ppc64le host CPU is supported. This happens because,
>> in a fresh install, we don't have a C compiler to autodetect
>> the $cpu variable to "ppc64".
>>
>> Since we need a C compiler to properly get the value of $cpu
>> in this and other cases, this patch changes the location of the C
>> compiler check right after setting the preferred CC.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> ---
>>   configure | 34 +++++++++++++++++-----------------
>>   1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 285d123dbf..a641bf18b6 100755
>> --- a/configure
>> +++ b/configure
>> @@ -467,6 +467,23 @@ else
>>     cc=3D"${CC-${cross_prefix}gcc}"
>>   fi
>>  =20
>> +write_c_skeleton() {
>> +    cat > $TMPC <<EOF
>> +int main(void) { return 0; }
>> +EOF
>> +}
>> +
>> +# check that the C compiler works.
>> +write_c_skeleton;
>> +if compile_object ; then
>> +  : C compiler works ok
>> +else
>> +    error_exit "\"$cc\" either does not exist or does not work"
>> +fi
>> +if ! compile_prog ; then
>> +    error_exit "\"$cc\" cannot build an executable (is your linker br=
oken?)"
>> +fi
>> +
>>   if test -z "${CXX}${cross_prefix}"; then
>>     cxx=3D"c++"
>>   else
>> @@ -537,12 +554,6 @@ EOF
>>     compile_object
>>   }
>>  =20
>> -write_c_skeleton() {
>> -    cat > $TMPC <<EOF
>> -int main(void) { return 0; }
>> -EOF
>> -}
>> -
>>   if check_define __linux__ ; then
>>     targetos=3D"Linux"
>>   elif check_define _WIN32 ; then
>> @@ -1593,17 +1604,6 @@ if test -z "$werror" ; then
>>       fi
>>   fi
>>  =20
>> -# check that the C compiler works.
>> -write_c_skeleton;
>> -if compile_object ; then
>> -  : C compiler works ok
>> -else
>> -    error_exit "\"$cc\" either does not exist or does not work"
>> -fi
>> -if ! compile_prog ; then
>> -    error_exit "\"$cc\" cannot build an executable (is your linker br=
oken?)"
>> -fi
>> -
>>   if test "$bogus_os" =3D "yes"; then
>>       # Now that we know that we're not printing the help and that
>>       # the compiler works (so the results of the check_defines we use=
d
>>
