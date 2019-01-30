Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gooH9-00014m-BI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gooH7-0000bT-J2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:43:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gooH7-0000Z5-7K
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:43:25 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<815dd9b2-f2fb-40d1-67c1-9862e05f6b22@redhat.com>
	<0390e138-dc06-f82b-7867-c29e9be2e4fb@redhat.com>
	<819e9476-cb5d-e4c8-71b8-de22c8d2e6a2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86830f34-d777-61b4-474e-053a97dfc718@redhat.com>
Date: Wed, 30 Jan 2019 12:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <819e9476-cb5d-e4c8-71b8-de22c8d2e6a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 30/01/19 12:32, Thomas Huth wrote:
> Oh, I thought this was for convenience. So for s390x, the main problem is
> AFAIK that the architecture does not support LSI, so all devices that
> require LSI can not work here. Maybe we should introduce a "LSI" switch
> instead, so that the boards which provide LSI can select it, and all normal
> PCI devices (at least the ones that do not work with MSI only) would
> "depend on LSI", too?

Makes sense (I would call it "depends on PCI_INTX", or even make it a
negative "depends on !NO_PCI_INTX" that would only be selected by s390).

Another idea is to provide an alternative way

    config X
        imply Y

to write

    config Y
        default y if X

("imply" was added a year or two ago to Kconfig).  This would simplify
writing the configuration for variables such as CONFIG_PCI_DEVICES, and
it would also be useful to express soft dependencies such as

    config PC
        imply PCI_DEVICES
        imply QXL

    config Q35
        imply VTD

etc.  This can be left for future work though.

>> Is there a use case for disabling
>> CONFIG_ISA_DEVICES but not wanting to base your configuration on
>> "allnoconfig"?
> 
> "make allnoconfig" is not working for me yet:
> 
> make MINIKCONF="python -B /home/thuth/devel/qemu/scripts/minikconf.py  --" config-all-devices.mak
> make[1]: Entering directory `/tmp/qemu-kconfig'
>   GEN     x86_64-softmmu/config-devices.mak.tmp
> /home/thuth/devel/qemu/scripts/minikconf.py: invalid option --
> 
> So I disabled PCI_DEVICES here intead for my tests for the hard
> requirements, and then I ran into this error:
> 
> hw/net/ne2000-isa.c:65: undefined reference to `ne2000_setup_io'
> hw/net/ne2000-isa.c:71: undefined reference to `ne2000_reset'
> ../hw/net/ne2000-isa.o:(.data.rel+0x1d0): undefined reference to `vmstate_ne2000'
> ../hw/net/ne2000-isa.o:(.data.rel+0x270): undefined reference to `ne2000_receive'
> 
> That's why I thought a CONFIG_ISA_DEVICES switch would be good, too.
> But we likely should simply fix the dependency of the NE2000_ISA switch
> instead.

Ok!

Paolo
