Received: from eggs.gnu.org ([2001:4830:134:3::10]:35571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwsS-00051u-Ft
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwsR-0008Km-LJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:35:52 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYwsR-0008KE-G4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:35:51 -0500
Received: by mail-oi0-x241.google.com with SMTP id t16so5660391oif.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e40cc107-2fe9-d8a5-b4fd-385c0d22c564@redhat.com>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
	<6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
	<CAFEAcA-Nn4VmSnxT7Of8Nh+p5QgF9cMzkqZ-VBCC=2zRgk-Xdw@mail.gmail.com>
	<e40cc107-2fe9-d8a5-b4fd-385c0d22c564@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:35:30 +0000
Message-ID: <CAFEAcA8QqEna4u92bk88++Y1JrpCJD=KDpSfbJ8DhfSiTRm+=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Drew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>

On 9 January 2018 at 16:29, Laszlo Ersek <lersek@redhat.com> wrote:
> On 01/09/18 17:12, Peter Maydell wrote:
>> On 9 January 2018 at 15:58, Laszlo Ersek <lersek@redhat.com> wrote:
>>> Sorry, no clue about any of this -- where should I read up?
>>
>> I cc'd you mostly as a heads-up since the QEMU bug is UEFI affecting,
>> not because I wanted to make you read the GIC specs :-)
>
> Thanks (and, thanks :) ) -- from patch #2, looks like GICv2 is affected
> too, and the patch seems to be fixing commit a9d853533cc1
> ("hw/intc/arm_gic: Switch to read/write callbacks with tx attributes",
> 2015-05-12).
>
> Is that right? That commit was released with v2.4.0. Should I have
> experienced the error? Is it KVM / hardware specific? What are the symptoms?

Happens under TCG emulation only. The bug got introduced with
commit c79c0a314c43b78f6, which changed the effect of a device
returning MEMTX_ERROR/MEMTX_DECODE_ERROR from "RAZ/WI" to
"guest data abort". That's in general the right thing to do,
but in the case of these device models we were returning those
values for cases which aren't supposed to provoke aborts.

The symptom is that if your guest code is poorly behaved and
tries to read or write offsets that don't correspond to documented
GIC registers, it will take an abort that it didn't before.
Linux is fine; this UEFI image I have lying around stopped working.

thanks
-- PMM
