Received: from eggs.gnu.org ([2001:4830:134:3::10]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yyZ-0002CC-RK
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9yyW-0005SQ-Id
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:46:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9yyW-0005Re-8h
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:46:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1Jkfb9097439
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 15:46:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dyjxxdq6h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 15:46:54 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 15:46:53 -0400
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
	<CAFEAcA9TD+imsuD+0zmZ5FGH7cVCw5+ZiKdPS1uBjqj=ujKiQw@mail.gmail.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 17:46:49 -0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TD+imsuD+0zmZ5FGH7cVCw5+ZiKdPS1uBjqj=ujKiQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <fb931086-a889-7e76-5c1e-ec393d681044@linux.vnet.ibm.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>



On 11/01/2017 05:41 PM, Peter Maydell wrote:
> On 1 November 2017 at 19:31, Daniel Henrique Barboza
> <danielhb@linux.vnet.ibm.com> wrote:
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
>>
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
> I think that currently we try to make "--help" work
> even if you don't have a working C compiler. Does this
> break that?
Just checked, configure --help isn't broken with this change:


$ ../configure --help

Usage: configure [options]
Options: [defaults in brackets after descriptions]

Standard options:
 =C2=A0 --help=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print this message
(...)


Thanks,

Daniel

>
> thanks
> -- PMM
>
