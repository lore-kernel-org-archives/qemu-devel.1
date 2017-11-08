Received: from eggs.gnu.org ([2001:4830:134:3::10]:49223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCYWy-0003hV-Cv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCYWx-0005mx-F3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:09:08 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171108215212.GW3111@localhost.localdomain>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106201332.GA2152@flamenco>
	<73e9c472-82da-b293-27cd-ca9e0ff93179@linaro.org>
	<20171108215212.GW3111@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:08:35 -0800
Message-ID: <CAKmqyKNOSdKjxJUVq0dtu7h4ELLqnvT27HDbe_FpVn+tyy7agw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Emilio G. Cota" <cota@braap.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Wed, Nov 8, 2017 at 1:52 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Nov 08, 2017 at 10:29:43PM +0100, Richard Henderson wrote:
>> On 11/06/2017 09:13 PM, Emilio G. Cota wrote:
>> > Subject: [PATCH] qom: move CPUClass.tcg_initialize to a global
>> >
>> > 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
>> > introduces a per-CPUClass bool that we check so that the target CPU
>> > is initialized for TCG only once. This works well except when
>> > we end up creating more than one CPUClass, in which case we end
>> > up incorrectly initializing TCG more than once, i.e. once for
>> > each CPUClass.
>> >
>> > This can be replicated with:
>> >   $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
>> >       -global driver=xlnx,,zynqmp,property=has_rpu,value=on
>> > In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
>> > whereas the "regular" CPUs are prefixed by "cortex-a53-". This
>> > results in two CPUClass instances being created.
>> >
>> > Fix it by introducing a static variable, so that only the first
>> > target CPU being initialized will initialize the target-dependent
>> > part of TCG, regardless of CPUClass instances.
>>
>> Hah!
>>
>> So, I had been thinking of the xylinx ARM + Microblaze case, where we really do
>> need two different initializations.  I never imagined that two different ARM
>> parts had different CPUClasses.
>
> Is xylinx ARM + Microblaze something that already works (and
> would be broken by this patch), or something planned for the
> future?

Something planned for the future, it has never worked.

Alistair

>
>>
>> So I guess it's my initial patch that unified this that's more buggy than not.
>
> We still have the option of reverting the original patch, but (if
> it doesn't break anything) this patch looks like a simpler fix
> for 2.11 than a full revert.
>
> --
> Eduardo
>
