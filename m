Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQjAy-0002Sa-Q1
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQjAv-0006X5-N5
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:25:32 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQjAv-0006Vh-AO
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:25:29 -0500
Date: Sat, 24 Nov 2018 20:25:25 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181125012525.GA22864@flamenco>
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org>
	<CAL1e-=gL0s2-zLgBYQrW1=VSOB=LepzDgDS08P7qGNAiOynsyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1e-=gL0s2-zLgBYQrW1=VSOB=LepzDgDS08P7qGNAiOynsyg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Sun, Nov 25, 2018 at 01:25:25 +0100, Aleksandar Markovic wrote:
> > Note: some architectures (at least PPC, there might be others) clear
> > the status flags passed to softfloat before most FP operations. This
> > precludes the use of hardfloat, so to avoid introducing a performance
> > regression for those targets, we add a flag to disable hardfloat.
> > In the long run though it would be good to fix the targets so that
> > at least the inexact flag passed to softfloat is indeed sticky.
> 
> Can you elaborate more on this paragraph?

Sure. We only use hardfloat when the inexact flag is already
set. If it isn't, we defer to softfloat. This is done for two
reasons:

- Computing the inexact flag requires duplicating
  most of what softfloat does, so it's not worth doing. Note
  that clearing and reading the host's fp flags is even
  slower, so that's not an option.

- The inexact flag is raised *very* frequently. The flag
  remains set (in the guest) unless guest code explicitly
  clears it, which few guest workloads do.

It therefore makes sense for hardfloat to only kick in once
the inexact flag has already been set.

Most targets directly keep the guest's FP flags in the same
struct (float_status) that is passed to softfloat ops.
PPC, however, keeps the state of the guest FP flags in one
place, and passes a pristine float_status to softfloat code
every time it calls it. Thus, given that hardfloat is
entirely implemented in softfloat.c, PPC targets cannot
currently take advantage of it.

Changing this in the PPC target is not impossible, but it will
require additional work that I'm not doing in this series, hence
my note. So for now, PPC targets just have hardfloat disabled
at compile time, which avoids adding overhead for a feature
that they cannot use.

Let me know if anything is unclear. Cheers,

		Emilio
