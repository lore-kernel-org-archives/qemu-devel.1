Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZVLB-0005GN-W8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZVL7-0004kI-E1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:28:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZVL7-0004ig-5i
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39E82356F2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 06:28:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1545143539-26253-1-git-send-email-thuth@redhat.com>
	<87woo6d8qn.fsf@dusky.pond.sub.org>
	<056308f4-a0eb-37b8-a9c7-67ce6a0e6cc6@redhat.com>
Date: Wed, 19 Dec 2018 07:28:09 +0100
In-Reply-To: <056308f4-a0eb-37b8-a9c7-67ce6a0e6cc6@redhat.com> (Thomas Huth's
	message of "Wed, 19 Dec 2018 05:57:24 +0100")
Message-ID: <87pnty6neu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [QEMU PATCH] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 2018-12-18 18:50, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
>>> should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
>>> ivshmem-doorbell instead). Time to remove the deprecated device now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  docs/specs/ivshmem-spec.txt |   8 +-
>>>  hw/i386/pc_piix.c           |   4 -
>>>  hw/misc/ivshmem.c           | 206 +-------------------------------------------
>>>  qemu-deprecated.texi        |   5 --
>>>  scripts/device-crash-test   |   1 -
>>>  tests/ivshmem-test.c        |  65 +++++---------
>>>  6 files changed, 29 insertions(+), 260 deletions(-)
>>>
>>> diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.txt
>>> index a1f5499..042f7ea 100644
>>> --- a/docs/specs/ivshmem-spec.txt
>>> +++ b/docs/specs/ivshmem-spec.txt
>>> @@ -17,12 +17,16 @@ get interrupted by its peers.
>>>  
>>>  There are two basic configurations:
>>>  
>>> -- Just shared memory: -device ivshmem-plain,memdev=HMB,...
>>> +- Just shared memory:
>>> +
>>> +      -device ivshmem-plain,memdev=HMB,...
>>>  
>>>    This uses host memory backend HMB.  It should have option "share"
>>>    set.
>>>  
>>> -- Shared memory plus interrupts: -device ivshmem,chardev=CHR,vectors=N,...
>>> +- Shared memory plus interrupts:
>>> +
>>> +      -device ivshmem-doorbell,chardev=CHR,vectors=N,...
>>>  
>>>    An ivshmem server must already be running on the host.  The device
>>>    connects to the server's UNIX domain socket via character device
>> 
>> Just whitespace.  Intentional?
>
> It's not just whitespace, I had to change "-device ivshmem" into
> "-device ivshmem-doorbell" here, and that did not fit into one line anymore.

Oww, that should've been done in commit 5400c02b90b.  Turns out I'm not
only blind to mistakes in my own texts, I'm also blind to the fixes.
Suggest to add to the commit message:

    Belatedly update a mention of the deprecated "ivshmem" in
    docs/specs/ivshmem-spec.txt to "ivshmem-doorbell".  Missed in commit
    5400c02b90b.

>>> @@ -882,8 +864,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>>>      IVShmemState *s = IVSHMEM_COMMON(dev);
>>>      Error *err = NULL;
>>>      uint8_t *pci_conf;
>>> -    uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
>>> -        PCI_BASE_ADDRESS_MEM_PREFETCH;
>>> +    const uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
>>> +        PCI_BASE_ADDRESS_MEM_PREFETCH | PCI_BASE_ADDRESS_MEM_TYPE_64;
>>>      Error *local_err = NULL;
>>>  
>>>      /* IRQFD requires MSI */
>> 
>> Sure this belongs to this patch?
>
> Yes. I had to remove the "if (s->not_legacy_32bit)" below, so I moved
> the PCI_BASE_ADDRESS_MEM_TYPE_64 to the other bits above. I could also
> leave it below, but I think that would look a little bit lonely there
> without the if-statement.

I missed that part over the addition of const; I should've read more
closely.

I don't care for const here, but I don't really mind it either.  But
let's eliminate the variable instead.  It's used just once, and there's
considerable distance.

>>> @@ -903,10 +885,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>>>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>>                       &s->ivshmem_mmio);
>>>  
>>> -    if (s->not_legacy_32bit) {
>>> -        attr |= PCI_BASE_ADDRESS_MEM_TYPE_64;
>>> -    }
>>> -
>>>      if (s->hostmem != NULL) {
>>>          IVSHMEM_DPRINTF("using hostmem\n");
>>>  
> [...]
>>> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
>>> index c37b196..9811d66 100644
>>> --- a/tests/ivshmem-test.c
>>> +++ b/tests/ivshmem-test.c
>>> @@ -305,20 +305,18 @@ static void *server_thread(void *data)
>>>      return NULL;
>>>  }
>>>  
>>> -static void setup_vm_with_server(IVState *s, int nvectors, bool msi)
>>> +static void setup_vm_with_server(IVState *s, int nvectors)
>>>  {
>>> -    char *cmd = g_strdup_printf("-chardev socket,id=chr0,path=%s,nowait "
>>> -                                "-device ivshmem%s,chardev=chr0,vectors=%d",
>>> -                                tmpserver,
>>> -                                msi ? "-doorbell" : ",size=1M,msi=off",
>>> -                                nvectors);
>>> +    char *cmd = g_strdup_printf("-chardev socket,id=chr0,path=%s,nowait -device"
>> 
>> Awkward line break.
>> 
>>> +                                " ivshmem-doorbell,chardev=chr0,vectors=%d",
>>> +                                tmpserver, nvectors);
>> 
>> Suggest
>> 
>>        char *cmd = g_strdup_printf("-chardev socket,id=chr0,path=%s,nowait "
>>                        "-device ivshmem-doorbell,chardev=chr0,vectors=%d",
>>                        tmpserver, nvectors);
>
> Ok, I can do that in v2.
>
>  Thomas

Thanks!
