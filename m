Received: from eggs.gnu.org ([2001:4830:134:3::10]:60280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9YXK-0001Sf-9e
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9YXD-0003sb-Ti
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:05:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9YXD-0003rL-Og
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:05:15 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org> <20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
	<87muxyyr82.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8fc9f287-c0c1-45c1-b46c-64f479b12723@redhat.com>
Date: Fri, 20 Apr 2018 18:04:59 +0200
MIME-Version: 1.0
In-Reply-To: <87muxyyr82.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 04/20/18 14:53, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:

[snip]

>> The targets with softmmu are: aarch64, alpha, arm, cris, hppa, i386,
>> lm32, m68k, microblaze, microblazeel, mips, mips64, mips64el, mipsel,
>> moxie, nios2, or1k, ppc, ppc64, ppcemb, riscv32, riscv64, s390x, sh4,
>> sh4eb, sparc, sparc64, tricore, unicore32, x86_64, xtensa, xtensaeb.
>>
>> That is, at least the following constants in CpuInfoArch have no
>> corresponding (identical) mapping -- I'll state to the right of the
>> arrow the emulation targets which I know or presume to be associated
>> with the CpuInfoArch constant:
>> - x86 -> i386, x86_64
>> - sparc -> sparc, sparc64
>> - ppc -> ppc, ppc64, ppcemb
>> - mips -> mips, mips64, mips64el, mipsel
>> - s390 -> s390x
>> - riscv -> riscv32, riscv64
>>
>> The only constant that seems to have a 1:1 mapping is "tricore", but I
>> could perfectly well be thinking even that just because I have no clue
>> about "tricore".
>>
>> So, I don't think CpuInfoArch can be updated so that it both remains
>> compatible with current QMP clients, and serves "firmware.json". In the
>> firmware schema we don't just need CPU architecture, but actual emulator
>> names (and board / machine types).
> 
> The completely orthodox fix for CpuInfo would be:
> 
> * Keep @arch unchanged.  In particular, keep "other" for all targets
>   other than 'x86', 'sparc', 'ppc', 'mips', 'tricore'.
> 
> * Add a new member @target of new enum type Target, whose values match
>   configures idea of targets exactly.
> 
> * Make the new member the union tag.
> 
> It's too late for complete orthodoxy; we already changed @arch.
> 
> A common enum type Target makes sense anyway, I think.
> 
> Using it in CpuInfo as described above may make sense, too.  Could be
> left to a follow-up patch.
> 
>> I grepped 'qapi/*json' for the whole word "x86_64", and the only thing
>> that remotely matches is the @TargetInfo structure, in which the @arch
>> field is a string, coming with the example "x86_64". The example also
>> names "i386" separately.
> 
> Well spotted.
> 
> TargetInfo member @arch is set to TARGET_NAME, which matches configure's
> idea of the target.  If we add enum Target, we should change @arch's
> type from str to Target.
> 
>> So what might make sense is to introduce a separate enum in
>> "qapi/misc.json" with all the softmmu targets I listed above, and change
>> the type of @TargetInfo.@arch to that enum.
> 
> I arrived at this conclusion, too.
> 
>>                                             In parallel,
>> qmp_query_target() would have to be updated to look up the enum value
>> matching TARGET_NAME. (I do think we can ignore linux-user etc emulators
>> for collecting the relevant arches here: @TargetInfo is only used in the
>> "query-target" QMP command, and Markus said above that QMP is only used
>> with system emulation.)
>>
>> Should I do this?
> 
> Yes, please.

OK, so here's my understanding:

(1) I'll introduce a new @Target enum in misc.json. I'll inherit /
include it in firmware.json. This is compatible with what Dan said.

(2) I'll change @TargetInfo.@arch to the new type. I believe this will
break the compilation of qmp_query_target(); I'll hack on that until it
builds again, with the lookup. :)

(3) Regarding the addition of @target to CpuInfo (accompanying @arch)
doesn't look hard; what *does* look hard is changing the union
discriminator from @arch to @target. @target has many more values, and I
would have to map all of them to the (fewer) @arch values that currently
do *not* select @CpuInfoOther. Here's an example:

- Both @i386 and @x86_64 from @target mean @x86 in @arch,
- because @x86 currently selects @CpuInfoX86, not @CpuInfoOther,
  both @i386 and @x86_64 must be assigned @CpuInfoX86.

This depends on the knowledge that "x86" actually *means* "i386 plus
x86_64", and I totally don't have that knowledge for the rest of the
arches / targets.

So, the modification of @CpuInfo I would indeed like to pass off to
someone else. (Well, if all the architecture maintainers follow up and
tell me what emulators exactly fall under the umbrella of each
individual @arch value, I can post the patch.) BTW... I wonder how
compatibility would be affected if we just added @target to @CpuInfo,
even without making it the new discriminator.

... Anyway, I think I've gotten a huge amount of useful and actionable
feedback; thanks everyone, let me work on RFCv3 and post it soon. :)

Thanks!
Laszlo
