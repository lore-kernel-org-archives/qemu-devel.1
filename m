Received: from eggs.gnu.org ([209.51.188.92]:44050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtYMj-0001At-U1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtYMi-0001nT-LC
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:44:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtYMi-0001m5-B2
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:44:48 -0500
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
	<0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
	<bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
	<f7b55eef-68da-ef50-b060-05e86f659903@redhat.com>
	<113577fd-71c8-972f-b658-635d3decd62d@linux.ibm.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <7339d38a-74b7-bac8-677f-a27b88226453@oracle.com>
Date: Tue, 12 Feb 2019 13:43:54 +0000
MIME-Version: 1.0
In-Reply-To: <113577fd-71c8-972f-b658-635d3decd62d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
To: Stefan Berger <stefanb@linux.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, liam.merwick@oracle.com

On 12/02/2019 13:27, Stefan Berger wrote:
> On 2/12/19 7:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/11/19 10:13 PM, Stefan Berger wrote:
>>> On 2/11/19 3:09 PM, Liam Merwick wrote:
>>>> On 11/02/2019 19:56, Stefan Berger wrote:
>>>>> On 2/11/19 11:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 2/11/19 4:03 PM, Liam Merwick wrote:
>> [...]
>>>>>>> -=C2=A0=C2=A0=C2=A0 printf("tpm_tis: %s length =3D %d\n", string,=
 len);
>>>>>>> +=C2=A0=C2=A0=C2=A0 printf("tpm_tis: %s length =3D %u\n", string,=
 len);
>>>>>> So here the format is '%zu'.
>>>>>> However in code cleanup we try go get ride of printf() calls and
>>>>>> replace them with trace points.
>>>>>
>>>>> This code is only used for debugging if DEBUG_TIS has been #defined.
>>>>> No need to add tracing here.
>>>> I'd come up the attached change (but that seems like overkill).
>>>
>>> I don't think we need tracing for this.
>> So if you think the code is mature enough, let's remove the DEBUG call=
s!
>>
>> Else we prefer to convert DEBUG printf to trace events because (at=20
>> least):
>> - no need to recompile to enable debugging
>> - when compiled with debugging, you don't mess with STDIO which can be
>> used as a chardev backend.
> Fine. Then I withdraw my reviewed-by.


I don't see a way of removing the DEBUG calls without adding the=20
overhead of a call to tpm_tis_show_buffer() each time even if tracing is=20
not enabled (the 3 trace calls are interdependent and need a for loop).
Is there any example of a trace point that calls a function that then=20
does non-trivial printing?

I could send a v3 with the patch I attached previously with the 3 printf=20
calls changed to trace points but still wrapped in 'if (DEBUG_TIS)' and=20
optimised out in non-debug.

Regards,
Liam
