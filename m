Received: from eggs.gnu.org ([2001:4830:134:3::10]:36205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yrG-0007oD-0z
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yrB-000884-SC
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yrB-00087Q-JK
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:39:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1JVPcq003994
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:39:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dyh353uxq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:39:16 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:39:15 -0400
References: <20171101192151.18972-1-danielhb@linux.vnet.ibm.com>
	<57a99d3c-5157-e3b9-9696-49bbd821422d@amsat.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 17:39:09 -0200
MIME-Version: 1.0
In-Reply-To: <57a99d3c-5157-e3b9-9696-49bbd821422d@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <de8d0da3-2ec2-7149-1121-06df87a88228@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] configure: adding ppc64le to supported
 host CPUs
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



On 11/01/2017 05:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Daniel,
>
> On 11/01/2017 04:21 PM, Daniel Henrique Barboza wrote:
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
> Can you add the output of the new behavior?
>
> Also please update the subject, then:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Hey!

I've updated the subject in the v4 already.

The output didn't change: in my test scenario (fresh OS with no
CC installed in a ppc64le host), if I try to run configure I get:


../configure --enable-trace-backend=3Dsimple --enable-debug=20
--target-list=3Dppc64-softmmu

ERROR: "cc" either does not exist or does not work


Instead of an error message saying that ppc64le isn't supported.



Daniel
>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
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
