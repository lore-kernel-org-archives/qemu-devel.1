Received: from eggs.gnu.org ([2001:4830:134:3::10]:38574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dHA0r-0000QO-0x
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dHA0n-0006dG-3o
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 10:26:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51155
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dHA0m-0006cQ-TG
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 10:26:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53ENfim082106
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 10:26:38 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2auurgn5dq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 10:26:38 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 08:26:37 -0600
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602191230-mutt-send-email-mst@kernel.org>
	<c2f1189a-48cf-4e01-c761-c20fe50ab67d@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 3 Jun 2017 10:26:27 -0400
MIME-Version: 1.0
In-Reply-To: <c2f1189a-48cf-4e01-c761-c20fe50ab67d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <a3d4cc14-056c-3157-4add-525e36e29c41@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, edk2-devel-ml01 <edk2-devel@ml01.01.org>, SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Kevin O'Connor <kevin@koconnor.net>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>

On 06/02/2017 07:20 PM, Laszlo Ersek wrote:
> On 06/02/17 18:30, Michael S. Tsirkin wrote:
>> On Fri, Jun 02, 2017 at 05:45:21PM +0200, Laszlo Ersek wrote:
>>> Hi,
>>>
>>> this message is cross-posted to three lists (qemu, seabios, edk2). I'll
>>> follow up with three patch series, one series for each project. I'll
>>> cross-post all of the patches as well, but I'll add the project name in
>>> the "bag of tags" in the subject lines.
>>>
>>> The QEMU series introduces two extensions to the ALLOCATE firmware
>>> linker/loader command.
>>>
>>> One extension is a new allocation zone, with value 3, for allowing the
>>> firmware to allocate the fw_cfg blobs in 64-bit address space.
>> Seems to make sense. I guess it's safe to do this if no
>> pointers to this table are 32 bit, right?
> That's right. For example, the TCPA patch (6 of 7) in the QEMU series
> does this, because the ACPI_BUILD_TPMLOG_FILE is only referenced by a
> 64-bit pointer.
>
>> Is there a chance we'll ever be able to use this on PC
>> assuming the need to support 32 bit guests?
> Well, sticking with the TCPA example, if an ACPI table defines *only* an
> 8-byte pointer to some memory area, that seems to preclude support for
> 32-bit guests already, generally speaking, no?

I just tested this, giving 8G of memory to a VM and running i386 Fedora 
in it. The memory allocated for the TCPA log seems to be in 32bit 
memory, so not out of reach of i386 guests. I guess it's important what 
the firmware does with it, whether it strictly follows the 64bit and 
allocates memory as far up as possible or provides compatibility. 
SeaBIOS (1.10.0) seems to do the right thing.

    Stefan
