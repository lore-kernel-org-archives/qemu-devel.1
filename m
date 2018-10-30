Received: from eggs.gnu.org ([2001:4830:134:3::10]:41750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTeg-0004ev-Mt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTee-0003z2-H4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:01:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHTed-0003us-2w
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:01:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id q25so10944129otn.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:01:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030125005.28151-1-peter.maydell@linaro.org>
References: <20181030125005.28151-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:01:28 +0000
Message-ID: <CAFEAcA_JvsqWPgauPmtp_jdgNOwi2zwcHexPSiLE-Eka+PcDTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] configure: symlink directories,
 not wildcarded files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 30 October 2018 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes a problem with our build infrastructure
> that meant that MST's recent 'pci, pc, virtio' pullreq failed
> tests.
>
> Currently our configure script has a wildcard loop that creates
> symlinks for every data file in tests/acpi-test-data from the
> source tree to the build tree. However, if a new data file is
> added in git, there is nothing that causes configure to be rerun,
> and so it is not available in the build tree, which can cause
> test failures.
>
> The core of the change here is that instead of linking every
> individual data file, we just symlink the directory itself (which
> we do in patch 2 for this and also tests/hex-loader-check-data).
> The rest of the patchset deals with:
>  * renaming a shell variable to make it clearer that it's OK
>    to put directories to symlink in it, not just files
>  * adding a comment about why wildcarding is a bad idea
>  * cleaning up a couple of places that did their own symlinking
>    when they could have just used the existing code
>
> We do still use wildcarding to construct a list of files in
> pc-bios to be symlinked; we get away with this because we don't
> in practice add new BIOS images often and if we do there's also
> usually a change that means configure is rerun anyway. We can't
> just symlink all of pc-bios into the build tree because it
> contains other things than just generated binaries. There's
> scope for fixing this, I think, but I wanted to get this fix out.

...having sent this out and moved on to something else, I have
discovered a problem with it. If you configure a build tree
using this, and then switch back to a git branch which has
the older configure, then that configure will end up trashing
all the tests/acpi-test-data and tests/hex-loader-check-data
files in the source tree by replacing them with symlinks to
themselves... This is fixable by doing "git checkout tests"
but it's a bit of a landmine for bisection :-(

thanks
-- PMM
