Received: from eggs.gnu.org ([2001:4830:134:3::10]:50299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fIbDv-0003H7-AV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fIbDp-0005mA-DV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:46:43 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
	<CAFEAcA9kcKb28uQJOnqCAC4Gf9b7Hnu0wJbG1nHQLF4U1T9sKA@mail.gmail.com>
	<99693ba4-c282-a10b-e811-697617f7ee06@weilnetz.de>
	<CAFEAcA81y1r5N2zi5fPoV5iZ9dd0YBeThcX=qXdJXdNSNO8nsA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <291b8b6f-1692-a5ee-f44c-4f8c4dd614fa@twiddle.net>
Date: Tue, 15 May 2018 07:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81y1r5N2zi5fPoV5iZ9dd0YBeThcX=qXdJXdNSNO8nsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 05/15/2018 06:25 AM, Peter Maydell wrote:
> On 15 May 2018 at 14:13, Stefan Weil <sw@weilnetz.de> wrote:
>> This is fixed in upstream vixl, in fact:
>>
>> https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337fda52845ed3d2e620cc02
>>
>> That fix will work for the moment, but is not sufficient for the future
>> because it only supports gcc 7.x, but not gcc 8.x or later:
>>
>> +#elif __GNUC__ == 7
>>
>> How do we proceed with the code in QEMU? Do you have a plan to update the
>> vixl code? As vixl is obviously no longer maintained on GitHub, I am not
>> sure whom I could contact.
> 
> The github page points you to the linaro repo which is the new upstream.
> That said, I think we're planning to deprecate vixl now we have the
> capstone support. Richard, what's the status here? Could we just remove
> the vixl code now?

We could just remove vixl, yes.  I'd like to see updates to capstone to support
instructions post v8.0, but it's not like we have those with vixl either...

> I guess that having the compiler check is better than finding them
> later with coverity. It's a shame gcc doesn't support the standard
> mechanism of using /* fallthrough */ to mark these, though.

It does.  Apparently not by default anymore, however:

@item @option{-Wimplicit-fallthrough=0} disables the warning altogether.

@item @option{-Wimplicit-fallthrough=1} matches @code{.*} regular
expression, any comment is used as fallthrough comment.

@item @option{-Wimplicit-fallthrough=2} case insensitively matches
@code{.*falls?[ \t-]*thr(ough|u).*} regular expression.

@item @option{-Wimplicit-fallthrough=3} case sensitively matches one of the
following regular expressions:
...

I think either =2 or =1 would work for us in QEMU.


r~
