Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTqQJ-0002YD-54
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTqQI-00087H-8D
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:13:59 -0400
References: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
	<1528554193-27270-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_R_68FDq-=1coazcTpc1MGqh2ZanccP8C=C9ZJ9_T_6Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ee86518f-5eb3-f54c-1892-893f87c0b4a9@redhat.com>
Date: Fri, 15 Jun 2018 17:13:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_R_68FDq-=1coazcTpc1MGqh2ZanccP8C=C9ZJ9_T_6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hi Peter,

On 06/15/2018 02:26 PM, Peter Maydell wrote:
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

You're right.

Besides, what is unclear to me is the use case where the end-user
provides his own dtb. In that case, do we want to "erase" all the
/memory@addr nodes defined by the user and replace them by the nodes
below? Potentially the end user could have provided several memory
nodes, right?

Same question for non NUMA case, do we want to remove all the /memory
nodes provided by the end-user?

Thanks

Eric
> 
>> +        char *nodename = g_strdup("/memory");
>>          Error *err = NULL;
>>
>> -        rc = fdt_path_offset(fdt, "/memory");
>> +        /* If there is an existing /memory node (user provided dtb), we add the
>> +         * new bank into it, otherwise we create a /memory@addr node
>> +         */
>> +        rc = fdt_path_offset(fdt, nodename);
> 
> If we create /memory@addr nodes then we should also look for them in
> an input dtb, I think. Otherwise we'll break the usecase where the
> user asks QEMU to dump the generated dtb to a file, edits it and
> then passes it back to a subsequent QEMU invocation, because we won't
> find the memory node we created.
> 
> thanks
> -- PMM
> 
