Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g08gh-0005ZV-Qe
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g08gh-0007NL-2B
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:12:23 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g08gg-0007Mx-OX
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:12:22 -0400
Received: by mail-wm0-x241.google.com with SMTP id 207-v6so3235541wme.5
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 10:12:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180912160118.21158-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c8bfd44b-4d12-c2f6-7ac1-f8cda7178355@amsat.org>
Date: Wed, 12 Sep 2018 18:13:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] Add missed read callback for some
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org

Hi Li,

On 9/12/18 6:01 PM, Li Qiang wrote:
> From: Li Qiang <liq3ea@gmail.com>
> 
> This patch set try to add the missed read callback for memory region.
> Without this patchset, when the guest reads the IO port/memory, it will
> cause an NULL-dereference issue. For example, add 
> "-device isa-debug-exit" to command, then read the 0x501 port, it causes a 
> SIGSEGV.
> 
> The only exception is 'readonly_mem_ops' as its read is directly 
> access the underlying host ram as the comments says.
> 
> These missed read callback is mostly pointed by Laszlo Ersek.
> 
> 
> 
> Li Qiang (8):
>   fw_cfg_mem: add read memory region callback
>   hw: debugexit: add read callback
>   hw: hyperv_testdev: add read callback
>   hw: pc-testdev: add read memory region callback
>   hw: designware: add read memory region callback
>   hw: pvrdma: add read memory region callback
>   hw: sun4c: add read memory region callback
>   exec: add read callback for notdirty memory region

Why not rather simply add a check in
memory_region_oldmmio_read_accessor() instead?

Eventually:

{
    uint64_t tmp;
    int idx = ctz32(size);

    if (unlikely(mr->ops->old_mmio.write[idx]
                 && !mr->ops->old_mmio.read[idx])) {
        tmp = 0; /* XXX is 0 the expected value??? */
    } else {
        tmp = mr->ops->old_mmio.read[idx](mr->opaque, addr);
    }
    ...
