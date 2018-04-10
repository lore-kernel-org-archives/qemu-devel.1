Received: from eggs.gnu.org ([2001:4830:134:3::10]:52664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5pFx-0000A6-SW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5pFu-0004ki-Hj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:08:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5pFu-0004k7-B5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:07:58 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
	<20180410055914.3ak6niwxjkpph26u@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <52191fc3-e4d1-e780-47a1-311df2a2f99e@redhat.com>
Date: Tue, 10 Apr 2018 11:07:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180410055914.3ak6niwxjkpph26u@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 04/10/18 07:59, Gerd Hoffmann wrote:
>   Hi,
> 
>> I threw in "-kernel" because, although it also (usually?) means
>> "memory", I expected people would want it separate.
>>
>> Regarding memory vs. pflash, I thought that these two, combined with the
>> access permissions, could cover all of RAM, ROM, and read-only and
>> read-write pflash too.
>>
>> So, "-bios" (-> ROM) boils down to "memory", with write access denied --
>> please see the SeaBIOS example near the end.
> 
> Hmm, I'm wondering whenever it is useful to model things this way.  It's
> not like you can actually configure things for -bios seabios.rom or
> -kernel uboot.elf.  Only pflash allows to actually configure things, and
> there are not that many useful combinations.  The code needs
> Read+Execute.  Allowing Write could be useful in theory, to allow the
> guest doing firmware updates.  But I think nobody actually does that, so
> in practice it is fixed.  The varstore can have different permissions,
> but it's only two useful combinations.  Either allow access
> unconditionally, or allow access in secure contect (aka smm) only.

(I hope I understand your point right:)

I'm also fine if we simply define a fixed (but extensible) set of
mapping methods, basically a new enum type, that simply tells libvirtd
what this firmware *is*. IOW, directly reference a mapping method we
know libvirt implements, rather than give vague hints.

This could repurpose SystemFirmwareType, but it should become more
detailed. I'm thinking like:
- ovmf: split files without requiring SMM
- ovmf_smm: split files with SMM requirement
- seabios: exactly that
- ... other things others suggest.

So "ovmf" would refer precisely to point (3) in my email
<http://mid.mail-archive.com/3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>,
and "ovmf_smm" would refer to point (4) in that email.

Let me post the next version soon with this idea, focusing just on OVMF
and maybe SeaBIOS. Then let us see if that RFCv2 format lends itself
easily to extensions by Thomas. :)

Thanks!
Laszlo
