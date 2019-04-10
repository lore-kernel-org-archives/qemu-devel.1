Received: from eggs.gnu.org ([209.51.188.92]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5or-0004MW-1n
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5op-0005Gw-RB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE5op-0005GE-Ha
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:30:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
	<CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
	<CAFEAcA9S0H=tX4wZOxwbar-UpxH3D+JUc0_6VRStz_doRKmB+g@mail.gmail.com>
Date: Wed, 10 Apr 2019 07:30:37 +0200
In-Reply-To: <CAFEAcA9S0H=tX4wZOxwbar-UpxH3D+JUc0_6VRStz_doRKmB+g@mail.gmail.com>
	(Peter Maydell's message of "Tue, 9 Apr 2019 21:28:41 +0100")
Message-ID: <8736mq4ebm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sergio Lopez <slp@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>, David Gibson <david@gibson.dropbear.id.au>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 9 Apr 2019 at 21:15, Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Tue, Apr 9, 2019 at 1:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> > On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
>> > >
>> > > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>> > > computation of @dt_size overflows to a negative number, which then
>> > > gets converted to a very large size_t for g_malloc0() and
>> > > load_image_size().  In the (fortunately improbable) case g_malloc0()
>> > > succeeds and load_image_size() survives, we'd assign the negative
>> > > number to *sizep.  What that would do to the callers I can't say, but
>> > > it's unlikely to be good.
>> > >
>> > > Fix by rejecting images whose size would overflow.
>> > >
>> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >
>> > I think this patch is missing some attributions for the
>> > security researchers who found the issue initially.
>> > PJP's patch for this from a couple of weeks back has a
>> > reported-by credit:
>> > https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

Uh, I missed that thread.  Thanks for doing my homework for me!

>> It seems like from that discussion that this patch is the correct approach.
>>
>> I can add the attributions and send a PR for 4.0. I'll send it by EOD
>> unless anyone has any objections.
>
> Thanks. I think given it's 21:30 here I'm going to postpone
> tagging rc3 til tomorrow (mid-afternoon UK time). I'm still
> hoping we can avoid an rc4...

Want me to look for a few more integer overflows today?  ;-P
