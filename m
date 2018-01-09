Received: from eggs.gnu.org ([2001:4830:134:3::10]:44250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eYyyo-0003Lw-Lz
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eYyyY-00056q-Dd
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:50:34 -0500
Date: Tue, 9 Jan 2018 19:48:45 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180109184845.e2ma4po2sibogkua@kamzik.brq.redhat.com>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
	<6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
	<CAFEAcA-Nn4VmSnxT7Of8Nh+p5QgF9cMzkqZ-VBCC=2zRgk-Xdw@mail.gmail.com>
	<e40cc107-2fe9-d8a5-b4fd-385c0d22c564@redhat.com>
	<CAFEAcA8QqEna4u92bk88++Y1JrpCJD=KDpSfbJ8DhfSiTRm+=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8QqEna4u92bk88++Y1JrpCJD=KDpSfbJ8DhfSiTRm+=w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Wei Huang <wei@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, cdall@linaro.org

On Tue, Jan 09, 2018 at 04:35:30PM +0000, Peter Maydell wrote:
> On 9 January 2018 at 16:29, Laszlo Ersek <lersek@redhat.com> wrote:
> > On 01/09/18 17:12, Peter Maydell wrote:
> >> On 9 January 2018 at 15:58, Laszlo Ersek <lersek@redhat.com> wrote:
> >>> Sorry, no clue about any of this -- where should I read up?
> >>
> >> I cc'd you mostly as a heads-up since the QEMU bug is UEFI affecting,
> >> not because I wanted to make you read the GIC specs :-)
> >
> > Thanks (and, thanks :) ) -- from patch #2, looks like GICv2 is affected
> > too, and the patch seems to be fixing commit a9d853533cc1
> > ("hw/intc/arm_gic: Switch to read/write callbacks with tx attributes",
> > 2015-05-12).
> >
> > Is that right? That commit was released with v2.4.0. Should I have
> > experienced the error? Is it KVM / hardware specific? What are the symptoms?
> 
> Happens under TCG emulation only. The bug got introduced with
> commit c79c0a314c43b78f6, which changed the effect of a device
> returning MEMTX_ERROR/MEMTX_DECODE_ERROR from "RAZ/WI" to
> "guest data abort". That's in general the right thing to do,
> but in the case of these device models we were returning those
> values for cases which aren't supposed to provoke aborts.
> 
> The symptom is that if your guest code is poorly behaved and
> tries to read or write offsets that don't correspond to documented
> GIC registers, it will take an abort that it didn't before.
> Linux is fine; this UEFI image I have lying around stopped working.

Thanks for pointing this out. I had just recently noticed that the
'gicv3-active' kvm-unit-tests test had stopped passing on TCG, getting
DABTs when attempting to write GICD_ICACTIVER. I was just about to
complain in this thread that that register is indeed documented, but
now I see the implementation of the test was always wrong. It was using
the wrong register base, RD vs. SGI...

drew
