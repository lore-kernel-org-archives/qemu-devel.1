Received: from eggs.gnu.org ([2001:4830:134:3::10]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYUz2-0005Jw-Be
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYUz1-0008TK-E7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:21:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fYUz1-0008R7-70
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:21:03 -0400
Received: by mail-wr0-x241.google.com with SMTP id t6-v6so5099870wrq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 04:21:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f500f7df-3eff-c9d6-2630-0c00f2360d6e@linux.vnet.ibm.com>
References: <20180621115530.11069-1-marcandre.lureau@redhat.com>
	<20180621115530.11069-2-marcandre.lureau@redhat.com>
	<f500f7df-3eff-c9d6-2630-0c00f2360d6e@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 28 Jun 2018 13:21:01 +0200
Message-ID: <CAJ+F1CLJNjy4cOS5Vn182MOW-EPNngfOmdOJ5sE7SGJNqMuKBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Jun 21, 2018 at 2:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 06/21/2018 07:55 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> The following patches implement the TPM Physical Presence Interface,
>> and makes use of new memory region and fw_cfg entries. Enable it by
>> default on >2.12 machine type.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/hw/compat.h | 10 ++++++++++
>>   hw/tpm/tpm_crb.c    |  3 +++
>>   hw/tpm/tpm_tis.c    |  3 +++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>> index 563908b874..dac847548b 100644
>> --- a/include/hw/compat.h
>> +++ b/include/hw/compat.h
>> @@ -2,6 +2,16 @@
>>   #define HW_COMPAT_H
>>     #define HW_COMPAT_2_12 \
>> +    {\
>> +        .driver   =3D "tpm-crb",\
>> +        .property =3D "ppi",\
>> +        .value    =3D "false",\
>> +    },\
>> +    {\
>> +        .driver   =3D "tpm-tis",\
>> +        .property =3D "ppi",\
>> +        .value    =3D "false",\
>> +    },\
>>       {\
>>           .driver   =3D "migration",\
>>           .property =3D "decompress-error-check",\
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index a92dd50437..d5b0ac5920 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -41,6 +41,8 @@ typedef struct CRBState {
>>       MemoryRegion cmdmem;
>>         size_t be_buffer_size;
>> +
>> +    bool ppi_enabled;
>>   } CRBState;
>>     #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
>> @@ -221,6 +223,7 @@ static const VMStateDescription vmstate_tpm_crb =3D =
{
>>     static Property tpm_crb_properties[] =3D {
>>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>> +    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>
>
> Wouldn't we have to bump up the version of teh VMStateDescription?

A device property is not saved with vmstate afaik.

>
>    Stefan
>
>>   diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 12f5c9a759..d9ddf9b723 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -81,6 +81,8 @@ typedef struct TPMState {
>>       TPMVersion be_tpm_version;
>>         size_t be_buffer_size;
>> +
>> +    bool ppi_enabled;
>>   } TPMState;
>>     #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
>> @@ -950,6 +952,7 @@ static const VMStateDescription vmstate_tpm_tis =3D =
{
>>   static Property tpm_tis_properties[] =3D {
>>       DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
>>       DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
>> +    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
