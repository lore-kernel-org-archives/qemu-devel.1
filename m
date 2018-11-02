Received: from eggs.gnu.org ([2001:4830:134:3::10]:59062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdSs-0004c3-Ta
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdSf-0004DA-8h
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:42:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIdSZ-0003lu-Ji
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:42:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so409611wrs.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 10:41:47 -0700 (PDT)
References: <20181102115239.22485-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64c84ad5-614d-58c8-29a5-86df6d851161@redhat.com>
Date: Fri, 2 Nov 2018 18:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181102115239.22485-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1 0/4] configure: symlink
 directories, not wildcarded files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

On 2/11/18 12:52, Peter Maydell wrote:
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
> In v1 of this patchset I addressed this by changing configure
> to make tests/acpi-test-data itself a symlink. Unfortunately
> this has an awkward consequence that if we did that and
> a developer switched git branches from one after that change
> to one before it then configure would end up trashing all
> the test files by making them symlinks to themselves.
> So instead in v2, we move all the data files to the tests/data/
> directory. tests/data/ is already symlinked as a directory,
> so there is no problem for bisection.
> 
> Patch 1 does that for tests/acpi-test-data.
> Patch 2 does that for tests/hex-loader-check-data.
> Patch 3 is a cleanup, renaming a variable and adding
> documentation so that it's clearer that symlinking can
> be used for directories and that wildcarding files is bad.
> Patch 4 rolls some ad-hoc symlinking into the common loop.
> 
> We do still use wildcarding to construct a list of files in
> pc-bios to be symlinked; we get away with this because we don't
> in practice add new BIOS images often and if we do there's also
> usually a change that means configure is rerun anyway. We can't
> just symlink all of pc-bios into the build tree because it
> contains other things than just generated binaries. There
> might be scope for fixing this, but I wanted to get this fix out.
> 
> thanks
> -- PMM
> 
> Peter Maydell (4):
>    tests: Move tests/acpi-test-data/ to tests/data/acpi/
>    tests: Move tests/hex-loader-check-data/ to tests/data/hex-loader/
>    configure: Rename FILES variable to LINKS
>    configure: Use LINKS loop for all build tree symlinks

I left one comment about when using rebuild-expected-aml.sh
in out-of-tree builds. Anyway for the series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
