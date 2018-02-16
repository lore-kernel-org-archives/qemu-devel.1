Received: from eggs.gnu.org ([2001:4830:134:3::10]:40314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emiLF-0008Dp-Ll
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emiLC-0007BR-Ix
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:54:29 -0500
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-2-git-send-email-walling@linux.vnet.ibm.com>
	<75373e6d-ceb5-f1e5-a535-34871837ca51@redhat.com>
	<5d80de97-f6c2-f984-214d-89ff745b7c4c@linux.vnet.ibm.com>
	<f1db2635-91e9-3ef1-58f0-3c74b8c93a27@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <89871b6c-62a0-f5e7-1f13-db9f245e28db@redhat.com>
Date: Fri, 16 Feb 2018 16:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <f1db2635-91e9-3ef1-58f0-3c74b8c93a27@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 16.02.2018 15:57, Collin L. Walling wrote:
> On 02/16/2018 07:19 AM, Viktor Mihajlovski wrote:
>> On 16.02.2018 11:42, Thomas Huth wrote:
>>> On 15.02.2018 23:54, Collin L. Walling wrote:
>>>> Some ECKD bootmap code was using structs designed for SCSI.
>>>> Even though this works, it confuses readability. Add a new
>>>> BootMapTable struct to assist with readability in bootmap
>>>> entry code. Also:
>>>>
>>>> - replace ScsiMbr in ECKD code with appropriate structs
>>>> - fix read_block messages to reflect BootMapTable
>>>> - fixup ipl_scsi to use BootMapTable (referred to as Program Table)
>>>> - defined value for maximum table entries
>>>>
>>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>>> ---
>>>> =C2=A0 pc-bios/s390-ccw/bootmap.c | 60
>>>> +++++++++++++++++++++-------------------------
>>>> =C2=A0 pc-bios/s390-ccw/bootmap.h | 14 +++++++++--
>>>> =C2=A0 2 files changed, 39 insertions(+), 35 deletions(-)
>>> [...]
>>>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>>>> index cf99a4c..850b655 100644
>>>> --- a/pc-bios/s390-ccw/bootmap.h
>>>> +++ b/pc-bios/s390-ccw/bootmap.h
>>>> @@ -53,6 +53,15 @@ typedef union BootMapPointer {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtEckdBlockPtr xeckd;
>>>> =C2=A0 } __attribute__ ((packed)) BootMapPointer;
>>>> =C2=A0 +#define MAX_TABLE_ENTRIES=C2=A0 30
>>>> +
>>>> +/* aka Program Table */
>>>> +typedef struct BootMapTable {
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t magic[4];
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t reserved[12];
>>>> +=C2=A0=C2=A0=C2=A0 BootMapPointer entry[];
>>>> +} __attribute__ ((packed)) BootMapTable;
>>>> +
>>>> =C2=A0 typedef struct ComponentEntry {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ScsiBlockPtr data;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t pad[7];
>>>> @@ -69,8 +78,9 @@ typedef struct ComponentHeader {
>>>> =C2=A0 typedef struct ScsiMbr {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t magic[4];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t version_id;
>>>> -=C2=A0=C2=A0=C2=A0 uint8_t reserved[8];
>>>> -=C2=A0=C2=A0=C2=A0 ScsiBlockPtr blockptr[];
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t reserved1[8];
>>>> +=C2=A0=C2=A0=C2=A0 ScsiBlockPtr pt;=C2=A0=C2=A0 /* block pointer to=
 program table */
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t reserved2[120];
>>> Did you want to pad the struct to 512 bytes here? If so, I think that
>>> should have been "uint32_t" instead of "uint8_t" or "480" instead of
>>> "120" ?
>>>
>> Should probably be uint8_t[480] then to stay in style with other
>> reserved field definitions.
>=20
> The idea was to mimic the Scsi MBR struct defined in zipl.=C2=A0 It has
> reserved space for what would appear to be for 5 more ScsiBlockPtrs
> (which are not used in zipl) and a boot_info struct (which we don't nee=
d
> in QEMU).
>=20
> Alternatively, I can just omit the reserved2 field. I placed it there
> for "completeness" but it is not at all necessary.

I'd say just drop it. It looks rather confusing than helpful to me.

 Thomas
