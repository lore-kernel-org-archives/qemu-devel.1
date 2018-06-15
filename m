Received: from eggs.gnu.org ([2001:4830:134:3::10]:39531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkU4-0002e4-2t
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkU3-0006n2-Ei
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:53:28 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTkU3-0006mI-9D
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:53:27 -0400
Received: by mail-ot0-x241.google.com with SMTP id l15-v6so10202507oth.6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 01:53:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2f81a60-6b05-1240-ab18-69d46a29185e@redhat.com>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-6-peter.maydell@linaro.org>
	<e2f81a60-6b05-1240-ab18-69d46a29185e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 09:53:06 +0100
Message-ID: <CAFEAcA-kmhb4igH2gihSsOe4JFP1u8yienOBDqWvCvqjexftFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/13] hw/misc/tz-mpc.c: Implement the
 Arm TrustZone Memory Protection Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 15 June 2018 at 08:10, Auger Eric <eric.auger@redhat.com> wrote:
> after reading 8/13, I have a doubt here about the ret.perm value that
> stays IOMMU_RW independently on the translation success. Usually if the
> translation failn perm is set to IOMMU_NONE. In your case you also play
> with the output address space which switches to the blocked one in case
> of failure and you handle access failure through that means. So maybe
> the end result is the same but I am not sure.

The end result is different, which is why we have to return RW here.
If we return NONE we are telling the caller that this will be
a memory transaction failure, so the CPU emulation will generate
a bus-error kind of exception. By returning RW we tell the caller
that it should make transactions for this address. We can then
handle them in the MPC with the correct behaviour for a blocked
access (generating an interrupt, and configurably either completing
the access as RAZ/WI or returning MEMTX_ERROR to cause a busfault.)

thanks
-- PMM
