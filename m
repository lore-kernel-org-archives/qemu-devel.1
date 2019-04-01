Received: from eggs.gnu.org ([209.51.188.92]:46436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hAxf7-0004nz-Jz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hAxf6-0006Wu-BJ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:11:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40440
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hAxf6-0006Wg-4K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:11:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31E1Jx1107847
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 10:11:43 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkku59udr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 10:11:43 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 1 Apr 2019 15:11:42 +0100
Reply-To: jjherne@linux.ibm.com
References: <1552494682-16788-1-git-send-email-jjherne@linux.ibm.com>
	<1552494682-16788-12-git-send-email-jjherne@linux.ibm.com>
	<a52f522d-e161-f11f-a9b1-85f2ed2d0262@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 1 Apr 2019 10:11:34 -0400
MIME-Version: 1.0
In-Reply-To: <a52f522d-e161-f11f-a9b1-85f2ed2d0262@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <eba1dd75-6b95-1026-52b0-c5ca0c4552a0@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/15] s390-bios: cio error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/27/19 6:47 AM, Thomas Huth wrote:
> On 13/03/2019 17.31, Jason J. Herne wrote:
>> Add verbose error output for when unexpected i/o errors happen. This e=
ases the
>> burden of debugging and reporting i/o errors. No error information is =
printed
>> in the success case, here is an example of what is output on error:
>>
>> cio device error
>>    ssid  : 0x0000000000000000
>>    cssid : 0x0000000000000000
>>    sch_no: 0x0000000000000000
>>
>> Interrupt Response Block Data:
>>      Function Ctrl : [Start]
>>      Activity Ctrl : [Start-Pending]
>>      Status Ctrl : [Alert] [Primary] [Secondary] [Status-Pending]
>>      Device Status : [Unit-Check]
>>      Channel Status :
>>      cpa=3D: 0x000000007f8d6038
>>      prev_ccw=3D: 0x0000000000000000
>>      this_ccw=3D: 0x0000000000000000
>> Eckd Dasd Sense Data (fmt 32-bytes):
>>      Sense Condition Flags :
>>      Residual Count     =3D: 0x0000000000000000
>>      Phys Drive ID      =3D: 0x000000000000009e
>>      low cyl address    =3D: 0x0000000000000000
>>      head addr & hi cyl =3D: 0x0000000000000000
>>      format/message     =3D: 0x0000000000000008
>>      fmt-dependent[0-7] =3D: 0x0000000000000004
>>      fmt-dependent[8-15]=3D: 0xe561282305082fff
>>      prog action code   =3D: 0x0000000000000016
>>      Configuration info =3D: 0x00000000000040e0
>>      mcode / hi-cyl     =3D: 0x0000000000000000
>>      cyl & head addr [0]=3D: 0x0000000000000000
>>      cyl & head addr [1]=3D: 0x0000000000000000
>>      cyl & head addr [2]=3D: 0x0000000000000000
>>
>> The Sense Data section is currently only printed for ECKD DASD.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   pc-bios/s390-ccw/cio.c  | 237 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
>>   pc-bios/s390-ccw/libc.h |  11 +++
>>   2 files changed, 247 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>> index 58f63e4..54fd6ad 100644
>> --- a/pc-bios/s390-ccw/cio.c
>> +++ b/pc-bios/s390-ccw/cio.c
>> @@ -85,6 +85,228 @@ static bool irb_error(Irb *irb)
>>       return irb->scsw.dstat !=3D (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEN=
D);
>>   }
>>  =20
>> +static void print_eckd_dasd_sense_data(SenseDataEckdDasd *sd)
>> +{
>> +    char msgline[512];
>> +
>> +    if (sd->config_info & 0x8000) {
>> +        sclp_print("Eckd Dasd Sense Data (fmt 24-bytes):\n");
>> +    } else {
>> +        sclp_print("Eckd Dasd Sense Data (fmt 32-bytes):\n");
>> +    }
>> +
>> +    strcat(msgline, "    Sense Condition Flags :");
>> +    if (sd->status[0] & SNS_STAT0_CMD_REJECT) {
>> +        strcat(msgline, " [Cmd-Reject]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_INTERVENTION_REQ) {
>> +        strcat(msgline, " [Intervention-Required]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_BUS_OUT_CHECK) {
>> +        strcat(msgline, " [Bus-Out-Parity-Check]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_EQUIPMENT_CHECK) {
>> +        strcat(msgline, " [Equipment-Check]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_DATA_CHECK) {
>> +        strcat(msgline, " [Data-Check]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_OVERRUN) {
>> +        strcat(msgline, " [Overrun]");
>> +    }
>> +    if (sd->status[0] & SNS_STAT0_INCOMPL_DOMAIN) {
>> +        strcat(msgline, " [Incomplete-Domain]");
>> +    }
>> +
>> +    if (sd->status[1] & SNS_STAT1_PERM_ERR) {
>> +        strcat(msgline, " [Permanent-Error]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_INV_TRACK_FORMAT) {
>> +        strcat(msgline, " [Invalid-Track-Fmt]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_EOC) {
>> +        strcat(msgline, " [End-of-Cyl]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_MESSAGE_TO_OPER) {
>> +        strcat(msgline, " [Operator-Msg]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_NO_REC_FOUND) {
>> +        strcat(msgline, " [No-Record-Found]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_FILE_PROTECTED) {
>> +        strcat(msgline, " [File-Protected]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_WRITE_INHIBITED) {
>> +        strcat(msgline, " [Write-Inhibited]");
>> +    }
>> +    if (sd->status[1] & SNS_STAT1_IMPRECISE_END) {
>> +        strcat(msgline, " [Imprecise-Ending]");
>> +    }
>> +
>> +    if (sd->status[2] & SNS_STAT2_REQ_INH_WRITE) {
>> +        strcat(msgline, " [Req-Inhibit-Write]");
>> +    }
>> +    if (sd->status[2] & SNS_STAT2_CORRECTABLE) {
>> +        strcat(msgline, " [Correctable-Data-Check]");
>> +    }
>> +    if (sd->status[2] & SNS_STAT2_FIRST_LOG_ERR) {
>> +        strcat(msgline, " [First-Error-Log]");
>> +    }
>> +    if (sd->status[2] & SNS_STAT2_ENV_DATA_PRESENT) {
>> +        strcat(msgline, " [Env-Data-Present]");
>> +    }
>> +    if (sd->status[2] & SNS_STAT2_IMPRECISE_END) {
>> +        strcat(msgline, " [Imprecise-End]");
>> +    }
>=20
> GCC 8 aborts here:
>=20
> pc-bios/s390-ccw/cio.c: In function =E2=80=98do_cio=E2=80=99:
> pc-bios/s390-ccw/cio.c:146:19: error: array subscript 2 is above array
> bounds of =E2=80=98uint8_t[2]=E2=80=99 {aka =E2=80=98unsigned char[2]=E2=
=80=99} [-Werror=3Darray-bounds]
>       if (sd->status[2] & SNS_STAT2_REQ_INH_WRITE) {
>           ~~~~~~~~~~^~~
>=20
>   Thomas
>=20

This is a result of incomplete refactoring. We renamed status byte 0 to c=
ommon_status and=20
I never updated the references. Thanks for catching this. Myself and my c=
ompiler missed it.

--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
