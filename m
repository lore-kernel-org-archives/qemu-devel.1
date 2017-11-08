Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCUyW-0006T1-Rj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCUyT-0000gy-N1
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:21:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCUyT-0000gU-EA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:21:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8IJfOC089597
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 13:21:15 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e44gvst78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:21:02 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 13:20:29 -0500
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-6-git-send-email-stefanb@linux.vnet.ibm.com>
	<20171108162256.GF13150@boraha>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 13:20:27 -0500
MIME-Version: 1.0
In-Reply-To: <20171108162256.GF13150@boraha>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d049e7e6-690f-ebc7-b27b-85033371b0eb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] tpm: tpm_passthrough: Fail startup if
 FE buffer size < BE buffer size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com

On 11/08/2017 11:22 AM, Marc-Andr=E9 Lureau wrote:
> Hi Stefan,
>
> On Mon, Nov 06, 2017 at 07:58:56PM -0500, Stefan Berger wrote:
>> If the requested buffer size of the frontend is smaller than the fixed
>> buffer size of the host's TPM, fail the startup_tpm() interface functi=
on,
>> which will make the device unusable. We fail it because the backend TP=
M
>> could produce larger packets than what the frontend could pass to the =
OS.
>>
>> The current combination of TIS frontend and either passthrough or emul=
ator
>> backend will not lead to this case since the TIS can support any size =
of
>> buffer.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_passthrough.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
>> index ec755fe..66d5098 100644
>> --- a/hw/tpm/tpm_passthrough.c
>> +++ b/hw/tpm/tpm_passthrough.c
>> @@ -304,6 +304,20 @@ static TPMBackend *tpm_passthrough_create(QemuOpt=
s *opts)
>>       return TPM_BACKEND(obj);
>>   }
>>  =20
>> +static int tpm_passthrough_startup_tpm(TPMBackend *tb, uint32_t buffe=
rsize)
>> +{
>> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
>> +
>> +    if (buffersize && buffersize < tpm_pt->tpm_buffersize) {
>> +        error_report("Requested buffer size of %u is smaller than hos=
t TPM's "
>> +                     "fixed buffer size of %u",
>> +                     buffersize, tpm_pt->tpm_buffersize);
> Looks ok
>
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *t=
b)
>>   {
>>       TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
>> @@ -362,6 +376,7 @@ static void tpm_passthrough_class_init(ObjectClass=
 *klass, void *data)
>>       tbc->opts =3D tpm_passthrough_cmdline_opts;
>>       tbc->desc =3D "Passthrough TPM backend driver";
>>       tbc->create =3D tpm_passthrough_create;
>> +    tbc->startup_tpm =3D tpm_passthrough_startup_tpm;
>>       tbc->reset =3D tpm_passthrough_reset;
>>       tbc->cancel_cmd =3D tpm_passthrough_cancel_cmd;
>>       tbc->get_tpm_established_flag =3D tpm_passthrough_get_tpm_establ=
ished_flag;
>> --=20
>> 2.5.5
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>

Thanks for the review. I'll post v2 shortly.

     Stefan
