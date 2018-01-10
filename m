Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZ8qx-00084t-PZ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZ8qt-00050j-RG
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:23:07 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
	<20171228151809.10495a90@igors-macbook-pro.local>
	<10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
	<CAFEAcA--f5eK0_zij55o09M+FyRUVH+Pnwc3tsT6rLm1kpvbBw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <c45372c1-dd9a-8224-9745-49f56188ec8c@huawei.com>
Date: Wed, 10 Jan 2018 13:22:30 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--f5eK0_zij55o09M+FyRUVH+Pnwc3tsT6rLm1kpvbBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James
	Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU
	Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

Peter,
  Thank you very much for your time to review it and give some comments.

On 2018/1/10 0:51, Peter Maydell wrote:
>> the error type to Multi-bit ECC.
>>
>> [1]:
>> UEFI Spec 2.6 Errata A:
>>
>> "N.2.5 Memory Error Section"
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         Mnemonic |   Byte Offset |  Byte Length |        Description  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         ........ |  ............ |  .........   |        ...........  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>> Memory Error Type|     72        |       1      |Identifies the type o=
f error that occurred:|
>>                  |               |              | 0 =E2=80=93 Unknown =
                             |
>>                  |               |              | 1 =E2=80=93 No error=
                             |
>>                  |               |              | 2 =E2=80=93 Single-b=
it ECC                       |
>>                  |               |              | 3 =E2=80=93 Multi-bi=
t ECC                        |
>>                  |               |              | 4 =E2=80=93 Single-s=
ymbol ChipKill ECC           |
>>                  |               |              | 5 =E2=80=93 Multi-sy=
mbol ChipKill ECC            |
>>                  |               |              | 6 =E2=80=93 Master a=
bort                          |
>>                  |               |              | 7 =E2=80=93 Target a=
bort                          |
>>                  |               |              | 8 =E2=80=93 Parity E=
rror                          |
>>                  |               |              | 9 =E2=80=93 Watchdog=
 timeout                      |
>>                  |               |              | 10 =E2=80=93 Invalid=
 address                      |
>>                  |               |              | 11 =E2=80=93 Mirror =
Broken                        |
>>                  |               |              | 12 =E2=80=93 Memory =
Sparing                       |
>>                  |               |              | 13 - Scrub corrected=
 error                |
>>                  |               |              | 14 - Scrub uncorrect=
ed error              |
>>                  |               |              | 15 - Physical Memory=
 Map-out event        |
>>                  |               |              | All other values res=
erved.                |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         ........ |  ............ |  .........   |        ...........  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
> There's a value specified for "we don't know what the error type is",
> which is "0 - Unknown". I think we should use that rather than claiming
> that we have a particular type of error when we don't actually know tha=
t.
Agree peter's suggestion. It seems "0 - Unknown" makes sense.

>=20
> I agree with James that we don't want to report a particular type of
> error to the guest anyway -- the VM is a virtual environment, and
> the exact reason why the hardware/firmware/host kernel have decided
> that a bit of RAM isn't usable any more doesn't matter to the guest.
> We just want to report "this RAM has gone away, sorry" to it.
Agree with peter, appreciate for the comments.

>=20
> thanks
> -- PMM
