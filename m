Received: from eggs.gnu.org ([2001:4830:134:3::10]:48298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emhS3-0002CG-Dz
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emhS0-0002AS-Eh
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:57:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emhS0-0002A5-5w
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:57:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GEuSBf035949
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:57:23 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5wa1jn1w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:57:22 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 07:57:21 -0700
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-2-git-send-email-walling@linux.vnet.ibm.com>
	<75373e6d-ceb5-f1e5-a535-34871837ca51@redhat.com>
	<5d80de97-f6c2-f984-214d-89ff745b7c4c@linux.vnet.ibm.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 09:57:17 -0500
MIME-Version: 1.0
In-Reply-To: <5d80de97-f6c2-f984-214d-89ff745b7c4c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f1db2635-91e9-3ef1-58f0-3c74b8c93a27@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 01/12] s390-ccw: refactor
 boot map table code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/16/2018 07:19 AM, Viktor Mihajlovski wrote:
> On 16.02.2018 11:42, Thomas Huth wrote:
>> On 15.02.2018 23:54, Collin L. Walling wrote:
>>> Some ECKD bootmap code was using structs designed for SCSI.
>>> Even though this works, it confuses readability. Add a new
>>> BootMapTable struct to assist with readability in bootmap
>>> entry code. Also:
>>>
>>> - replace ScsiMbr in ECKD code with appropriate structs
>>> - fix read_block messages to reflect BootMapTable
>>> - fixup ipl_scsi to use BootMapTable (referred to as Program Table)
>>> - defined value for maximum table entries
>>>
>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> ---
>>>   pc-bios/s390-ccw/bootmap.c | 60 +++++++++++++++++++++--------------=
-----------
>>>   pc-bios/s390-ccw/bootmap.h | 14 +++++++++--
>>>   2 files changed, 39 insertions(+), 35 deletions(-)
>> [...]
>>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>>> index cf99a4c..850b655 100644
>>> --- a/pc-bios/s390-ccw/bootmap.h
>>> +++ b/pc-bios/s390-ccw/bootmap.h
>>> @@ -53,6 +53,15 @@ typedef union BootMapPointer {
>>>       ExtEckdBlockPtr xeckd;
>>>   } __attribute__ ((packed)) BootMapPointer;
>>>  =20
>>> +#define MAX_TABLE_ENTRIES  30
>>> +
>>> +/* aka Program Table */
>>> +typedef struct BootMapTable {
>>> +    uint8_t magic[4];
>>> +    uint8_t reserved[12];
>>> +    BootMapPointer entry[];
>>> +} __attribute__ ((packed)) BootMapTable;
>>> +
>>>   typedef struct ComponentEntry {
>>>       ScsiBlockPtr data;
>>>       uint8_t pad[7];
>>> @@ -69,8 +78,9 @@ typedef struct ComponentHeader {
>>>   typedef struct ScsiMbr {
>>>       uint8_t magic[4];
>>>       uint32_t version_id;
>>> -    uint8_t reserved[8];
>>> -    ScsiBlockPtr blockptr[];
>>> +    uint8_t reserved1[8];
>>> +    ScsiBlockPtr pt;   /* block pointer to program table */
>>> +    uint8_t reserved2[120];
>> Did you want to pad the struct to 512 bytes here? If so, I think that
>> should have been "uint32_t" instead of "uint8_t" or "480" instead of "=
120" ?
>>
> Should probably be uint8_t[480] then to stay in style with other
> reserved field definitions.

The idea was to mimic the Scsi MBR struct defined in zipl.=C2=A0 It has
reserved space for what would appear to be for 5 more ScsiBlockPtrs
(which are not used in zipl) and a boot_info struct (which we don't need
in QEMU).

Alternatively, I can just omit the reserved2 field. I placed it there
for "completeness" but it is not at all necessary.

>>>   } __attribute__ ((packed)) ScsiMbr;
>>>  =20
>>>   #define ZIPL_MAGIC              "zIPL"
>>>
>>   Thomas
>>
>


--=20
- Collin L Walling
