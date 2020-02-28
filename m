Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C0C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 04:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0E32469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 04:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="oCnFE4tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E32469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7WtW-00082U-Lg
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 23:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afish@apple.com>) id 1j7Wsm-0007aq-GL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afish@apple.com>) id 1j7Wsj-0004mE-W5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:04:12 -0500
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <afish@apple.com>) id 1j7Wsj-0004m8-PU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:04:09 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 01S42FVf035279; Thu, 27 Feb 2020 20:04:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from :
 message-id : content-type : mime-version : subject : date : in-reply-to :
 cc : to : references; s=20180706;
 bh=sogiF3MOgiVYTzCyPQlgB56fCHd1LMGlZUMDFcQdbi4=;
 b=oCnFE4tNKlrUsoveFRL6Os8+3UmJ8+JszSyxAC/NTiV0AFly0pOwhbbzD5wXo6gmCD50
 93XqVxFrCYpW3egcLoL69IqXgeUJxcKbv6cahZZRDRf6t70Ydqk80MQSJQU8/imTmHMb
 ikkOdZwXIlEGcQII2urDfj4R3lZKpCPMgqr4eRDvYXbqpg1Vlq/nMg4Nx8lypRdRQJ3b
 amsFYIE6LobuyUTID86rFLAH670sixl9B55wna12sQfjAqHXabI7SzyFzOUmNGULkZ1N
 8kfDE5Hmt9x683i/o/rIygD+/nOCFWAQxdD+L92+96/yiyl9Nod9ApAfUgdEMT9xAQ94 yg== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2yepth55hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 27 Feb 2020 20:04:04 -0800
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019)) with ESMTPS id <0Q6E00BUU8MR5V30@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Thu, 27 Feb 2020 20:04:03 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019)) id <0Q6E000008KRDP00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Thu,
 27 Feb 2020 20:04:03 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 08777febe38bb384cc57fda39d0586b7
X-Va-E-CD: 74fbc9fcbd3d4b0e941105e5641a1eeb
X-Va-R-CD: 7f28ace2b24f1e656a1dc26e6a401e24
X-Va-CD: 0
X-Va-ID: a3b58b51-851a-456c-9a0b-8d01320425de
X-V-A: 
X-V-T-CD: 08777febe38bb384cc57fda39d0586b7
X-V-E-CD: 74fbc9fcbd3d4b0e941105e5641a1eeb
X-V-R-CD: 7f28ace2b24f1e656a1dc26e6a401e24
X-V-CD: 0
X-V-ID: 130bf62f-9d7e-48f3-bcc6-5289b1940415
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_08:2020-02-26,
 2020-02-27 signatures=0
Received: from [17.235.11.246] by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.1.20190704 64bit (built Jul  4
 2019))
 with ESMTPSA id <0Q6E00NYI8MPIM10@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Thu,
 27 Feb 2020 20:04:02 -0800 (PST)
Message-id: <284BFC25-8534-4147-8616-DE7C410DB681@apple.com>
Content-type: multipart/alternative;
 boundary="Apple-Mail=_656EDCE8-0EB3-47A4-A1F9-C2C49993C4D8"
MIME-version: 1.0 (Mac OS X Mail 13.0 \(3594.4.17\))
Subject: Re: [edk2-devel] A problem with live migration of UEFI virtual
 machines
Date: Thu, 27 Feb 2020 20:04:00 -0800
In-reply-to: <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
Cc: wuchenye1995 <wuchenye1995@gmail.com>, zhoujianjay <zhoujianjay@gmail.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, discuss <discuss@edk2.groups.io>
To: devel@edk2.groups.io, lersek@redhat.com
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston> <20200224152810.GX635661@redhat.com>
 <8b0ec286-9322-ee00-3729-6ec7ee8260a6@redhat.com>
 <3E8BB07B-8730-4AB8-BCB6-EA183FB589C5@apple.com>
 <465a5a84-cac4-de39-8956-e38771807450@redhat.com>
 <8F42F6F1-A65D-490D-9F2F-E12746870B29@apple.com>
 <6666a886-720d-1ead-8f7e-13e65dcaaeb4@redhat.com>
X-Mailer: Apple Mail (2.3594.4.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_08:2020-02-26,
 2020-02-27 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.60
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


--Apple-Mail=_656EDCE8-0EB3-47A4-A1F9-C2C49993C4D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Feb 26, 2020, at 1:42 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> Hi Andrew,
>=20
> On 02/25/20 22:35, Andrew Fish wrote:
>=20
>> Laszlo,
>>=20
>> The FLASH offsets changing breaking things makes sense.
>>=20
>> I now realize this is like updating the EFI ROM without rebooting the
>> system.  Thus changes in how the new EFI code works is not the issue.
>>=20
>> Is this migration event visible to the firmware? Traditionally the
>> NVRAM is a region in the FD so if you update the FD you have to skip
>> NVRAM region or save and restore it. Is that activity happening in
>> this case? Even if the ROM layout does not change how do you not lose
>> the contents of the NVRAM store when the live migration happens? =
Sorry
>> if this is a remedial question but I'm trying to learn how this
>> migration works.
>=20
> With live migration, the running guest doesn't notice anything. This =
is
> a general requirement for live migration (regardless of UEFI or =
flash).
>=20
> You are very correct to ask about "skipping" the NVRAM region. With =
the
> approach that OvmfPkg originally supported, live migration would =
simply
> be unfeasible. The "build" utility would produce a single (unified)
> OVMF.fd file, which would contain both NVRAM and executable regions, =
and
> the guest's variable updates would modify the one file that would =
exist.
> This is inappropriate even without considering live migration, because
> OVMF binary upgrades (package updates) on the virtualization host =
would
> force guests to lose their private variable stores (NVRAMs).
>=20
> Therefore, the "build" utility produces "split" files too, in addition
> to the unified OVMF.fd file. Namely, OVMF_CODE.fd and OVMF_VARS.fd.
> OVMF.fd is simply the concatenation of the latter two.
>=20
> $ cat OVMF_VARS.fd OVMF_CODE.fd | cmp - OVMF.fd
> [prints nothing]


Laszlo,

Thanks for the detailed explanation.=20

Maybe I was overcomplicating this. Given your explanation I think the =
part I'm missing is OVMF is implying FLASH layout, in this split model, =
based on the size of the OVMF_CODE.fd and OVMF_VARS.fd.  Given that if =
OVMF_CODE.fd gets bigger the variable address changes from a QEMU point =
of view. So basically it is the QEMU  API that is making assumptions =
about the relative layout of the FD in the split model that makes a =
migration to larger ROM not work. Basically the -pflash API does not =
support changing the size of the ROM without moving NVRAM given the way =
it is currently defined.=20

Given the above it seems like the 2 options are:
1) Pad OVMF_CODE.fd to be very large so there is room to grow.
2) Add some feature to QUEM that allows the variable store address to =
not be based on OVMF_CODE.fd size.=20

I did see this [1] and combined with your email I either understand, or =
I'm still confused? :)

I'm not saying we need to change anything, I'm just trying to make sure =
I understand how OVMF and QEMU are tied to together.=20

[1] =
https://www.redhat.com/archives/libvir-list/2019-January/msg01031.html

Thanks,

Andrew Fish




>=20
> When you define a new domain (VM) on a virtualization host, the domain
> definition saves a reference (pathname) to the OVMF_CODE.fd file.
> However, the OVMF_VARS.fd file (the variable store *template*) is not
> directly referenced; instead, it is *copied* into a separate (private)
> file for the domain.
>=20
> Furthermore, once booted, guest has two flash chips, one that maps the
> firmware executable OVMF_CODE.fd read-only, and another pflash chip =
that
> maps its private varstore file read-write.
>=20
> This makes it possible to upgrade OVMF_CODE.fd and OVMF_VARS.fd (via
> package upgrades on the virt host) without messing with varstores that
> were earlier instantiated from OVMF_VARS.fd. What's important here is
> that the various constants in the new (upgraded) OVMF_CODE.fd file
> remain compatible with the *old* OVMF_VARS.fd structure, across =
package
> upgrades.
>=20
> If that's not possible for introducing e.g. a new feature, then the
> package upgrade must not overwrite the OVMF_CODE.fd file in place, but
> must provide an additional firmware binary. This firmware binary can
> then only be used by freshly defined domains (old domains cannot be
> switched over). Old domains can be switched over manually -- and only =
if
> the sysadmin decides it is OK to lose the current variable store
> contents. Then the old varstore file for the domain is deleted
> (manually), the domain definition is updated, and then a new =
(logically
> empty, pristine) varstore can be created from the *new* OVMF_2_VARS.fd
> that matches the *new* OVMF_2_CODE.fd.
>=20
>=20
> During live migration, the "RAM-like" contents of both pflash chips =
are
> migrated (the guest-side view of both chips remains the same, =
including
> the case when the writeable chip happens to be in "programming mode",
> i.e., during a UEFI variable write through the Fault Tolerant Write =
and
> Firmware Volume Block(2) protocols).
>=20
> Once live migration completes, QEMU dumps the full contents of the
> writeable chip to the backing file (on the destination host). Going
> forward, flash writes from within the guest are reflected to said
> host-side file on-line, just like it happened on the source host =
before
> live migration. If the file backing the r/w pflash chip is on NFS
> (shared by both src and dst hosts), then this one-time dumping when =
the
> migration completes is superfluous, but it's also harmless.
>=20
> The interesting question is, what happens when you power down the VM =
on
> the destination host (=3D post migration), and launch it again there, =
from
> zero. In that case, the firmware executable file comes from the
> *destination host* (it was never persistently migrated from the source
> host, i.e. never written out on the dst). It simply comes from the =
OVMF
> package that had been installed on the destination host, by the
> sysadmin. However, the varstore pflash does reflect the permanent =
result
> of the previous migration. So this is where things can fall apart, if
> both firmware binaries (on the src host and on the dst host) don't =
agree
> about the internal structure of the varstore pflash.
>=20
> Thanks
> Laszlo
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
>=20
> View/Reply Online (#54845): =
https://edk2.groups.io/g/devel/message/54845
> Mute This Topic: https://groups.io/mt/71141681/1755084
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [afish@apple.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


--Apple-Mail=_656EDCE8-0EB3-47A4-A1F9-C2C49993C4D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Feb 26, 2020, at 1:42 AM, Laszlo Ersek &lt;<a =
href=3D"mailto:lersek@redhat.com" class=3D"">lersek@redhat.com</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">Hi Andrew,<br class=3D""><br class=3D"">On 02/25/20 22:35, =
Andrew Fish wrote:<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">Laszlo,<br class=3D""><br class=3D"">The FLASH offsets =
changing breaking things makes sense.<br class=3D""><br class=3D"">I now =
realize this is like updating the EFI ROM without rebooting the<br =
class=3D"">system. &nbsp;Thus changes in how the new EFI code works is =
not the issue.<br class=3D""><br class=3D"">Is this migration event =
visible to the firmware? Traditionally the<br class=3D"">NVRAM is a =
region in the FD so if you update the FD you have to skip<br =
class=3D"">NVRAM region or save and restore it. Is that activity =
happening in<br class=3D"">this case? Even if the ROM layout does not =
change how do you not lose<br class=3D"">the contents of the NVRAM store =
when the live migration happens? Sorry<br class=3D"">if this is a =
remedial question but I'm trying to learn how this<br class=3D"">migration=
 works.<br class=3D""></blockquote><br class=3D"">With live migration, =
the running guest doesn't notice anything. This is<br class=3D"">a =
general requirement for live migration (regardless of UEFI or flash).<br =
class=3D""><br class=3D"">You are very correct to ask about "skipping" =
the NVRAM region. With the<br class=3D"">approach that OvmfPkg =
originally supported, live migration would simply<br class=3D"">be =
unfeasible. The "build" utility would produce a single (unified)<br =
class=3D"">OVMF.fd file, which would contain both NVRAM and executable =
regions, and<br class=3D"">the guest's variable updates would modify the =
one file that would exist.<br class=3D"">This is inappropriate even =
without considering live migration, because<br class=3D"">OVMF binary =
upgrades (package updates) on the virtualization host would<br =
class=3D"">force guests to lose their private variable stores =
(NVRAMs).<br class=3D""><br =
class=3D""></div></div></blockquote><blockquote type=3D"cite" =
class=3D""><div class=3D""><div class=3D"">Therefore, the "build" =
utility produces "split" files too, in addition<br class=3D"">to the =
unified OVMF.fd file. Namely, OVMF_CODE.fd and OVMF_VARS.fd.<br =
class=3D"">OVMF.fd is simply the concatenation of the latter two.<br =
class=3D""><br class=3D"">$ cat OVMF_VARS.fd OVMF_CODE.fd | cmp - =
OVMF.fd<br class=3D"">[prints nothing]<br =
class=3D""></div></div></blockquote><div><br class=3D""></div><div><br =
class=3D""></div><div><div>Laszlo,</div><div><br =
class=3D""></div><div>Thanks for the detailed =
explanation.&nbsp;</div><div><br class=3D""></div><div>Maybe I was =
overcomplicating this. Given your explanation I think the part I'm =
missing is OVMF is implying FLASH layout, in this split model, based on =
the size of the&nbsp;OVMF_CODE.fd and&nbsp;<span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"">OVMF_VARS.fd. &nbsp;Given that =
if&nbsp;</span>OVMF_CODE.fd gets bigger the variable address changes =
from a QEMU point of view. So basically it is the QEMU &nbsp;API that is =
making assumptions about the relative layout of the FD in the split =
model that makes a migration to larger ROM not work. Basically the =
-pflash API does not support changing the size of the ROM without moving =
NVRAM given the way it is currently defined.&nbsp;</div><div><br =
class=3D""></div><div>Given the above it seems like the 2 options =
are:</div><div>1) Pad&nbsp;<span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" =
class=3D"">OVMF_CODE.fd to be very large so there is room to =
grow.</span></div><div><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"">2) Add =
some feature to QUEM that allows the variable store address to not be =
based on&nbsp;</span><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); background-color: rgb(255, 255, 255);" =
class=3D"">OVMF_CODE.fd size.&nbsp;</span></div><div><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
background-color: rgb(255, 255, 255);" class=3D""><br =
class=3D""></span></div><div><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D"">I =
did see this [1] and combined with your email I either understand, or =
I'm still confused? :)</span></div><div><br class=3D""></div><div>I'm =
not saying we need to change anything, I'm just trying to make sure I =
understand how OVMF and QEMU are tied to together.&nbsp;</div><div><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
background-color: rgb(255, 255, 255);" class=3D""><br =
class=3D""></span></div><div><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" =
class=3D"">[1]&nbsp;</span><font color=3D"#000000" class=3D""><a =
href=3D"https://www.redhat.com/archives/libvir-list/2019-January/msg01031.=
html" =
class=3D"">https://www.redhat.com/archives/libvir-list/2019-January/msg010=
31.html</a></font></div><div><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=3D""><br=
 class=3D""></span></div><div><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" =
class=3D"">Thanks,</span></div><div><span style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" =
class=3D""><br class=3D""></span></div><div><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); background-color: rgb(255, 255, =
255);" class=3D"">Andrew Fish</span></div><div><br =
class=3D""></div><blockquote type=3D"cite" class=3D""><div =
class=3D""></div></blockquote></div><div><br class=3D""></div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D""><br class=3D"">When you define a new domain (VM) on a =
virtualization host, the domain<br class=3D"">definition saves a =
reference (pathname) to the OVMF_CODE.fd file.<br class=3D"">However, =
the OVMF_VARS.fd file (the variable store *template*) is not<br =
class=3D"">directly referenced; instead, it is *copied* into a separate =
(private)<br class=3D"">file for the domain.<br class=3D""><br =
class=3D"">Furthermore, once booted, guest has two flash chips, one that =
maps the<br class=3D"">firmware executable OVMF_CODE.fd read-only, and =
another pflash chip that<br class=3D"">maps its private varstore file =
read-write.<br class=3D""><br class=3D"">This makes it possible to =
upgrade OVMF_CODE.fd and OVMF_VARS.fd (via<br class=3D"">package =
upgrades on the virt host) without messing with varstores that<br =
class=3D"">were earlier instantiated from OVMF_VARS.fd. What's important =
here is<br class=3D"">that the various constants in the new (upgraded) =
OVMF_CODE.fd file<br class=3D"">remain compatible with the *old* =
OVMF_VARS.fd structure, across package<br class=3D"">upgrades.<br =
class=3D""><br class=3D"">If that's not possible for introducing e.g. a =
new feature, then the<br class=3D"">package upgrade must not overwrite =
the OVMF_CODE.fd file in place, but<br class=3D"">must provide an =
additional firmware binary. This firmware binary can<br class=3D"">then =
only be used by freshly defined domains (old domains cannot be<br =
class=3D"">switched over). Old domains can be switched over manually -- =
and only if<br class=3D"">the sysadmin decides it is OK to lose the =
current variable store<br class=3D"">contents. Then the old varstore =
file for the domain is deleted<br class=3D"">(manually), the domain =
definition is updated, and then a new (logically<br class=3D"">empty, =
pristine) varstore can be created from the *new* OVMF_2_VARS.fd<br =
class=3D"">that matches the *new* OVMF_2_CODE.fd.<br class=3D""><br =
class=3D""><br class=3D"">During live migration, the "RAM-like" contents =
of both pflash chips are<br class=3D"">migrated (the guest-side view of =
both chips remains the same, including<br class=3D"">the case when the =
writeable chip happens to be in "programming mode",<br class=3D"">i.e., =
during a UEFI variable write through the Fault Tolerant Write and<br =
class=3D"">Firmware Volume Block(2) protocols).<br class=3D""><br =
class=3D"">Once live migration completes, QEMU dumps the full contents =
of the<br class=3D"">writeable chip to the backing file (on the =
destination host). Going<br class=3D"">forward, flash writes from within =
the guest are reflected to said<br class=3D"">host-side file on-line, =
just like it happened on the source host before<br class=3D"">live =
migration. If the file backing the r/w pflash chip is on NFS<br =
class=3D"">(shared by both src and dst hosts), then this one-time =
dumping when the<br class=3D"">migration completes is superfluous, but =
it's also harmless.<br class=3D""><br class=3D"">The interesting =
question is, what happens when you power down the VM on<br class=3D"">the =
destination host (=3D post migration), and launch it again there, =
from<br class=3D"">zero. In that case, the firmware executable file =
comes from the<br class=3D"">*destination host* (it was never =
persistently migrated from the source<br class=3D"">host, i.e. never =
written out on the dst). It simply comes from the OVMF<br =
class=3D"">package that had been installed on the destination host, by =
the<br class=3D"">sysadmin. However, the varstore pflash does reflect =
the permanent result<br class=3D"">of the previous migration. So this is =
where things can fall apart, if<br class=3D"">both firmware binaries (on =
the src host and on the dst host) don't agree<br class=3D"">about the =
internal structure of the varstore pflash.<br class=3D""><br =
class=3D"">Thanks<br class=3D"">Laszlo<br class=3D""><br class=3D""><br =
class=3D"">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br class=3D""><a =
href=3D"http://Groups.io" class=3D"">Groups.io</a> Links: You receive =
all messages sent to this group.<br class=3D""><br class=3D"">View/Reply =
Online (#54845): <a href=3D"https://edk2.groups.io/g/devel/message/54845" =
class=3D"">https://edk2.groups.io/g/devel/message/54845</a><br =
class=3D"">Mute This Topic: <a =
href=3D"https://groups.io/mt/71141681/1755084" =
class=3D"">https://groups.io/mt/71141681/1755084</a><br class=3D"">Group =
Owner: <a href=3D"mailto:devel+owner@edk2.groups.io" =
class=3D"">devel+owner@edk2.groups.io</a><br class=3D"">Unsubscribe: <a =
href=3D"https://edk2.groups.io/g/devel/unsub" =
class=3D"">https://edk2.groups.io/g/devel/unsub</a> &nbsp;[<a =
href=3D"mailto:afish@apple.com" class=3D"">afish@apple.com</a>]<br =
class=3D"">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br class=3D""><br=
 class=3D""></div></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_656EDCE8-0EB3-47A4-A1F9-C2C49993C4D8--

