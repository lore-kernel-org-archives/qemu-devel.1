Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eA0HD-0005JY-Q3
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 17:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eA0HC-00045h-QJ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 17:10:19 -0400
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ce8c1a6e1ab21911798dba9915bab413dc9f3e38.1508390588.git.alistair.francis@xilinx.com>
	<e0a073e4-a976-360e-3c55-6e2a221af519@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <ef1fc32a-c730-a2c2-4a06-189f84420b0e@redhat.com>
Date: Wed, 1 Nov 2017 17:10:09 -0400
MIME-Version: 1.0
In-Reply-To: <e0a073e4-a976-360e-3c55-6e2a221af519@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 16/46] hw/ide: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com, qemu-block@nongnu.org



On 10/24/2017 11:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Alistair,
>=20
> On 10/19/2017 01:16 PM, Alistair Francis wrote:
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and the=
n
>> compiler issues where manually fixed.
>>
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|e=
rror_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|err=
or_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_r=
eport("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_rep=
ort("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repor=
t("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report(=
"\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\=
1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"=
\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2=
);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);=
|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|I=
g}' \
>>     {} +
>>
>> Some lines where then manually tweaked to pass checkpatch.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: qemu-block@nongnu.org
>> ---
>> V2:
>>  - Split hw patch into individual directories
>>
>>  hw/ide/ahci.c | 6 +++---
>>  hw/ide/core.c | 2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index c25e293d88..2ed015285a 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -410,8 +410,8 @@ static void ahci_mem_write(void *opaque, hwaddr ad=
dr,
>> =20
>>      /* Only aligned reads are allowed on AHCI */
>>      if (addr & 3) {
>> -        fprintf(stderr, "ahci: Mis-aligned write to addr 0x"
>> -                TARGET_FMT_plx "\n", addr);
>> +        error_report("ahci: Mis-aligned write to addr 0x"
>> +                     TARGET_FMT_plx "", addr);
>=20
> removing this trailing "":
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

^ ACK

Acked-by: John Snow <jsnow@redhat.com>

>>          return;
>>      }
>> =20
>> @@ -1053,7 +1053,7 @@ static void process_ncq_command(AHCIState *s, in=
t port, uint8_t *cmd_fis,
>>      g_assert(is_ncq(ncq_fis->command));
>>      if (ncq_tfs->used) {
>>          /* error - already in use */
>> -        fprintf(stderr, "%s: tag %d already used\n", __func__, tag);
>> +        error_report("%s: tag %d already used", __func__, tag);
>>          return;
>>      }
>> =20
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 5f1cd3b91f..0ea34f62ba 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -2762,7 +2762,7 @@ static int ide_drive_pio_pre_save(void *opaque)
>> =20
>>      idx =3D transfer_end_table_idx(s->end_transfer_func);
>>      if (idx =3D=3D -1) {
>> -        fprintf(stderr, "%s: invalid end_transfer_func for DRQ_STAT\n=
",
>> +        error_report("%s: invalid end_transfer_func for DRQ_STAT",
>>                          __func__);
>=20
> eventually indent this line?
>=20
>                         __func__);
>=20
>>          s->end_transfer_fn_idx =3D 2;
>>      } else {
>=20
>=20
