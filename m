Received: from eggs.gnu.org ([2001:4830:134:3::10]:39394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKUN0-0000xT-5L
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKUMv-0005Se-7u
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:47:22 -0400
Received: from chuckie.co.uk ([82.165.15.123]:39600
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKUMv-0005R8-0P
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:47:17 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612132034.1d15ab04@nial.brq.redhat.com>
	<bb84bdf5-6d09-60be-5954-dd6cde59264f@ilande.co.uk>
	<0d1ddd4f-d008-29df-cb6d-38a8da84afb5@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <dd374c9d-ebae-a259-c90e-1440ad7af19b@ilande.co.uk>
Date: Mon, 12 Jun 2017 19:46:54 +0100
MIME-Version: 1.0
In-Reply-To: <0d1ddd4f-d008-29df-cb6d-38a8da84afb5@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On 12/06/17 19:27, Laszlo Ersek wrote:

>> Based upon this what do you think the best solution would be?
> 
> 
> if you apply patch #2 without patch #1, then the above SIGSEGV will hit
> on all fw_cfg using targets / machine types, not just
> qemu-system-sparc64. The reason is that, after patch #2 (without patch
> #1 applied) you have
> 
>   fw_cfg_init1()
>     ...
>       fw_cfg_add_bytes_read_callback()
>         s->entries[arch][key].data
>   qdev_init_nofail()
>     fw_cfg_file_slots_allocate()
> 
> IOW, the s->entries array is now dynamically allocated (after the
> introduction of the x-file-slots property):
> 
>     FWCfgEntry *entries[2];
> 
> and it is allocated in fw_cfg_file_slots_allocate(), called from
> realize. But with patch #2 applied in isolation, you perform the first
> dereference (from fw_cfg_init1(), indirectly) before allocation, that's
> why it crashes.
> 
> Ultimately we need the following order:
> 
> (1) set properties (from device defaults, from device compat settings,
> and from the command line; and also directly from code, such as in
> fw_cfg_init_io_dma())
> 
> (2) call qdev_init_nofail() -- this will consume the properties from
> (1), including the x-file-slots property, for allocating "s->entries" in
> fw_cfg_file_slots_allocate()
> 
> (3) call fw_cfg_add_*() -- now that the device has been realized and is
> usable.
> 
> This means that
> 
> - patch #1 should be dropped,
> 
> - and in patch #2, you have to push the rest of fw_cfg_init1() --
> everything that is after the original qdev_init_nofail() call -- to the
> end of the realize functions.
> 
> 
> Alternatively, in patch #2, you have to split fw_cfg_init1() into two
> parts, fw_cfg_init1() and fw_cfg_init2(). fw_cfg_init1() would keep
> everything that's *before* the original qdev_init_nofail() call, and
> fw_cfg_init2() would get everything *after*. Then, in
> fw_cfg_init_io_dma() and fw_cfg_init_mem_wide(), you'd do
> 
>     fw_cfg_init1(dev);
>     qdev_init_nofail(dev);
>     fw_cfg_init2(dev);
> 
> In short, you cannot reorder steps (2) and (3) against each other -- you
> cannot add fw_cfg entries before you realize the device -- and the crash
> happens because that's exactly what patch #2 does at the moment.
> 
> And, patch #1 is not the right fix (you can allocate s->entries only in
> realize, because the size depends on a property, which you can only
> access in realize). The right fix is to drop patch #1 and to split
> fw_cfg_init1() like described above.
> 
> ... Hmmm, wait a second, while the above approach would fix patch #2, in
> fact I think patch #2 doesn't have the right *goal*.
> 
> I'll comment under patch #2.

Yes that now makes sense - I think I managed to confuse myself when
writing the patch since I grepped for the type and the calls to the
fw_cfg_init_*() functions but managed to miss the x-file-slots property
as pointed out by Igor :(

Reading what you said above, I'd be inclined to move the default values
from fw_cfg_init1() into a QOM method in the parent fw_cfg type as
suggested by Igor, and then call the method right at the end of the
realise function in order to load them.

However it also sounds like you have some better thoughts for patch #2
so I'll wait for your reply to that first.


ATB,

Mark.
