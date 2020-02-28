Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA15EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC5A2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1oR/ibD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC5A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dqI-0003N0-GP
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j7dpg-0002vW-22
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j7dpd-0001GE-1e
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:29:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j7dpc-0001Fb-KZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582889363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYJkMQlwnkgyCVURpXs6P4Z7O5E9qq1vhLTwQPkAhig=;
 b=f1oR/ibDQ0zYshagJpbpCHfUFaqBQoqpCzk9/Rsu0gfuQFmWHSyt0htPBhbNvZKS59lRci
 qrCK+k9Xvk6PfVA+B5l8B3oJ06BBY9e0f8cpfUuGeyz/jQuFErFNd/ig+Tdf7iOqE6kK6V
 avvOkwe9iqaIjka2b+5fU8aNvBUCp3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-bWwAuYFYPIG0cF7_kakAPg-1; Fri, 28 Feb 2020 06:29:16 -0500
X-MC-Unique: bWwAuYFYPIG0cF7_kakAPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1728107ACC7;
 Fri, 28 Feb 2020 11:29:13 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-243.ams2.redhat.com
 [10.36.116.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D80FF5C554;
 Fri, 28 Feb 2020 11:29:10 +0000 (UTC)
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, Andrew Fish
 <afish@apple.com>, "devel@edk2.groups.io" <devel@edk2.groups.io>
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
 <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
 <B2D15215269B544CADD246097EACE7474BB28B35@dggemm508-mbx.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ea6f0558-a007-64a3-09d6-0a803f09b5ad@redhat.com>
Date: Fri, 28 Feb 2020 12:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BB28B35@dggemm508-mbx.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhoujianjay <zhoujianjay@gmail.com>, discuss <discuss@edk2.groups.io>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/28/20 04:20, Zhoujian (jay) wrote:
> Hi Laszlo,
>=20
>> -----Original Message-----
>> From: Qemu-devel
>> [mailto:qemu-devel-bounces+jianjay.zhou=3Dhuawei.com@nongnu.org] On Beha=
lf
>> Of Laszlo Ersek
>> Sent: Wednesday, February 26, 2020 5:42 PM
>> To: Andrew Fish <afish@apple.com>; devel@edk2.groups.io
>> Cc: berrange@redhat.com; qemu-devel@nongnu.org; Dr. David Alan Gilbert
>> <dgilbert@redhat.com>; zhoujianjay <zhoujianjay@gmail.com>; discuss
>> <discuss@edk2.groups.io>; Alex Benn=C3=A9e <alex.bennee@linaro.org>;
>> wuchenye1995 <wuchenye1995@gmail.com>
>> Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual =
machines
>>
>> Hi Andrew,
>>
>> On 02/25/20 22:35, Andrew Fish wrote:
>>
>>> Laszlo,
>>>
>>> The FLASH offsets changing breaking things makes sense.
>>>
>>> I now realize this is like updating the EFI ROM without rebooting the
>>> system.  Thus changes in how the new EFI code works is not the issue.
>>>
>>> Is this migration event visible to the firmware? Traditionally the
>>> NVRAM is a region in the FD so if you update the FD you have to skip
>>> NVRAM region or save and restore it. Is that activity happening in
>>> this case? Even if the ROM layout does not change how do you not lose
>>> the contents of the NVRAM store when the live migration happens? Sorry
>>> if this is a remedial question but I'm trying to learn how this
>>> migration works.
>>
>> With live migration, the running guest doesn't notice anything. This is =
a general
>> requirement for live migration (regardless of UEFI or flash).
>>
>> You are very correct to ask about "skipping" the NVRAM region. With the
>> approach that OvmfPkg originally supported, live migration would simply =
be
>> unfeasible. The "build" utility would produce a single (unified) OVMF.fd=
 file, which
>> would contain both NVRAM and executable regions, and the guest's variabl=
e
>> updates would modify the one file that would exist.
>> This is inappropriate even without considering live migration, because O=
VMF
>> binary upgrades (package updates) on the virtualization host would force=
 guests
>> to lose their private variable stores (NVRAMs).
>>
>> Therefore, the "build" utility produces "split" files too, in addition t=
o the unified
>> OVMF.fd file. Namely, OVMF_CODE.fd and OVMF_VARS.fd.
>> OVMF.fd is simply the concatenation of the latter two.
>>
>> $ cat OVMF_VARS.fd OVMF_CODE.fd | cmp - OVMF.fd [prints nothing]
>>
>> When you define a new domain (VM) on a virtualization host, the domain
>> definition saves a reference (pathname) to the OVMF_CODE.fd file.
>> However, the OVMF_VARS.fd file (the variable store *template*) is not di=
rectly
>> referenced; instead, it is *copied* into a separate (private) file for t=
he domain.
>>
>> Furthermore, once booted, guest has two flash chips, one that maps the
>> firmware executable OVMF_CODE.fd read-only, and another pflash chip that
>> maps its private varstore file read-write.
>>
>> This makes it possible to upgrade OVMF_CODE.fd and OVMF_VARS.fd (via
>> package upgrades on the virt host) without messing with varstores that w=
ere
>> earlier instantiated from OVMF_VARS.fd. What's important here is that th=
e
>> various constants in the new (upgraded) OVMF_CODE.fd file remain compati=
ble
>> with the *old* OVMF_VARS.fd structure, across package upgrades.
>>
>> If that's not possible for introducing e.g. a new feature, then the pack=
age
>> upgrade must not overwrite the OVMF_CODE.fd file in place, but must prov=
ide an
>> additional firmware binary. This firmware binary can then only be used b=
y freshly
>> defined domains (old domains cannot be switched over). Old domains can b=
e
>> switched over manually -- and only if the sysadmin decides it is OK to l=
ose the
>> current variable store contents. Then the old varstore file for the doma=
in is
>> deleted (manually), the domain definition is updated, and then a new (lo=
gically
>> empty, pristine) varstore can be created from the *new* OVMF_2_VARS.fd t=
hat
>> matches the *new* OVMF_2_CODE.fd.
>>
>>
>> During live migration, the "RAM-like" contents of both pflash chips are =
migrated
>> (the guest-side view of both chips remains the same, including the case =
when the
>> writeable chip happens to be in "programming mode", i.e., during a UEFI =
variable
>> write through the Fault Tolerant Write and Firmware Volume Block(2) prot=
ocols).
>>
>> Once live migration completes, QEMU dumps the full contents of the write=
able
>> chip to the backing file (on the destination host). Going forward, flash=
 writes from
>> within the guest are reflected to said host-side file on-line, just like=
 it happened
>> on the source host before live migration. If the file backing the r/w pf=
lash chip is
>> on NFS (shared by both src and dst hosts), then this one-time dumping wh=
en the
>> migration completes is superfluous, but it's also harmless.
>>
>> The interesting question is, what happens when you power down the VM on =
the
>> destination host (=3D post migration), and launch it again there, from z=
ero. In that
>> case, the firmware executable file comes from the *destination host* (it=
 was
>> never persistently migrated from the source host, i.e. never written out=
 on the
>> dst). It simply comes from the OVMF package that had been installed on t=
he
>> destination host, by the sysadmin. However, the varstore pflash does ref=
lect the
>> permanent result of the previous migration. So this is where things can =
fall apart,
>> if both firmware binaries (on the src host and on the dst host) don't ag=
ree about
>> the internal structure of the varstore pflash.
>>
>=20
> Hi Laszlo,
>=20
> I found an ealier thread that you said there're 4 options to use ovmf:
>=20
> https://lists.gnu.org/archive/html/qemu-discuss/2018-04/msg00045.html
>=20
> Excerpt:
> "(1) If you map the unified image with -bios, all of that becomes ROM --
> read-only memory.
> (2) If you map the unified image with -pflash, all of that becomes
> read-write MMIO.
> (3) If you use the split images (OVMF_CODE.fd and a copy of
> OVMF_VARS.fd), and map then as flash chips, then the top part
> (OVMF_CODE.fd, consisting of SECFV and FVMAIN_COMPACT) becomes
> read-only flash (MMIO), and the bottom part (copy of OVMF_VARS.fd,
> consisting of FTW Spare, FTW Work, Event log, and NV store) becomes
> read-write flash (MMIO).
> (4) If you use -bios with OVMF_CODE.fd only, then the top part will be
> ROM, and the bottom part will be "black hole" MMIO."
>=20
> I think you're talking about the option (2)(acceptable) and option (3)
> (best solution) in this thread, and I agree.

Yes, exactly.

>=20
> I'm wondering will it be different about ancient option (1) with live
> migration. You tried add -DMEM_VARSTORE_EMU_ENABLE=3DFALSE
> build flag to disable -bios support, but Option (1) may be used for the
> old VMs started several years ago running on the cloud...

I'm unaware of any VMs running in clouds that use "-bios" with OVMF. It
certainly seems a terrible idea, regardless of live migration.

>=20
> With developing new features, the size of OVMF.fd is becoming larger
> and larger, that seems to be the trend. It would be nice if it could be
> hot-updated to the new version. As Daniel said, could it feasible to add
> zero-padding to the firmware images?

You're mixing up small details. OVMF_CODE.fd is already heavily padded,
internally. We've grown the *internal* DXEFV firmware volume repeatedly
over *years*, without *any* disruption to users. Please see:

- da78c88f4535 ("OvmfPkg: raise DXEFV size to 8 MB", 2014-03-05)

- 08df58ec3043 ("OvmfPkg: raise DXEFV size to 9 MB", 2015-10-07)

- 2f7b34b20842 ("OvmfPkg: raise DXEFV size to 10 MB", 2016-05-31)

- d272449d9e1e ("OvmfPkg: raise DXEFV size to 11 MB", 2018-05-29)

To this day, i.e., with edk2 master @ edfe16a6d9f8, you can build OVMF
in the default feature configuration [*] for -D FD_SIZE_2MB.

[*]
  DEFINE SECURE_BOOT_ENABLE      =3D FALSE
  DEFINE SMM_REQUIRE             =3D FALSE
  DEFINE SOURCE_DEBUG_ENABLE     =3D FALSE
  DEFINE TPM2_ENABLE             =3D FALSE
  DEFINE TPM2_CONFIG_ENABLE      =3D FALSE

  DEFINE NETWORK_TLS_ENABLE             =3D FALSE
  DEFINE NETWORK_IP6_ENABLE             =3D FALSE
  DEFINE NETWORK_HTTP_BOOT_ENABLE       =3D FALSE

For example:

$ build \
  -a IA32 -a X64 \
  -b DEBUG \
  -p OvmfPkg/OvmfPkgIa32X64.dsc \
  -t GCC48 \
  -D FD_SIZE_2MB

Note that this build will contain DEBUG messages (at least DEBUG_INFO
level ones) and ASSERT()s too.

The final usage report at the end of the command is:

SECFV [14%Full] 212992 total, 31648 used, 181344 free
PEIFV [31%Full] 917504 total, 284584 used, 632920 free
DXEFV [44%Full] 11534336 total, 5113688 used, 6420648 free
FVMAIN_COMPACT [73%Full] 1753088 total, 1284216 used, 468872 free

What does that mean? It means that largest firmware volume, DXEFV, uses
just 44% of the 11MB allotted size.

And FVMAIN_COMPACT, which embeds (among other things) DXEFV in
LZMA-compressed format, only uses 73% of its allotted size, which is
1712 KB.

All this means that in the default feature config, there's still a bunch
of room free in the 2MB build, even with DEBUGs and ASSERT()s enabled,
and with an old compiler that does not do link-time optimization.

I think you must have misunderstood the purpose of the 4MB build. The
4MB build was solely introduced for enlarging the *varstore*. That was
motivated by passing an SVVP check. This is described in detail in the
relevant commit, which I may have linked earlier.

https://github.com/tianocore/edk2/commit/b24fca05751f

(Please consult the diagram in the commit message carefully. It shows
you how the various firmware volumes / flash devices are nested; it will
help you understand where the 1712 KB FVMAIN_COMPACT firmware volume is
placed in the final image, and how FVMAIN_COMPACT embeds / compresses
DXEFV.)

And *given that* we had to introduce an incompatible change (for
enlarging the varstore, for SVVP's sake), it made sense to *also*
enlarge the other parts of the flash content. But the motivation was
strictly the varstore change, and that was inevitably an incompatible
change. In fact, you can see in the commit message that the *outer*
container FVMAIN_COMPACT was enlarged from 1712 to 3360 kilobytes, the
embedded PEIFV and DXEFV firmware volumes didn't put that extra space to
use. The SECFV firmware volume runs directly from flash, so it's not
compressed, but even that firmware volume got no "space injection". So
basically all the size increase that *could* have been exploited for
executable code size was spent on padding.

As far as I can tell, we have never broken compatibility due to
executable code size increases.

Sorry if I over-explained this; I simply don't know how to express this
any better.


> Things are a little different here,
> i.e. the size of src and dest are 2M and 4M respectively, copy the source
> 2M to the dest side, and then add zero-padding to the end of the image
> to round it upto 4 MB at the dest side (With some modification of
> qemu_ram_resize in QEMU to avoid length mismatch error report)?

No, this doesn't make any sense.

On both the source host and the destination host, the same pathname (for
example, "/usr/share/OVMF/OVMF_CODE.fd") must point to same-size
(compatible) firmware binaries. Both must be built with the same -D
FD_SIZE_2MB flag, or with the same -D FD_SIZE_4MB flag. Then you can
migrate.

You can offer a 4MB build too on the destination host, but it must be
under a different pathname. So that after the domain has been migrated
in from the source host, and then re-launched against the firmware
binary that's on the destination host, there is an incompatibility
between the domain's *original* varstore, and the domain's *new*
firmware binary.

>=20
> The physical address assigned to ovmf region will change from
> 0xffe00000 - 0xffffffff to 0xffc00000 - 0xffffffff, after the OS has
> started I see this range will be recycled and assigned to other PCI
> devices(using the command "cat /proc/iomem") by guest OS. So,
> this range change seems that will not affect the guest I think.
> But if the code of OVMF is running when paused at the src side
> then will it be continued to run at the dest side, I'm not sure...
>=20
> So, may I ask that would it be feasible or compatible for option (1)
> when live migration between different ovmf sizes? Thanks.

Sorry, my brain just cannot cope with the idea of even *running* OVMF in
production with "-bios" -- let alone migrate it.

But anyway... if you are dead set on this, you can try the following:

- On the destination host, rename the 4MB build to a different filename.

- On the destination host, update all your domain definitions to refer
to the renamed filename with "-bios"

- on the destination host, rebuild your current (more modern) firmware
package, using the -D FD_SIZE_2MB flag. If you have not enabled a bunch
of features meanwhile, it will actually succeed.

- on the destination host, put this fresh build (with unified size 2MB)
in the original place (using the original pathname)

- now you can migrate domains from your source host. The pathname they
refer to with "-bios" will exist, and it will be a 2MB build. And the
contents of that build will be more modern (presumably) than what you
are migrating away from.

Please understand this: when you *allowed* OVMF to build with 4MB size,
and installed it under the exact same pathname (on the destination host)
where you previously used to keep a 2MB binary, *that* is when you broke
compatibility.

What's quite unfathomable to me is that the 2MB->4MB change in upstream
was *solely* motivated by varstore enlargement (for passing SVVP with
*flash*-based variables), but you're still using the ancient and
non-conformant \NvVars emulation that comes with "-bios".

Please, flash based variables with OVMF and QEMU have been supported
since QEMU v1.6.

I've attempted to remove -bios support from OVMF multiple times, I've
always been prevented from doing that, and the damage is obvious only now.

Laszlo


