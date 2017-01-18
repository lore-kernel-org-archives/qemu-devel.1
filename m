Received: from eggs.gnu.org ([2001:4830:134:3::10]:59760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTvPG-00052t-V7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTvPC-0000ra-45
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cTvPB-0000rA-UY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:56:22 -0500
References: <1484743490-24721-1-git-send-email-thuth@redhat.com>
	<CAKmqyKM5RfdR63XDQXKh5Yu6+s5GwAgj8i95AJAfgPaN8HiGYw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b37aa0c3-2baa-0256-7f55-87012c9002b9@redhat.com>
Date: Wed, 18 Jan 2017 19:56:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM5RfdR63XDQXKh5Yu6+s5GwAgj8i95AJAfgPaN8HiGYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/core/null-machine: Add the
 possibility to instantiate a CPU and RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18.01.2017 18:57, Alistair Francis wrote:
> On Wed, Jan 18, 2017 at 4:44 AM, Thomas Huth <thuth@redhat.com> wrote:
>> Sometimes it is useful to have just a machine with CPU and RAM, without
>> any further hardware in it, e.g. if you just want to do some instruction
>> debugging for TCG with a remote GDB attached to QEMU, or run some embedded
>> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
>> features a "dummy" machine, and xtensa a "sim" machine for exactly this
>> purpose.
>> All target architectures have nowadays also a "none" machine, which would
>> be a perfect match for this, too - but it currently does not allow to add
>> CPU and RAM yet. Thus let's add these possibilities in a generic way to the
>> "none" machine, too, so that we hopefully do not need additional "dummy"
>> machines in the future anymore (and maybe can also get rid of the already
>> existing "dummy"/"sim" machines one day).
>> Note that the default behaviour of the "none" machine is not changed, i.e.
>> no CPU and no RAM is instantiated by default. You have explicitely got to
>> specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
>> these new features.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v3:
>>  - Get rid of the cpu_init_def() wrapper again, make null-machine.o
>>    target dependent instead and use cpu_init() directly.
>>  - Omit the loader code for the "-kernel" option for now (users can
>>    use "-device loader,..." instead). We can add code for the -kernel
>>    parameter later (either an implementation or a warning), once we've
>>    decided how it should behave for the "none" machine.
> 
> I think there should at least be a warning to start with though. It
> seems confusing that no errors are reported but the argument is
> ignored.

I'm still rather in favor of adding the hunk here that calls the generic
loader for "-kernel" ... anyway, we can add either behavior with a later
patch. So far the "none" machine never reported an error here, so this
is not a regression if we do not have this right from the start.

 Thomas
