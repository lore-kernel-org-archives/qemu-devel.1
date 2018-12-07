Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gVJ7l-0001JH-Cc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gVJ7i-0000GZ-59
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gVJ7h-00005f-Fd
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:37:05 -0500
References: <20181207131732.21073-1-lvivier@redhat.com>
	<f4c7787a-c0c5-b239-9d61-e5ae0fcfa6b9@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5206f22c-a472-2f17-e9e9-adf7960fb6cb@redhat.com>
Date: Fri, 7 Dec 2018 17:37:01 +0100
MIME-Version: 1.0
In-Reply-To: <f4c7787a-c0c5-b239-9d61-e5ae0fcfa6b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi-disk: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/12/2018 16:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/7/18 2:17 PM, Laurent Vivier wrote:
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  hw/scsi/scsi-disk.c  | 105 +++++++++++++++++++++---------------------=
-
>>  hw/scsi/trace-events |  29 ++++++++++++
>>  2 files changed, 81 insertions(+), 53 deletions(-)
...
>> =20
>> +static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, ui=
nt8_t *buf,
>> +                                       void (*trace_fn)(uint32_t, uin=
t32_t,
>> +                                                        char const *)=
)
>> +{
>> +    int i;
>> +    int len =3D scsi_cdb_length(buf);
>> +    char *line_buffer, *p;
>> +
>> +    line_buffer =3D g_malloc(len * 5 + 1);
>> +
>> +    for (i =3D 0, p =3D line_buffer; i < len; i++) {
>> +        p +=3D sprintf(p, " 0x%02x", buf[i]);
>> +    }
>> +    trace_fn(lun, tag, line_buffer);
>> +
>> +    g_free(line_buffer);
>> +}
>> +
>>  static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uin=
t32_t lun,
>>                                       uint8_t *buf, void *hba_private)
>>  {
>> @@ -2512,16 +2518,9 @@ static SCSIRequest *scsi_new_request(SCSIDevice=
 *d, uint32_t tag, uint32_t lun,
>>      }
>>      req =3D scsi_req_alloc(ops, &s->qdev, tag, lun, hba_private);
>> =20
>> -#ifdef DEBUG_SCSI
>> -    DPRINTF("Command: lun=3D%d tag=3D0x%x data=3D0x%02x", lun, tag, b=
uf[0]);
>> -    {
>> -        int i;
>> -        for (i =3D 1; i < scsi_cdb_length(buf); i++) {
>> -            printf(" 0x%02x", buf[i]);
>> -        }
>> -        printf("\n");
>> +    if (trace_event_get_state_backends(TRACE_SCSI_DISK_NEW_REQUEST)) =
{
>> +        scsi_disk_new_request_dump(lun, tag, buf, trace_scsi_disk_new=
_request);
>=20
> TIL about trace_event_get_state_backends(), I'll use it to clean other
> hexdump traces, thanks :)

I've copied that from gdbstub.c where there is an hexdump() function
using it.

I'm going to send a v2 of this patch, because I think it is not needed
in this case to pass the function in the parameters.

Thanks,
Laurent
