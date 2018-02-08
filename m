Received: from eggs.gnu.org ([2001:4830:134:3::10]:38644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejjb8-0003rd-1X
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejjb4-00020n-7W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:34 -0500
References: <20180207162920.28386-1-pbonzini@redhat.com>
	<w514lmrrdun.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d3ce16f-9831-7960-53a4-24c08295a5f9@redhat.com>
Date: Thu, 8 Feb 2018 11:38:24 +0100
MIME-Version: 1.0
In-Reply-To: <w514lmrrdun.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: early check for
 blockers on drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 08/02/2018 11:10, Alberto Garcia wrote:
> On Wed 07 Feb 2018 05:29:20 PM CET, Paolo Bonzini wrote:
>> Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
>> it is checked a bit late and the result is that the target is
>> created even if drive-mirror subsequently fails.  Add an early
>> check to avoid this.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  blockdev.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 8e977eef11..c7e2e0a00e 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3565,6 +3565,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>>          return;
>>      }
>>  
>> +    /* Early check to avoid creating target */
>> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
>> +        return;
>> +    }
>> +
>>      aio_context = bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
> 
> Do we need to hold the AioContext in order to check for op blockers?

In include/block/block_int.h, they are not in the "Protected by
AioContext lock" section.

Paolo
