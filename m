Received: from eggs.gnu.org ([2001:4830:134:3::10]:55604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY80F-000132-QT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY80E-0002jK-U5
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:15 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dY80E-0002j5-Nc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:44:14 -0400
Received: by mail-wm0-x233.google.com with SMTP id k69so19496160wmc.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:44:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 10:43:52 +0100
Message-ID: <CAFEAcA-9vJSoGu07fCudPhO4NVbrXN1N5T+LH4voQ97Yg1dBCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kamil Rytarowski <n54@gmx.com>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

Ping for review? It would be nice to get the NetBSD host into
the build-test rotation...

thanks
-- PMM

On 14 July 2017 at 09:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes the build on NetBSD by making sure we only
> build the ivshmem-client and ivshmem-server tools if the host OS
> actually supports ivshmem. (Previously we were only gating building
> of the within-QEMU ivshmem PCI device.)
>
> Most of this patchset is the work of Kamil Rytarowski; I just
> split it up into easily-reviewable patches and fixed a few bugs.
>
> Tested on Linux, on NetBSD, and on Linux with a '--disable-linux-user
> --disable-system' config (which was the one that was failing with
> our previous attempt to fix this bug).
>
> NB: we still have some things we need to fix to be able to put
> NetBSD into the build-test set. The next issue is that 'make check'
> fails with
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k --verbose -m=quick tests/check-qdict
> sh: arith: syntax error: "RANDOM % 255 + 1"
>
> likely because we're using a bashism there.
>
> thanks
> -- PMM
>
> Kamil Rytarowski (2):
>   configure: Use an explicit CONFIG_IVSHMEM rather than CONFIG_EVENTFD
>   configure: Don't build ivshmem tools unless CONFIG_IVSHMEM is set
>
> Peter Maydell (1):
>   configure: Rename CONFIG_IVSHMEM to CONFIG_IVSHMEM_DEVICE
>
>  configure               | 11 +++++++++++
>  Makefile                |  2 ++
>  Makefile.objs           |  4 ++--
>  hw/misc/Makefile.objs   |  2 +-
>  tests/Makefile.include  |  4 ++--
>  default-configs/pci.mak |  2 +-
>  6 files changed, 19 insertions(+), 6 deletions(-)
