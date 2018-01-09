Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYx7y-0001Kh-5O
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYx7x-0006TC-AM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:51:54 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYx7x-0006Sh-2k
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:51:53 -0500
Received: by mail-ot0-x242.google.com with SMTP id q5so11868228oth.2
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:51:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
	<20171228151809.10495a90@igors-macbook-pro.local>
	<10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:51:31 +0000
Message-ID: <CAFEAcA--f5eK0_zij55o09M+FyRUVH+Pnwc3tsT6rLm1kpvbBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 2/9] ACPI: Add APEI GHES table
 generation and CPER record support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

On 3 January 2018 at 02:21, gengdongjiu <gengdongjiu@huawei.com> wrote:
> On 2017/12/28 22:18, Igor Mammedov wrote:
>> On Thu, 28 Dec 2017 13:54:11 +0800
>> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>> In order to simulation, we hard code the error
>>> type to Multi-bit ECC.
>> Not sure what this is about, care to elaborate?
>
> please see Memory Error Record in [1], in which the "Memory Error Type" f=
ield is used to describe the
> error type, such as  Multi-bit ECC or Parity Error etc. Because KVM or ho=
st does not pass the memory
> error type to Qemu, so Qemu does not know what is the error type for the =
memory section. Hence we let QEMU simulate
> the error type to Multi-bit ECC.
>
> [1]:
> UEFI Spec 2.6 Errata A:
>
> "N.2.5 Memory Error Section"
> -----------------+---------------+--------------+------------------------=
-------------------+
>         Mnemonic |   Byte Offset |  Byte Length |        Description     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+
>         ........ |  ............ |  .........   |        ...........     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+
> Memory Error Type|     72        |       1      |Identifies the type of e=
rror that occurred:|
>                  |               |              | 0 =E2=80=93 Unknown    =
                          |
>                  |               |              | 1 =E2=80=93 No error   =
                          |
>                  |               |              | 2 =E2=80=93 Single-bit =
ECC                       |
>                  |               |              | 3 =E2=80=93 Multi-bit E=
CC                        |
>                  |               |              | 4 =E2=80=93 Single-symb=
ol ChipKill ECC           |
>                  |               |              | 5 =E2=80=93 Multi-symbo=
l ChipKill ECC            |
>                  |               |              | 6 =E2=80=93 Master abor=
t                          |
>                  |               |              | 7 =E2=80=93 Target abor=
t                          |
>                  |               |              | 8 =E2=80=93 Parity Erro=
r                          |
>                  |               |              | 9 =E2=80=93 Watchdog ti=
meout                      |
>                  |               |              | 10 =E2=80=93 Invalid ad=
dress                      |
>                  |               |              | 11 =E2=80=93 Mirror Bro=
ken                        |
>                  |               |              | 12 =E2=80=93 Memory Spa=
ring                       |
>                  |               |              | 13 - Scrub corrected er=
ror                |
>                  |               |              | 14 - Scrub uncorrected =
error              |
>                  |               |              | 15 - Physical Memory Ma=
p-out event        |
>                  |               |              | All other values reserv=
ed.                |
> -----------------+---------------+--------------+------------------------=
-------------------+
>         ........ |  ............ |  .........   |        ...........     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+

There's a value specified for "we don't know what the error type is",
which is "0 - Unknown". I think we should use that rather than claiming
that we have a particular type of error when we don't actually know that.

I agree with James that we don't want to report a particular type of
error to the guest anyway -- the VM is a virtual environment, and
the exact reason why the hardware/firmware/host kernel have decided
that a bit of RAM isn't usable any more doesn't matter to the guest.
We just want to report "this RAM has gone away, sorry" to it.

thanks
-- PMM
