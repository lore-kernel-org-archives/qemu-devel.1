Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFk9z-0006d3-0Q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFk9y-00031z-6D
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:38:19 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFk9x-00031F-V6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:38:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id 123so28855206wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:38:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__bsp5_yJZJr3LBbB_5yuALZ4o5ELXhJo4OO5jjz4G3A@mail.gmail.com>
References: <1495444679-7736-1-git-send-email-sandipandas1990@gmail.com>
	<87bmqanz6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<CAFEAcA__bsp5_yJZJr3LBbB_5yuALZ4o5ELXhJo4OO5jjz4G3A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 17:37:56 +0100
Message-ID: <CAFEAcA_EisxJa1710ngcpScjfFVvnSpAr-_2RjdmQngoxw0DJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH risu v2] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipandas1990@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 30 May 2017 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 May 2017 at 16:26, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>> Sandipan Das <sandipandas1990@gmail.com> writes:
>>
>>> The patterns for the following instructions are fixed:
>>>  * Rotate Left Doubleword then Clear Right (rldcr[.])
>>>  * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
>>>  * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])
>>>
>>> The first instruction has a typo. For the other two instructions,
>>> the extended opcodes are incorrect and the shift field 'sha' is
>>> absent. Also, the shift field 'sh' should be used in place of the
>>> register field 'rb'.
>>>
>>> Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
>>
>> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> Thanks; applied to risu master.

...but I foolishly didn't run build-all-archs first, which
points out that there's a bug:
Syntax error detected evaluating RLDIMId PPC64LE constraints string:         ]
{ $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
Global symbol "$rb" requires explicit package name (did you forget to
declare "my $rb"?) at (eval 429) line 1.
Global symbol "$rb" requires explicit package name (did you forget to
declare "my $rb"?) at (eval 429) line 1.

You forgot to update the constraints when you changed the
field names... I think that the constraints on $rb should
be removed rather than just changed to use $sh because this
field is an immediate, not a register number, so we don't need
to make it avoid 1 and 13. This would bring them into line with
the other rotate-immediates. I'll post a patch in a second.

thanks
-- PMM
