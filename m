Received: from eggs.gnu.org ([2001:4830:134:3::10]:56924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOgQP-0002JM-Lg
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOgQM-0002Zc-Fo
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:45 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOgQM-0002Yw-9D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:42 -0400
Received: by mail-wr0-x235.google.com with SMTP id f16-v6so20343577wrm.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 02:32:42 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
	<ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
Date: Fri, 01 Jun 2018 10:32:39 +0100
Message-ID: <87zi0ezwaw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 05/30/2018 03:46 PM, Richard Henderson wrote:
>> Thanks.  Queued to tcg-next.
> Hmph.  Unqueued, at least for now.
>
> ERROR:/home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615:page_unlock_=
_debug:
> assertion failed: (page_is_locked(pd))
>
> #3  0x00007ffff4b6915e in g_assertion_message_expr ()
>     at /lib64/libglib-2.0.so.0
> #4  0x000055555583c088 in page_unlock__debug (pd=3D0x7fffa423aa80)
>     at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615
> #5  0x000055555583c1be in page_unlock (pd=3D0x7fffa423aa80)
>     at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:661
> #6  0x000055555583c2ef in page_entry_destroy (p=3D0x7fffa8024460)
>     at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:694
> #7  0x00007ffff4b6f448 in  () at /lib64/libglib-2.0.so.0
> #8  0x00007ffff4b6fea2 in g_tree_destroy () at /lib64/libglib-2.0.so.0
> #9  0x000055555583c791 in page_collection_unlock (set=3D0x7fffa802eba0)
>     at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:842
> #10 0x00005555557b301a in memory_notdirty_write_complete (ndi=3D0x7fffd9c=
f6050)
>     at /home/rth/work/qemu/qemu/exec.c:2495
> #11 0x00005555557b317f in notdirty_mem_write (opaque=3D0x0, ram_addr=3D12=
334096,
> val=3D18446739675675374544, size=3D8) at /home/rth/work/qemu/qemu/exec.c:=
2535
> #12 0x000055555580f14b in memory_region_write_accessor (mr=3D0x5555562a38=
a0
> <io_mem_notdirty>, addr=3D12334096, value=3D0x7fffd9cf6178, size=3D8, shi=
ft=3D0,
> mask=3D18446744073709551615, attrs=3D...) at /home/rth/work/qemu/qemu/mem=
ory.c:530
> #13 0x000055555580f360 in access_with_adjusted_size (addr=3D12334096,
> value=3D0x7fffd9cf6178, size=3D8, access_size_min=3D1, access_size_max=3D=
8, access_fn=3D
>     0x55555580f061 <memory_region_write_accessor>, mr=3D0x5555562a38a0
> <io_mem_notdirty>, attrs=3D...) at /home/rth/work/qemu/qemu/memory.c:597
> #14 0x0000555555811cef in memory_region_dispatch_write (mr=3D0x5555562a38=
a0
> <io_mem_notdirty>, addr=3D12334096, data=3D18446739675675374544, size=3D8=
, attrs=3D...)
>     at /home/rth/work/qemu/qemu/memory.c:1474
> #15 0x0000555555825d73 in io_writex (env=3D0x555556869090,
> iotlbentry=3D0x555556870520, mmu_idx=3D0, val=3D18446739675675374544,
> addr=3D18446739675675374608, retaddr=3D140736231479305, size=3D8) at
> /home/rth/work/qemu/qemu/accel/tcg/cputlb.c:813
> #16 0x0000555555828b6d in io_writeq (env=3D0x555556869090, mmu_idx=3D0, i=
ndex=3D225,
> val=3D18446739675675374544, addr=3D18446739675675374608, retaddr=3D140736=
231479305)
>     at /home/rth/work/qemu/qemu/accel/tcg/softmmu_template.h:265
> #17 0x0000555555828d2c in helper_le_stq_mmu (env=3D0x555556869090,
> addr=3D18446739675675374608, val=3D18446739675675374544, oi=3D48,
> retaddr=3D140736231479305)
>     at /home/rth/work/qemu/qemu/accel/tcg/softmmu_template.h:301
> #18 0x00007fffb5159809 in code_gen_buffer ()
>
> I can invoke similar crashes with just about every image I try.

Just booting up? I've been hammering builds in my system image with
debug-tcg enabled and haven't triggered it yet.

Using:

./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-versi=
on=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -nic user,mod=
el=3Dvirtio-net-pci,hostfwd=3Dtcp::2222-:22 -device virtio-blk-device,drive=
=3Dmyblock -drive file=3D/home/alex/lsrc/qemu/images/debian-stable-arm64.qc=
ow2,id=3Dmyblock,index=3D0,if=3Dnone -kernel /home/alex/lsrc/qemu/images/aa=
rch64-current-linux-kernel-only.img -append "console=3DttyAMA0 root=3D/dev/=
vda1" -display none -m 4096 -name debug-threads=3Don -smp 8
--
Alex Benn=C3=A9e
