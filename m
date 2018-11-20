Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7TZ-000196-S9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7TX-00008H-QW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:58:05 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7TX-00007q-JT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:58:03 -0500
Received: by mail-ot1-x344.google.com with SMTP id u3so1899199ota.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:58:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541672989-15967-8-git-send-email-gengdongjiu@huawei.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-8-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:57:42 +0000
Message-ID: <CAFEAcA9wLv96u_GYCBPFtkQMvntoHDKhQjremmN1noaJxsvhAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND v15 07/10] KVM: Move related
 hwpoison page functions to accel/kvm/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Zheng Xiang <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 November 2018 at 10:29, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> kvm_hwpoison_page_add() and kvm_unpoison_all() will be used both
> by X86 and ARM platforms, so move these functions to a common
> accel/kvm/ folder to avoid duplicate code.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Address Peter's comments to move related hwpoison page function to
> accel/kvm folder in [1]
> Address Paolo's comments to move HWPoisonPage definition back to
> accel/kvm/kvm-all.c
>
> [1]:
> https://lists.gnu.org/archive/html/qemu-arm/2017-09/msg00077.html
> https://lists.gnu.org/archive/html/qemu-arm/2017-09/msg00152.html
> ---

> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -115,6 +115,11 @@ void qemu_ram_free(RAMBlock *block);
>
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
>
> +/* Add a poisoned page to the list */
> +void kvm_hwpoison_page_add(ram_addr_t ram_addr);
> +/* Free and remove all the poisoned pages in the list */
> +void kvm_unpoison_all(void *param);
> +

In my previous review comments I said:
>>> Any new globally-visible function prototype in a header should
>>> have a doc-comment formatted documentation comment, please.
>>
>>
>> Ok, thanks for this reminder. Do you mean I need to add comments
>> for this globally-visible function, such as below:
>>
>> /*
>>  * xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>>  */
>> void kvm_hwpoison_page_add(ram_addr_t ram_addr);
>
> It should be in the doc-comment format, which begins
> "/**" and has some stylization of how you list parameters
> and so on. Lots of examples in the existing headers.

Can we have a doc-comment in the proper format and with a little
more detail than a single line, please?

thanks
-- PMM
