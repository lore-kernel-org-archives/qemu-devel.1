Received: from eggs.gnu.org ([209.51.188.92]:46085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guNhl-0000YO-Oe
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guNhk-0001pJ-JY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:33:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1guNhi-0001gA-LJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:33:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id t200so7440562wmt.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 12:33:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20190214180216.246707-1-sgarzare@redhat.com>
	<20190214140613-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43cdfd65-9ef4-df75-7932-3360813025f1@redhat.com>
Date: Thu, 14 Feb 2019 21:33:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190214140613-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: run the multiboot loader
 before the PVH loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Liam Merwick <liam.merwick@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, George Kennedy <George.Kennedy@oracle.com>

On 14/02/19 20:09, Michael S. Tsirkin wrote:
> On Thu, Feb 14, 2019 at 07:02:16PM +0100, Stefano Garzarella wrote:
>> Some multiboot images could be in the ELF format. In the current
>> implementation QEMU fails because we try to load these images
>> as a PVH image.
>>
>> In order to fix this issue, we should try multiboot first (we
>> already check the multiboot magic header before to load it).
>> If it is not a multiboot image, we can try the PVH loader.
>>
>> Fixes: ab969087da6 ("pvh: Boot uncompressed kernel using direct boot ABI", 2019-01-15)
>> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Paolo can you pls merge since you did the pvh things?

Yes, queued.

Paolo

>> ---
>>  hw/i386/pc.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3889eccdc3..207c267093 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1209,6 +1209,17 @@ static void load_linux(PCMachineState *pcms,
>>      if (ldl_p(header+0x202) == 0x53726448) {
>>          protocol = lduw_p(header+0x206);
>>      } else {
>> +        /*
>> +         * This could be a multiboot kernel. If it is, let's stop treating it
>> +         * like a Linux kernel.
>> +         * Note: some multiboot images could be in the ELF format (the same of
>> +         * PVH), so we try multiboot first since we check the multiboot magic
>> +         * header before to load it.
>> +         */
>> +        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
>> +                           kernel_cmdline, kernel_size, header)) {
>> +            return;
>> +        }
>>          /*
>>           * Check if the file is an uncompressed kernel file (ELF) and load it,
>>           * saving the PVH entry point used by the x86/HVM direct boot ABI.
>> @@ -1262,12 +1273,6 @@ static void load_linux(PCMachineState *pcms,
>>  
>>              return;
>>          }
>> -        /* This looks like a multiboot kernel. If it is, let's stop
>> -           treating it like a Linux kernel. */
>> -        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
>> -                           kernel_cmdline, kernel_size, header)) {
>> -            return;
>> -        }
>>          protocol = 0;
>>      }
>>  
>> -- 
>> 2.20.1
