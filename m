Received: from eggs.gnu.org ([2001:4830:134:3::10]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHx8-0000ZD-Mz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHx3-0003Qa-G7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elHx3-0003QD-Bl
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:37 -0500
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
	<98934c2f-2210-83d7-d629-157e5a7cee8e@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4cafa8f-efac-00e1-683a-304a91c695ca@redhat.com>
Date: Mon, 12 Feb 2018 11:31:35 -0600
MIME-Version: 1.0
In-Reply-To: <98934c2f-2210-83d7-d629-157e5a7cee8e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>

On 02/12/2018 08:46 AM, Murilo Opsfelder Araujo wrote:
> On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
>> From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
>>
>> fd_write_vmcore can fail to execute for a lot of reasons that can be
>> retrieved by errno, but it only returns -1. This makes difficult for
>> the caller to know what happened and only a generic error message is
>> propagated back to the user. This is an example using dump-guest-memory:
>>

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
> 
> Do we need -ret passed to error_setg_errno()? fd_write_vmcore() returns
> negative errno in case of error.

Yes, this usage is correct.  error_setg_errno() takes a positive errno 
value (using strerror, which only decodes positive values into useful 
strings); but we typically return negative errno values (as was 
correctly done in fd_write_vmcore), so the extra layer of negation here 
is needed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
