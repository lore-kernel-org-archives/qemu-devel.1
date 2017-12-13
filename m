Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eP5cm-0008Ha-I4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eP5ch-0005WZ-Mn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:54:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eP5ch-0005W0-EY
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:54:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDBnJRI105924
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:54:47 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eu3m30bgx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:54:47 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 04:54:46 -0700
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510371554-29833-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLT2yDg25709DO_BbdSL0vY6TOjGYtVCo_gtarB6YNAXg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 06:54:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLT2yDg25709DO_BbdSL0vY6TOjGYtVCo_gtarB6YNAXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a80295eb-6744-f096-b98b-a800cf8af5cc@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm_tis: Return TPM_VERSION_UNSPEC in
 case of BE failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 12/13/2017 05:23 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Sat, Nov 11, 2017 at 4:39 AM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> In case the backend has a failure, such as the tpm_emulator's CMD_INIT
>> failing, the TIS goes into failure mode and does not respond to reads
>> or writes to MMIO registers. In this case we need to prevent the ACPI
>> table from being added and the straight-forward way is to indicate tha=
t
>> there's no known TPM version being used.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Resending an old response?

https://patchwork.kernel.org/patch/10058405/

>
>
>> ---
>>   hw/tpm/tpm_tis.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index c0a0204..eca3374 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -970,6 +970,10 @@ static enum TPMVersion tpm_tis_get_tpm_version(TP=
MIf *ti)
>>   {
>>       TPMState *s =3D TPM(ti);
>>
>> +    if (tpm_backend_had_startup_error(s->be_driver)) {
>> +        return TPM_VERSION_UNSPEC;
>> +    }
>> +
>>       return tpm_backend_get_tpm_version(s->be_driver);
>>   }
>>
>> --
>> 2.5.5
>>
>>
>
>
