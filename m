Received: from eggs.gnu.org ([2001:4830:134:3::10]:39829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ea5Dd-0006G7-4R
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ea5DY-0007ak-7f
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:42:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49820
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ea5DY-0007aM-1m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:42:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0CJdSfF096841
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:42:18 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ff2qu9nvm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:42:18 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 12 Jan 2018 12:42:17 -0700
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJwt+txMjY1AtCRF0_FzkgAm_qv8_itHUwnWD9s_Oucqg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 14:42:14 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJwt+txMjY1AtCRF0_FzkgAm_qv8_itHUwnWD9s_Oucqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <93fd6ae0-ab03-3e4a-cb85-26ab492e0f79@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] acpi: implement aml_lless_equal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: kevin@koconnor.net, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/2018 10:17 AM, Marc-Andr=C3=A9 Lureau wrote:
> 2018-01-10 19:35 GMT+01:00 Stefan Berger <stefanb@linux.vnet.ibm.com>:
>> LLessEqualOp =3D LNotOp LGreaterOp
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks. I added a comment line above the function now:

/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLLessEqual */

>
>
>> ---
>>   hw/acpi/aml-build.c         | 10 ++++++++++
>>   include/hw/acpi/aml-build.h |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 36a6cc4..597a58d 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -568,6 +568,16 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
>>       return var;
>>   }
>>
>> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2)
>> +{
>> +    /* LLessEqualOp :=3D LNotOp LGreaterOp */
>> +    Aml *var =3D aml_opcode(0x92 /* LNotOp */);
>> +    build_append_byte(var->buf, 0x94 /* LGreaterOp */);
>> +    aml_append(var, arg1);
>> +    aml_append(var, arg2);
>> +    return var;
>> +}
>> +
>>   /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefAdd */
>>   Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst)
>>   {
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 88d0738..c4398cc 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -267,6 +267,7 @@ Aml *aml_lor(Aml *arg1, Aml *arg2);
>>   Aml *aml_shiftleft(Aml *arg1, Aml *count);
>>   Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
>>   Aml *aml_lless(Aml *arg1, Aml *arg2);
>> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2);
>>   Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst);
>>   Aml *aml_subtract(Aml *arg1, Aml *arg2, Aml *dst);
>>   Aml *aml_increment(Aml *arg);
>> --
>> 2.5.5
>>
>>
>
>
