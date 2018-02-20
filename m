Received: from eggs.gnu.org ([2001:4830:134:3::10]:57274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eo7GH-0003kL-Hr
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eo7GB-0004Y6-Dy
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:43:09 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eo7GB-0004XN-38
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:43:03 -0500
Received: by mail-wr0-x230.google.com with SMTP id z12so7815191wrg.4
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 04:43:02 -0800 (PST)
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<CAFEAcA9ZVrXbzTHHjMRpEadBjFLecgxwKvsN4gtWuR0NMP5xWQ@mail.gmail.com>
	<579a7106-ecdb-984e-97b5-bd23d0625156@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <579a7106-ecdb-984e-97b5-bd23d0625156@vivier.eu>
Date: Tue, 20 Feb 2018 12:43:00 +0000
Message-ID: <87mv03al2j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 13/02/2018 =C3=A0 16:51, Peter Maydell a =C3=A9crit:
>> On 6 February 2018 at 16:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>> Hi,
>>>
>>> The main change is applying the __attribute__((flatten)) to some of
>>> the public functions that show up in Emilio's dbt-benchmark. This
>>> seems to be a cleaner solution that squashing inlines higher up the
>>> chain and still leaves the chance for re-use for the less widely used
>>> functions. The results are an improvement over v3 by some margin:
>>>
>>>                          NBench score; higher is better
>>>
>>>     5 +-+-----------+-------------+------------+-------------+---------=
--+-+
>>>       |                     ****### %%%%  +++                          =
    |
>>>   4.5 +-+...................*..*..#.%..%..****##..%%%%+ system-2.5     =
  +-+
>>>       |                     *  *  # %  %  *  * #  %  %      master     =
    |
>>>     4 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-v3     =
  +-+
>>>   3.5 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-%%%%...=
..+-+
>>>       |                     *  *  # %  %  *  * #  %  %  * *  #  %  %   =
    |
>>>     3 +-+...................*..*..#.%..%..*..*.#..%..%..*.*..#..%..%...=
..+-+
>>>       |                     *  *  #+%  %  *  * #$$$  %  * *  #  %  %   =
    |
>>>   2.5 +-+........####.......*..*..#$$..%..*..*.#..$..%..*.*..#..%..%...=
..+-+
>>>       |       ****  #  %%%  *  *  # $  %  *  * #  $  %  * *  #$$$  %   =
    |
>>>     2 +-+.....*..*..#..%.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%...=
..+-+
>>>       |       *  *  #  % %  *  *  # $  %  *  * #  $  %  * *  #  $  %   =
    |
>>>   1.5 +-+.....*..*..#$$$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%...=
..+-+
>>>     1 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%...=
..+-+
>>>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %   =
    |
>>>   0.5 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%...=
..+-+
>>>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %   =
    |
>>>     0 +-+-----****###$$$%%--****###$$%%%--****##$$$%%%--***###$$$%%%---=
--+-+
>>>                  FOURIER     NEURAL NETLU DECOMPOSITION    gmean
>>>
>>> Slightly easier to read PNG:
>>>
>>>     https://i.imgur.com/XEeL0bC.png
>>>
>>> I think it's pretty ready for a merge. Shall I submit a pull myself or
>>> does it make sense going via someone else? According to MAINTAINERS
>>> Peter and Aurelien are responsible for this code...
>>
>> I had some nits but I think the best thing to do is if you fix those
>> and then just send a pull request for this.
>
> Just to be sure no one has missed that:
>
> https://bellard.org/libbf/
>
> I'm wondering if it can help for this work.

I did have a brief look through to get a sense of how it works. The
first thing it is missing however is half-precision. It only seems to
deal in 32 and 64 bit floats. The code is also fairly sparse in its
commenting.

The main approach seems to be somewhere between rth's glibc macro fest
and what we have now. It makes extensive use of every QEMU developers
favourite glue macro to instantiate code from a "template". This allows
some better usage of size appropriate types in each instantiation where
we just do most things at the highest precision.

However I think it also suffers the same problem as SoftFloat3 as in
it is not an upstream project so it is just another lump of code to
import into out code base. Based on that I favour our re-factor more as
I think it is easier to follow and hopefully will be easier to maintain.

I think we can address the inefficiencies in our mul/div code by passing
FloatFmt in and letting the compiler deal with it in each flattened
implementation. I prototyped mul:

  http://ix.io/MYw

However unless we are super worried about these inefficiencies I'm
proposing we merge what we have and deal with these in a later round.

>
> Thanks,
> Laurent


--
Alex Benn=C3=A9e
