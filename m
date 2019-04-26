Received: from eggs.gnu.org ([209.51.188.92]:36831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzZj-0008Ku-RW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzQy-0002ym-6i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJzQx-0002sc-9d
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:54:28 -0400
Date: Fri, 26 Apr 2019 13:54:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190426135412.758769f9@Igors-MacBook-Pro.local>
In-Reply-To: <1556211116-172721-1-git-send-email-xuwei5@huawei.com>
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
	<1556211116-172721-1-git-send-email-xuwei5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: x00249684 <xuwei5@huawei.com>
Cc: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com, Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com

On Fri, 26 Apr 2019 00:51:56 +0800
x00249684 <xuwei5@huawei.com> wrote:

> Hi Igor,
> 
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 ", &data);
> 
> Replaced the cortex-a57 with host and succesfully tested on the hisilicon arm64 
> D05 board. Otherwise it failed with "kvm_init_vcpu failed: Invalid argument".
> Is it possilbe to set the cpu type like numa-test.c?

I think it works with numa-test because it uses TCG only but in case of bios-tables-test
it uses accel="kvm:tcg" to leverage KVM capabilities whenever possible to speed up test.

Now back to our ARM test case, uefi requirement is to use 64bit CPU (hence it was cortex-a57)
however unlike x86 it obviously breaks since KVM accelerator on ARM host is used
and it doesn't work with anything other than 'host' cpu model.

I think we still want to use KVM whenever possible, but problem lies in that
user (testcase) doesn't have an idea if KVM accelerator is available and host is 64 CPU.

to sum up we need to support 2 modes:
  1. host is 64 ARM, use kvm with -cpu host
  2. all other cases use tcg with -cpu cortex-a57

I can hack to probe if /dev/kvm is accessible and host is 64 bit and use #1
otherwise fallback to #2
or as quick fix do only #2 initially and think about a better solution to #1 

Is there any other suggestions/opinions how to approach issue/proceed.

PS:
we probably would like to reuse this not only for acpi tests but also for other
arm/virt test cases that involve running guest code. 

> Thanks!
> 
> Best Regards,
> Wei
