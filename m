Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EGI-0001B4-2F
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EGH-0007Tj-0k
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:05:38 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:54772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5EGG-0007TK-Ri
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:05:36 -0400
Received: by mail-wr0-x244.google.com with SMTP id o44so9020306wrf.11
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:05:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019091507.GF8408@redhat.com>
References: <1508352023-28591-1-git-send-email-alindsay@codeaurora.org>
	<20171019091507.GF8408@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 18:05:15 +0100
Message-ID: <CAFEAcA-eUxmCTB=-gMwHDfxn2n01+cOULH6S211BybWex=7DiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] build: Fix dtc-checkout race condition in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Aaron Lindsay <alindsay@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19 October 2017 at 10:15, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Oct 18, 2017 at 02:40:23PM -0400, Aaron Lindsay wrote:
>> This was introduced by:
>>     commit aef45d51d1204f3335fb99de6658e0c5612c2b67
>>     Author: Daniel P. Berrange <berrange@redhat.com>
>>     Date:   Fri Sep 29 11:11:56 2017 +0100
>>
>>       build: automatically handle GIT submodule checkout for dtc
>>
>> On my system, I see the following with a fresh clone:
>>
>> % ./configure --disable-gtk --target-list=aarch64-softmmu
>> % make -j8
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>>   GEN     config-host.h
>> mkdir -p dtc/libfdt
>>   GIT     ui/keycodemapdb dtc
>> mkdir -p dtc/tests
>>   GEN     qemu-options.def
>> [snip]
>>   GEN     migration/trace.h
>> make: *** [git-submodule-update] Error 1
>> make: *** Waiting for unfinished jobs....
>>
>> Upon closer inspection, the root cause of the error is:
>>
>> % git submodule update --init ui/keycodemapdb dtc
>> fatal: destination path 'dtc' already exists and is not an empty directory.
>> Clone of 'git://git.qemu-project.org/dtc.git' into submodule path 'dtc' failed
>>
>> This patch fixes this race condition by forcing the 'dtc/%' rule which caused
>> 'dtc' to be non-empty to wait on '.git-submodule-status'.
>
> Yes this makes sense
>
>>
>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Thanks; applied to master as a buildfix.

-- PMM
