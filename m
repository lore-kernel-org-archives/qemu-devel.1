Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F9C35E0E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 21:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB35A20838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 21:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="wzzoVSbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB35A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6hs8-0004Db-0O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 16:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afish@apple.com>) id 1j6hrH-0003N3-Kn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afish@apple.com>) id 1j6hrD-00050u-Cm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:35:14 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:39668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <afish@apple.com>) id 1j6hrD-0004wK-4E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:35:11 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 01PLWWwE037291; Tue, 25 Feb 2020 13:35:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=qKb5PINfCaL73QEkVYnLDbQZcKPdrG7GINYTRy9EvTw=;
 b=wzzoVSbxZetWU9fXn+ptU23xBCq8KMm/NjIlp5X29Xv1jOAQKiXql3X+8m5s2yCexa3e
 eHFnxnZ9MCp2F8f32bJchgVqsEJkGauv+fZgKyppVyLuNa6rsemUgjri/w80brlhwV0g
 G4f74zfHGTRdbV60CO90S+dAntt+glneK582/hexqFFq2i0xTKPBwshvV2SAO8ZeZe5c
 KDiFBkMOKHQ4z72jOkhDFrK/DYZ1+dQLIo0U5CVjiM0wcbRut/uJhf0FDpc2hB15jaqd
 zeUAA4NPsveL/j5vh2Qmk5S9lnXq9UwK74KsgLvibLiFy85XWRpbqhWi4THm1zUMVAQT uQ== 
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2yb444hnyp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 25 Feb 2020 13:35:05 -0800
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019)) with ESMTPS id <0Q6A004B01AFJ9J0@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Tue, 25 Feb 2020 13:35:03 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019)) id <0Q6A00G0011EOC00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 25 Feb 2020 13:35:03 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 08777febe38bb384cc57fda39d0586b7
X-Va-E-CD: 74fbc9fcbd3d4b0e941105e5641a1eeb
X-Va-R-CD: 7f28ace2b24f1e656a1dc26e6a401e24
X-Va-CD: 0
X-Va-ID: 4d9512ec-98fe-4fb6-b876-0fc75eac1f6a
X-V-A: 
X-V-T-CD: 08777febe38bb384cc57fda39d0586b7
X-V-E-CD: 74fbc9fcbd3d4b0e941105e5641a1eeb
X-V-R-CD: 7f28ace2b24f1e656a1dc26e6a401e24
X-V-CD: 0
X-V-ID: 925ad2cc-cc3c-4180-b47c-43c20d4675fc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_08:2020-02-25,
 2020-02-25 signatures=0
Received: from [17.235.17.79] by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019))
 with ESMTPSA id <0Q6A00FUK1ADSV50@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 25 Feb 2020 13:35:03 -0800 (PST)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 13.0 \(3594.4.17\))
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
In-reply-to: <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
Date: Tue, 25 Feb 2020 13:35:01 -0800
Cc: wuchenye1995 <wuchenye1995@gmail.com>, zhoujianjay <zhoujianjay@gmail.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, discuss <discuss@edk2.groups.io>
Content-transfer-encoding: quoted-printable
Message-id: <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
To: devel@edk2.groups.io, lersek@redhat.com
X-Mailer: Apple Mail (2.3594.4.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-02-25_08:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.151.62.66
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrew Fish <afish@apple.com>
From: Andrew Fish via <qemu-devel@nongnu.org>



> On Feb 25, 2020, at 12:40 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> Hi Andrew,
>=20
> On 02/25/20 19:56, Andrew Fish wrote:
>> Laszlo,
>>=20
>> If I understand this correctly is it not more complicated than just =
size. It also assumes the memory layout is the same?
>=20
> Yes.
>=20
>> The legacy BIOS used fixed magic address ranges, but UEFI uses =
dynamically allocated memory so addresses are not fixed. While the UEFI =
firmware does try to keep S3 and S4 layouts consistent between boots, =
I'm not aware of any mechanism to keep the memory map address the same =
between versions of the firmware?
>=20
> It's not about RAM, but platform MMIO.
>=20

Laszlo,

The FLASH offsets changing breaking things makes sense.=20

I now realize this is like updating the EFI ROM without rebooting the =
system.  Thus changes in how the new EFI code works is not the issue.=20

Is this migration event visible to the firmware? Traditionally the NVRAM =
is a region in the FD so if you update the FD you have to skip NVRAM =
region or save and restore it. Is that activity happening in this case? =
Even if the ROM layout does not change how do you not lose the contents =
of the NVRAM store when the live migration happens? Sorry if this is a =
remedial question but I'm trying to learn how this migration works.=20

Thanks,

Andrew Fish

> The core of the issue here is that the -D FD_SIZE_4MB and -D =
FD_SIZE_2MB
> build options (or more directly, the different FD_SIZE_IN_KB macro
> settings) set a bunch of flash-related build-time constant macros, and
> PCDs, differently, in the following files:
>=20
> - OvmfPkg/OvmfPkg.fdf.inc
> - OvmfPkg/VarStore.fdf.inc
> - OvmfPkg/OvmfPkg*.dsc
>=20
> As a result, the OVMF_CODE.fd firmware binary will have different
> hard-coded references to the variable store pflash addresses.
> (Guest-physical MMIO addresses that point into the pflash range.)
>=20
> If someone tries to combine an OVMF_CODE.fd firmware binary from e.g.
> the 4MB build, with a variable store file that was originally
> instantiated from an OVMF_VARS.fd varstore template from the 2MB =
build,
> then the firmware binary's physical address references and various =
size
> references will not match the contents / layout of the varstore pflash
> chip, which maps an incompatibly structured varstore file.
>=20
> For example, "OvmfPkg/VarStore.fdf.inc" describes two incompatible
> EFI_FIRMWARE_VOLUME_HEADER structures (which "build" generates for the
> OVMF_VARS.fd template) between the 4MB (total size) build, and the
> 1MB/2MB (total size) build.
>=20
> The commit message below summarizes the internal layout differences,
> from 1MB/2MB -> 4MB:
>=20
> https://github.com/tianocore/edk2/commit/b24fca05751f
>=20
> Excerpt (relevant for OVMF_VARS.fd):
>=20
>  Description                Compression type                Size [KB]
>  -------------------------  -----------------  ----------------------
>  Non-volatile data storage  open-coded binary    128 ->   528 ( +400)
>                               data
>    Variable store                                 56 ->   256 ( +200)
>    Event log                                       4 ->     4 (   +0)
>    Working block                                   4 ->     4 (   +0)
>    Spare area                                     64 ->   264 ( +200)
>=20
> Thanks
> Laszlo
>=20
>=20
>>> On Feb 25, 2020, at 9:53 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>>>=20
>>> On 02/24/20 16:28, Daniel P. Berrang=C3=A9 wrote:
>>>> On Tue, Feb 11, 2020 at 05:39:59PM +0000, Alex Benn=C3=A9e wrote:
>>>>>=20
>>>>> wuchenye1995 <wuchenye1995@gmail.com> writes:
>>>>>=20
>>>>>> Hi all,
>>>>>>  We found a problem with live migration of UEFI virtual machines
>>>>>>  due to size of OVMF.fd changes.
>>>>>>  Specifically, the size of OVMF.fd in edk with low version such =
as
>>>>>>  edk-2.0-25 is 2MB while the size of it in higher version such as
>>>>>>  edk-2.0-30 is 4MB.
>>>>>>  When we migrate a UEFI virtual machine from the host with low
>>>>>>  version of edk2 to the host with higher one, qemu component will
>>>>>>  report an error in function qemu_ram_resize while
>>>>>> checking size of ovmf_pcbios: Length mismatch: pc.bios: 0x200000 =
in
>>>>>> !=3D 0x400000: Invalid argument.
>>>>>>  We want to know how to solve this problem after updating the
>>>>>>  version of edk2.
>>>>>=20
>>>>> You can only migrate a machine that is identical - so =
instantiating a
>>>>> empty machine with a different EDK image is bound to cause a =
problem
>>>>> because the machines don't match.
>>>>=20
>>>> I don't believe we are that strict for firmware in general. The
>>>> firmware is loaded when QEMU starts, but that only matters for the
>>>> original source host QEMU. During migration, the memory content of =
the
>>>> original firmware will be copied during live migration, overwriting
>>>> whatever the target QEMU loaded off disk. This works....provided =
the
>>>> memory region is the same size on source & target host, which is =
where
>>>> the problem arises in this case.
>>>>=20
>>>> If there's a risk that newer firmware will be larger than old =
firmware
>>>> there's only really two options:
>>>>=20
>>>> - Keep all firmware images forever, each with a unique versioned
>>>>   filename. This ensures target QEMU will always load the original
>>>>   smaller firmware
>>>>=20
>>>> - Add padding to the firmware images. IOW, if the firmware is 2 MB,
>>>>   add zero-padding to the end of the image to round it upto 4 MB
>>>>   (whatever you anticipate the largest size wil be in future).
>>>>=20
>>>> Distros have often taken the latter approach for QEMU firmware in =
the
>>>> past. The main issue is that you have to plan ahead of time and get
>>>> this padding right from the very start. You can't add the padding
>>>> after the fact on an existing VM.
>>>=20
>>> Following up here *too*, just for completeness.
>>>=20
>>> The query in this thread has been posted three times now (and I have
>>> zero idea why). Each time it generated a different set of responses. =
For
>>> completes, I'm now going to link the other two threads here (because =
the
>>> present thread seems to have gotten the most feedback).
>>>=20
>>> To the OP:
>>>=20
>>> - please do *NOT* repost the same question once you get an answer. =
It
>>> only fragments the discussion and creates confusion. It also doesn't
>>> hurt if you *confirm* that you understood the answer.
>>>=20
>>> - Yet further, if your email address has @gmail.com for domain, but =
your
>>> msgids contain "tencent", that raises some eyebrows (mine for sure).
>>> You say "we" in the query, but never identify the organization =
behind
>>> the plural pronoun.
>>>=20
>>> (I've been fuming about the triple-posting of the question for a =
while
>>> now, but it's only now that, upon seeing how much work Dan has put =
into
>>> his answer, I've decided that dishing out a bit of netiquette would =
be
>>> in order.)
>>>=20
>>> * First posting:
>>> - msgid:      <tencent_F1295F826E46EDFF3D77812B@qq.com =
<mailto:tencent_F1295F826E46EDFF3D77812B@qq.com>>
>>> - edk2-devel: https://edk2.groups.io/g/devel/message/54146 =
<https://edk2.groups.io/g/devel/message/54146>
>>> - qemu-devel: =
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02419.html =
<https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02419.html>
>>>=20
>>> * my response:
>>>   - msgid:      <12553.1581366059422195003@groups.io =
<mailto:12553.1581366059422195003@groups.io>>
>>>   - edk2-devel: https://edk2.groups.io/g/devel/message/54161 =
<https://edk2.groups.io/g/devel/message/54161>
>>>   - qemu-devel: none, because (as an exception) I used the stupid
>>>                 groups.io <http://groups.io/> web interface to =
respond, and so my response
>>>                 never reached qemu-devel
>>>=20
>>> * Second posting (~4 hours after the first)
>>> - msgid:      <tencent_3CD8845EC159F0161725898B@qq.com =
<mailto:tencent_3CD8845EC159F0161725898B@qq.com>>
>>> - edk2-devel: https://edk2.groups.io/g/devel/message/54147 =
<https://edk2.groups.io/g/devel/message/54147>
>>> - qemu-devel: =
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02415.html =
<https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02415.html>
>>>=20
>>> * Dave's response:
>>>   - msgid:      <20200220154742.GC2882@work-vm>
>>>   - edk2-devel: https://edk2.groups.io/g/devel/message/54681 =
<https://edk2.groups.io/g/devel/message/54681>
>>>   - qemu-devel: =
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05632.html =
<https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05632.html>
>>>=20
>>> * Third posting (next day, present thread) -- cross posted to yet
>>> another list (!), because apparently Dave's feedback and mine had =
not
>>> been enough:
>>> - msgid:        <tencent_BC7FD00363690990994E90F8@qq.com =
<mailto:tencent_BC7FD00363690990994E90F8@qq.com>>
>>> - edk2-devel:   https://edk2.groups.io/g/devel/message/54220 =
<https://edk2.groups.io/g/devel/message/54220>
>>> - edk2-discuss: https://edk2.groups.io/g/discuss/message/135 =
<https://edk2.groups.io/g/discuss/message/135>
>>> - qemu-devel:   =
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02735.html =
<https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg02735.html>
>>>=20
>>> Back on topic: see my response again. The answer is, you can't solve =
the
>>> problem (specifically with OVMF), and QEMU in fact does you service =
by
>>> preventing the migration.
>>>=20
>>> Laszlo
>>>=20
>>>=20
>>>=20
>>=20
>>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
>=20
> View/Reply Online (#54796): =
https://edk2.groups.io/g/devel/message/54796
> Mute This Topic: https://groups.io/mt/71141681/1755084
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [afish@apple.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


