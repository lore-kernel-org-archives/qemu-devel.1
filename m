Received: from eggs.gnu.org ([2001:4830:134:3::10]:51903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbPsz-00033F-Rw
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbPsv-0003UG-DF
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbPsv-0003Tx-5I
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:54:01 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<e531606c10f3c40dbc10d0fa4a4a5d806d7946d9.1486285434.git.ben@skyportsystems.com>
	<20170207145151.42fb0cc6@nial.brq.redhat.com>
	<b0dac808-e617-616e-6a1b-11c242b9250a@redhat.com>
	<20170208114347.2bc8ae2b@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9a6c7225-0b57-fdc6-4a43-49068b175842@redhat.com>
Date: Wed, 8 Feb 2017 11:53:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170208114347.2bc8ae2b@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/10] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, mst@redhat.com

On 02/08/17 11:43, Igor Mammedov wrote:
> On Tue, 7 Feb 2017 21:09:27 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 02/07/17 14:51, Igor Mammedov wrote:
>>> On Sun,  5 Feb 2017 01:11:56 -0800
>>> ben@skyportsystems.com wrote:
>>>   
>>>> From: Ben Warren <ben@skyportsystems.com>
>>>>
>>>> This is initially used to patch a 64-bit address into
>>>> the VM Generation ID SSDT
>>>>
>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>>> ---  
>>> ...  
>>>> +int
>>>> +build_append_named_qword(GArray *array, const char *name_format, ...)  
>>> it ain't used anywhere, I'd just drop this patch.  
>>
>> Ben and I discussed this under
>> - msgid <6E25852D-224A-4BDC-AA83-8DC87DB4D0F0@skyportsystems.com>
>>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg425496.html
>> - msgid <a93a6be3-cbed-5afe-7c72-96410fbfce41@redhat.com>
>>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg425519.html
>>
>> On 01/26/17 06:35, Ben Warren wrote:
>>> I propose to still include this patch but touch up the comments as
>>> requested by Laszlo.  This way it will be in the toolbox for future
>>> users and has been tested.  [...]  
>>
>> I generally agree that dead code is undesirable, but this function has
>> surfaced several times until now, and we get to review it every single
>> time. Ben tested it, I support its inclusion.
>>
>> OTOH I also pointed it out to Ben
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg425218.html
>>
>> that he should expect disagreement between his reviewers :) Given that
>> I'm observing this series more from the sidelines and you maintain /
>> support ACPI gen in QEMU, I certainly defer to you on this.
> It's not only dead, having patchable QWORD ready for use in QEMU
> would tempt someone to use it and that would lead to XP BSOD
> if it slips screening at review time.

Good point.

> I'd delay this patch until
> we announce that ACPI 1.0 (XP based) guest no more supported by
> new QEMU.
> 
> Anyway I won't object to merging this if you insist and give it your RB.

No, you are entirely right. As long as we consider Windows XP guests
first class citizens (i.e., we even reject the idea of additional
command line options), then keeping QWORD "out of sight" is safer.

Follow up question: when are we going to drop Windows XP? Do we have a
plan? :) It's quite a struggle to support both ends of the spectrum with
the same machine types and options (decades-old DOS and Windows XP vs.
supercomputer-class NUMA setups). I think this limits development.

(Just curious; I'm not suggesting to drop Windows XP "soon".)

Thanks!
Laszlo


>>
>>
>>>> +{
>>>> +    int offset;
>>>> +    va_list ap;
>>>> +
>>>> +    build_append_byte(array, 0x08); /* NameOp */
>>>> +    va_start(ap, name_format);
>>>> +    build_append_namestringv(array, name_format, ap);
>>>> +    va_end(ap);
>>>> +
>>>> +    build_append_byte(array, 0x0E); /* QWordPrefix */
>>>> +
>>>> +    offset = array->len;
>>>> +    build_append_int_noprefix(array, 0x0000000000000000, 8);
>>>> +    assert(array->len == offset + 8);
>>>> +
>>>> +    return offset;
>>>> +}
>>>> +
>>>>  static GPtrArray *alloc_list;
>>>>  
>>>>  static Aml *aml_alloc(void)
>>>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>>>> index 559326c..dbf63cf 100644
>>>> --- a/include/hw/acpi/aml-build.h
>>>> +++ b/include/hw/acpi/aml-build.h
>>>> @@ -385,6 +385,10 @@ int
>>>>  build_append_named_dword(GArray *array, const char *name_format, ...)
>>>>  GCC_FMT_ATTR(2, 3);
>>>>  
>>>> +int
>>>> +build_append_named_qword(GArray *array, const char *name_format, ...)
>>>> +GCC_FMT_ATTR(2, 3);
>>>> +
>>>>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>>>>                         uint64_t len, int node, MemoryAffinityFlags flags);
>>>>    
>>>
>>>   
>>
> 
