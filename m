Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9cL-00006y-EJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9cH-0001o6-H3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:53:17 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-5-pbonzini@redhat.com>
	<74cd69b3-0425-53fe-5c5d-9604740d8f34@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65d6f4f3-c30b-5cb2-9b2a-7d1e25038a19@redhat.com>
Date: Tue, 22 Aug 2017 15:53:01 +0200
MIME-Version: 1.0
In-Reply-To: <74cd69b3-0425-53fe-5c5d-9604740d8f34@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/10] scsi: introduce
 sg_io_sense_from_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

On 22/08/2017 15:45, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Paolo,
>=20
> On 08/22/2017 10:18 AM, Paolo Bonzini wrote:
>> Move more knowledge of SG_IO out of hw/scsi/scsi-generic.c, for
>> reusability.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/scsi/scsi-generic.c | 40 +++++++---------------------------------
>>   include/scsi/utils.h   |  3 +++
>>   scsi/utils.c           | 35 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 45 insertions(+), 33 deletions(-)
>>
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index 7a8f500934..04c687ee76 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -81,6 +81,7 @@ static void scsi_free_request(SCSIRequest *req)
>>   static void scsi_command_complete_noio(SCSIGenericReq *r, int ret)
>>   {
>>       int status;
>> +    SCSISense sense;
>>         assert(r->req.aiocb =3D=3D NULL);
>>   @@ -88,42 +89,15 @@ static void
>> scsi_command_complete_noio(SCSIGenericReq *r, int ret)
>>           scsi_req_cancel_complete(&r->req);
>>           goto done;
>>       }
>> -    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
>> -        r->req.sense_len =3D r->io_header.sb_len_wr;
>> -    }
>> -
>> -    if (ret !=3D 0) {
>> -        switch (ret) {
>> -        case -EDOM:
>> -            status =3D TASK_SET_FULL;
>> -            break;
>> -        case -ENOMEM:
>> -            status =3D CHECK_CONDITION;
>> -            scsi_req_build_sense(&r->req, SENSE_CODE(TARGET_FAILURE))=
;
>> -            break;
>> -        default:
>> -            status =3D CHECK_CONDITION;
>> -            scsi_req_build_sense(&r->req, SENSE_CODE(IO_ERROR));
>> -            break;
>> -        }
>> -    } else {
>> -        if (r->io_header.host_status =3D=3D SG_ERR_DID_NO_CONNECT ||
>> -            r->io_header.host_status =3D=3D SG_ERR_DID_BUS_BUSY ||
>> -            r->io_header.host_status =3D=3D SG_ERR_DID_TIME_OUT ||
>> -            (r->io_header.driver_status & SG_ERR_DRIVER_TIMEOUT)) {
>> -            status =3D BUSY;
>> -            BADF("Driver Timeout\n");
>> -        } else if (r->io_header.host_status) {
>> -            status =3D CHECK_CONDITION;
>> -            scsi_req_build_sense(&r->req, SENSE_CODE(I_T_NEXUS_LOSS))=
;
>> -        } else if (r->io_header.status) {
>> -            status =3D r->io_header.status;
>> -        } else if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) =
{
>> -            status =3D CHECK_CONDITION;
>> +    status =3D sg_io_sense_from_errno(-ret, &r->io_header, &sense);
>> +    if (status =3D=3D CHECK_CONDITION) {
>> +        if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
>> +            r->req.sense_len =3D r->io_header.sb_len_wr;
>>           } else {
>> -            status =3D GOOD;
>> +            scsi_req_build_sense(&r->req, sense);
>>           }
>>       }
>> +
>>       DPRINTF("Command complete 0x%p tag=3D0x%x status=3D%d\n",
>>               r, r->req.tag, status);
>>   diff --git a/include/scsi/utils.h b/include/scsi/utils.h
>> index 76c3db98c0..c12b34f2e5 100644
>> --- a/include/scsi/utils.h
>> +++ b/include/scsi/utils.h
>> @@ -113,6 +113,9 @@ int scsi_cdb_length(uint8_t *buf);
>>   #define SG_ERR_DID_TIME_OUT    0x03
>>     #define SG_ERR_DRIVER_SENSE    0x08
>> +
>> +int sg_io_sense_from_errno(int errno_value, struct sg_io_hdr *io_hdr,
>> +                           SCSISense *sense);
>>   #endif
>>     #endif
>> diff --git a/scsi/utils.c b/scsi/utils.c
>> index 54d6d4486a..ca5b058a73 100644
>> --- a/scsi/utils.c
>> +++ b/scsi/utils.c
>> @@ -412,3 +412,38 @@ const char *scsi_command_name(uint8_t cmd)
>>       }
>>       return names[cmd];
>>   }
>> +
>> +#ifdef CONFIG_LINUX
>> +int sg_io_sense_from_errno(int errno_value, struct sg_io_hdr *io_hdr,
>> +                           SCSISense *sense)
>> +{
>> +    if (errno_value !=3D 0) {
>> +        switch (errno_value) {
>> +        case EDOM:
>> +            return TASK_SET_FULL;
>> +        case ENOMEM:
>> +            *sense =3D SENSE_CODE(TARGET_FAILURE);
>> +            return CHECK_CONDITION;
>> +        default:
>> +            *sense =3D SENSE_CODE(IO_ERROR);
>> +            return CHECK_CONDITION;
>> +        }
>> +    } else {
>> +        if (io_hdr->host_status =3D=3D SG_ERR_DID_NO_CONNECT ||
>> +            io_hdr->host_status =3D=3D SG_ERR_DID_BUS_BUSY ||
>> +            io_hdr->host_status =3D=3D SG_ERR_DID_TIME_OUT ||
>> +            (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT)) {
>> +            return BUSY;
>> +        } else if (io_hdr->host_status) {
>> +            *sense =3D SENSE_CODE(I_T_NEXUS_LOSS);
>> +            return CHECK_CONDITION;
>> +        } else if (io_hdr->status) {
>> +            return io_hdr->status;
>> +        } else if (io_hdr->driver_status & SG_ERR_DRIVER_SENSE) {
>> +            return CHECK_CONDITION;
>> +        }
>=20
>> +    }
> I find it easier to read with the return GOOD out of the if/else:
>=20
>        return GOOD;

Yes, you're right.

Paolo
