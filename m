Received: from eggs.gnu.org ([209.51.188.92]:39918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJzkN-0001fb-87
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJzkM-0007LA-AD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJzkM-0007Ji-4I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id r6so4175514wrm.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 05:14:28 -0700 (PDT)
References: <20190419075625.24251-1-thuth@redhat.com>
	<c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
	<e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84638796-204e-3f43-3fe1-f5329e9cd466@redhat.com>
Date: Fri, 26 Apr 2019 14:14:25 +0200
MIME-Version: 1.0
In-Reply-To: <e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 4/26/19 7:42 AM, Thomas Huth wrote:
> On 26/04/2019 00.55, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 4/19/19 9:56 AM, Thomas Huth wrote:
>>> First patch fixes a problem with ohci_die(), second patch moves PCI code into
>>> a separate file, so that the sysbus OHCI device can also be used without
>>> the dependency on the PCI code.
>>>
>>> v2: Split the patch into two patches, one for the ohci_die() fix and one
>>>     for the PCI code movement.
>>
>> Way cleaner. I wonder why you don't use a typedef for the void
>> (*ohci_die_fn)(struct OHCIState *) prototype.
> 
> It does not work in that case:
> 
> typedef struct OHCIState {            // <-- struct OHCIState definition
>     [...]
>     uint32_t async_td;
>     bool async_complete;
> 
>     void (*ohci_die)(struct OHCIState *ohci); // <-- ohci_die definition
> } OHCIState;                         // <-- typedef OHCIState definition
> 
> The typedef is defined after the ohci_die entry.

I was thinking of forward declaration:

typedef struct OHCIState OHCIState;

typedef void (ohci_die_fn)(OHCIState *ohci);

struct OHCIState {
    [...]
    uint32_t async_td;
    bool async_complete;

    ohci_die_fn *ohci_die;
} OHCIState;

static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
                          uint32_t num_ports,
                          dma_addr_t localmem_base,
                          char *masterbus, uint32_t firstport,
                          AddressSpace *as,
                          ohci_die_fn *ohci_die, Error **errp)
{ ...

> 
>> Anyway to this series:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>  Thanks!
>   Thomas
> 
