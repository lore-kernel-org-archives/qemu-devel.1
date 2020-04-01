Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5580C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9C720719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzUCVdnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9C720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJghs-0007KL-Qd
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jJghJ-0006va-6m
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jJghH-0007WF-Hy
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:58:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jJghH-0007Vp-BQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:58:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id h9so904849wrc.8
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XEZthN+y7dg0Dx2jCSjj0qqrmHXSVo6mxSVKiOJ1Snw=;
 b=OzUCVdnWC4mrqOJ+CBoqWD3onEOPj3jDwCwadGaBto8jog1vgJl4G9dUw8nej6IkZL
 2qnBvJmY5Sqw+JuCuGoAFq8JZWFwPZj93yp0GQ9aFSeT0mFc5qBXxmu09WYvT0zffneZ
 MVHUdu1ve8Jtm0sncp12u9jeC81lZK/C7KrG/Zxmtl1J6H9bJT6f5Wddgae/TgfX+t57
 mHmKwqhOWG24Y6l0pNZI3LrBfOekrz6iGsGTrm0r2oPUOoabmnT5qBuMgclV2Up0w9cQ
 N+/DSbcXXw6tgCj80HARXoBqqvffU9LTzxRMg5dKXLFHrQGH+bPjiQaDJ3dG7SlkvXvK
 UHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XEZthN+y7dg0Dx2jCSjj0qqrmHXSVo6mxSVKiOJ1Snw=;
 b=NMQ7+Uj851mMloRk78VFRxwxgk/CTonvsrGQqq4l5gY4BmppbE715lXzBvghN0Rm0M
 9q/ucaqX93tPggcl/ZSl4riEYFTZghUFqfX2/i4deTEgVOQ51M5YF9WT386sYE8gY0tP
 Xfab/pviC4eg0aXPGMgXbQPio4XEcL3vCpqfLWZH21VmYQD1WytbKpe0aNH5wU7tNh5o
 bBjycnRnhoElU+HXgEObt4EyBOqNZI+eSP4arFErBVvs3LbhCbiZ3hede3ex+A21IDWJ
 mYoiBuGKbu2bjwlqUAUd1QKcfx9UC8CjjuJIwYnM02PJSX7arNrH5KVWQnQrPh42an1I
 XGAw==
X-Gm-Message-State: ANhLgQ2KZqm2okmwnPOy+SFXjmLaKZ0eVUcABRhMiwvFTreXh2N6b+B7
 pOurcN7aFFATW5FciQXSZmf76sR/YqhT/7yHUAY=
X-Google-Smtp-Source: ADFU+vulS78MdY8QkliVRQssDTFGjjakfsP41zMYiZqeBsJ2CHnY3U0cX6YjhM5NTY8DzWcwySMZ7nCzZvDkEyQ90+0=
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr25688364wrn.381.1585760313811; 
 Wed, 01 Apr 2020 09:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 1 Apr 2020 18:58:20 +0200
Message-ID: <CAJ+F1CLU4kPK1Tw3X7oTAWtUp0Q4Q=wm3-Uj-_2JO09vq0paBg@mail.gmail.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
To: Thanos Makatos <thanos.makatos@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 1, 2020 at 5:51 PM Thanos Makatos
<thanos.makatos@nutanix.com> wrote:
>
> > On Thu, Mar 26, 2020 at 09:47:38AM +0000, Thanos Makatos wrote:
> > > Build MUSER with vfio-over-socket:
> > >
> > >         git clone --single-branch --branch vfio-over-socket
> > git@github.com:tmakatos/muser.git
> > >         cd muser/
> > >         git submodule update --init
> > >         make
> > >
> > > Run device emulation, e.g.
> > >
> > >         ./build/dbg/samples/gpio-pci-idio-16 -s <N>
> > >
> > > Where <N> is an available IOMMU group, essentially the device ID, whi=
ch
> > must not
> > > previously exist in /dev/vfio/.
> > >
> > > Run QEMU using the vfio wrapper library and specifying the MUSER devi=
ce:
> > >
> > >         LD_PRELOAD=3Dmuser/build/dbg/libvfio/libvfio.so qemu-system-x=
86_64
> > \
> > >                 ... \
> > >                 -device vfio-pci,sysfsdev=3D/dev/vfio/<N> \
> > >                 -object memory-backend-file,id=3Dram-node0,prealloc=
=3Dyes,mem-
> > path=3Dmem,share=3Dyes,size=3D1073741824 \
> > >                 -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0
> > >

fyi, with 5.0 you no longer need -numa!:

-object memory-backend-memfd,id=3Dmem,size=3D2G -M memory-backend=3Dmem

(hopefully, we will get something even simpler one day)

> > > Bear in mind that since this is just a PoC lots of things can break, =
e.g. some
> > > system call not intercepted etc.
> >
> > Cool, I had a quick look at libvfio and how the transport integrates
> > into libmuser.  The integration on the libmuser side is nice and small.
> >
> > It seems likely that there will be several different implementations of
> > the vfio-over-socket device side (server):
> > 1. libmuser
> > 2. A Rust equivalent to libmuser
> > 3. Maybe a native QEMU implementation for multi-process QEMU (I think J=
J
> >    has been investigating this?)
> >
> > In order to interoperate we'll need to maintain a protocol
> > specification.  Mayb You and JJ could put that together and CC the vfio=
,
> > rust-vmm, and QEMU communities for discussion?
>
> Sure, I can start by drafting a design doc and share it.

ok! I am quite amazed you went this far with a ldpreload hack. This
demonstrates some limits of gpl projects, if it was necessary.

I think with this work, and the muser experience, you have a pretty
good idea of what the protocol could look like. My approach, as I
remember, was a quite straightforward VFIO over socket translation,
while trying to see if it could share some aspects with vhost-user,
such as memory handling etc.

To contrast with the work done on qemu-mp series, I'd also prefer we
focus our work on a vfio-like protocol, before trying to see how qemu
code and interface could be changed over multiple binaries etc. We
will start with some limitations, similar to the one that apply to
VFIO: migration, introspection, managements etc are mostly left out
for now. (iow, qemu-mp is trying to do too many things simultaneously)

That's the rough ideas/plan I have in mind:
- draft/define a "vfio over unix" protocol
- similar to vhost-user, also define some backend conventions
https://github.com/qemu/qemu/blob/master/docs/interop/vhost-user.rst#backen=
d-program-conventions
- modify qemu vfio code to allow using a socket backend. Ie something
like "-chardev socket=3Dfoo -device vfio-pci,chardev=3Dfoo"
- implement some test devices (and outside qemu, in whatever
language/framework - the more the merrier!)
- investigate how existing qemu binary could expose some devices over
"vfio-unix", for ex: "qemu -machine none -chardev socket=3Dfoo,server
-device pci-serial,vfio=3Dfoo". This would avoid a lot of proxy and code
churn proposed in qemu-mp.
- think about evolution of QMP, so that commands are dispatched to the
right process. In my book, this is called a bus, and I would go for
DBus (not through qemu) in the long term. But for now, we probably
want to split QMP code to make it more modular (in qemu-mp series,
this isn't stellar either). Later on, perhaps look at bridging QMP
over DBus.
- code refactoring in qemu, to allow smaller binaries, that implement
the minimum for vfio-user devices. (imho, this will be a bit easier
after the meson move, as the build system is simpler)

That should allow some work sharing.

I can't wait for your design draft, and see how I could help.

>
> > It should cover the UNIX domain socket connection semantics (does a
> > listen socket only accept 1 connection at a time?  What happens when th=
e
> > client disconnects?  What happens when the server disconnects?), how
> > VFIO structs are exchanged, any vfio-over-socket specific protocol
> > messages, etc.  Basically everything needed to write an implementation
> > (although it's not necessary to copy the VFIO struct definitions from
> > the kernel headers into the spec or even document their semantics if
> > they are identical to kernel VFIO).
> >
> > The next step beyond the LD_PRELOAD library is a native vfio-over-socke=
t
> > client implementation in QEMU.  There is a prototype here:
> > https://github.com/elmarco/qemu/blob/wip/vfio-user/hw/vfio/libvfio-
> > user.c
> >
> > If there are any volunteers for working on that then this would be a
> > good time to discuss it.
> >
> > Finally, has anyone looked at CrosVM's out-of-process device model?  I
> > wonder if it has any features we should consider...
> >
> > Looks like a great start to vfio-over-socket!
>


--=20
Marc-Andr=C3=A9 Lureau

