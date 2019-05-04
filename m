Received: from eggs.gnu.org ([209.51.188.92]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMvU0-0005IF-FP
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMvTy-0006Nm-Uh
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMvTy-0006N3-Of
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v189so1507077wmf.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 07:17:41 -0700 (PDT)
References: <20190504123538.14952-1-philmd@redhat.com>
	<ffe3d73d-b9a2-a0e3-6dee-222a3d87cc28@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b10a02d5-e54a-7dd5-4e7e-3a39b3fd0b1a@redhat.com>
Date: Sat, 4 May 2019 16:17:39 +0200
MIME-Version: 1.0
In-Reply-To: <ffe3d73d-b9a2-a0e3-6dee-222a3d87cc28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/net/ne2000: Extract the PCI device from
 the chipset common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 5/4/19 4:09 PM, Thomas Huth wrote:
> On 04/05/2019 14.35, Philippe Mathieu-Daudé wrote:
>> The ne2000.c file contains functions common the the ISA and PCI
>> devices. To allow to build with one or another, extract the PCI
>> specific part into a new file.
>>
>> This fix an issue where the NE2000_ISA Kconfig had to pull the
>> full PCI core objects.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/net/Kconfig       |   7 ++-
>>  hw/net/Makefile.objs |   3 +-
>>  hw/net/ne2000-pci.c  | 132 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/net/ne2000.c      | 105 ----------------------------------
>>  4 files changed, 139 insertions(+), 108 deletions(-)
>>  create mode 100644 hw/net/ne2000-pci.c
>>
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 7d7bbc5d7c9..4ef86dc3a53 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -1,10 +1,14 @@
>>  config DP8393X
>>      bool
>>  
>> +config NE2000_COMMON
>> +    bool
> 
> I'd maybe rather simply name it "NE2000" instead of "NE2000_COMMON", but
> that's just a matter of taste.

I started using this name, but then realized it is confuse and someone
could enable CONFIG_NE2000=y expecting a network device, but none would
be linked.

Paolo, would it be useful to add some 'internal' Kconfig property (like
"default")? So that config is not user-selectable, but only
dependency-selectable. CONFIG_ARM_V7M might be a similar example (we
don't want the user to unselect it).

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
