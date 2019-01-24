Received: from eggs.gnu.org ([209.51.188.92]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmiS9-0003Mi-Ka
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmiS1-00058b-Pl
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:06:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gmiS0-00056m-EY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:06:00 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-5-lersek@redhat.com>
	<fd79f085-f3d8-dc06-9d43-9c4fcea69317@redhat.com>
	<8d4dc6b0-d4d9-2919-194f-c27cb40699b3@redhat.com>
	<CAFEAcA8uVAXMuwVk2ZLAP34Hk_tp9dvWjy06gauyohesOvCuNg@mail.gmail.com>
	<5cc9c1e9-4fd7-27c4-46bc-2388148945c5@redhat.com>
	<90bd9ea1-916e-f3ae-d4dc-f0f69b7400c2@redhat.com>
Message-ID: <a22215af-86f1-9191-a596-81e02d6e15cb@redhat.com>
Date: Thu, 24 Jan 2019 18:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <90bd9ea1-916e-f3ae-d4dc-f0f69b7400c2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 01/23/19 17:13, Laszlo Ersek wrote:

> FWIW, I've asked
> 
> - both on edk2-devel, about adding .NOTPARALLEL to the generated inner
> makefiles:
> 
>   "parallelism in the module-level, generated GNUmakefile's"
>   https://lists.01.org/pipermail/edk2-devel/2019-January/035463.html
> 
> - and on help-make, about safely filtering the job-related options from
> MAKEFLAGS, between the outer and inner "make" processes:
> 
>   "filtering job options from MAKEFLAGS, manually"
>   http://lists.gnu.org/archive/html/help-make/2019-01/msg00003.html

Results:

- The "build" utility in BaseTools generates such GNUMakefiles that
dependencies between targets are fully described. This is an explicit
goal and if we notice any missing deps, that's a bug to be reported and
fixed. As a consequence, we can expect the recipes in those GNUMakefiles
to be fully parallelizable. Therefore we need not add .NOTPARALLEL to
them (in the edk2 project), or filter MAKEFLAGS, or append "-j1" to
MAKEFLAGS.

- The .NOTPARALLEL target ignores any pre-requisites it gets;
.NOTPARALLEL applies to the entire current invocation of make. Therefore
we just need to stick a bare .NOTPARALLEL into
"tests/uefi-test-tools/Makefile", to keep "build" itself isolated.

I'm going to post v2 with this one addition (i.e., .NOTPARALLEL).

Thanks,
Laszlo
