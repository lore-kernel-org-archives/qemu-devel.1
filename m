Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKzBn-0003qJ-0m
	for qemu-devel@nongnu.org; Tue, 22 May 2018 00:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKzBj-00025f-Tn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 00:46:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKzBj-00024y-Nm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 00:46:19 -0400
Received: by mail-qk0-x242.google.com with SMTP id s12-v6so3909822qke.0
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 21:46:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
	<0cf434fe-a8f3-dc24-4350-197d2d56c4f3@amsat.org>
	<CAFEAcA_ed2RsYXN5jP2u5L0UYi3XP7MxjjF76RoKsjjwBKtLCw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <50982051-3be4-d84c-5dfe-49d0be8eac29@amsat.org>
Date: Tue, 22 May 2018 01:45:54 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ed2RsYXN5jP2u5L0UYi3XP7MxjjF76RoKsjjwBKtLCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 03/12/2018 10:16 AM, Peter Maydell wrote:
> On 12 March 2018 at 13:03, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 03/09/2018 06:03 PM, Peter Maydell wrote:
>>> I think the spec says that if the guest makes an invalid selection
>>> for one function in the group then we must ignore all the set values,
>>
>> ... for the current group? ...
>>
>>> not just the one that was wrong, so we need to check everything
>>> first before we start writing the new values back.
>>
>> I'm following the "Physical Layer Simplified Specification Version 3.01".
>>
>>   4.3.10.3 Mode 1 Operation - Set Function
>>
>>   Switching to a new functionality is done by:
>>   • When a function cannot be switched because it is busy,
>>     the card returns the current function number (not returns 0xF),
>>     the other functions in the other groups may still be switched.
>>
>>   In response to a set function, the switch function will return ...
>>   • The function that is the result of the switch command. In case
>>     of invalid selection of one function or more, all set values
>>     are ignored and no change will be done (identical to the case
>>     where the host selects 0xF for all functions groups). The
>>     response to an invalid selection of function will be 0xF.
>>
>> I'm not sure how to interpret this paragraph, I understand it as:
>> "all set values are ignored [in the current group]" but this is
>> confusing because of the "identical to ... all functions groups".
> 
> The command only lets you specify one value function in each
> group, so "all set values" must mean "the set values for every
> group", I think, and the parenthesised text confirms that --
> it should act as if the command specified 0xf for everything.
> It's slightly less clear what exactly the response should be:
> should it return 0xf for the groups where there was an invalid
> selection, and <whatever the current value is> for the groups
> where the selection request was ok, or just 0xf for everything ?
> (This is probably most easily answered by testing the behaviour
> of a real sd card I guess...)

Sorry to let you wait so long, it took me days to have full setup and
tests :/

Testing, the behavior is as you said:
"it return 0xf for the groups where there was an invalid  selection, and
<whatever the current value is> for the groups where the selection
request was ok"

>>> do_cmd(6, 0x00fffff0)
"00648001800180018001c00180010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
0064 // Maximum current consumption: 64mA
8001 // Function group 6, information. If a bit i is set, function i is
supported. 0=default
8001 // 5: default
8001 // 4: default
8001 // 3: default
c001 // 2: 0 = default + 0xE = Vendor specific
8001 // 1: default
0 //6 The function which can be switched in function group 6. 0xF shows
function set error with the argument.
0 //5
0 //4
0 //3
0 //2
0 //1
00 // Data Structure Version: 00h – bits 511:376 are defined
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// undef

>>> do_cmd(6, 0x0)
// same as do_cmd(6, 0x00fffff0)

Let's try to set Current Limit: 400mA (function name 1 to group No 4,
arg slice [15:12]):

we need to use CMD6 argument:
(gdb) p/x 0x00fffff0 & ~(0xf << 12) | (1 << 12)
0xff1ff0

>>> do_cmd(6, 0x00ff1ff0)
"00008001800180018001c001800100f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
0000 // 0mA
8001 //6
8001 //5
8001 //4
8001 //3
c001 //2
8001 //1
0 //6
0 //5
f //function group 4 "0xF shows function set error with the argument."
0 //3
0 //2
0 //1
00 // v0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

Now, let's try to set Command system: Advanced Security SD (function
name 4 to group No 2, arg slice [7:4]):

(gdb) p/x 0x00fffff0 & ~(0xf << 4) | (2 << 4)
0xffff20

>>> do_cmd(6, 0x00ffff20)
"00008001800180018001c00180010000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
0000 // 0mA
8001 //6
8001 //5
8001 //4
8001 //3
c001 //2
8001 //1
0 //6
0 //5
0 //4
0 //3
f //function group 2 "0xF shows function set error with the argument."
0 //1
00 // v0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

Finally those 2 incorrect functions at once:

(gdb) p/x 0x00fffff0 & ~(0xf << 12 | 0xf << 4) | (1 << 12) | (2 << 4)
0xff1f20

>>> do_cmd(6, 0xff1f20)
"00008001800180018001c001800100f0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
...
0 //6
0 //5
f //function group 4: error with the argument
0 //3
f //function group 2: error with the argument
0 //1
00 // v0
...

Regards,

Phil.
