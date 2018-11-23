Received: from eggs.gnu.org ([2001:4830:134:3::10]:41062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQGbo-0008IA-Gy
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQGZr-0005Hw-4Q
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:53:19 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQGZq-0005FR-W3
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:53:19 -0500
Received: by mail-oi1-x243.google.com with SMTP id 192-v6so10701693oii.6
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<CAFEAcA_8jJz5dE7XP4R=LjEC5WzP3jzutg=YqiYjJVwZZz+jvQ@mail.gmail.com>
	<20181123182415.GP18284@habkost.net>
In-Reply-To: <20181123182415.GP18284@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 18:53:07 +0000
Message-ID: <CAFEAcA-WwupF9Lm85+S4YSq1f5Y0AjEOtG0Uzh=7pDVdF0w38A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Fri, 23 Nov 2018 at 18:24, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Nov 23, 2018 at 06:14:28PM +0000, Peter Maydell wrote:
> > One thing I would like to do with this new "cpu cluster"
> > concept is to use it to handle a problem we have at the
> > moment with TCG, where we assume all CPUs have the same
> > view of physical memory (and so if CPU A executes from physical
> > address X it can share translated code with CPU B executing
> > from physical address X). The idea is that we should include
> > the CPU cluster number in the TCG hash key that we use to
> > look up cached translation blocks, so that only CPUs in
> > the same cluster (assumed to have the same view of memory
> > and to be identical) share TBs.
> >
> > If we don't have a unique integer key for the cluster, what
> > should we use instead ?
>
> This sounds like a reasonable use of cluster_id as implemented in
> this patch.  The ID would be only used internally and not exposed
> to the outside, right?

It would be internal to QEMU (not exposed to the guest or
to the user), yes.

> I'm more worried about cases where we could end up exposing the
> ID in an external interface (either to guests, or through QMP or
> the command-line).  This happened to cpu_index and we took a long
> time to fix the mess.

I see, thanks.

My other question about this code was a slightly different one -- are
we guaranteed to be holding the iothread lock when we create
new QOM objects? (ie that we won't have races between two threads
which both try to create new objects and increment the variable)

thanks
-- PMM
