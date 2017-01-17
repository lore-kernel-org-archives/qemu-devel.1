Received: from eggs.gnu.org ([2001:4830:134:3::10]:53130)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cTRzf-0002tV-9S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cTRzb-0006tk-CX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:32:03 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:42514 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cTRzb-0006t7-46
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:31:59 -0500
References: <1484579832-18589-1-git-send-email-pl@kamp.de>
	<20170117112848.GB6199@lemon>
From: Peter Lieven <pl@kamp.de>
Message-ID: <06840643-1e3d-b60b-95c1-6e28c441aa1e@kamp.de>
Date: Tue, 17 Jan 2017 12:31:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170117112848.GB6199@lemon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] block/iscsi: avoid data
 corruption with cache=writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

Am 17.01.2017 um 12:28 schrieb Fam Zheng:
> On Mon, 01/16 16:17, Peter Lieven wrote:
>> nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
>> request starts and ends within the same cluster. This results
>> in passing -1 to bitmap_set and bitmap_clear and they don't
>> handle negative values properly. In the end this leads to data
>> corruption.
>>
>> Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   block/iscsi.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 6aeeb9e..1860f1b 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -499,14 +499,18 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
>>       if (allocated) {
>>           bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
>>       } else {
>> -        bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
>> +        if (nb_cls_shrunk > 0) {
>> +            bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
>> +        }
>>       }
>>   
>>       if (iscsilun->allocmap_valid == NULL) {
>>           return;
>>       }
>>       if (valid) {
>> -        bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
>> +        if (nb_cls_shrunk > 0) {
>> +            bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
>> +        }
>>       } else {
>>           bitmap_clear(iscsilun->allocmap_valid, cl_num_expanded,
>>                        nb_cls_expanded);
>> -- 
>> 1.9.1
>>
>>
> It's probably a good idea to add assertions parameter in bitmap_*.

yes, i will send a follow-up patch.

Peter
