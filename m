Received: from eggs.gnu.org ([2001:4830:134:3::10]:50687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1flbPl-0005iQ-BI
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1flbPk-0002BM-CW
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:50:49 -0400
References: <CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
	<20180726114158.am7kgc3jekxg55i5@kamzik.brq.redhat.com>
	<CAFEAcA8YH4p__zT1o0s3vNZOsyWZn3XPLgkNeT+jSJpmjvFTUw@mail.gmail.com>
	<20180726123509.qyadwbz4skwashcj@kamzik.brq.redhat.com>
	<CAFEAcA-Zv5xV2VwMCfGXUv8oT+gC_dgn8Q3M1v3FBjry7TbXVA@mail.gmail.com>
	<CAHmQWvB1zgaLi++BhGEs1Emb0-5HOrzCcPrHJDoxx-8Be9df1g@mail.gmail.com>
	<CAFEAcA_mVGSicjN=wwJY8OCJ-j=DtdLjDvM9U-dC3dQ=RQQXMQ@mail.gmail.com>
	<CAKv+Gu8sCjfL=uKy4nM6pcRneUzw2YG79CuOVBH3TeNOXf689A@mail.gmail.com>
	<20180803093748.2s563javprolaqsi@kamzik.brq.redhat.com>
	<730e9571-89fd-2ca2-f88f-47a3c0c3d235@redhat.com>
	<20180803143958.yyujxlmjiftuq4x3@kamzik.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9f02915c-748a-1007-8635-e6fa0319cbd6@redhat.com>
Date: Fri, 3 Aug 2018 16:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180803143958.yyujxlmjiftuq4x3@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/03/18 16:39, Andrew Jones wrote:
> On Fri, Aug 03, 2018 at 03:44:21PM +0200, Laszlo Ersek wrote:

>> In my earlier email
>>
>>   dynamic DRAM base for ArmVirtQemu
>>   http://mid.mail-archive.com/4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com
>>
>> I investigated what it would take to adapt this SEC driver,
>> "ArmPlatformPkg/PrePeiCore" (and other drivers that depend on it, and
>> run from pflash) to a dynamic RAM base.
>>
>> First of all, the driver would have to be cloned from ArmPlatformPkg to
>> ArmVirtPkg (becasue we shouldn't / can't modify ArmPlatformPkg for this
>> paravirt feature). Then all the changes should occur under ArmVirtPkg.
>>
>> Those would begin with replacing the fixed PcdCPUCoresStackBase (i.e.,
>> the location of the stack, which is the only writeable thing we start
>> out with) with calculating (and passing around) a stack base derived
>> from the initial x0 value. (This is bullet (1) in my above email.)
> 
> I'm actually attacking it without a stack. x0 will have the address of
> the DTB, which may or may not also be the base address of main memory.
> There's no need to code to the assumption it is in order to have a
> stack. The code to parse the DT can all be done in assembler without
> a stack.

That sounds very cunning :)

But, a stack will certainly be needed by the rest of the code, so even
if the DTB parsing itself needs no stack, later (but still early)
dependencies on PcdCPUCoresStackBase (and friends) will have to be replaced.

>> IOW, the cornerstone of this feature is to replace all constants
>> (FixedPCDs and otherwise) related to the RAM Base with values
>> dynamically calculated from the initial x0 value. My earlier email
>> details this as well -- at the earliest, the results can only be passed
>> around on the (dynamically configured) stack itself; a bit later, PPIs
>> (= structures identified by particular GUIDs, located originally in
>> temporary SEC/PEI RAM) can be used too. But, there's nothing ArmVirtQemu
>> can "patch" the way ArmVirtQemuKernel and ArmVirtXen do.
> 
> I need to digest this more, too, and to modify it to use the actual base
> of memory found in the DT, rather then value of x0, which may or may
> not be the same value.

Good point!

Laszlo
