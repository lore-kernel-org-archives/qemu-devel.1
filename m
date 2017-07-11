Received: from eggs.gnu.org ([2001:4830:134:3::10]:59755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV3Pl-0001nR-LG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV3Pg-0003ps-Lv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dV3Pg-0003pc-Fa
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:13:48 -0400
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
Date: Wed, 12 Jul 2017 00:13:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Ben Warren <ben@skyportsystems.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/11/17 22:42, Peter Maydell wrote:
> On 11 July 2017 at 20:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Tue, Jul 11, 2017 at 05:49:07PM +0100, Peter Maydell wrote:
>>> The good news is it's not aarch64-specific. I just hit this on
>>> a build on x86_64 host, gcc, debug build:
>>>
>>>   GTESTER check-qtest-x86_64
>>> **
>>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/vmgenid-test.c:65:acpi_find_vgia:
>>> assertion failed (ACPI_ASSERT_CMP_str == "RSDT"): ("" == "RSDT")
>>> GTester: last random seed: R02S9eefaf38297e67e4f67d5db77989350e
>>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:826:
>>> recipe for target 'check-qtest-x86_64' failed
> 
>> Couldn't reproduce here. I suspect VM didn't start at all.
>> Am I right to assume this is without KVM?
> 
> On aarch64 host, definitely without KVM. On x86-64 host,
> I think it is without KVM but am not totally sure.
> 
> It may be one of those cases that only triggers if the
> host is heavily loaded at the time the test is running.

(I apologize if the root cause is obvious at this point -- I'm unclear
if the discussion is now about understanding the failure, or about ways
to mitigate it. I'm assuming the former.)

This test can occasionally fail because the test case has to wait until
the guest firmware proceeds far enough with executing the ACPI
linker/loader script. See RSDP_SLEEP_US and RSDP_TRIES_MAX in
acpi_find_vgia(). If the test case pokes at guest RAM "too early", using
monitor commands, then the guest fw will not have yet shaped guest RAM
as required.

(Again, apologies if this has been obvious all along.)

Thanks
Laszlo
