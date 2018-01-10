Received: from eggs.gnu.org ([2001:4830:134:3::10]:40429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHrH-0006AM-HH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHrC-0001fz-O6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZHrC-0001f0-H6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:59:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73C4A81DE3
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:59:57 +0000 (UTC)
References: <20180109193745.GA18506@amt.cnet>
	<20180109201616.dsrhwi5xzmrqbgnq@hz-desktop>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3558c89-d0ae-929a-51c7-b27562ac2853@redhat.com>
Date: Wed, 10 Jan 2018 15:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180109201616.dsrhwi5xzmrqbgnq@hz-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 09/01/2018 21:16, Haozhong Zhang wrote:
> On 01/09/18 17:37 -0200, Marcelo Tosatti wrote:
>>
>> Improve hugepage allocation failure message, indicating
>> whats happening to the user.
>>
>> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>>
>> diff --git a/exec.c b/exec.c
>> index 4722e521d4..439abedb98 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1643,7 +1643,8 @@ static void *file_ram_alloc(RAMBlock *block,
>>                           block->flags & RAM_SHARED);
>>      if (area == MAP_FAILED) {
>>          error_setg_errno(errp, errno,
>> -                         "unable to map backing store for guest RAM");
>> +                         "unable to map backing store for guest RAM, "
>> +                         "falling back to malloc based RAM allocation");
>>          return NULL;
>>      }
>>  
> 
> The backing store here is not always hugetlbfs, e.g., it can be NVDIMM
> and even regular files. In those cases, the failure of file_ram_alloc()
> does not fall back to malloc.

It's also not happending if !mem_prealloc.  Let's instead add an
error_report in allocate_system_memory_nonnuma (and it's probably better
to use MAP_ANON instead of malloc in the message).

Paolo
