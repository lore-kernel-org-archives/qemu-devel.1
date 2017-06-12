Received: from eggs.gnu.org ([2001:4830:134:3::10]:35864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKU3t-0004gw-J0
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKU3n-0006I8-FS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dKU3n-0006HT-6P
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:27:31 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612132034.1d15ab04@nial.brq.redhat.com>
	<bb84bdf5-6d09-60be-5954-dd6cde59264f@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0d1ddd4f-d008-29df-cb6d-38a8da84afb5@redhat.com>
Date: Mon, 12 Jun 2017 20:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <bb84bdf5-6d09-60be-5954-dd6cde59264f@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

Hi Mark,

On 06/12/17 13:45, Mark Cave-Ayland wrote:
> On 12/06/17 12:20, Igor Mammedov wrote:
> 
>> On Sat, 10 Jun 2017 13:30:16 +0100
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 316fca9..144e0c6 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -1017,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
>>>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>>>  }
>>>  
>>> +static void fw_cfg_init(Object *obj)
>>> +{
>>> +    FWCfgState *s = FW_CFG(obj);
>>> +
>>> +    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>>> +    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>>> +    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
>> it doesn't seem right,
>>
>> consider,
>>  object_new(fwcfg)
>>    1: fw_cfg_init -> g_new0(FWCfgEntry, fw_cfg_max_entry(s) -> FW_CFG_FILE_SLOTS_DFLT);
>>    2: set property x-file-slots
>>    3: realize -> fw_cfg_file_slots_allocate()
>>
>>> @@ -1052,10 +1062,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>>>                     file_slots_max);
>>>          return;
>>>      }
>>> -
>>> -    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>>> -    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>>> -    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
>> opps, s->entries doesn't account for new values of x-file-slots
>>
>> So question is why this patch is needed at all (it needs some reasoning in commit message)?
>>
>> So for now NACK and I'd suggest to drop this patch.
> 
> Right I missed the x-file-slots property when I was looking at this,
> mainly because all of the existing callers went through
> fw_cfg_init_mem() and fw_cfg_init_io(). I do see now though that the
> property is referenced in compat.h.
> 
> The reason for moving the initialisation is that if you apply patch 2 on
> its own then you get hit by the following assert on qemu-system-sparc64
> due to uninitialised data:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000062f81d in fw_cfg_add_bytes_read_callback (s=0x1e85410,
> key=0, callback=0, callback_opaque=0x0, data=0x9f6c28, len=4,
> read_only=true) at hw/nvram/fw_cfg.c:633
> 633         assert(s->entries[arch][key].data == NULL); /* avoid key
> conflict */
> (gdb) bt
> #0  0x000000000062f81d in fw_cfg_add_bytes_read_callback (s=0x1e85410,
> key=0, callback=0, callback_opaque=0x0, data=0x9f6c28, len=4,
> read_only=true) at hw/nvram/fw_cfg.c:633
> #1  0x000000000062fac8 in fw_cfg_add_bytes (s=0x1e85410, key=0,
> data=0x9f6c28, len=4) at hw/nvram/fw_cfg.c:664
> #2  0x00000000006307a8 in fw_cfg_init1 (dev=0x1e85410) at
> hw/nvram/fw_cfg.c:922
> #3  0x00000000006308fe in fw_cfg_init_io_dma (iobase=1296, dma_iobase=0,
> dma_as=0x0) at hw/nvram/fw_cfg.c:948
> #4  0x00000000006309bc in fw_cfg_init_io (iobase=1296) at
> hw/nvram/fw_cfg.c:968
> #5  0x00000000004f31e9 in sun4uv_init (address_space_mem=0x132df20,
> machine=0x132c8c0, hwdef=0x8bf400) at
> /home/build/src/qemu/git/qemu/hw/sparc64/sun4u.c:515
> #6  0x00000000004f3403 in sun4u_init (machine=0x132c8c0) at
> /home/build/src/qemu/git/qemu/hw/sparc64/sun4u.c:565
> #7  0x00000000005c0d26 in machine_run_board_init (machine=0x132c8c0) at
> hw/core/machine.c:760
> 
> 
> #8  0x0000000000532e56 in main (argc=2, argv=0x7fffffffeaa8,
> envp=0x7fffffffeac0) at vl.c:4594
> 
> Based upon this what do you think the best solution would be?


if you apply patch #2 without patch #1, then the above SIGSEGV will hit
on all fw_cfg using targets / machine types, not just
qemu-system-sparc64. The reason is that, after patch #2 (without patch
#1 applied) you have

  fw_cfg_init1()
    ...
      fw_cfg_add_bytes_read_callback()
        s->entries[arch][key].data
  qdev_init_nofail()
    fw_cfg_file_slots_allocate()

IOW, the s->entries array is now dynamically allocated (after the
introduction of the x-file-slots property):

    FWCfgEntry *entries[2];

and it is allocated in fw_cfg_file_slots_allocate(), called from
realize. But with patch #2 applied in isolation, you perform the first
dereference (from fw_cfg_init1(), indirectly) before allocation, that's
why it crashes.

Ultimately we need the following order:

(1) set properties (from device defaults, from device compat settings,
and from the command line; and also directly from code, such as in
fw_cfg_init_io_dma())

(2) call qdev_init_nofail() -- this will consume the properties from
(1), including the x-file-slots property, for allocating "s->entries" in
fw_cfg_file_slots_allocate()

(3) call fw_cfg_add_*() -- now that the device has been realized and is
usable.

This means that

- patch #1 should be dropped,

- and in patch #2, you have to push the rest of fw_cfg_init1() --
everything that is after the original qdev_init_nofail() call -- to the
end of the realize functions.


Alternatively, in patch #2, you have to split fw_cfg_init1() into two
parts, fw_cfg_init1() and fw_cfg_init2(). fw_cfg_init1() would keep
everything that's *before* the original qdev_init_nofail() call, and
fw_cfg_init2() would get everything *after*. Then, in
fw_cfg_init_io_dma() and fw_cfg_init_mem_wide(), you'd do

    fw_cfg_init1(dev);
    qdev_init_nofail(dev);
    fw_cfg_init2(dev);

In short, you cannot reorder steps (2) and (3) against each other -- you
cannot add fw_cfg entries before you realize the device -- and the crash
happens because that's exactly what patch #2 does at the moment.

And, patch #1 is not the right fix (you can allocate s->entries only in
realize, because the size depends on a property, which you can only
access in realize). The right fix is to drop patch #1 and to split
fw_cfg_init1() like described above.

... Hmmm, wait a second, while the above approach would fix patch #2, in
fact I think patch #2 doesn't have the right *goal*.

I'll comment under patch #2.

Thanks
Laszlo
