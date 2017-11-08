Received: from eggs.gnu.org ([2001:4830:134:3::10]:41182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXuw-0000t4-Eq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXut-0003j6-Cx
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:29:50 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:48072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCXut-0003i8-6M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:29:47 -0500
Received: by mail-wr0-x242.google.com with SMTP id k61so3720500wrc.4
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:29:46 -0800 (PST)
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106201332.GA2152@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73e9c472-82da-b293-27cd-ca9e0ff93179@linaro.org>
Date: Wed, 8 Nov 2017 22:29:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171106201332.GA2152@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 11/06/2017 09:13 PM, Emilio G. Cota wrote:
> Subject: [PATCH] qom: move CPUClass.tcg_initialize to a global
> 
> 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
> introduces a per-CPUClass bool that we check so that the target CPU
> is initialized for TCG only once. This works well except when
> we end up creating more than one CPUClass, in which case we end
> up incorrectly initializing TCG more than once, i.e. once for
> each CPUClass.
> 
> This can be replicated with:
>   $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
>       -global driver=xlnx,,zynqmp,property=has_rpu,value=on
> In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
> whereas the "regular" CPUs are prefixed by "cortex-a53-". This
> results in two CPUClass instances being created.
> 
> Fix it by introducing a static variable, so that only the first
> target CPU being initialized will initialize the target-dependent
> part of TCG, regardless of CPUClass instances.

Hah!

So, I had been thinking of the xylinx ARM + Microblaze case, where we really do
need two different initializations.  I never imagined that two different ARM
parts had different CPUClasses.

So I guess it's my initial patch that unified this that's more buggy than not.


r~
