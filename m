Received: from eggs.gnu.org ([209.51.188.92]:42158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsff-0003jq-Gd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsfZ-0006CS-Pj
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:47:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1ggsfY-00064z-Rj
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:47:53 -0500
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-2-git-send-email-liam.merwick@oracle.com>
	<20190102130650.GM24009@stefanha-x1.localdomain>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <896d7d97-f79e-25e8-0bae-47bc5725fe35@oracle.com>
Date: Tue, 8 Jan 2019 14:47:43 +0000
MIME-Version: 1.0
In-Reply-To: <20190102130650.GM24009@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 1/4] elf: Add optional function ptr to
 load_elf() to parse ELF notes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com



On 02/01/2019 13:06, Stefan Hajnoczi wrote:
> On Fri, Dec 21, 2018 at 08:03:49PM +0000, Liam Merwick wrote:
>> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>> index 74679ff8da3a..37d20a3800c1 100644
>> --- a/include/hw/elf_ops.h
>> +++ b/include/hw/elf_ops.h
>> @@ -266,6 +266,7 @@ fail:
>>   }
>>   
>>   static int glue(load_elf, SZ)(const char *name, int fd,
>> +                              uint64_t (*elf_note_fn)(void *, void *, bool),
>>                                 uint64_t (*translate_fn)(void *, uint64_t),
>>                                 void *translate_opaque,
>>                                 int must_swab, uint64_t *pentry,
>> @@ -496,8 +497,30 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>>                   high = addr + mem_size;
>>   
>>               data = NULL;
>> +
>> +        } else if (ph->p_type == PT_NOTE && elf_note_fn) {
>> +            struct elf_note *nhdr = NULL;
>> +
>> +            file_size = ph->p_filesz; /* Size of the range of ELF notes */
>> +            data = g_malloc0(file_size);
>> +            if (ph->p_filesz > 0) {
>> +                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
>> +                    goto fail;
>> +                }
>> +                if (read(fd, data, file_size) != file_size) {
>> +                    goto fail;
>> +                }
>> +            }
>> +
>> +            if (nhdr != NULL) {
>> +                bool is64 =
>> +                    sizeof(struct elf_note) == sizeof(struct elf64_note);
>> +                elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);
> 
> How does data get used?

Moved (as suggested in comments for next patch)

> 
>> +            }
>> +            g_free(data);
> 
> Missing data = NULL to prevent double free later?
> 

Added explicit assignment.

Regards,
Liam
