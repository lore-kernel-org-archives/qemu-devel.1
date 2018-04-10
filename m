Received: from eggs.gnu.org ([2001:4830:134:3::10]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5rpu-0000f7-QJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5rpr-0001ya-M4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:53:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5rpr-0001yM-Gc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:53:15 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
	<8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
	<20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
	<dc439111-4161-96e6-5b45-4dcee886427d@redhat.com>
	<74f1de8d-d1b0-fe55-5809-29e133279c37@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <be948f6f-5296-cc8d-059d-21a7f68bc847@redhat.com>
Date: Tue, 10 Apr 2018 13:53:06 +0200
MIME-Version: 1.0
In-Reply-To: <74f1de8d-d1b0-fe55-5809-29e133279c37@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 04/10/18 11:26, Thomas Huth wrote:
> On 10.04.2018 11:16, Laszlo Ersek wrote:
>> On 04/10/18 08:27, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>> - I considered adding wildcards (say, blacklist "all" i440fx machtypes,
>>>> present and future, for SMM-requiring OVMF builds), but then you get
>>>> into version sorting and similar mess. I considered fnmatch() --
>>>> basically simple ? and * wildcards -- but that's not expressive enough.
>>>
>>> I'd suggest whitelist with wildcards.  So the smm builds would get
>>> "pc-q35-*".
>>>
>>> libvirt knows about aliases, so it should be able to handle the "q35"
>>> shortcut like "pc-q35-${latest}".
>>>
>>> Or do you see another issue?
>>
>> Well, one issue I see is version sorting; I should say "Q35 but no
>> earlier than 2.4", and lexicographically, "2.11" sorts before "2.4".
>>
>> Anyway (also asking for Thomas's input here): if we run with your idea
>> to refer to exact mapping methods / firmware *implementation* types that
>> we know libvirt implements / supports as a "white box", do we still deem
>> machine type identification necessary? Because, libvirt already knows
>> (for example) that "ovmf_smm" requires pc-q35-2.4 or later. So we just
>> have to make a *reference* to that knowledge in the JSON file.
> 
> I think you really need a way to specify the machine there. Latest
> example from QEMU 2.12: We've now got two uboot binaries in the tree,
> pc-bios/u-boot.e500 and pc-bios/u-boot-sam460-20100605.bin. Both are
> uboot, both are for ppc, but u-boot.e500 only works with the "ppce500"
> machine and the other one only works with the "sam460ex" machine. How
> would you teach libvirt such a relationship without an explicit machine
> type identification field there?

My idea was to assign different "map method" enumeration constants to
them, and libvirtd would associate those with different machtype
requirements.

But, as Daniel explained, we cannot reference libvirtd features, so I
agree we have to express machine types somehow. I don't know how though.

For example, can we take it for granted that a machtype version number,
if it exists in the first place, always follows the last hyphen in the
machtype identifier? Say, "virt-2.11" / aarch64 conforms, "pc-q35-2.4"
and "pc-i440fx-2.12" conform too. But, is that a guarantee that covers
all arches and all boards?

Because, I don't think:
- machine-type-family = q35
- minimum-machine-type = 2.4

will work. Will every application that manages QEMU learn that "q35" is
short-hand for "pc-q35-XXX", and (again) that 2.12 sorts *after* 2.4?

Thanks,
Laszlo
