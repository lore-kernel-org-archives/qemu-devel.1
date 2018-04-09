Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5a04-0000M3-Sr
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Zzy-000679-LA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:50:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5Zzy-00066h-G6
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:50:30 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
Date: Mon, 9 Apr 2018 18:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 04/09/18 10:19, Gerd Hoffmann wrote:
>>> +{ 'enum' : 'SystemFirmwareType',
>>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>>
>> The naming here is quite a bad mixture between firmware interface
>> ('bios', 'uefi') and firmware implementations ('slof', 'uboot'). There
>> could be other implementations of BIOS or UEFI than SeaBIOS and EDK2 ...
>> so I'd suggest to rather name them 'seabios' and 'edk2' here instead.
> 
> uboot for example implements uefi unterfaces too (dunno how complete,
> but reportly recent versions can run uefi shell and grub just fine).

Indeed: when I was struggling with this enum type and tried to look for
more firmware types to add, my googling turned up the "UEFI on Top of
U-Boot" whitepaper, from Alex and Andreas :)

Again, this reaches to the root of the problem: when a user creates a
new domain, using high-level tools, they just want to tick "UEFI". (Dan
has emphasized this to me several times, so I think I get the idea by
now, if not the full environment.) We cannot ask the user, "please be
more specific, do you want UEFI from edk2, or UEFI on top of U-Boot?"

Instead, each of those firmware images will have to come with a JSON
document that states "uefi" in SystemFirmware.type, and the host admin
will be responsible for establishing a priority order between them.
Then, when the user asks for "UEFI" (and no more details), they'll get
(compatibly with the target architecture) whichever firmware the host
admin marked as "higher priority".

(Please be aware that with this argument, I'm trying to put myself into
Dan's shoes. It doesn't come *naturally* to me; in fact I'm viscerally
screaming inside at this amount of "fuzz". Personally I'd say, "I can
give you what you *say*, not what you *mean*, so *say* what you mean".
Apparently, that cannot work here, because what users mean is "UEFI" and
nothing more. I have to accept that.)

Thanks
Laszlo
