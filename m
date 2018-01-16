Received: from eggs.gnu.org ([2001:4830:134:3::10]:44773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebT8H-0002LC-Ld
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebT8B-00023f-Re
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:26:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44726
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ebT8B-00023K-LI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:26:31 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFOseV065906
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:26:29 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fhh59hntb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:26:28 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:21:28 -0700
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-3-git-send-email-walling@linux.vnet.ibm.com>
	<4d5caff2-335e-d936-5540-00ae755d55a9@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:21:24 -0500
MIME-Version: 1.0
In-Reply-To: <4d5caff2-335e-d936-5540-00ae755d55a9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <41ef6471-8a81-ffe3-c080-75db07d9edf0@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 2/8] s390-ccw: ipl structs
 for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 01/16/2018 07:32 AM, Thomas Huth wrote:
> On 15.01.2018 17:44, Collin L. Walling wrote:
>> ECKD DASDs have different IPL structures for CDL and LDL
>> formats. The current Ipl1 and Ipl2 structs follow the CDL
>> format, so we prepend "EckdCdl" to them. Boot info for LDL
>> has been moved to a new struct: EckdLdlIpl1.
>>
>> Also introduce structs for IPL stages 1 and 1b and for
>> disk geometry.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 29 +++++++++++++-----------
>>   pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++---=
----------
>>   2 files changed, 56 insertions(+), 28 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 6f8e30f..29915e4 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -221,9 +221,9 @@ static void run_eckd_boot_script(block_number_t mb=
r_block_nr)
>>   static void ipl_eckd_cdl(void)
>>   {
>>       XEckdMbr *mbr;
>> -    Ipl2 *ipl2 =3D (void *)sec;
>> +    EckdCdlIpl2 *ipl2 =3D (void *)sec;
>>       IplVolumeLabel *vlbl =3D (void *)sec;
>> -    block_number_t block_nr;
>> +    block_number_t mbr_block_nr;
>>  =20
>>       /* we have just read the block #0 and recognized it as "IPL1" */
>>       sclp_print("CDL\n");
>> @@ -231,16 +231,13 @@ static void ipl_eckd_cdl(void)
>>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>>       read_block(1, ipl2, "Cannot read IPL2 record at block 1");
>>  =20
>> -    mbr =3D &ipl2->u.x.mbr;
>> +    mbr =3D &ipl2->mbr;
>>       IPL_assert(magic_match(mbr, ZIPL_MAGIC), "No zIPL section in IPL=
2 record.");
>>       IPL_assert(block_size_ok(mbr->blockptr.xeckd.bptr.size),
>>                  "Bad block size in zIPL section of IPL2 record.");
>>       IPL_assert(mbr->dev_type =3D=3D DEV_TYPE_ECKD,
>>                  "Non-ECKD device type in zIPL section of IPL2 record.=
");
>>  =20
>> -    /* save pointer to Boot Script */
>> -    block_nr =3D eckd_block_num((void *)&(mbr->blockptr));
>> -
>>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>>       read_block(2, vlbl, "Cannot read Volume Label at block 2");
> Why did you move the block_nr =3D eckd_block_num(...) behind the
> read_block() ? That sounds like you could different values here now. If
> that has been done on purpose and is not a mistake, please add a proper
> sentence about this to the patch description.


Yes you are definitely correct... a guest running cdl formatted dasd shou=
ld
fail to IPL with this.=C2=A0 I must've made this error somewhere along th=
e way
when cleaning up the commits.=C2=A0 Thank you for catching this.


>
>>       IPL_assert(magic_match(vlbl->key, VOL1_MAGIC),
>> @@ -249,7 +246,10 @@ static void ipl_eckd_cdl(void)
>>                  "Invalid magic of volser block");
>>       print_volser(vlbl->f.volser);
>>  =20
>> -    run_eckd_boot_script(block_nr);
>> +    /* save pointer to Boot Script */
>> +    mbr_block_nr =3D eckd_block_num((void *)&mbr->blockptr);
>> +
>> +    run_eckd_boot_script(mbr_block_nr);
>>       /* no return */
>>   }
>>  =20
>> @@ -280,8 +280,8 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mod=
e)
>>  =20
>>   static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>>   {
>> -    block_number_t block_nr;
>> -    BootInfo *bip =3D (void *)(sec + 0x70); /* BootInfo is MBR for LD=
L */
>> +    block_number_t mbr_block_nr;
>> +    EckdLdlIpl1 *ipl1 =3D (void *)sec;
>>  =20
>>       if (mode !=3D ECKD_LDL_UNLABELED) {
>>           print_eckd_ldl_msg(mode);
>> @@ -292,15 +292,18 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
>>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>>       read_block(0, sec, "Cannot read block 0 to grab boot info.");
>>       if (mode =3D=3D ECKD_LDL_UNLABELED) {
>> -        if (!magic_match(bip->magic, ZIPL_MAGIC)) {
>> +        if (!magic_match(ipl1->boot_info.magic, ZIPL_MAGIC)) {
>>               return; /* not applicable layout */
>>           }
>>           sclp_print("unlabeled LDL.\n");
>>       }
>> -    verify_boot_info(bip);
>> +    verify_boot_info(&ipl1->boot_info);
>> +
>> +    /* save pointer to Boot Script */
>> +    mbr_block_nr =3D
>> +        eckd_block_num((void *)&ipl1->boot_info.bp.ipl.bm_ptr.eckd.bp=
tr);
> Well, the original code fitted nicely in one line ... thus maybe better
> keep the original variable name? (or use mbr_blk_nr or something simila=
r
> shorter?)


Maybe a voidptr to ipl1->boot_info... and pass that to eckd_block_num?
(or something along those lines?)

or

EckdBlockPtr bptr =3D ipl1->....bptr

I'll play with the options.


>
>> -    block_nr =3D eckd_block_num((void *)&(bip->bp.ipl.bm_ptr.eckd.bpt=
r));
>> -    run_eckd_boot_script(block_nr);
>> +    run_eckd_boot_script(mbr_block_nr);
>>       /* no return */
>>   }
>   Thomas
>


--=20
- Collin L Walling
