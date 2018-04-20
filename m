Received: from eggs.gnu.org ([2001:4830:134:3::10]:47148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9VXS-0000xo-2o
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9VXO-0002Z6-Vn
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:53:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9VXO-0002Yc-RO
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:53:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org>
	<20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
Date: Fri, 20 Apr 2018 14:53:01 +0200
In-Reply-To: <5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com> (Laszlo Ersek's
	message of "Thu, 19 Apr 2018 10:39:32 +0200")
Message-ID: <87muxyyr82.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/19/18 09:56, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Apr 19, 2018 at 09:48:36AM +0200, Markus Armbruster wrote:
>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>
>>>> On 04/18/18 10:47, Markus Armbruster wrote:
>>>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>>
>>>>>> +##
>>>>>> +# @FirmwareArchitecture:
>>>>>> +#
>>>>>> +# Defines the target architectures (emulator binaries) that firmwar=
e may
>>>>>> +# execute on.
>>>>>> +#
>>>>>> +# @aarch64: The firmware can be executed by the qemu-system-aarch64=
 emulator.
>>>>>> +#
>>>>>> +# @arm: The firmware can be executed by the qemu-system-arm emulato=
r.
>>>>>> +#
>>>>>> +# @i386: The firmware can be executed by the qemu-system-i386 emula=
tor.
>>>>>> +#
>>>>>> +# @x86_64: The firmware can be executed by the qemu-system-x86_64 e=
mulator.
>>>>>> +#
>>>>>> +# Since: 2.13
>>>>>> +##
>>>>>> +{ 'enum' : 'FirmwareArchitecture',
>>>>>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }
>>>>>
>>>>> Partial dupe of CpuInfoArch from misc.json.  Neither covers all our
>>>>> target architectures.  Should we have one that does in common.json
>>>>> instead?
>>>>
>>>> If we had one there, I'd use it here :)
>>>>
>>>> For collecting the arch identifiers, is it OK to run "./configure
>>>> --help", and look for the "*-softmmu" options under
>>>> "--target-list=3DLIST"? Because that's what I need here; the qemu-syst=
em-*
>>>> emulators.
>>>
>>> configure gets its list like this:
>>>
>>>     default_target_list=3D""
>>>
>>>     mak_wilds=3D""
>>>
>>>     if [ "$softmmu" =3D "yes" ]; then
>>>         mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-softmm=
u.mak"
>>>     fi
>>>     if [ "$linux_user" =3D "yes" ]; then
>>>         mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-linux-=
user.mak"
>>>     fi
>>>     if [ "$bsd_user" =3D "yes" ]; then
>>>         mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-us=
er.mak"
>>>     fi
>>>
>>>     for config in $mak_wilds; do
>>>         default_target_list=3D"${default_target_list} $(basename "$conf=
ig" .mak)"
>>>     done
>>>
>>> Since we use QMP only in system emulation, a QAPI enum limited to the
>>> system emulation targets makes sense.
>>>
>>> Replacing CpuInfoArch by such an enum will change the discriminator
>>> value from "other" to the real architecture, with the obvious
>>> compatibility concerns.  But we've accepted similar changes twice
>>> already: commit 9d0306dfdfb and commit 25fa194b7b1, both v2.12.0-rc0.
>>>
>>> "other" was a bad idea.  Hindsight 20/20.
>>>
>>> Getting rid of it in one go rather than piecemeal seems like the least
>>> bad way out.  Too late for 2.12, though.  Eric, what do you think?
>>=20
>> Given the context in which this "other" value is used, I think it is
>> reasonable to kill it and put a full arch list in there.
>>=20
>> No app is likely to be accessing the struct under "other" because it
>> is just an empty placeholder.
>
> Commit 9d0306dfdfb added "s390" and "CpuInfoS390", which I guess had the
> potential to confuse QMP clients that didn't expect "s390", but
> otherwise it didn't mess with preexistent enum values / structures.
>
> The same applies to commit 25fa194b7b1, just with "riscv" /
> "CpuInfoRISCV" substituted.
>
> Removing "other" might confuse QMP clients that expect it, except
> (according to Daniel) no such client exists, probably.

It's a done deal anyway; we're not going to hold 2.12 to avoid this QMP
compatibility break.

> However, replacing the current list of CpuInfoArch constants with the
> system emulation target list would be more intrusive than all three of
> the above. In particular there is no "x86" target; only i386 and x86_64
> targets exist. For the firmware schema, this distinction is important,
> but it would break QMP clients that expect "x86" (and such clients must
> certainly exist).

You're right.  Another nice mess.

> The targets with softmmu are: aarch64, alpha, arm, cris, hppa, i386,
> lm32, m68k, microblaze, microblazeel, mips, mips64, mips64el, mipsel,
> moxie, nios2, or1k, ppc, ppc64, ppcemb, riscv32, riscv64, s390x, sh4,
> sh4eb, sparc, sparc64, tricore, unicore32, x86_64, xtensa, xtensaeb.
>
> That is, at least the following constants in CpuInfoArch have no
> corresponding (identical) mapping -- I'll state to the right of the
> arrow the emulation targets which I know or presume to be associated
> with the CpuInfoArch constant:
> - x86 -> i386, x86_64
> - sparc -> sparc, sparc64
> - ppc -> ppc, ppc64, ppcemb
> - mips -> mips, mips64, mips64el, mipsel
> - s390 -> s390x
> - riscv -> riscv32, riscv64
>
> The only constant that seems to have a 1:1 mapping is "tricore", but I
> could perfectly well be thinking even that just because I have no clue
> about "tricore".
>
> So, I don't think CpuInfoArch can be updated so that it both remains
> compatible with current QMP clients, and serves "firmware.json". In the
> firmware schema we don't just need CPU architecture, but actual emulator
> names (and board / machine types).

The completely orthodox fix for CpuInfo would be:

* Keep @arch unchanged.  In particular, keep "other" for all targets
  other than 'x86', 'sparc', 'ppc', 'mips', 'tricore'.

* Add a new member @target of new enum type Target, whose values match
  configures idea of targets exactly.

* Make the new member the union tag.

It's too late for complete orthodoxy; we already changed @arch.

A common enum type Target makes sense anyway, I think.

Using it in CpuInfo as described above may make sense, too.  Could be
left to a follow-up patch.

> I grepped 'qapi/*json' for the whole word "x86_64", and the only thing
> that remotely matches is the @TargetInfo structure, in which the @arch
> field is a string, coming with the example "x86_64". The example also
> names "i386" separately.

Well spotted.

TargetInfo member @arch is set to TARGET_NAME, which matches configure's
idea of the target.  If we add enum Target, we should change @arch's
type from str to Target.

> So what might make sense is to introduce a separate enum in
> "qapi/misc.json" with all the softmmu targets I listed above, and change
> the type of @TargetInfo.@arch to that enum.

I arrived at this conclusion, too.

>                                             In parallel,
> qmp_query_target() would have to be updated to look up the enum value
> matching TARGET_NAME. (I do think we can ignore linux-user etc emulators
> for collecting the relevant arches here: @TargetInfo is only used in the
> "query-target" QMP command, and Markus said above that QMP is only used
> with system emulation.)
>
> Should I do this?

Yes, please.
