Received: from eggs.gnu.org ([2001:4830:134:3::10]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTob7-00046X-FO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTob6-0004IU-Kc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:17:01 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTob6-0004HT-De
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:17:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id e8-v6so8771919oii.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 06:17:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_R_68FDq-=1coazcTpc1MGqh2ZanccP8C=C9ZJ9_T_6Q@mail.gmail.com>
References: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
	<1528554193-27270-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_R_68FDq-=1coazcTpc1MGqh2ZanccP8C=C9ZJ9_T_6Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 14:16:39 +0100
Message-ID: <CAFEAcA8B2qu1g2yGn4HiWCBhX2Can+UyrL==QTdKvxL7_Wq2Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Silence dtc /memory
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 15 June 2018 at 13:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 June 2018 at 15:23, Eric Auger <eric.auger@redhat.com> wrote:
>> When running dtc on the guest /proc/device-tree we get the
>> following warning: Warning (unit_address_vs_reg): Node /memory
>> has a reg or ranges property, but no unit name".
>>
>> Let's fix that by adding the unit address to the node name. We also
>> don't create the /memory node anymore in create_fdt(). We directly
>> create it in load_dtb. /chosen still needs to be created in create_fdt
>> as the uart needs it. In case the user provided his own dtb, either
>> the bank is added to the existing /memory node or if this latter is
>> not found we create a new separate memory node.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/boot.c | 20 ++++++++++++++------
>>  hw/arm/virt.c |  6 ------
>>  2 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 1e2be20..2054670 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -593,24 +593,32 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>              g_free(nodename);
>>          }
>>      } else {
>
> I think you need also to change the "if" half of this if..else,
> which deals with NUMA, because it assumes a "/memory" node was
> created by the virt.c code and now it will not be.

...I think this breaks the tests/numa-test part of 'make check'.

thanks
-- PMM
