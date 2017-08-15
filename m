Received: from eggs.gnu.org ([2001:4830:134:3::10]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhRyS-0001Jr-RF
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhRyP-0001OD-Pd
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:52:56 -0400
Received: from m97139.mail.qiye.163.com ([220.181.97.139]:37164)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhRyO-0001NM-SX
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:52:53 -0400
References: <20170814084838.12233-1-wei.yang@ucloud.cn>
	<20170814185545-mutt-send-email-mst@kernel.org>
From: wyang <wei.yang@ucloud.cn>
Message-ID: <59925A94.4070502@ucloud.cn>
Date: Tue, 15 Aug 2017 10:21:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170814185545-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about
 block name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On 2017年08月14日 23:58, Michael S. Tsirkin wrote:
> On Mon, Aug 14, 2017 at 04:48:38PM +0800, wei.yang@ucloud.cn wrote:
>> From: Wei Yang <wei.yang@ucloud.cn>
>>
>> The assert would be touched when the version of acpica is greater than or
>> equal to 20160318. its reason is that "Disasembler: Update a couple
>> output items(commit id: 1ecbb3d)" is introduced by Robert, the patch
>> emits the AML filename as a zero-length string, and allows the compiler
>> to create the name later.
> So how does the output look then? Do you mean there's no comma then?

sorry for confusion, more clearly,  since the AML filename is a 
zero-length string, so the output of dsl file looks like this after
executing iasl command to disassemble AML file to DSL file


DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)

the block name is NULL string.

If the version of iasl command is less than 20160318, the output looks like

DefinitionBlock ("/tmp/xxxx.aml", "DSDT", 1, "BOCHS ", "BXPCDSDT", 
0x00000001)

>
>
>> Signed-off-by: Yang, Wei <wei.yang@ucloud.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: qemu-devel@nongnu.org
>> ---
>>   tests/bios-tables-test.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>> index 88dbf97853..d2ab073848 100644
>> --- a/tests/bios-tables-test.c
>> +++ b/tests/bios-tables-test.c
>> @@ -350,7 +350,6 @@ static GString *normalize_asl(gchar *asl_code)
>>       /* strip def block name (it has file path in it) */
>>       if (g_str_has_prefix(asl->str, DEF_BLOCK)) {
>>           block_name = g_strstr_len(asl->str, asl->len, BLOCK_NAME_END);
>> -        g_assert(block_name);
>>           asl = g_string_erase(asl, 0,
>>                                block_name + sizeof(BLOCK_NAME_END) - asl->str);
> The pointer math here won't do the right thing then, will it?

Yes, I will fix it.

Thanks
Wei
>
>>       }
>> -- 
>> 2.11.0
>>

-- 
Wei Yang(杨伟)
Mobile: +86-13436682065
Email: wei.yang@ucloud.cn
