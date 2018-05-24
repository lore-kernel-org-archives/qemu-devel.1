Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLqvq-0000ab-6V
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLqvl-0002lx-3P
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:09:30 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
	<CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
	<550464ac-5155-6311-d0f7-92c7c0813f82@redhat.com>
	<CAFEAcA-hobu_=VKhYQ+UZ1WX_JFfwCarkPKQhiBtXc3fre57rg@mail.gmail.com>
	<ee204f5f-600f-2425-a1ff-0418b4611e96@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a8485329-0986-c99b-ad64-ec5af0a987b8@redhat.com>
Date: Thu, 24 May 2018 16:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <ee204f5f-600f-2425-a1ff-0418b4611e96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Laszlo,

On 05/24/2018 03:59 PM, Laszlo Ersek wrote:
> On 05/24/18 15:07, Peter Maydell wrote:
>> On 24 May 2018 at 13:59, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 05/24/18 11:11, Peter Maydell wrote:
>>>> Won't it also break a guest which is just Linux loaded not via
>>>> firmware which is an aarch32 kernel without LPAE support?
>>>
>>> Does such a thing exist? (I honestly have no clue.)
>>
>> Yes, it does; LPAE isn't a mandatory kernel config option.
>> This is why we have the machine 'highmem' option, so that
>> we can run on those kernels by not putting anything above
>> the 4G boundary. Looking back at the history on that, we
>> opted at the time for "default to highmem on, and if you're
>> running an non-lpae kernel you need to turn it off manually".
> 
> Ah, OK, I didn't know that.
> 
>> So we can handle those kernels by just not putting ECAM
>> above 4G if highmem is false.
> 
> The problem is we can have a combination of 32-bit UEFI firmware (which
> certainly lacks LPAE) and a 32-bit kernel which supports LPAE.

Is it what happens with the FW you provided to me? There is no LPAE in it?

> Previously, you wouldn't specify highmem=off, and things would just work
> -- the firmware would simply ignore the >=4GB MMIO apertur  e, and use the
> 32-bit MMIO aperture only (and use the sole 32-bit ECAM). The kernel
> could then use both low and high MMIO apertures, however (I gather?).
>   
> The difference with "high ECAM" is that it is *moved* (not *added*), so
> the 32-bit firmware is left with nothing for config space access.
Yes it is not possible to declare several disjoint ECAM spaces for a
single segment I think, hence the move.

 For
> booting the same combination as above, you are suddenly forced to add
> highmem=off, just to keep the ECAM low -- and that, while it keeps the
> firmware happy, prevents the LPAE-capable kernel from using the high
> MMIO aperture.
> 
> So I think "highmem_ecam" should be computed like this:
> 
>   highmem_ecam = highmem_ecam_machtype_default &&
>                  highmem &&
>                  (!firmware_loaded || aarch64);

Looks sensible to me

Thanks

Eric
> 
> Thanks,
> Laszlo
> 
