Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNnS-0003Fn-Vj
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKNnP-00009C-SF
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:15 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38788
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKNnP-00008t-KL
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:46:11 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612132034.1d15ab04@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bb84bdf5-6d09-60be-5954-dd6cde59264f@ilande.co.uk>
Date: Mon, 12 Jun 2017 12:45:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170612132034.1d15ab04@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] fw_cfg: move initialisation of
 FWCfgState into instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 12/06/17 12:20, Igor Mammedov wrote:

> On Sat, 10 Jun 2017 13:30:16 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 316fca9..144e0c6 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1017,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
>>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>>  }
>>  
>> +static void fw_cfg_init(Object *obj)
>> +{
>> +    FWCfgState *s = FW_CFG(obj);
>> +
>> +    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>> +    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>> +    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
> it doesn't seem right,
> 
> consider,
>  object_new(fwcfg)
>    1: fw_cfg_init -> g_new0(FWCfgEntry, fw_cfg_max_entry(s) -> FW_CFG_FILE_SLOTS_DFLT);
>    2: set property x-file-slots
>    3: realize -> fw_cfg_file_slots_allocate()
> 
>> @@ -1052,10 +1062,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>>                     file_slots_max);
>>          return;
>>      }
>> -
>> -    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>> -    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>> -    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
> opps, s->entries doesn't account for new values of x-file-slots
> 
> So question is why this patch is needed at all (it needs some reasoning in commit message)?
> 
> So for now NACK and I'd suggest to drop this patch.

Right I missed the x-file-slots property when I was looking at this,
mainly because all of the existing callers went through
fw_cfg_init_mem() and fw_cfg_init_io(). I do see now though that the
property is referenced in compat.h.

The reason for moving the initialisation is that if you apply patch 2 on
its own then you get hit by the following assert on qemu-system-sparc64
due to uninitialised data:

Program received signal SIGSEGV, Segmentation fault.
0x000000000062f81d in fw_cfg_add_bytes_read_callback (s=0x1e85410,
key=0, callback=0, callback_opaque=0x0, data=0x9f6c28, len=4,
read_only=true) at hw/nvram/fw_cfg.c:633
633         assert(s->entries[arch][key].data == NULL); /* avoid key
conflict */
(gdb) bt
#0  0x000000000062f81d in fw_cfg_add_bytes_read_callback (s=0x1e85410,
key=0, callback=0, callback_opaque=0x0, data=0x9f6c28, len=4,
read_only=true) at hw/nvram/fw_cfg.c:633
#1  0x000000000062fac8 in fw_cfg_add_bytes (s=0x1e85410, key=0,
data=0x9f6c28, len=4) at hw/nvram/fw_cfg.c:664
#2  0x00000000006307a8 in fw_cfg_init1 (dev=0x1e85410) at
hw/nvram/fw_cfg.c:922
#3  0x00000000006308fe in fw_cfg_init_io_dma (iobase=1296, dma_iobase=0,
dma_as=0x0) at hw/nvram/fw_cfg.c:948
#4  0x00000000006309bc in fw_cfg_init_io (iobase=1296) at
hw/nvram/fw_cfg.c:968
#5  0x00000000004f31e9 in sun4uv_init (address_space_mem=0x132df20,
machine=0x132c8c0, hwdef=0x8bf400) at
/home/build/src/qemu/git/qemu/hw/sparc64/sun4u.c:515
#6  0x00000000004f3403 in sun4u_init (machine=0x132c8c0) at
/home/build/src/qemu/git/qemu/hw/sparc64/sun4u.c:565
#7  0x00000000005c0d26 in machine_run_board_init (machine=0x132c8c0) at
hw/core/machine.c:760


#8  0x0000000000532e56 in main (argc=2, argv=0x7fffffffeaa8,
envp=0x7fffffffeac0) at vl.c:4594

Based upon this what do you think the best solution would be?


ATB,

Mark.
