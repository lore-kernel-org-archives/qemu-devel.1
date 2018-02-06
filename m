Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6gt-0008Rg-Ue
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ej6gn-000136-SI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:05:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ej6gn-00012t-NX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:05:49 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16H4lE1005549
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 12:05:45 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf6ukwu9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:05:43 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 12:05:42 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-2-git-send-email-walling@linux.vnet.ibm.com>
	<fec28e66-4b6e-d448-9245-77583608dcf6@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 12:05:38 -0500
MIME-Version: 1.0
In-Reply-To: <fec28e66-4b6e-d448-9245-77583608dcf6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5852dd8e-1c9b-ce68-8c0f-a4d265242566@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 01/12] s390-ccw: refactor
 boot map table code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/06/2018 12:52 AM, Thomas Huth wrote:
> On 05.02.2018 21:57, Collin L. Walling wrote:
>> - replace ScsiMbr in ECKD code with BootMapTable
>> - fix read_block messages to reflect BMT
>> - reduce ipl_scsi code with BMT struct
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
> [...]
>> @@ -449,10 +451,8 @@ static void zipl_run(ScsiBlockPtr *pte)
>>   static void ipl_scsi(void)
>>   {
>>       ScsiMbr *mbr =3D (void *)sec;
>> -    uint8_t *ns, *ns_end;
>>       int program_table_entries =3D 0;
>> -    const int pte_len =3D sizeof(ScsiBlockPtr);
>> -    ScsiBlockPtr *prog_table_entry =3D NULL;
>> +    BootMapTable *bmt =3D (void *)sec;
>>       unsigned int loadparm =3D get_loadparm_index();
>>  =20
>>       /* Grab the MBR */
>> @@ -467,34 +467,23 @@ static void ipl_scsi(void)
>>       debug_print_int("MBR Version", mbr->version_id);
>>       IPL_check(mbr->version_id =3D=3D 1,
>>                 "Unknown MBR layout version, assuming version 1");
>> -    debug_print_int("program table", mbr->blockptr[0].blockno);
>> -    IPL_assert(mbr->blockptr[0].blockno, "No Program Table");
>> +    debug_print_int("program table", mbr->bmt.blockno);
>> +    IPL_assert(mbr->bmt.blockno, "No Program Table");
>>  =20
>>       /* Parse the program table */
>> -    read_block(mbr->blockptr[0].blockno, sec,
>> -               "Error reading Program Table");
>> +    read_block(mbr->bmt.blockno, sec, "Error reading Program Table");
>>  =20
>>       IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
>>  =20
>>       debug_print_int("loadparm index", loadparm);
>> -    ns_end =3D sec + virtio_get_block_size();
>> -    for (ns =3D (sec + pte_len); (ns + pte_len) < ns_end; ns +=3D pte=
_len) {
>> -        prog_table_entry =3D (ScsiBlockPtr *)ns;
>> -        if (!prog_table_entry->blockno) {
>> -            break;
>> -        }
>>  =20
>> +    while (bmt->bte[program_table_entries].scsi.blockno) {
>>           program_table_entries++;
> I think it might make sense to somehow limit this loop like it was done
> for the original for-loop, so that in case the sector only contains
> non-zero garbage you do not loop here forever.

It should be easy enough to implement a loop condition like it was before
without getting too messy.

I'll also dig into the docs (or more likely through the zipl code) and se=
e
if there exists a limit on the number of program entires for SCSI.


>
>> -        if (program_table_entries =3D=3D loadparm + 1) {
>> -            break; /* selected entry found */
>> -        }
>>       }
>>  =20
>>       debug_print_int("program table entries", program_table_entries);
>>  =20
>> -    IPL_assert(program_table_entries !=3D 0, "Empty Program Table");
> Don't want to keep the IPL_assert now that you've kept the
> program_table_entries variable?


True.=C2=A0 I'll re-add the assertion.


>
>> -    zipl_run(prog_table_entry); /* no return */
>> +    zipl_run(&bmt->bte[loadparm].scsi); /* no return */
>>   }
>   Thomas
>


--=20
- Collin L Walling
