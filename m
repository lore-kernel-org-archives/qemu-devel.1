Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK05Q-0001mz-UK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK05O-0006Qf-Na
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:04:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK05O-0006NF-Ge
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:03:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id q5so11103369otl.13
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:03:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181106115351.9422-1-ppandit@redhat.com>
References: <20181106115351.9422-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 12:03:35 +0000
Message-ID: <CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 6 November 2018 at 11:53, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While accessing script ram[2048] via 'lsi_ram_read/write' routines,
> 'addr' could exceed the ram range. Mask high order bits to avoid
> OOB access.
>
> Reported-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/lsi53c895a.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 3f207f607c..0800df416e 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2035,6 +2035,7 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
>      uint32_t mask;
>      int shift;
>
> +    addr &= 0x01FFF;
>      newval = s->script_ram[addr >> 2];
>      shift = (addr & 3) * 8;
>      mask = ((uint64_t)1 << (size * 8)) - 1;
> @@ -2050,6 +2051,7 @@ static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
>      uint32_t val;
>      uint32_t mask;
>
> +    addr &= 0x01FFF;
>      val = s->script_ram[addr >> 2];
>      mask = ((uint64_t)1 << (size * 8)) - 1;
>      val >>= (addr & 3) * 8;
> --

When can this masking have any effect? These functions are
the read and write ops for lsi_ram_ops, which we register with
    memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
                          "lsi-ram", 0x2000);
which specifies a memory region size of 0x2000. So the input
addr must be in the 0..0x1fff range already -- or have I missed
something ?

It would probably be helpful (for readers and static analysers)
to assert() that addr is < 0x2000, though.

thanks
-- PMM
