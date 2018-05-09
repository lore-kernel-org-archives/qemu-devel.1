Received: from eggs.gnu.org ([2001:4830:134:3::10]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGNCd-00048i-M3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGNCc-0000AZ-FP
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:11 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:33681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGNCc-00008h-8E
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:10 -0400
Received: by mail-ot0-x234.google.com with SMTP id l22-v6so39728312otj.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 04:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509053207.GA19425@umbus>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
	<CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
	<20180506133955.GP13229@umbus.fritz.box>
	<CAFEAcA-bYHDSFL07f3BE_Lj-Dou+GeZod6cdX4-LSxzpRmQaDA@mail.gmail.com>
	<20180509053207.GA19425@umbus>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 May 2018 12:23:49 +0100
Message-ID: <CAFEAcA-w4o72z-x+5bC8O+eC9A_0BG4opk=sSRB7J7c5VB+uTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>

On 9 May 2018 at 06:32, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Sun, May 06, 2018 at 04:04:02PM +0100, Peter Maydell wrote:
>> On 6 May 2018 at 14:39, David Gibson <david@gibson.dropbear.id.au> wrote:
>> > Although, that said, I'll re-iterate that I think qemu's fdt
>> > manipulation is now sufficiently complex that it would be better off
>> > using a "live" (dynamically allocated & pointer based) tree
>> > representation that we just flatten immediately before loading it into
>> > the guest.
>>
>> This sounds to me like something that should be handled
>> by libfdt.
>
> No, it's really not.  libfdt is specifically for reading and writing
> flattened trees in place, in flattened form.  That's the whole basis
> of the design and it's directly responsible for some of the
> infelicities you mention.
>
> I was never intended as a general runtime t manipulation library.  A
> libdt that does that (using an allocator and internal pointer
> representation) would be a nice thing to have, but libfdt isn't it.
> Obviously being able to use libfdt to flatten and unflatten trees
> would be a very good feature for such a library.

The difficulty is that libfdt is the closest we have to a
dt manipulation library. The current wrapper layer is sort
of trying to fix up its deficiencies for this use case.
I just think that libfdt (as project, not necessarily as
a single source file or library) is better placed to design
and implement a more featured dt manipulation library layer
than QEMU is.

(Possibly we have here a slight terminology confusion: when
I think about "libfdt" what I mean is "the project that has
code for manipulating device trees and provides a library
and some source files you can compile directly into a kernel
or bootloader and a standalone dtc compiler binary and so on",
not "specifically a single library". So it seems to me more
natural for generic library code for manipulating DTs with
an unflatten-manipulate-flatten approach would also be part
of that project.)

>> internal representation of the data structure is, I just
>> want to be able to (a) hand it an fdt read in from a file
>> (b) call various functions to modify the data structure
>> and then (c) write the resulting thing out to an fdt in
>> guest memory. Whether libfdt prefers to do that by
>> modifying the flat representation or by converting into
>> a dynamically allocated unflattened tree and back again
>> is something I'd rather leave to it as an implementation
>> detail.
>
> Sort of.  But there design constraints in libfdt which means that's
> not really feasible.  Such as:
>   * not requiring an allocator
>   * not requiring a "read / unflatten" pass before reading values from
>     an fdt
>   * not requiring allocation or creation of a "context" state for
>     manipulating a tree
>
> Those aren't aren't really relevant to qemu and perhaps aren't part of
> what you'd usually think of as the API.  But they do matter to real
> libfdt use cases.

Yes, you'd certainly want to keep the compile time option
to just have the "no allocation" parts of the library so
you could build it into kernels and boot loaders.

thanks
-- PMM
