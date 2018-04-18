Received: from eggs.gnu.org ([2001:4830:134:3::10]:52433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8lZe-0007vl-U3
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8lZb-0003R1-N4
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:48:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8lZb-0003Qt-HV
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:48:27 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
Date: Wed, 18 Apr 2018 13:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 11:04, Gerd Hoffmann wrote:
>> This surfaced in the RFCv1 discussion, but Daniel suggested ignoring
>> version numbers:
>>
>> http://mid.mail-archive.com/20180410093412.GI5155@redhat.com
>>
>> On 04/10/18 11:34, Daniel P. Berrang=C3=A9 wrote:
>>> IMHO it would be valid to just keep life simple and only record the
>>> base machine type name that can use the firmware ie "pc", "q35", and
>>> ignore the fact that in some cases the firmware might require a
>>> specific version of the machine type.
>=20
> IIRC this bit referes to the fact that SMM requires qemu >=3D 2.x (don'=
t
> remember which x) to work.  So smm-enabled edk2 would just say
> "pc-q35-*" instead of trying to specifying a version range somehow.

OK. I'm fine either way; Dan, can you please confirm you are OK with the
suggested wildcard format? (I.e., we still shouldn't include actual
version numbers in the supported machtypes list, but we should be more
specific than just "pc" and "q35" -- if the machine type is versioned,
use an asterisk for covering the version number.)

>> Continuing:
>>
>> On 04/18/18 08:02, Gerd Hoffmann wrote:
>>>> +# @secure-boot: The firmware implements the software interfaces for=
 UEFI Secure
>>>> +#               Boot, as defined in the UEFI specification. Note th=
at without
>>>> +#               @requires-smm, guest code running with kernel privi=
leges can
>>>> +#               undermine the security of Secure Boot.
>>>> +#
>>>> +# @secure-boot-enrolled-keys: The variable store (NVRAM) template a=
ssociated
>>>
>>> I think "enrolled-keys" should better be a separate feature.
>>
>> It's not possible from the edk2 side; without -D SECURE_BOOT_ENABLE, t=
he
>> SB-related variables (SetupMode, PK, KEK, ...) don't work at all.
>=20
> Sure.  The firmware builds will advertise both "secure-boot" and
> "enrolled-keys" features to specify that.
>=20
> But I think it should be enough to check for "secure-boot" feature to
> figure whenever a given firmware build supports secure boot, not both
> "secure-boot" and "secure-boot-plus-something-else".

Hmmm, I'm not sure I agree. One use case is that you want a domain
config in which well-known OS-es, signed by the MS UEFI certs, just boot
with SB enabled. (Some of our internal folks really want this.)

Another use case is that you want a domain in which SB *can* be enabled,
but your installer is signed with a different certificate chain (or it
is unsigned), and with *just* the MS certs enrolled, it wouldn't boot at
all. So you want the SB *feature*, but definitely not the initial
enrollment / SB *operational mode*.

For me to understand you better, are you suggesting merely that I:

- rename @secure-boot-enrolled-keys to @enrolled-keys, and

- drop the reference to @secure-boot from the end of the @enrolled-keys
  documentation paragraph? (Namely, "@secure-boot-enrolled-keys is only
  valid if the firmware also supports @secure-boot").

Or are you suggesting something more?

Thanks!
Laszlo
