Received: from eggs.gnu.org ([2001:4830:134:3::10]:40986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8iVs-0003CK-51
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8iVo-0006zT-78
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:32:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8iVo-0006yw-1Z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:32:20 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
Date: Wed, 18 Apr 2018 10:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 08:02, Gerd Hoffmann wrote:
> On Wed, Apr 18, 2018 at 12:40:54AM +0200, Laszlo Ersek wrote:
>> Add a schema that describes the different uses and properties of
>> virtual machine firmware.
>
> Looks good to me overall.
>
>> +{ 'enum' : 'FirmwareType',
>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
>
> openbios missing.
>
>> +{ 'enum' : 'FirmwareArchitecture',
>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }
>
> ppc(64) missing (but you have slof above ;) ...
> s390 too.

I figured those would be contributed by people that actually use them,
as separate patches :) In fact I would rather prefer removing "slof" and
"uboot" from this initial version, because I have zero clue about them.

Of course, if reviewers can tell me what *exact* enum constants I should
add, I'll comply.

>> +# @machines: Lists the machine types (known by the emulator that is s=
pecified
>> +#            through @architecture) that can execute the firmware. El=
ements of
>> +#            @machines are not supposed to be versioned; if a machine=
 type is
>> +#            versioned in QEMU (e.g. "pc-i440fx-2.12"), then its unve=
rsioned
>> +#            variant, which typically refers to the latest version (e=
.g. "pc"),
>> +#            should be listed in @machines. On the QEMU command line,=
 "-machine
>> +#            type=3D..." specifies the requested machine type.
>
> Hmm, I'd tend to ignore the aliases here (pc, q35, virt) and use
> wildcards instead (pc-i440fx-*, pc-q35-*, virt-*).
>
> I think that will be easier for libvirt to work with because it always
> resolves aliases to actual machine types when storing them in the
> domain xml.

This surfaced in the RFCv1 discussion, but Daniel suggested ignoring
version numbers:

http://mid.mail-archive.com/20180410093412.GI5155@redhat.com

On 04/10/18 11:34, Daniel P. Berrang=C3=A9 wrote:
> IMHO it would be valid to just keep life simple and only record the
> base machine type name that can use the firmware ie "pc", "q35", and
> ignore the fact that in some cases the firmware might require a
> specific version of the machine type.

Continuing:

On 04/18/18 08:02, Gerd Hoffmann wrote:
>> +# @secure-boot: The firmware implements the software interfaces for U=
EFI Secure
>> +#               Boot, as defined in the UEFI specification. Note that=
 without
>> +#               @requires-smm, guest code running with kernel privile=
ges can
>> +#               undermine the security of Secure Boot.
>> +#
>> +# @secure-boot-enrolled-keys: The variable store (NVRAM) template ass=
ociated
>
> I think "enrolled-keys" should better be a separate feature.

It's not possible from the edk2 side; without -D SECURE_BOOT_ENABLE, the
SB-related variables (SetupMode, PK, KEK, ...) don't work at all. For
example, if you try to run "EnrollDefaultKeys.efi" on an OVMF that was
built without SB, you get:

> FS1:\> EnrollDefaultKeys.efi
> error: GetVariable("SetupMode", 8BE4DF61-93CA-11D2-AA0D-00E098032B8C): =
Not Found

In other words, I don't see any use in a @Firmware element where
@nvram_template had the SB operational mode enabled and certificates
enrolled (hence listing the proposed @enrolled-keys in @features), while
@executable lacked the SB feature itself (hence not listing @secure-boot
in @features). In the first place, such a varstore file (to be saved as
@nvram_template) could never be *established* from within the guest,
using the @executable in question -- see the error message above.

Thanks!
Laszlo
