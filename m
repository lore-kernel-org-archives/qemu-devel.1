Received: from eggs.gnu.org ([2001:4830:134:3::10]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dadOe-0003QH-Ik
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dadOb-0003eX-W5
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:39:48 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dadOb-0003cR-Qn
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:39:45 -0400
Received: by mail-it0-f50.google.com with SMTP id h199so78664165ith.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 00:39:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726173543.GC3600@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
	<20170725133708.GE23343@stefanha-x1.localdomain>
	<fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
	<20170726173543.GC3600@stefanha-x1.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 27 Jul 2017 09:39:40 +0200
Message-ID: <CALAZnb0+=cYExGKszgROeA1TrpXc8zbXP_=+90jCWA70xMHHyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Jul 26, 2017 at 7:35 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jul 25, 2017 at 11:30:16AM -0400, Cleber Rosa wrote:
>> On 07/25/2017 09:37 AM, Stefan Hajnoczi wrote:
>> > On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
>> >> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> >> Reviewed-by: Fam Zheng <famz@redhat.com>
>> >> ---
>> >>  scripts/qemu.py               | 10 +++++-----
>> >>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>> >>  2 files changed, 14 insertions(+), 14 deletions(-)
>> >
>> > Please don't do this, it encourages code duplication.  Now arbitrary
>> > users can start accessing the public field directly instead of adding a
>> > reusable interfaces like add_monitor_telnet(), add_fd(), etc.
>> >
>>
>> Judging from tests/qemu-iotests/iotests.py:VM and your comment above, I
>> assume you see value in simple wrappers such as:
>>
>>    def add_device(self, opts):
>>         self._args.append('-device')
>>         self._args.append(opts)
>>         return self
>>
>> I honestly do not see any value here.  I do see value in other wrappers,
>> such as add_drive(), in which default values are there for convenience,
>> and a drive count is kept.  In the end, my point is that the there are
>> cases when a wrapper is just an annoyance and provides nothing more than
>>  the illusion of a better design.
>
> I don't see much value in simple wrappers either besides method chaining
> (more on that below).
>
> Getting back to this patch, I can only review patches in the context of
> the current code base.  I don't know future plans you may have.  The
> change may make sense together with other new changes that use a public
> args field in a useful way - it just doesn't make sense the way it has
> been presented in isolation.

We disagree on that. The current patch makes sense by itself. It
contains the changes in iotests.py, which has an instance of
QEMUMachine and is using the self._args.
My point mentioning the work to come is to provide yet another use case.

>
> About method chaining, the current code seems to be written with method
> chaining in mind:
>
> https://en.wikipedia.org/wiki/Method_chaining#Python
>
> If all arguments are methods then everything can be chained:
>
>   (vm.add_fd(fd.fileno(), 1, 'image0')
>      .add_drive('fd:image0', interface='none')
>      .add_device('virtio-blk-pci,drive=drive0'))
>
> So I guess there is a small value in having add_device().  That said,
> tests don't take advantage of method chaining much.
