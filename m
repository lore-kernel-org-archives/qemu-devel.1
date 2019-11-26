Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E22C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D2F2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6ObhLP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D2F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZix7-0007ho-Uw
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZivz-00078F-1Q
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZivv-00085O-Kx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:03:46 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZivv-000851-ET
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:03:43 -0500
Received: by mail-ot1-x333.google.com with SMTP id r27so2766525otc.8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=CSc9gXY4J2B3Zl1m/LYEvcLmTzjX5oRs5BMWPedVUDA=;
 b=u6ObhLP6U/71Xwj7jnU6gbmr+jsXmFFAHe19RnyijuS4hsoiUUrKvep72sKuYuRjsG
 6DRuES9aNIUcyvJUW+k6k7JBF8qlyPF76AlcpWtPRTjSIcuT9IonQWw9UK1KJY4z9y5u
 XSbL++aRN7m3eFg+vWgu2BUwFuKh5FoRM054oNl4ATHceAS67HCU5oTr6bmaBqOMy6FM
 fINE64hm2pGpUjAvweguvQffileD7AaqU2FqRA+WPnBm6MLYryojFmh7z80J7+4Q0NRN
 3d40zh+iQajnKHwWJU48koAterr/SHTwEtQvUM7Jmq8aQVs5RwbpJJW9kNr1vmAg3QDd
 rQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=CSc9gXY4J2B3Zl1m/LYEvcLmTzjX5oRs5BMWPedVUDA=;
 b=ZJGG1jdZeQEqBP3yt3yVdOFoPT/cFyeh/nL/WfOfeni3dd6mmAX5RuSUC3Z6BlZ08w
 6lvXU5LK4x7/kUIFVBMcWt8nuas3lwaC3+dntqr+/WSnCBHHqTvVixgn9kGyAjfjjk4G
 exVKL3dYJBg1+dSUJrsumXbGNc5+IK5wIl76Tcsje3QVQWw2HkQOJ442vcYaOI8FUI7z
 1mphVr1GU/12zYCOBHn15vSqKcha1l6p0cJA8LZTgluaQGvh6W+iu7+jUWQoBkHkUZu3
 76FPuNHMgnLK4Vw4AVkf4arNwz3GHBUccwBhQDEB9kDUgzwGvCjrqKXTRGxrdGe13OiW
 OLWQ==
X-Gm-Message-State: APjAAAWUECQH8S1lLt6XBW3jMUyqITis1cUsAldPce7UwgMDpdthnlpv
 /qszNrBkHQXpD/Hg9v8f0Ixk338lzvC28qtbHe0=
X-Google-Smtp-Source: APXvYqzg7FljYnoDnNdqFur2XBzoc+Ymcj2RvCJopbI9Lb7RXuOhgIts7UyGqYGiPhqwd/3PZ70wFfvvwF09HnRKPQM=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr1012385otc.295.1574805822442; 
 Tue, 26 Nov 2019 14:03:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 26 Nov 2019 14:03:42
 -0800 (PST)
In-Reply-To: <744f91e0-858b-3752-942d-f3d552691fd5@redhat.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=h69CVmS6Rpm_CNet836BLSxTPQsXmP1Ur4tVL-0uryOw@mail.gmail.com>
 <744f91e0-858b-3752-942d-f3d552691fd5@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 23:03:42 +0100
Message-ID: <CAL1e-=gNRfu0kSBdZuw4kAjBYZ3rr9fnins_T6XPb_Hg11KE-g@mail.gmail.com>
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a312c50598470d9b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a312c50598470d9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 26, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Aleksandar,
>
> On 11/26/19 9:46 PM, Aleksandar Markovic wrote:
>
>> On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
>> <philmd@redhat.com> wrote:
>>
>>>
>>> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>>> logical change was in 2005 (9542611a6). After we can count 164
>>> maintenance commits (QEMU API changes) with the exception of
>>> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>>>
>>> This machine was introduced as a proof of concept to run a MIPS
>>> CPU. 2 years later, the Malta machine was add (commit 5856de80)
>>> modeling a real platform.
>>>
>>> Note also this machine has no specification except 5 lines in
>>> the header of this file:
>>>
>>>   * emulates a simple machine with ISA-like bus.
>>>   * ISA IO space mapped to the 0x14000000 (PHYS) and
>>>   * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>>>   * All peripherial devices are attached to this "bus" with
>>>   * the standard PC ISA addresses.
>>>
>>> It is time to deprecate this obsolete machine. Users are
>>> recommended to use the Malta board, which hardware is well
>>> documented.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>
>>
>> Philippe,
>>
>> I see you added "libvir-list" in "cc". Was it a mistake, or there was
>> some purpose?
>>
>
> I don't pick the series recipient manually, I send my series with
> git-publish. Here it used the default QEMU profile.
>
> All profiles call git-sendmail with the cc-cmd set to the
> get_maintainer.pl script:
>
> $ cat .gitpublish
> #
> # Common git-publish profiles that can be used to send patches to QEMU
> upstream.
> #
> # See https://github.com/stefanha/git-publish for more information
> #
> [gitpublishprofile "default"]
> base =3D master
> to =3D qemu-devel@nongnu.org
> cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit
> --nogit-fallback 2>/dev/null
>
> Having a closer look, libvir-list list was Cc'ed because it is listed as
> reviewer of the qemu-deprecated.texi file, which was modified.
>
> ./scripts/get_maintainer.pl -f qemu-deprecated.texi
> libvir-list@redhat.com (reviewer:Incompatible changes)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
>
OK. No problem. It just looked strange.

As far as consuktations, I am just waiting for some responses within
company to establish if somebody is perhaps using this machine with some
ancient kernel. I got some opinions that are in favor of R4000 machine
deprecating, but I need to wait for all relevant departments to confirm.

What happened to TileGX?

Yours,
Aleksandar



>   qemu-deprecated.texi | 5 +++++
>>>   hw/mips/mips_r4k.c   | 1 +
>>>   MAINTAINERS          | 2 +-
>>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>> index 4b4b7425ac..05265b43c8 100644
>>> --- a/qemu-deprecated.texi
>>> +++ b/qemu-deprecated.texi
>>> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should
>>> use 'scsi-hd' or
>>>
>>>   @section System emulator machines
>>>
>>> +@subsection mips r4k platform (since 4.2)
>>> +
>>> +This machine type is very old and unmaintained. Users should use the
>>> 'malta'
>>> +machine type instead.
>>> +
>>>   @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>>>
>>>   These machine types are very old and likely can not be used for live
>>> migration
>>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>>> index 70024235ae..0b79ad26cb 100644
>>> --- a/hw/mips/mips_r4k.c
>>> +++ b/hw/mips/mips_r4k.c
>>> @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>>>
>>>   static void mips_machine_init(MachineClass *mc)
>>>   {
>>> +    mc->deprecation_reason =3D "use malta machine type instead";
>>>       mc->desc =3D "mips r4k platform";
>>>       mc->init =3D mips_r4k_init;
>>>       mc->block_default_type =3D IF_IDE;
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5e5e3e52d6..3b3a88e264 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>>>   R4000
>>>   M: Aurelien Jarno <aurelien@aurel32.net>
>>>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>> -S: Maintained
>>> +S: Obsolete
>>>   F: hw/mips/mips_r4k.c
>>>
>>>   Fulong 2E
>>> --
>>> 2.21.0
>>>
>>>
>>>
>>
>

--000000000000a312c50598470d9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 26, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hi Aleksandar,<br>
<br>
On 11/26/19 9:46 PM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.co=
m</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
The r4k machine was introduced in 2005 (6af0bf9c7) and its last<br>
logical change was in 2005 (9542611a6). After we can count 164<br>
maintenance commits (QEMU API changes) with the exception of<br>
1 fix in 2015 (memory leak, commit 3ad9fd5a).<br>
<br>
This machine was introduced as a proof of concept to run a MIPS<br>
CPU. 2 years later, the Malta machine was add (commit 5856de80)<br>
modeling a real platform.<br>
<br>
Note also this machine has no specification except 5 lines in<br>
the header of this file:<br>
<br>
=C2=A0 * emulates a simple machine with ISA-like bus.<br>
=C2=A0 * ISA IO space mapped to the 0x14000000 (PHYS) and<br>
=C2=A0 * ISA memory at the 0x10000000 (PHYS, 16Mb in size).<br>
=C2=A0 * All peripherial devices are attached to this &quot;bus&quot; with<=
br>
=C2=A0 * the standard PC ISA addresses.<br>
<br>
It is time to deprecate this obsolete machine. Users are<br>
recommended to use the Malta board, which hardware is well<br>
documented.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
</blockquote>
<br>
Philippe,<br>
<br>
I see you added &quot;libvir-list&quot; in &quot;cc&quot;. Was it a mistake=
, or there was<br>
some purpose?<br>
</blockquote>
<br>
I don&#39;t pick the series recipient manually, I send my series with git-p=
ublish. Here it used the default QEMU profile.<br>
<br>
All profiles call git-sendmail with the cc-cmd set to the <a href=3D"http:/=
/get_maintainer.pl" target=3D"_blank">get_maintainer.pl</a> script:<br>
<br>
$ cat .gitpublish<br>
#<br>
# Common git-publish profiles that can be used to send patches to QEMU upst=
ream.<br>
#<br>
# See <a href=3D"https://github.com/stefanha/git-publish" target=3D"_blank"=
>https://github.com/stefanha/gi<wbr>t-publish</a> for more information<br>
#<br>
[gitpublishprofile &quot;default&quot;]<br>
base =3D master<br>
to =3D <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-deve=
l@nongnu.org</a><br>
cccmd =3D scripts/<a href=3D"http://get_maintainer.pl" target=3D"_blank">ge=
t_maintainer.pl</a> --noroles --norolestats --nogit --nogit-fallback 2&gt;/=
dev/null<br>
<br>
Having a closer look, libvir-list list was Cc&#39;ed because it is listed a=
s reviewer of the qemu-deprecated.texi file, which was modified.<br>
<br>
./scripts/<a href=3D"http://get_maintainer.pl" target=3D"_blank">get_mainta=
iner.pl</a> -f qemu-deprecated.texi<br>
<a href=3D"mailto:libvir-list@redhat.com" target=3D"_blank">libvir-list@red=
hat.com</a>=C2=A0(<wbr>reviewer:Incompatible changes)<br>
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a>=C2=A0(open list:All patches CC here)<br>
<br></blockquote><div><br></div><div>OK. No problem. It just looked strange=
.</div><div><br></div><div>As far as consuktations, I am just waiting for s=
ome responses within company to establish if somebody is perhaps using this=
 machine with some ancient kernel. I got some opinions that are in favor of=
 R4000 machine deprecating, but I need to wait for all relevant departments=
 to confirm.</div><div><br></div><div>What happened to TileGX?</div><div><b=
r></div><div>Yours,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 qemu-deprecated.texi | 5 +++++<br>
=C2=A0 hw/mips/mips_r4k.c=C2=A0 =C2=A0| 1 +<br>
=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0 3 files changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi<br>
index 4b4b7425ac..05265b43c8 100644<br>
--- a/qemu-deprecated.texi<br>
+++ b/qemu-deprecated.texi<br>
@@ -266,6 +266,11 @@ The &#39;scsi-disk&#39; device is deprecated. Users sh=
ould use &#39;scsi-hd&#39; or<br>
<br>
=C2=A0 @section System emulator machines<br>
<br>
+@subsection mips r4k platform (since 4.2)<br>
+<br>
+This machine type is very old and unmaintained. Users should use the &#39;=
malta&#39;<br>
+machine type instead.<br>
+<br>
=C2=A0 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)<br>
<br>
=C2=A0 These machine types are very old and likely can not be used for live=
 migration<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index 70024235ae..0b79ad26cb 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)<br>
<br>
=C2=A0 static void mips_machine_init(MachineClass *mc)<br>
=C2=A0 {<br>
+=C2=A0 =C2=A0 mc-&gt;deprecation_reason =3D &quot;use malta machine type i=
nstead&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 mc-&gt;desc =3D &quot;mips r4k platform&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 mc-&gt;init =3D mips_r4k_init;<br>
=C2=A0 =C2=A0 =C2=A0 mc-&gt;block_default_type =3D IF_IDE;<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..3b3a88e264 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -972,7 +972,7 @@ F: hw/net/mipsnet.c<br>
=C2=A0 R4000<br>
=C2=A0 M: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" target=
=3D"_blank">aurelien@aurel32.net</a>&gt;<br>
=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.c=
om" target=3D"_blank">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
-S: Maintained<br>
+S: Obsolete<br>
=C2=A0 F: hw/mips/mips_r4k.c<br>
<br>
=C2=A0 Fulong 2E<br>
--<br>
2.21.0<br>
<br>
<br>
</blockquote>
<br>
</blockquote>
<br>
</blockquote>

--000000000000a312c50598470d9b--

