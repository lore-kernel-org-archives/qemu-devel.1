Received: from eggs.gnu.org ([2001:4830:134:3::10]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIEc1-0006f6-Rt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIEby-0003Fv-4z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIEbx-0003FN-Vk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:33:30 -0400
References: <20170606121747.25356-1-pbonzini@redhat.com>
	<20170606121747.25356-3-pbonzini@redhat.com>
	<4dc94314-3a5b-7cf6-12d9-c63fbfc22cb6@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d4889fb-e78a-4b5a-fcf1-8f7dbd79553c@redhat.com>
Date: Tue, 6 Jun 2017 15:33:19 +0200
MIME-Version: 1.0
In-Reply-To: <4dc94314-3a5b-7cf6-12d9-c63fbfc22cb6@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] megasas: do not read sense length more
 than once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: zyy4013@stu.ouc.edu.cn, hare@suse.de, ppandit@redhat.com



On 06/06/2017 15:26, Philippe Mathieu-Daud=E9 wrote:
> Hi Paolo,
>=20
> Should this patch go in qemu-stable?
>=20
> On 06/06/2017 09:17 AM, Paolo Bonzini wrote:
>> Avoid TOC-TOU bugs depending on how the compiler behaves.
>=20
> Can you be more descriptive here? Which compiler? (thinking about how t=
o
> prevent this class of bugs).

If you do

int f(int *x)
{
   if (*x =3D=3D 0) {
       return 42;
   }
   return *x;
}

It's possible that the guest races against the two reads and f() returns
zero.  This is unlikely in the case at least at -O2, but pretty likely
at -O0.

For other patches later in the series, there is no compiler dependence
at all, since the two accesses occur very far from each other.

There is no way really to prevent them except being careful: the rule is
basically that guest-provided data must only be read once.

Thanks,

Paolo

> Regards,
>=20
> Phil.
>=20
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/scsi/megasas.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
>> index 804122ab05..1888118e5f 100644
>> --- a/hw/scsi/megasas.c
>> +++ b/hw/scsi/megasas.c
>> @@ -309,9 +309,11 @@ static int megasas_build_sense(MegasasCmd *cmd,
>> uint8_t *sense_ptr,
>>      PCIDevice *pcid =3D PCI_DEVICE(cmd->state);
>>      uint32_t pa_hi =3D 0, pa_lo;
>>      hwaddr pa;
>> +    int frame_sense_len;
>>
>> -    if (sense_len > cmd->frame->header.sense_len) {
>> -        sense_len =3D cmd->frame->header.sense_len;
>> +    frame_sense_len =3D cmd->frame->header.sense_len;
>> +    if (sense_len > frame_sense_len) {
>> +        sense_len =3D frame_sense_len;
>>      }
>>      if (sense_len) {
>>          pa_lo =3D le32_to_cpu(cmd->frame->pass.sense_addr_lo);
>>
