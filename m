Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A263C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E708B2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTlyn18b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E708B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxUI-0001Aq-4F
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIxTV-0000Lk-K5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIxTT-0002cY-R1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:41:21 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIxTT-0002bN-DH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:41:19 -0400
Received: by mail-ot1-x342.google.com with SMTP id r19so12907891otn.7
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pziit0ywMJXo6zW7dH47iRdtfxoC3d6yj8KaYdXDC/E=;
 b=YTlyn18b8UIwL5XcdTm0FD3gJokYcaL9GrAdkPH0IRVyNfdoqpvfT2S634EOv/lgKF
 1ExQ+MdCfpDYd7rfhZWubGkmesbxcdPAiERzlXXU7uJazwEvXgWaUzGz1q99hZZjXA+t
 PHa2EwujabqBF+eT0F0vZPX5E7L6B0TzOUhhA8b/YDne/nENbMytECGLHMWunYqdIT3A
 GIttaeshJFxytzeCTyNXRyNQ6pfrI41B4JK1MQd1daWpoHIVcekA+mNr/j137ddO/P12
 0zjGTPfIxFEuTFsBcdebPuk2c7jzy5tYZa3qi6SIiClY6S89RtqsqQXLx28vUzF2VE++
 REUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pziit0ywMJXo6zW7dH47iRdtfxoC3d6yj8KaYdXDC/E=;
 b=HVxGcQ9eu7sd+XfPJDuC+585B3TJtndVdECZTaMwDhCrpS2WgEMjD+vekoxRSvynef
 WkajIUZ5afETuZWUxFqoCwvr8k06U09QjkJabqVUOvBbfz829DGfV4mELJipT3CXXGPV
 7OTX+4k8Tc5N62Q+jq7ZGADuQfuLLutXawUqaRXKUtGRFwiNcTDjZTXEJaRgYJF7FKl0
 Moa1f/x18bHYvOLvqXiV/RCGxCQmo9qaRvBDiPBQoX0HTa6sFQoXoJ3d8XxfVgBoJdOI
 cOBp1BHl0cg7Eti9J0UDX6o4pxbjbWFY8WnHGbW/v1x0af1eqQNHgoPgyqeFtagEFWtq
 5xKA==
X-Gm-Message-State: ANhLgQ3EAwKb4zjZ8THjpYaiS0rBN4GvFelPj2TKwmbz8ao5BAgyyoLK
 mCqkWZS1+0Mkiw1qklbY1LElZ5DmAopdnfhOI6/Z9g==
X-Google-Smtp-Source: ADFU+vvhxVAL8hlgp7KES036l3wzu0KvcnXKlqBud3uWU5JdmQNeJRF4MKO1RO3mh+4JO9G6tec5wOwPAuRs82Sd3x0=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr10009800otf.91.1585586476537; 
 Mon, 30 Mar 2020 09:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
In-Reply-To: <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 17:41:04 +0100
Message-ID: <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Jon Doron <arilou@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 17:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 3/30/20 6:08 PM, Peter Maydell wrote:
> > On Mon, 30 Mar 2020 at 16:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >>
> >> Since commit 3f940dc98, we added support for vAttach packet
> >> to select a particular thread/cpu/core. However when using
> >> the GDB physical memory mode, it is not clear which CPU
> >> address space is used.
> >> Since the CPU address space is stored in CPUState::as, use
> >> address_space_rw() instead of cpu_physical_memory_rw().
> >>
> >> Fixes: ab4752ec8d9
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   gdbstub.c | 7 ++-----
> >>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/gdbstub.c b/gdbstub.c
> >> index 013fb1ac0f..3baaef50e3 100644
> >> --- a/gdbstub.c
> >> +++ b/gdbstub.c
> >> @@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *=
cpu, target_ulong addr,
> >>
> >>   #ifndef CONFIG_USER_ONLY
> >>       if (phy_memory_mode) {
> >> -        if (is_write) {
> >> -            cpu_physical_memory_write(addr, buf, len);
> >> -        } else {
> >> -            cpu_physical_memory_read(addr, buf, len);
> >> -        }
> >> +        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> >> +                         buf, len, is_write);
> >>           return 0;
> >
> > There's an argument here for using
> >     int asidx =3D cpu_asidx_from_attrs(cpu, MEMTXATTRS_UNSPECIFIED);
> >     AddressSpace *as =3D cpu_get_address_space(cpu, asidx);
> >
> > though it will effectively boil down to the same thing in the end
> > as there's no way for the gdbstub to specify whether it wanted
> > eg the Arm secure or non-secure physical address space.
>
> https://static.docs.arm.com/ihi0074/a/debug_interface_v6_0_architecture_s=
pecification_IHI0074A.pdf
>
> * Configuration of hypervisor noninvasive debug.
>
> This field can have one of the following values:
>
> - 0b00
> Separate controls for hypervisor noninvasive debug are not implemented,
> or no hypervisor is implemented. For ARMv7 PEs that implement the
> Virtualization Extensions, and for ARMv8 PEs that implement EL2, if
> separate controls for hypervisor debug visibility are not implemented,
> the hypervisor debug visibility is indicated by the relevant Non-secure
> debug visibility fields NSNID and NSID.
>
> OK so for ARM "noninvasive debug is not implemented" and we would use
> the core secure address space?

I'm not very familiar with the debug interface (we don't model
it in QEMU), but I think that is the wrong end of it. These
are bits in AUTHSTATUS, which is a read-only register provided
by the CPU to the debugger. It basically says "am I, the CPU,
going to permit you, the debugger, to debug code running
in secure mode, or in EL2". (The CPU gets to decide this:
for security some h/w will not want any random with access
to the jtag debug port to be able to just read out code from
the secure world, for instance.)

What the debugger gets to control is bits in the CSW register
in the "MEM-AP"; it can use these to specify the size of
a memory access it wants to make to the guest, and also
the 'type', which is IMPDEF but typically lets the debugger
say "code access vs data access", "privileged vs usermode"
and "secure vs non-secure".

The equivalent in the QEMU world is that the debugger can
specify the memory transaction attributes. The question is
whether the gdb protocol provides any equivalent of that:
if it doesn't then gdbstub.c has to make up an attribute and
use that.

> Instead of MEMTXATTRS_UNSPECIFIED I should use a crafted MemTxAttrs with
> .secure =3D 1, .unspecified =3D 1?

You shouldn't set 'unspecified =3D 1', because that indicates
"this is MEMTXATTRS_UNSPECIFIED". The default set of
unspecified-attributes are probably good enough,
though, so you can just use MEMTXATTRS_UNSPECIFIED.

> The idea of this command is to use the
> CPU AS but not the MMU/MPU, maybe it doesn't make sense...

The trouble is that the command isn't precise enough.
"read/write to physical memory" is fine if the CPU has
exactly one physical address space, but it's ambiguous if the CPU
has more than one physical address space. Either we need the
user to be able to tell us which one they wanted somehow
(which for QEMU more or less means that they should tell
us what tx attributes they wanted), or we need to make an
arbitrary decision.

PS: do we have any documentation of this new command ?
ab4752ec8d9 has the implementation but no documentation...

thanks
-- PMM

