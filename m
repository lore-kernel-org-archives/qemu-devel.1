Received: from eggs.gnu.org ([2001:4830:134:3::10]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWjDg-00089o-SC
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWjDf-0008GG-Sj
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:36:36 -0500
Date: Wed, 3 Jan 2018 14:36:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180103143618.322b1b33@redhat.com>
In-Reply-To: <fc9e6c01-3334-f79c-5416-499177234044@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-8-git-send-email-gengdongjiu@huawei.com>
	<20171228155310.312e95bb@igors-macbook-pro.local>
	<fc9e6c01-3334-f79c-5416-499177234044@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 7/9] ARM: ACPI: Add GPIO notification
 type for hardware RAS error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On Wed, 3 Jan 2018 11:48:30 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> On 2017/12/28 22:53, Igor Mammedov wrote:
> > On Thu, 28 Dec 2017 13:54:16 +0800
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
[...]
> >> +static void acpi_dsdt_add_error_device(Aml *scope)
> >> +{
> >> +    Aml *dev = aml_device(ACPI_HARDWARE_ERROR_DEVICE);
> >> +    Aml *method;
> >> +
> >> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C33")));
> >> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >> +
> >> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >> +    aml_append(method, aml_return(aml_int(0x0f)));  
> > no need for dummy _STA method, device is assumed to be present if there is no _STA   
> Igor,
>   do you mean remove above two line code as shown in [1]?
> I dump the DSDT table in my host Ubuntu PC for the error device (PNP0C33), it has the _STA, as shown in [2].
> do we not want to add the _STA for guest?
> 
> [1]
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_int(0x0f)));
compared to host, yours method does nothing,
read ACPI6.2 "6.3.7 _STA (Status)" one more time

> [2]:
>         Device (WERR)
>         {
>             Name (_HID, EisaId ("PNP0C33"))  // _HID: Hardware ID
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 If (LGreaterEqual (OSYS, 0x07D9))
>                 {
>                     Return (0x0F)
>                 }
>                 Else
>                 {
>                     Return (Zero)
>                 }
>             }
>         }
> >   
> >> +    aml_append(dev, method);
> >> +    aml_append(scope, dev);
> >> +}
> >> +
[...]
