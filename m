Received: from eggs.gnu.org ([2001:4830:134:3::10]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1doXrc-0004r8-Tb
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1doXrX-0003Xx-6h
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:35:12 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1doXrW-0003WT-V8
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:35:07 -0400
Received: by mail-oi0-f51.google.com with SMTP id r203so30573876oih.0
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 09:35:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJTBuyhvCySRHvrKMOW7fvjuogTUUUXi4QRjiJrrzfu-gbb5jQ@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
	<CAJTBuyhKqbXWjphh-t60TVjZfVFEYGyWFgEs4TmR+CE1q04GhQ@mail.gmail.com>
	<CAJTBuyhvCySRHvrKMOW7fvjuogTUUUXi4QRjiJrrzfu-gbb5jQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 3 Sep 2017 18:35:05 +0200
Message-ID: <CABgObfYAH3xtVO0mZCBiVnE5m=p_BqiopGJtovzL1LFBN0366Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Izik Eidus <izik@veertu.com>
Cc: vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@gmail.com>, =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?= <sergio.g.delreal@gmail.com>

Il 03 set 2017 6:17 PM, "Izik Eidus" <izik@veertu.com> ha scritto:

Hi,

Paolo, my biggest challenge right now is:
hvf-all.c
it include currently the following copyright:

// Copyright 2008 IBM Corporation

//           2008 Red Hat, Inc.

// Copyright 2011 Intel Corporation

// Copyright 2016 Veertu, Inc.
// Copyright 2017 The Android Open Source Project

and it is GPLv2, However we want to integrate this stuff to QEMU in the
required license (GPLv2+), I have a suggestion that maybe the safest way
for us to achieve GPLv2+  would be that we will send you the current
hypervisor framework implementation of Anka that is derived from
xhyve/bhyve + our own changes to make it run windows / linux / macOS,


What code is derived from v2-only sources? IIRC the task switch code is
derived from KVM, is there anything else?

If you can identify the functions that cannot be v2-or-later that's already
okay. There is a lot more refactoring to do in the HVF code to remove
duplication with other parts of the code, and if it's just a couple
isolated cases we can maybe try to prioritize them. For example it's part
of the plan to replace the task switch code with the version in
seg_helper.c. Worst case, QEMU has done clean room reverse engineering a
couple times in the past to fix licensing issues.

If you think your plan works better and you can devote a week to it, we can
also try it. But having a clear answer on what code is from v2-only sources
may help judging on the better approach. I an worried that some of the
later patches could be tricky to redo/backport. What are the advantages of
the newer implementation? Does it reuse more KVM userspace bits?

Paolo

in
such case all copyright go back to BSD2 and we can license it as GPL2v+ or
whatever work for QEMU.
If you want to go in such case what we will do would be the following:
take kvm user space implemantion of qemu that is GPLv2+, integrate to it
the hypervisor framework from Anka (in kvm user space style) - this will
put us in hvf [1|2|3 / 13] in safe GPLv2+ and then we can back port the
rest of Sergio changes to this stuff.

I know this is less than ideal as it requires some changes to the current
patch set, however it will make it 100% safe to be GPL2v+, what you guys
think?, we can get this stuff done before the end of this week...

Thanks.


On Fri, Sep 1, 2017 at 12:39 AM, Izik Eidus <izik@veertu.com> wrote:

>
>
> On Fri, Sep 1, 2017 at 12:21 AM, Paolo Bonzini <pbonzini@redhat.com>
> wrote:
>
>> Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com> ha scritto:
>>
>> > Izik, Vincent (assuming you are the right person to contact at Google),
>> > can you reply to Daniel and Stefan?
>> >
>>
>> Hi,
>>
>> What I suggest is that we will send our patch' again as gpl2+ and clean
>> the
>> entire stuff to make sure they are falling into the right copyright
>> category as required by QEMU.
>>
>>
>> That's not necessary. Just you and Vincent replying to this thread with a
>> "Signed-off-by" line would be enough for Sergio to use the right license
in
>> his v3 submission. Sergio already made some non-trivial changes that are
>> needed for inclusion in QEMU from a supportability (e.g. dirty page
>> tracking for graphics) or maintainability perspective (e.g. -cpu
support),
>> so the simplest thing to do is to retrofit the right license to his
>> submission. You can do so if you can confirm that the code you used only
>> came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the rest
>> was written by Veertu).
>>
>
> Hi,
>
> Sure fine with us, let me go over all the code and see that all copyright
> that are needed are there, and then you can relicense all our code to
> GPLv2+, I think I saw a a file that was missing Bochs copyright in it, so
I
> want to make sure that I fix this before and that all others are fine.
>
> Thanks.
>
>
>>
>> Google has already contributed the HAXN accelerator, so I am moderately
>> optimistic that they can help with HVF too.
>>
>> BTW, another thing that need to be integrated in order to make this stuff
>> useful is the vmnet patch's, it is apple NAT for vms that allow guests to
>> have networking...
>>
>>
>> People can always use slirp (or tap with some more effort), so these
>> patches are already a minimum viable feature and pretty close to being
>> mergeable. But of course any other contribution is welcome!
>>
>> Paolo
>>
>>
>> (altho that it come with a trick, without certificate it
>> will require root permission, while hypverisor framework itself can run
>> without root)
>>
>> What do you guys think?
>>
>>
>> >
>> > Sergio worked on completing the QEMU port to Hypervisor.framework. The
>> > hvf-all.c file that Daniel pointed out as v2-only is derived from
>> kvm-all.c
>> > and hax-all.c, and should be under v2-or-later license. The others seem
>> to
>> > be either original or derived from Bochs, which is LGPL, so they could
>> be
>> > LGPL or GPLv2+.
>> >
>> > Thanks,
>> >
>> > Paolo
>> >
>> >
>> > There are benefits to having this code upstream.  If they ever want to
>> > rebase on qemu.git there will be less work for them.
>>
>>
OK,


> >
>> > Stefan
>> >
>> >
>> >
>>
>>
>>
>
