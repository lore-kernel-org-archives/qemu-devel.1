Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diZu4-0002Mx-Ph
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diZu1-0001Gf-MG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diZu1-0001GD-G7
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:33:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	<87lgmluw2g.fsf@dusky.pond.sub.org>
	<ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com>
	<87fucq86wh.fsf@dusky.pond.sub.org>
	<CAKmqyKOnhGZ6Ei+gSdmOBjHGpVt+G6_J4VF6GVkTCAt1_8GV4w@mail.gmail.com>
	<e7220fad-0b73-68af-20d4-6522789b17c3@amsat.org>
Date: Fri, 18 Aug 2017 07:32:58 +0200
In-Reply-To: <e7220fad-0b73-68af-20d4-6522789b17c3@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	17 Aug 2017 16:31:48 -0300")
Message-ID: <87efs95tkl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 08/17/2017 02:55 PM, Alistair Francis wrote:
>>>> On 15/08/2017 09:30, Markus Armbruster wrote:
>>>>> The stupid fix is to repeat libraries until the link succeeds:
>>>>>
>>>>>      test-util-obj-y =3D libqemuutil.a libqemustub.a libqemuutil.a
>>>>>
> [...]
>>>>>
>>>>> Sticking '-Wp,-(' and '-Wp,-)' into the command line I get from make =
V=3D1
>>>>> doesn't work for me, though.
>>>>>
>>>>> The smart solution is not to have .a reference each other.
>>>>
>>>> Nah, I think we should teach those new kids on the block about -lX11
>>>> instead. :)
>>
>> This sounds scary...
>>
>>>>
>>>>> Paolo, what do you think?
>>>>
>>>> Another possibility is to just merge the two static libraries into one.
>>>
>>> Sounds good to me!
>>
>> I feel like I have opened a can of worms.
>
> you are good at it! IIRC it all started with a 1-line change in
> tcp_chr_wait_connected() more than 2 months ago :)
>
>>
>> I can try and combine libqemustub.a into libqemuutil.a is that the
>> solution? I just want to make sure before I start this.
>
> IMHO your series is OK like this, add a "TODO remove once
> libqemuutil.a circular dep is resolved" comment in the Makefile is
> enough, and let this issue for another time.

I disagree.

If merging the two .a is beyond your reach (I hope it isn't), then the
spot to mess up is this one:

    # TODO bla bla explain bla
    test-util-obj-y =3D libqemuutil.a libqemustub.a libqemuutil.a
