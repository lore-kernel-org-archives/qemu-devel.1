Received: from eggs.gnu.org ([2001:4830:134:3::10]:34983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1g7JSn-00082q-Q6
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1g7JGx-0001JL-Ft
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:55:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1g7JGx-0001If-47
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:55:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id s12-v6so1958950wmc.0
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 04:55:26 -0700 (PDT)
References: <20180720081948.23644-1-remy.noel@blade-group.com>
	<20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
	<20180807145701.GK2556@work-vm>
	<CAFEAcA9mgyCzR7-ANw0YvKdzz-0H50vETrr_sw5bH5D_2PUeNg@mail.gmail.com>
	<20180807150935.GL2556@work-vm>
	<3d89d87f-857d-ebb1-1fe7-710a52ea381d@blade-group.com>
	<d7592b8a-ccf3-7d68-9fce-30a80fa58bce@redhat.com>
	<20180830112849.medou3o5rrpbymj6@sirius.home.kraxel.org>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <c2e4bc3a-1f5b-4ec1-4a90-4b5d782fa9fc@blade-group.com>
Date: Tue, 2 Oct 2018 13:55:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180830112849.medou3o5rrpbymj6@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On 8/30/18 1:28 PM, Gerd Hoffmann wrote:

>> I'll take a look...
> Ping, any results?
>
> I'm wondering whenever we should just revert
> 93abfc88bd649de1933588bfc7175605331b3ea9.
>
> Retested hotplug with 93abfc88bd649de1933588bfc7175605331b3ea9 reverted.
> Works just fine with guest kernel loaded.  Doesn't work without guest
> booted (grub prompt for example), but pci hotplug requires guest
> cooperation so this isn't a bug in secondary-vga ...
>
> cheers,
>    Gerd

I finally got the time to get back on this issue.

Just deleting the 3 subregions from the mmio in the exit callback does 
the job and everything works fine. I'll re-submit the patch in a new thread.

Reverting 93abfc88bd649de1933588bfc7175605331b3ea9 indeed frees the 
object but the hanging memory regions seems to cause some problems upon 
reset::

   - After deleting a device and adding it back, i get a segfault when 
calling system_reset:

                 #0  0x00007f90611acab8 g_hash_table_iter_next 
(libglib-2.0.so.0)
                 #1  0x000055a631e7aa39 object_resolve_partial_path 
(qemu-system-x86_64)
                 #2  0x000055a631e7a9ea object_resolve_partial_path 
(qemu-system-x86_64)
                 #3  0x000055a631e7a9ea object_resolve_partial_path 
(qemu-system-x86_64)
                 #4  0x000055a631e7a9ea object_resolve_partial_path 
(qemu-system-x86_64)
                 #5  0x000055a631e7aafd object_resolve_path_type 
(qemu-system-x86_64)
                 #6  0x000055a631c29879 piix4_pm_find (qemu-system-x86_64)
                 #7  0x000055a631b2d4ed acpi_get_pm_info 
(qemu-system-x86_64)
                 #8  0x000055a631b35903 acpi_build (qemu-system-x86_64)
                 #9  0x000055a631b3618d acpi_build_update 
(qemu-system-x86_64)
                 #10 0x000055a631d27cb3 fw_cfg_select (qemu-system-x86_64)
                 #11 0x000055a631d2848c fw_cfg_comb_write 
(qemu-system-x86_64)
                 #12 0x000055a631a5ebd7 memory_region_write_accessor 
(qemu-system-x86_64)
                 #13 0x000055a631a5edec access_with_adjusted_size 
(qemu-system-x86_64)
                 #14 0x000055a631a61ac2 memory_region_dispatch_write 
(qemu-system-x86_64)
                 #15 0x000055a6319fcbf9 flatview_write_continue 
(qemu-system-x86_64)
                 #16 0x000055a6319fcd43 flatview_write (qemu-system-x86_64)
                 #17 0x000055a6319fd049 address_space_write 
(qemu-system-x86_64)
                 #18 0x000055a6319fd09a address_space_rw 
(qemu-system-x86_64)
                 #19 0x000055a631a7cd66 kvm_handle_io (qemu-system-x86_64)
                 #20 0x000055a631a7d499 kvm_cpu_exec (qemu-system-x86_64)
                 #21 0x000055a631a43cb7 qemu_kvm_cpu_thread_fn 
(qemu-system-x86_64)
                 #22 0x000055a631fbbadd qemu_thread_start 
(qemu-system-x86_64)
                 #23 0x00007f905c851a9d start_thread (libpthread.so.0)
                 #24 0x00007f905c781a43 __clone (libc.so.6)

   - When calling system_reset just after removing a device, we get a 
bunch of:

         GLib-CRITICAL **: 10:16:29.020: g_hash_table_iter_init: 
assertion 'hash_table != NULL' failed

         GLib-CRITICAL **: 10:16:29.023: g_hash_table_iter_next: 
assertion 'ri->version == ri->hash_table->version' failed


I did not inquiry those further though as the subregions removal did 
lead to a clean state.


Remy Noel
