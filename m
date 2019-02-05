Received: from eggs.gnu.org ([209.51.188.92]:36846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoWC-0001Gk-SS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoWB-0001i9-3g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:23:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqoWA-0001hT-U2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:23:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so1812034wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 16:23:14 -0800 (PST)
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-5-lersek@redhat.com>
	<20190204124613-mutt-send-email-mst@kernel.org>
	<e9e9ed1d-0675-6a6e-1706-b6a23169719c@redhat.com>
	<20190204142534-mutt-send-email-mst@kernel.org>
	<d4e8a405-cfb5-a302-bc7f-34537f2d7fcf@redhat.com>
	<20190204165316-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2570198-bd70-252c-b5cb-05e4676b71a2@redhat.com>
Date: Tue, 5 Feb 2019 01:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190204165316-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 2/4/19 10:55 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 08:46:33PM +0100, Philippe Mathieu-Daudé wrote:
>> On 2/4/19 8:32 PM,  Michael S. Tsirkin wrote:
>>> On Mon, Feb 04, 2019 at 07:41:38PM +0100, Laszlo Ersek wrote:
>>>> On 02/04/19 18:47, Michael S. Tsirkin wrote:
>>>>> On Mon, Feb 04, 2019 at 05:03:24PM +0100, Laszlo Ersek wrote:
>>>>>> Introduce the following build scripts under "tests/uefi-test-tools":
[...]>>>>>> +# In turn, the "build" utility of edk2 BaseTools invokes
another "make".
>>>>>> +# Although the outer "make" process advertizes its job server to all child
>>>>>> +# processes via MAKEFLAGS in the environment, the outer "make" closes the job
>>>>>> +# server file descriptors (exposed in MAKEFLAGS) before executing a recipe --
>>>>>> +# unless the recipe is recognized as a recursive "make" recipe. Recipes that
>>>>>> +# call $(MAKE) are classified automatically as recursive; for "build.sh" below,
>>>>>> +# we must mark the recipe manually as recursive, by using the "+" indicator.
>>>>>> +# This way, when the inner "make" starts a parallel build of the target edk2
>>>>>> +# module, it can communicate with the outer "make"'s job server.
>>>>>> +Build/bios-tables-test.%.efi: build-edk2-tools
>>>>>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
>>>>>
>>>>> Does this actually work with an out of tree build?
>>>>
>>>> It's not supposed to.
>>>>
>>>> Again, it's not something that a normal QEMU build includes. It is only
>>>> for maintainers to rebuild when there is a reason to do so. The output
>>>> binaries are tracked by git, and will be used as-is (in binary form) by
>>>> the ACPI test suite. If there are updates to the UEFI source code, the
>>>> binaries will have to be rebuilt by a maintainer (or by me, if I submit
>>>> the UEFI code changes), and the refreshed blobs are to be checked into
>>>> git. Think iPXE oproms for an analogy.
>>>>
>>>>> Shouldn't this be SRC_PATH/tests/uefi-test-tools/ ?
>>>>
>>>> No; nothing under roms/ is built like that, and the same applies to this
>>>> patch as well.
>>>>
>>>> *Conceptually*, this patch is for roms/. However, in earlier discussion,
>>>> it was suggested that roms/ be kept dedicated to external git submodules
>>>> only, and that we not add such ROM source to roms/ whose master repo is
>>>> genuinely the QEMU repo. Please see the sub-thread at:
>>>>
>>>>   Re: [PATCH 10/14] tests: acpi: ignore SMBIOS tests when UEFI firmware is used
>>>>   http://mid.mail-archive.com/20190116115217.jduhqrwbjhuibmoq@sirius.home.kraxel.org
>>>>
>>>> The last idea was that the UEFI source code should be kept in a direct
>>>> subdirectory of tests/ (rather than in roms/). And the binaries should
>>>> go under tests/data/uefi-boot-images/ (rather than pc-bios/).
>>>>
>>>> Thanks
>>>> Laszlo
>>>
>>> Hmm I see. You see rebuild-expected-aml.sh does not work
>>> like this at all. It works fine with an out of tree build:
>>> check it out.
>>
>> But rebuild-expected-aml.sh does not depend of roms/.
> 
> It absolutely depends on pc-bios/bios.bin

Oh you are right!

I'm taking notes for an eventual future cleanup.

Regards,

Phil.
