Received: from eggs.gnu.org ([2001:4830:134:3::10]:33077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1elKXc-0007nX-Ce
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1elKXY-0007uI-VQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:17:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1elKXY-0007tV-JA
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:17:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CKGWT4083168
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 15:17:27 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3hgk8s7b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 15:17:26 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 15:17:25 -0500
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212194531.GA26349@morn.lan>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 15:17:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180212194531.GA26349@morn.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5345fb74-02cf-9793-78d7-490e5e77ad27@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, lersek@redhat.com, mst@redhat.com

On 02/12/2018 02:45 PM, Kevin O'Connor wrote:
> On Fri, Feb 09, 2018 at 03:19:31PM -0500, Stefan Berger wrote:
>> I have played around with this patch and some modifications to EDK2. Though
>> for EDK2 the question is whether to try to circumvent their current
>> implementation that uses SMM or use SMM. With this patch so far I circumvent
>> it, which is maybe not a good idea.
>>
>> The facts for EDK2's PPI:
>>
>> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM via
>> an SMI and the PPI code is written into a UEFI variable. For this ACPI uses
>> the memory are at 0xFFFF 0000 to pass parameters from the OS (via ACPI) to
>> SMM. This is declared in ACPI with an OperationRegion() at that address.
>> Once the machine is rebooted, UEFI reads the variable and finds the PPI code
>> and reacts to it.
> I'm a bit confused by this.  The top 1M of the first 4G of ram is
> generally mapped to the flash device on real machines.  Indeed, this
> is part of the mechanism used to boot an X86 machine - it starts
> execution from flash at 0xfffffff0.  This is true even on modern
> machines.
>
> So, it seems strange that UEFI is pushing a code through a memory
> device at 0xffff0000.  I can't see how that would be portable.  Are
> you sure the memory write to 0xffff0000 is not just a trigger to
> invoke the SMI?

I base this on the code here:

https://github.com/tianocore/edk2/blob/master/SecurityPkg/Tcg/Tcg2Smm/Tpm.asl#L81

OperationRegion (TNVS, SystemMemory, 0xFFFF0000, 0xF0)

>
> It sounds as if the ultimate TPM interface that must be supported is
> the ACPI DSDT methods.  Since you're crafting the DSDT table yourself,
> why does there need to be two different backends - why can't the same
> mechanism be used for both SeaBIOS and UEFI?  Is this because you are
> looking to reuse TPM code already in UEFI that requires a specific
> interface?

UEFI uses SMM to write the PPI code into a UEFI variable that it then 
presumably stores back to NVRAM. With SeaBIOS I would go the path of 
having the ACPI code write the code in the OperationRegion() and leave 
it at that, so not invoke SMM. EDK2 also reads the result of the 
operation from a register that SMM uses to pass a return value through. 
We wouldn't need that for SeaBIOS.

    Stefan

>
> -Kevin
>
