Received: from eggs.gnu.org ([209.51.188.92]:41782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtHhF-0002Xt-3M
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtHhE-0000x3-5a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:56:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtHhE-0000ua-0K
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:56:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1BJsjuD051333
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 14:56:45 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkd7rxfty-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 14:56:45 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 11 Feb 2019 19:56:44 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 11 Feb 2019 14:56:41 -0500
MIME-Version: 1.0
In-Reply-To: <13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 2/11/19 11:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Liam,
>
> On 2/11/19 4:03 PM, Liam Merwick wrote:
>> cppcheck reports:
>>
>> [hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires=
 'int' but the argument type is 'unsigned int'
>>
>> Fix this by using %u instead of %d


Liam, Neither gcc nor cppcheck 1.86 complains about this on my system.=20
What version of cppcheck are you using?


>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>>   hw/tpm/tpm_tis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 860c2ace7d99..395500e8a61d 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -110,7 +110,7 @@ static void tpm_tis_show_buffer(const unsigned cha=
r *buffer,
>>       uint32_t len, i;
> If you want to clean this, use a size_t here instead of u32.
>
>>  =20
>>       len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
>> -    printf("tpm_tis: %s length =3D %d\n", string, len);
>> +    printf("tpm_tis: %s length =3D %u\n", string, len);
> So here the format is '%zu'.
> However in code cleanup we try go get ride of printf() calls and replac=
e
> them with trace points.


This code is only used for debugging if DEBUG_TIS has been #defined. No=20
need to add tracing here.


>
>>       for (i =3D 0; i < len; i++) {
>>           if (i && !(i % 16)) {
>>               printf("\n");
>>
