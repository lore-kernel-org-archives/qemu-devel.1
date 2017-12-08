Received: from eggs.gnu.org ([2001:4830:134:3::10]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDOJ-00064s-Py
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDOG-0008L5-LI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:48:15 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eNDOG-0008Kx-GM
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:48:12 -0500
Received: by mail-vk0-f67.google.com with SMTP id n63so6477675vkf.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 23:48:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABdb736YcfLJxGY9M-rzT1KuLjmxVTRf3VxJjP9101VBHj6Apw@mail.gmail.com>
References: <20171115073144.14758-1-lprosek@redhat.com>
	<1f8754babd990beb90c516d2973b21d3@hostfission.com>
	<CABdb7363ki8=BroGTP6Z+Shc+WLn3kJjM2e5y3N=R7vL=y4rKg@mail.gmail.com>
	<CABdb736YcfLJxGY9M-rzT1KuLjmxVTRf3VxJjP9101VBHj6Apw@mail.gmail.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 8 Dec 2017 08:48:11 +0100
Message-ID: <CABdb735m9mWUe5bLwKGibV7zRqakB3Gv+QWMKnDPTWAKnj6wmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geoffrey McRae <geoff@hostfission.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Mon, Nov 20, 2017 at 1:49 PM, Ladi Prosek <lprosek@redhat.com> wrote:
> On Mon, Nov 20, 2017 at 10:07 AM, Ladi Prosek <lprosek@redhat.com> wrote:
>> On Sun, Nov 19, 2017 at 9:39 PM,  <geoff@hostfission.com> wrote:
>>> I just updated to the latest build and applied this patch set, now on VM
>>> reset the qemu crashes with the following assert:
>>>
>>> ivshmem.c:467: ivshmem_add_kvm_msi_virq: Assertion
>>> `!s->msi_vectors[vector].pdev' failed.
>>
>> I see asserts too. Even with v1 on top of QEMU v2.10.0 so I must have
>> missed something.
>>
>> Looking. And, needless to say, these patches should not be applied just yet :)
>
> Ok, here goes it.
>
> 1)
> ivshmem.c:467: ivshmem_add_kvm_msi_virq: Assertion
> `!s->msi_vectors[vector].pdev' failed.
>
> Is caused by the ivshmem device not undoing the effects of
> ivshmem_enable_irqfd() on reset.
>
> This fix works for me:
>
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -758,10 +758,15 @@ static void ivshmem_msix_vector_use(IVShmemState *s)
>      }
>  }
>
> +
> +static void ivshmem_disable_irqfd(IVShmemState *s);
> +
>  static void ivshmem_reset(DeviceState *d)
>  {
>      IVShmemState *s = IVSHMEM_COMMON(d);
>
> +    ivshmem_disable_irqfd(s);
> +
>      s->intrstatus = 0;
>      s->intrmask = 0;
>      if (ivshmem_has_feature(s, IVSHMEM_MSI)) {

I have added this to v3 as patch 4.

> 2)
> ivshmem.c:354: ivshmem_vector_mask: Assertion `v->unmasked' failed.
>
> which I've been also getting after I enabled Driver Verifier and
> Windows started crashing
> (https://github.com/virtio-win/kvm-guest-drivers-windows/pull/199), is
> caused by the MSI-X code masking already masked vectors on reset. I'm
> going to post a patch similar to this:
>
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -500,11 +500,12 @@ void msix_reset(PCIDevice *dev)
>          return;
>      }
>      msix_clear_all_vectors(dev);
> +    msix_mask_all(dev, dev->msix_entries_nr);
>      dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] &=
>             ~dev->wmask[dev->msix_cap + MSIX_CONTROL_OFFSET];
>      memset(dev->msix_table, 0, dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE);
>      memset(dev->msix_pba, 0, QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8);
> -    msix_mask_all(dev, dev->msix_entries_nr);
> +    msix_update_function_masked(dev);
>  }
>
>
> Then either no further changes to this patchset are necessary. Or, if
> relying on unmasks/masks (or
> msix_vector_use_notifier/msix_vector_release_notifier as it's called
> in msix.c) always being balanced is not recommended, the assert will
> simply change into an if.

This is fixed in "msix: don't mask already masked vectors on reset":
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01362.html
