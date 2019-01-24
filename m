Received: from eggs.gnu.org ([209.51.188.92]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gmUug-00011a-G1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gmUuf-0007tT-Fl
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:38:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gmUuf-0007lw-6V
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:38:41 -0500
Date: Thu, 24 Jan 2019 03:38:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <ab10ffce-c591-a08c-3ecf-145f1ef0cd07@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1901240336030.16385@zero.eik.bme.hu>
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<ab10ffce-c591-a08c-3ecf-145f1ef0cd07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH v4 00/44] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, sameo@linux.intel.com

On Thu, 24 Jan 2019, Paolo Bonzini wrote:
> On 23/01/19 07:55, Yang Zhong wrote:
>> This Kconfig implementation is rebased from Paolo's branch
>> https://github.com/bonzini/qemu/commits/kconfig
>>
>> I rebased most of patches except non-x86 ARCHs dependency definitions
>> this time.
>> https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig
>>
>> The current RFC patches only support
>> (*) x86_64 platform build
>>     Once design is fixed, we can do other archs.
>>
>> (*) defconfig
>>     "randconfig" build has some issues, which are mostly related
>>     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
>>     some CONFIG* has different setting value in config-host.mak and
>>     %/config-device.mak, which make QEMU build failure.
>>
>> (*) Kconfig in hw/ directory
>>
>> The current configure and build command are same with previous
>> commands and if we want to disable or enable some features, like
>> "tcg", we still need add "--enable/--disable-tcg" in configure
>> command line. If we want to disable one emulation device, we can
>> disable this in related Kconfig file in hw/ directory.
>>
>> The current build command:
>> (*) ./configure --target-list=x86_64-softmmu
>> (*) make -j8
>>
>> Since the Kconfig language replace traditional CONFIG_* in
>> default-config/%-softmmu.mak, the %-softmmu.mak file only
>> define embeded boards or machines, like 440fx and Q35 in x86_64
>> platform. The Kconfig has already defined dependency topology
>> between different Kconfig files, but there are still some issues
>>
>> (*) Kconfig for configure(config-host.mak)
>>     Some CONFIG* in configure  need some logic to generate, those
>>     are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
>>
>> (*) Kconfig for %config-target.mak
>>     The CONFIG* in %/config-target.mak file, this is still related
>>     with configure.
>>
>> (*) randconfig support issue.
>>
>> Before this RFC patches, we have talked Kconfig in another thread
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
>>
>> Please give your comments on this RFC thread, many thanks!
>
> I started looking at this, and found two bugs in current code
> (unreachable devices that shouldn't be there - SERIAL_ISA for ARM,
> ACPI_NVDIMM for MIPS).  There are a few issues in that the script is not

The ACPI_NVDIMM for MIPS is pulled in by CONFIG_VT82C686 which needs ACPI 
which needs NVDIMM even though it's probably not used. At least I think 
so, I haven't tested if it could be removed.

Regards,
BALATON Zoltan

> Python 3-enabled and only x86 compiles, but they are easily fixed.  A
> slightly bigger thing is to make VFIO configuration more fine-grained
> and express it with kconfig dependencies, but it's just a couple patches
> in the same spirit as these ones.  I'll look at randconfig next.
>
> Paolo
>
>
