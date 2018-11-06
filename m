Received: from eggs.gnu.org ([2001:4830:134:3::10]:54923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2SV-0002p5-9p
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2SR-0004MG-AJ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:35:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gK2SR-0004M2-59
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:35:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA6EZ2mb110972
	for <qemu-devel@nongnu.org>; Tue, 6 Nov 2018 09:35:54 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nkaejy63m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 09:35:54 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 6 Nov 2018 14:35:53 -0000
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
	<20181030214740.2294043-3-stefanb@linux.vnet.ibm.com>
	<e1c724bf-4117-a938-bc20-3056991ce0ec@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 6 Nov 2018 09:35:49 -0500
MIME-Version: 1.0
In-Reply-To: <e1c724bf-4117-a938-bc20-3056991ce0ec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <941ac771-44b0-c3df-1693-c8b38a7d042e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 2/5] tests/tpm: Display if swtpm is not
 found or --tpm2 not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 11/6/18 6:51 AM, Thomas Huth wrote:
> On 2018-10-30 22:47, Stefan Berger wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> If swtpm is not found in $PATH or --tpm2 isn't supported, we display
>> this in the test log. We cannot mark the test as skipped due to a bug =
in
>> certain versions of the gtester environment that interprets a skipped =
test
>> as failure.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   tests/tpm-tests.c | 33 +++++++++++++++++++++------------
>>   tests/tpm-util.c  |  8 +-------
>>   tests/tpm-util.h  |  2 ++
>>   3 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
>> index 10c6592aac..93a5beba01 100644
>> --- a/tests/tpm-tests.c
>> +++ b/tests/tpm-tests.c
>> @@ -18,6 +18,17 @@
>>   #include "libqtest.h"
>>   #include "tpm-tests.h"
>>  =20
>> +static bool
>> +tpm_test_swtpm_skip(void)
>> +{
>> +    if (!tpm_util_swtpm_has_tpm2()) {
>> +        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support;=
 ");
>> +        return true;
>> +    }
> I now get this ugly (4-times duplicated) output each time I run "make c=
heck":
>
> swtpm not in PATH or missing --tpm2 support; swtpm not in PATH or missi=
ng --tpm2 support; swtpm not in PATH or missing --tpm2 support; swtpm not=
 in PATH or missing --tpm2 support;
>
> Could you please use g_test_message() here instead like we're doing
> it in most of the other tests already?


Sure, I'll change it. When I tested it I found these lines in the log=20
formatted as expected.

 =C2=A0=C2=A0 Stefan

>
>   Thanks,
>    Thomas
>
