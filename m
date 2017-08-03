Received: from eggs.gnu.org ([2001:4830:134:3::10]:47557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ddFpC-0003l3-0X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ddFp7-00022k-Dl
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ddFp6-00020x-U1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:05:57 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-2-git-send-email-zuban32s@gmail.com>
	<20170803155042-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <fa31d912-584e-32ae-e795-6223d6d43c42@redhat.com>
Date: Thu, 3 Aug 2017 16:05:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170803155042-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 03/08/2017 15:52, Michael S. Tsirkin wrote:
> On Sat, Jul 29, 2017 at 02:37:49AM +0300, Aleksandr Bezzubikov wrote:
>> Unmask previously masked SHPC feature in _OSC method.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> 

Hi Michael,


> This does not do what the subject says - it enables
> SHPC unconditionally. And I think it will actually break
> ACPI hotplug for the PC unless we add an interface to
> disable ACPI hotplug and enable SHPC.
> 
> Pls limit to Q35 only.
>

The code is inside build_q35_osc_method,
I don't understand how it affects the PC machine.

Thanks,
Marcel


>> ---
>>   hw/i386/acpi-build.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 6b7bade..2ab32f9 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1848,9 +1848,9 @@ static Aml *build_q35_osc_method(void)
>>   
>>       /*
>>        * Always allow native PME, AER (no dependencies)
>> -     * Never allow SHPC (no SHPC controller in this system)
>> +     * Allow SHPC (PCI bridges can have SHPC controller)
>>        */
>> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
>> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>>   
>>       if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>>       /* Unknown revision */
>> -- 
>> 2.7.4
