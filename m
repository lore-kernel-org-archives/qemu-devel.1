Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24ACA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 20:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338B220679
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 20:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFwezrdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338B220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQH3s-0004K9-Dj
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 16:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iQH1r-0003NZ-Rw
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 16:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iQH1q-0006A1-E0
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 16:26:47 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:37068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>)
 id 1iQH1p-0005s9-NJ; Thu, 31 Oct 2019 16:26:45 -0400
Received: by mail-io1-xd31.google.com with SMTP id 1so8312435iou.4;
 Thu, 31 Oct 2019 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RCWcNjA6YA1P7K/DuJcVtvfBIJ7JQ3sR/pPwfnQPdEk=;
 b=UFwezrdD9VmGtfk3/lz3Ms8s6D5AxNNodxsHQo++MbhTqkLfMv7QkeNgkLksJmcNpE
 KBCzv4cU/xkLMYTxAxH0ljPanXeRk78xzxzuZSv/vYIw4/Vd1KskjHEIeq4fHhf/PBUy
 hhvD9zEuoBmDGqvb1k2JO97rzMldGBTqrvlY2etbys3toYwvg5/0CP/5obhJYSd713//
 pUk+Y6/CuWtHfxoy9tj2mQkequVyBKI9n/2nJw+YiZGCi0+Zp+tj1EzgOS0j8XtmFcq9
 pmxxqupA+pcSyJW6RCaQqg3LUPgAwIjpkGWZfY+GLf8HxqrPIIhNjveMrCIcgHy79LQD
 NsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RCWcNjA6YA1P7K/DuJcVtvfBIJ7JQ3sR/pPwfnQPdEk=;
 b=Xc+CghJdTro7ITOaY+iyuFI59u21NG61eaNL8ZZeIg2LR7oNJC7uJAgLkiDW9V5S9d
 JFBDnBMFVl1lFbHvW3t3mD6lf24+6KF+HE4/b5zmq8051hQ/WMToUyWidk78hToFKL/6
 efmZtbP1IGTgqir/0Uv+GEyPrDv7Nqw9CjQsruHHNuGL2HltMQEexizNhvdwak0u5pWL
 oDlKEPBF0mdaGLk9MMflTWpHWJ01166KeQOTOfbXC9h8KgQgekG+iZKCYsKIBI3mz3qD
 FH5DaMsJFXnVXuATfy8bkKibiR5/sq8/0MVzWKXoVw4AdILEpc5iiSvpx2gg+/vZ7Y6A
 X4rQ==
X-Gm-Message-State: APjAAAVK4XU6xGyPVerpuqNAD2Po5hJeU4rbaTrvYhNrfn886EP7q9c1
 MKyoFZFBw3PNqf4FiGWgUtT2IBwlfyEi8ywoLKs=
X-Google-Smtp-Source: APXvYqwqQa6VF33CMCt8O0l67vz6RPsv2B0iKfSbPqVTz8CU2gL6QmVvT/bexV2aIPz90w7iljIe5b0/1WPZmU8gSMw=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr6668699ioq.143.1572553600094; 
 Thu, 31 Oct 2019 13:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2K0np63wni3G7GNWPxTq40Kb1VeTN7Ocn=E=BqSmd+pDsX9A@mail.gmail.com>
 <7e2a821c-ed6b-ccb1-f517-405359358a26@redhat.com>
 <CAM2K0nox06JcmjfM20G1-p2Vwq5Xb7hRAX0DVBfdCepnqUiZQg@mail.gmail.com>
 <b6ef8a2d-04aa-aa73-a8f3-ef649786a163@redhat.com>
In-Reply-To: <b6ef8a2d-04aa-aa73-a8f3-ef649786a163@redhat.com>
From: Wayne Li <waynli329@gmail.com>
Date: Thu, 31 Oct 2019 15:26:27 -0500
Message-ID: <CAM2K0nqnfJyp02wjp=krof7QDrARHvFL28om8Dudr4E1ACwB0A@mail.gmail.com>
Subject: Re: Missing PVR setting capability
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9585705963aaaea"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d31
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b9585705963aaaea
Content-Type: text/plain; charset="UTF-8"

So it's been a little while and I've been trying some different
approaches.  I think the problem I am having is because I don't have the
required kernel modules loaded.  When I run lsmod I only see the following
two modules loaded:

Module                  Size  Used by
nfsd                  100940  11
exportfs                6723  1 nfsd

The archlinux website says the following modules need to be running:

kvm_intel             245760  0
kvmgt                  28672  0
mdev                   20480  2 kvmgt,vfio_mdev
vfio                   32768  3 kvmgt,vfio_mdev,vfio_iommu_type1
kvm                   737280  2 kvmgt,kvm_intel
irqbypass              16384  1 kvm

Granted that I am running on a powerpc processor not an intel processor,
the modules that I myself to need to load will be a little different from
that.  But I can't find those modules to load on my device.  For example, I
can't find a kvm.ko file on the device despite the fact that I was able to
find the kvm directories I mentioned earlier.  Did I have to compile those
modules myself?  In the kvm module directory there is C code and a
makefile, but just running make doesn't work.

Note that I'm using a Yocto Linux system that I myself didn't build.  My
coworker built the Linux system on SD card and was in the process of trying
to figure out if kvm was actually enabled on the system or not before he
left the company.  I'm learning about the system as I go.

On Tue, Oct 22, 2019 at 1:46 PM Thomas Huth <thuth@redhat.com> wrote:

> On 22/10/2019 18.24, Wayne Li wrote:
> > If I run "lsmod | grep kvm" nothing shows up but if I just do a "find .
> > -name "kvm"" I get the following:
> [...]
> > ./sys/devices/virtual/misc/kvm
> > ./sys/class/misc/kvm
> > ./sys/kernel/debug/kvm
> > ./sys/module/kvm
> >
> > I guess this shows my OS does have KVM on it?
>
> Alright, I guess that means that KVM compiled into the kernel ... should
> be fine, I think.
>
> >  I added the two flags you
> > mentioned when running QEMU (the -cpu and the -machine flags) but the
> > -cpu flag doesn't seem like it's doing anything as even when I put a
> > clearly wrong argument after the flag no error related to the cpu is
> > thrown.  Also it says ppce500 is not a machine type and that the
> > supported machines are:
> >
> > bamboo               bamboo
> > boeing-machine       Boeing Machine
> > none                 empty machine
> > ref405ep             ref405ep
> > taihu                taihu
> > virtex-ml507         Xilinx Virtex ML507 reference design
>
> Oh, are you running qemu-system-ppc instead of qemu-system-ppc64? I
> thought these e*500 CPUs are 64-bit? Is your host kernel 64-bit or 32-bit?
>
> Anyway, if you're using a modified version of QEMU, you should
> definitely ask the people who did the modifications there.
>
>  Thomas
>
>

--000000000000b9585705963aaaea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So it&#39;s been a little while and I&#39;ve been try=
ing some different approaches.=C2=A0 I think the problem I am having is bec=
ause I don&#39;t have the required kernel modules loaded.=C2=A0 When I run =
lsmod I only see the following two modules loaded:</div><div><br>Module =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size =C2=A0Used =
by<br>nfsd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010=
0940 =C2=A011<br>exportfs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A06723 =C2=A01 nfsd</div><div><br></div><div>The archlinux website says=
 the following modules need to be running:</div><div><br></div><div>kvm_int=
el =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 245760 =C2=A00<br>kvmgt =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028672 =C2=A00<br>md=
ev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20480 =C2=
=A02 kvmgt,vfio_mdev<br>vfio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 32768 =C2=A03 kvmgt,vfio_mdev,vfio_iommu_type1<br>kvm =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 737280 =C2=A02 =
kvmgt,kvm_intel<br>irqbypass =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A016384 =C2=A01 kvm</div><div><br></div><div>Granted that I am running on =
a powerpc processor not an intel processor, the modules that I myself to ne=
ed to load will be a little different from that.=C2=A0 But I can&#39;t find=
 those modules to load on my device.=C2=A0 For example, I can&#39;t find a =
kvm.ko file on the device despite the fact that I was able to find the kvm =
directories I mentioned earlier.=C2=A0 Did I have to compile those modules =
myself?=C2=A0 In the kvm module directory there is C code and a makefile, b=
ut just running make doesn&#39;t work.</div><div><br></div><div>Note that I=
&#39;m using a Yocto Linux system that I myself didn&#39;t build.=C2=A0 My =
coworker built the Linux system on SD card and was in the process of trying=
 to figure out if kvm was actually enabled on the system or not before he l=
eft the company.=C2=A0 I&#39;m learning about the system as I go.<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Oct 22, 2019 at 1:46 PM Thomas Huth &lt;<a href=3D"mailto:thuth@red=
hat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 22/10/2019 18.24, Wayne Li wrote:<br>
&gt; If I run &quot;lsmod | grep kvm&quot; nothing shows up but if I just d=
o a &quot;find .<br>
&gt; -name &quot;kvm&quot;&quot; I get the following:<br>
[...]<br>
&gt; ./sys/devices/virtual/misc/kvm<br>
&gt; ./sys/class/misc/kvm<br>
&gt; ./sys/kernel/debug/kvm<br>
&gt; ./sys/module/kvm<br>
&gt; <br>
&gt; I guess this shows my OS does have KVM on it?<br>
<br>
Alright, I guess that means that KVM compiled into the kernel ... should<br=
>
be fine, I think.<br>
<br>
&gt;=C2=A0 I added the two flags you<br>
&gt; mentioned when running QEMU (the -cpu and the -machine flags) but the<=
br>
&gt; -cpu flag doesn&#39;t seem like it&#39;s doing anything as even when I=
 put a<br>
&gt; clearly wrong argument after the flag no error related to the cpu is<b=
r>
&gt; thrown.=C2=A0 Also it says ppce500 is not a machine type and that the<=
br>
&gt; supported machines are:<br>
&gt; <br>
&gt; bamboo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bamboo<br>
&gt; boeing-machine =C2=A0 =C2=A0 =C2=A0 Boeing Machine<br>
&gt; none =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 empty mac=
hine<br>
&gt; ref405ep =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref405ep<br>
&gt; taihu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0taihu<br>
&gt; virtex-ml507 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Xilinx Virtex ML507 reference=
 design<br>
<br>
Oh, are you running qemu-system-ppc instead of qemu-system-ppc64? I<br>
thought these e*500 CPUs are 64-bit? Is your host kernel 64-bit or 32-bit?<=
br>
<br>
Anyway, if you&#39;re using a modified version of QEMU, you should<br>
definitely ask the people who did the modifications there.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--000000000000b9585705963aaaea--

