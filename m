Received: from eggs.gnu.org ([2001:4830:134:3::10]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRzVY-0004lk-JL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRzVX-0006cW-GP
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:54:56 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRzVX-0006cE-C0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:54:55 -0500
Received: by mail-vk0-x233.google.com with SMTP id r136so30944995vke.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 02:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 10:54:33 +0000
Message-ID: <CAFEAcA9fENz1=__4-upW=HLZJ50pAYkA4H2T13wDs62PNDXK3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/67] ppc-for-2.9 queue 20170112
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 12 January 2017 at 02:02, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit b44486dfb9447c88e4b216e730adcc780190852c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' into staging (2017-01-10 14:52:34 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170112
>
> for you to fetch changes up to 229b5b6b56db9c3e6b8f44b4b55a62fa32979f47:
>
>   ppc: Fix a warning in bcdcfz code and improve BCD_DIG_BYTE macro (2017-01-12 10:21:49 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-01-12
>
> This is the first ppc pull request for qemu-2.9.  It's been a while
> coming, partly due to dealing with some problems running my usual set
> of tests.  So, there's quite a lot in here.
>
>     * More POWER9 instruction implementations for TCG
>     * The simpler parts of my CPU compatibility mode cleanup
>         * This changes behaviour to prefer compatibility modes over
>           "raW" mode for new machine type versions
>     * New "40p" machine type which is essentially a modernized and
>       cleaned up "prep".  The intention is that it will replace "prep"
>       once it has some more testing and polish.
>     * Add pseries-2.9 machine type
>     * Implement H_SIGNAL_SYS_RESET hypercall
>     * Consolidate the two alternate CPU init paths in pseries by
>       making it always go through CPU core objects to initialize CPU
>     * A handful of bugfixes and cleanups
>
> There are also some changes not strictly related to ppc code, but for
> its benefit:
>
>     * Limit the pxi-expander-bridge (PXB) device to x86 guests only
>       (it's essentially a hack to work around historical x86
>       limitations)
>     * Revise a number of qtests and enable them for ppc

Hi -- this fails "make check" on OSX host:

  GTESTER check-qtest-ppc64
qemu-system-ppc64: -object
memory-backend-file,id=mb1,size=1M,share,mem-path=/dev/shm/qtest-68237-4247260626:
invalid object type: memory-backend-file
Broken pipe
GTester: last random seed: R02Sc13bf53b8b3055a3c30552f67d7c263b
**
ERROR:/Users/pm215/src/qemu-for-merges/tests/libqos/pci.c:412:void
qpci_plug_device_test(const char *, const char *, uint8_t, const char
*): assertion failed: (!qdict_haskey(response, "error"))
GTester: last random seed: R02Sf3594a21c711ec941d5f4c89724ce12d
qemu-system-ppc64: -device ivshmem-plain,memdev=mb1: 'ivshmem-plain'
is not a valid device model name
Broken pipe

It looks like you've enabled the ivshmem test unconditionally,
but it should only be turned on if CONFIG_EVENTFD is true, see
how we do this for x86:

check-qtest-pci-$(CONFIG_EVENTFD) += tests/ivshmem-test$(EXESUF)
gcov-files-pci-y += hw/misc/ivshmem.c

Q: can we just enable these tests for PCI with
check-qtest-ppc64-y += $(check-qtest-pci-y)
gcov-files-ppc64-y += $(gcov-files-pci-y)

the way we do for i386/x86_64 ? Or is that doing too much
unwanted extra testing?

thanks
-- PMM
