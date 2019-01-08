Received: from eggs.gnu.org ([209.51.188.92]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsfh-0003kY-Lw
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1ggsfg-0006Sw-Uo
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1ggsfg-0006Hu-JX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:48:00 -0500
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-3-git-send-email-liam.merwick@oracle.com>
	<20190102131234.GN24009@stefanha-x1.localdomain>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <2a32ba41-0303-77a5-7ed8-8aefa4e800ba@oracle.com>
Date: Tue, 8 Jan 2019 14:47:51 +0000
MIME-Version: 1.0
In-Reply-To: <20190102131234.GN24009@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/4] elf-ops.h: Add get_elf_note_type()
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



On 02/01/2019 13:12, Stefan Hajnoczi wrote:
> On Fri, Dec 21, 2018 at 08:03:50PM +0000, Liam Merwick wrote:
>> +    while (note_type != elf_note_type) {
>> +        nhdr_namesz = nhdr->n_namesz;
>> +        nhdr_descsz = nhdr->n_descsz;
>> +
>> +        elf_note_entry_offset = nhdr_size +
>> +            QEMU_ALIGN_UP(nhdr_namesz, phdr_align) +
>> +            QEMU_ALIGN_UP(nhdr_descsz, phdr_align);
>> +
>> +        /* If the offset calculated in this iteration exceeds the
>> +	 * supplied size, we are done and no matching note was found.
>> +	 */
> 
> Indentation is off here.  QEMU uses 4-space indentation.
> 
>> +        if (elf_note_entry_offset > note_size) {
>> +            return NULL;
>> +        }
>> +
>> +        /* skip to the next ELF Note entry */
>> +        nhdr = (void *)nhdr + elf_note_entry_offset;
>> +        note_type = nhdr->n_type;
>> +    }
>> +
>> +    return nhdr;
>> +}
>> +
>>   static int glue(load_elf, SZ)(const char *name, int fd,
>>                                 uint64_t (*elf_note_fn)(void *, void *, bool),
>>                                 uint64_t (*translate_fn)(void *, uint64_t),
>> @@ -512,6 +555,13 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>>                   }
>>               }
>>   
>> +	    /* Search the ELF notes to find one with a type matching the
>> +	     * value passed in via 'translate_opaque'
>> +	     */
>> +            nhdr = (struct elf_note *)data;
> 
> Ah, I see data gets used here!  It would be clearer to move loading of
> data into this patch.


Moved.

> 
>> +	    assert(translate_opaque != NULL);
>> +            nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
>> +                                               *(uint64_t *)translate_opaque);
> 
> Indentation is off in this hunk.  QEMU uses 4-space indentation.
> 

A few stray tabs had snuck in - I've fixed all those.

Regards,
Liam
