Received: from eggs.gnu.org ([2001:4830:134:3::10]:41216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f94JN-0002wY-UF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f94JJ-0000Iq-V0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:48:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f94JJ-0000IZ-PN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:48:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
Date: Thu, 19 Apr 2018 09:48:36 +0200
In-Reply-To: <8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com> (Laszlo Ersek's
	message of "Wed, 18 Apr 2018 13:35:17 +0200")
Message-ID: <87in8nvdpn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/18/18 10:47, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>
>>> +##
>>> +# @FirmwareArchitecture:
>>> +#
>>> +# Defines the target architectures (emulator binaries) that firmware may
>>> +# execute on.
>>> +#
>>> +# @aarch64: The firmware can be executed by the qemu-system-aarch64 emulator.
>>> +#
>>> +# @arm: The firmware can be executed by the qemu-system-arm emulator.
>>> +#
>>> +# @i386: The firmware can be executed by the qemu-system-i386 emulator.
>>> +#
>>> +# @x86_64: The firmware can be executed by the qemu-system-x86_64 emulator.
>>> +#
>>> +# Since: 2.13
>>> +##
>>> +{ 'enum' : 'FirmwareArchitecture',
>>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }
>> 
>> Partial dupe of CpuInfoArch from misc.json.  Neither covers all our
>> target architectures.  Should we have one that does in common.json
>> instead?
>
> If we had one there, I'd use it here :)
>
> For collecting the arch identifiers, is it OK to run "./configure
> --help", and look for the "*-softmmu" options under
> "--target-list=LIST"? Because that's what I need here; the qemu-system-*
> emulators.

configure gets its list like this:

    default_target_list=""

    mak_wilds=""

    if [ "$softmmu" = "yes" ]; then
        mak_wilds="${mak_wilds} $source_path/default-configs/*-softmmu.mak"
    fi
    if [ "$linux_user" = "yes" ]; then
        mak_wilds="${mak_wilds} $source_path/default-configs/*-linux-user.mak"
    fi
    if [ "$bsd_user" = "yes" ]; then
        mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
    fi

    for config in $mak_wilds; do
        default_target_list="${default_target_list} $(basename "$config" .mak)"
    done

Since we use QMP only in system emulation, a QAPI enum limited to the
system emulation targets makes sense.

Replacing CpuInfoArch by such an enum will change the discriminator
value from "other" to the real architecture, with the obvious
compatibility concerns.  But we've accepted similar changes twice
already: commit 9d0306dfdfb and commit 25fa194b7b1, both v2.12.0-rc0.

"other" was a bad idea.  Hindsight 20/20.

Getting rid of it in one go rather than piecemeal seems like the least
bad way out.  Too late for 2.12, though.  Eric, what do you think?

[...]
