Received: from eggs.gnu.org ([2001:4830:134:3::10]:37342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1elGMQ-0004Z1-B0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1elGMN-0001Rf-He
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:49:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1elGMN-0001Ph-8V
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:49:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CFnPIF128582
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 10:49:37 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3d49aber-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 10:49:36 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 10:49:35 -0500
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
	<98934c2f-2210-83d7-d629-157e5a7cee8e@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 13:49:30 -0200
MIME-Version: 1.0
In-Reply-To: <98934c2f-2210-83d7-d629-157e5a7cee8e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <9bdd6f79-05e2-48ab-385a-70b6a3ac207c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] dump.c: allow fd_write_vmcore to
 return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>



On 02/12/2018 12:46 PM, Murilo Opsfelder Araujo wrote:
> On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
>> From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
>>
>> fd_write_vmcore can fail to execute for a lot of reasons that can be
>> retrieved by errno, but it only returns -1. This makes difficult for
>> the caller to know what happened and only a generic error message is
>> propagated back to the user. This is an example using dump-guest-memory:
>>
>> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
>> dump: failed to save memory
>>
>> All callers of fd_write_vmcore of dump.c does error handling via
>> error_setg(), so at first it seems feasible to add the Error pointer as
>> an argument of fd_write_vmcore. This proved to be more complex than it
>> first looked. fd_write_vmcore is used by write_elf64_notes and
>> write_elf32_notes as a WriteCoreDumpFunction prototype. WriteCoreDumpFunction
>> is declared in include/qom/cpu.h and is used all around the code. This
>> leaves us with few alternatives:
>>
>> - change the WriteCoreDumpFunction prototype to include an error pointer.
>> This would require to change all functions that implements this prototype
>> to also receive an Error pointer;
>>
>> - change both write_elf64_notes and write_elf32_notes to no use the
>> WriteCoreDumpFunction. These functions use not only fd_write_vmcore
>> but also buf_write_note, so this would require to change buf_write_note
>> to handle an Error pointer. Considerable easier than the alternative
>> above, but it's still a lot of code just for the benefit of the callers
>> of fd_write_vmcore.
>>
>> This patch presents an easier solution that benefits all fd_write_vmcore
>> callers:
>>
>> - instead of returning -1 on error, return -errno. All existing callers
>> already checks for ret < 0 so there is no need to change the caller's
>> logic too much. This also allows the retrieval of the errno.
>>
>> - all callers were updated to use error_setg_errno instead of just
>> errno_setg. Now that fd_write_vmcore can return an errno, let's update
>> all callers so they can benefit from a more detailed error message.
>>
>> This is the same dump-guest-memory example with this patch applied:
>>
>> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
>> dump: failed to save memory: No space left on device
>> (qemu)
>>
>> This example illustrates an error of fd_write_vmcore when called
>> from write_data. All other callers will benefit from better
>> error messages as well.
>>
>> Reported-by: yilzhang@redhat.com
>> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
>> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   dump.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/dump.c b/dump.c
>> index 7b13baa413..171ff8a3b8 100644
>> --- a/dump.c
>> +++ b/dump.c
>> @@ -107,7 +107,7 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
>>
>>       written_size = qemu_write_full(s->fd, buf, size);
>>       if (written_size != size) {
>> -        return -1;
>> +        return -errno;
>>       }
>>
>>       return 0;
>> @@ -140,7 +140,7 @@ static void write_elf64_header(DumpState *s, Error **errp)
>>
>>       ret = fd_write_vmcore(&elf_header, sizeof(elf_header), s);
>>       if (ret < 0) {
>> -        error_setg(errp, "dump: failed to write elf header");
>> +        error_setg_errno(errp, -ret, "dump: failed to write elf header");
> Do we need -ret passed to error_setg_errno()? fd_write_vmcore() returns
> negative errno in case of error.

I am passing -ret here to provide a positive errno value to 
error_setg_errno. I
am not sure if os_error can be negative and didn't want to risk 
strerror() breaking.



Daniel


>
> Cheers
> Murilo
