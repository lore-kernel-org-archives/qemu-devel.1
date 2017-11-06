Received: from eggs.gnu.org ([2001:4830:134:3::10]:54422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eBqte-0008VW-J2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 18:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eBqtd-0002Vl-Kn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 18:33:38 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171106232145.GA25246@flamenco>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106215454.GB2152@flamenco>
	<CAKmqyKOSOHdpzfu_WMPWo6Mh_kfmYhem0nR=BD3_hUws0tGEww@mail.gmail.com>
	<20171106232145.GA25246@flamenco>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 6 Nov 2017 15:33:05 -0800
Message-ID: <CAKmqyKM20ibTxSFQ5FE_fzgOkcHfjXmrK36mpKswz=ZPwfMshA@mail.gmail.com>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Nov 6, 2017 at 3:21 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Mon, Nov 06, 2017 at 14:32:35 -0800, Alistair Francis wrote:
>> Sorry for the silence here, I noticed these were broken just before I
>> went on holidays but didn't get a chance to fix anything.
>>
>> For the Xilinx case I was thinking of patching the machine code to
>> sanely follow the -smp option.
>>
>> -smp 1 -> Only create 1 A53
>> -smp 4 -> Create 4 A53s
>> -smp 6 -> Create all the CPUs
>>
>> I see a lot of advantages in not forcing the smallest number of CPUs
>> to be 4 unless we really have to.
>>
>> I do see a nice advantage in being able to set the default smp option
>> to something not 1 so the default closely matches hardware, but users
>> can override that if they want to.
>>
>> So for the patch below I like the default_cpus option, but for Xilinx
>> at least I would like to patch the logic to follow the -smp option
>> instead of force a minimum.
>
> Agreed, honouring -smp would be the right fix.
> Just note that since this is a regression we need the fix to
> be in for 2.11.

Ok, I can spin up a patch for the Xilinx boards in the next day (maybe 2)

>
> I just took a look at the non-Xilinx boards. It seems simple enough to
> substitute the hard-coded value for smp_cpus, but yet again
> I see "Property" structs that I'm not sure what to do with.
> For instance, bcm2836.c:152:
>
> static Property bcm2836_props[] = {
>     DEFINE_PROP_UINT32("enabled-cpus", BCM2836State, enabled_cpus, BCM2836_NCPUS),
>     DEFINE_PROP_END_OF_LIST()
> };
>
> What is the purpose here? To enable/disable CPUs with -global args,
> just like it's done for the Xilinx boards? Shouldn't we just use
> -smp for that?

Hmm...

>
> Also, note that I don't have a way to test these boards, which
> explains why I'm reluctant to change board code. But of
> course if board maintainers step in, I'm all for it :-)

Yeah, I see.

What about if we set default_cpus to the -smp option that is expected.
Then on some of the older boards (like the bcm2836) we print a warning
in the machine init() if the -smp option doesn't match that?

That way the default args work, we allow users to specify a overwrite
but we warn them that it might not work and it ensures all boards
follow a similar flow.

Then if we can test the boards and know that -smp 1 works we can
remove the warning.

Thanks,
Alistair

>
> Thanks,
>
>                 Emilio
>
