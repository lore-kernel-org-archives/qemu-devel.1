Received: from eggs.gnu.org ([2001:4830:134:3::10]:57212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSjeW-0007kr-OU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSjeR-0006K0-Sl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:43:32 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSjeR-0006JP-NF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:43:27 -0400
Received: by mail-wm0-f43.google.com with SMTP id i127so165484571wma.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 05:43:27 -0700 (PDT)
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com> <20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <198fdd58-7793-8990-8adc-989c189ba529@redhat.com>
Date: Wed, 5 Jul 2017 14:43:24 +0200
MIME-Version: 1.0
In-Reply-To: <c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org

On 05/07/2017 13:58, Thomas Huth wrote:
> On 05.07.2017 13:44, Fam Zheng wrote:
>> On Wed, 07/05 12:04, Daniel P. Berrange wrote:
>>> While you can say people should just add '-M pc' that isn't a nice
>>> user experiance, because it makes the assumption that people actually
>>> understand what caused their breakage. When the incompatibilities
>>> arise the error messages are unlikely to give any hint to users that
>>> the problems are caused by the machine type change. So unless someone
>>> is very familiar with debugging QEMU, they're not going to realize
>>> that '-M pc' will fix their problem.
>>
>> While we change the default, can we start to print a message like 'machine type
>> ("-M" option) not specified, default to Q35. If you find compatibility issues,
>> try "-M pc"'?
> 
> Or we could simply remove the default machine type completely for a
> couple of releases? That would force people to update their script with
> "-M pc" ... and once this has been established, we can finally make q35
> the default?

Apart from the user experience issues pointed out by Fam, this would
lead to people using "-M pc" without understanding it, and not being
able to use q35 features.

I think there are two cases:

- if we are worried about command-line users' IDE VMs not booting after
the q35 upgrade (because the PATA adapter becomes SATA/AHCI), we cannot
change the default in QEMU, period.  This would affect at least Windows
VMs; Fedora and derivatives should have both ATA_PIIX and SATA_AHCI as
built-in drivers, I don't know about Debian derivatives and e.g. Gentoo.

- if we are not, and we think q35 is okay for every new VM except
Windows 95 or 2003, we can change the default to "-M q35".  Windows 95
and 2003 users can be asked to add "-M pc".

In the second case, libvirt could still switch from pc to q35 and/or
libosinfo could be changed to suggest q35 instead of pc.

If possible, NICs should keep the same PCI address after upgrade.

Paolo
