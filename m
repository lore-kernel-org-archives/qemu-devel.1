Received: from eggs.gnu.org ([2001:4830:134:3::10]:37911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJI2M-0001di-LJ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJI2J-0005oR-L9
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:57:22 -0500
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1eJI2J-0005o5-En
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:57:19 -0500
Received: by mail-qk0-x22a.google.com with SMTP id 136so31983711qkd.4
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:57:18 -0800 (PST)
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
	<b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
Date: Mon, 27 Nov 2017 09:57:10 -0200
MIME-Version: 1.0
In-Reply-To: <b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] glibc "linux: spawni.c: simplify error reporting
 to parent" breaks qemu-user/Windows Service For Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.com>, James Clarke <jrtc27@jrtc27.com>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

On 26/11/2017 18:35, John Paul Adrian Glaubitz wrote:
> On 11/26/2017 09:28 PM, John Paul Adrian Glaubitz wrote:
>> I'm not sure yet what the actual problem is but I thought it should be necessary
>> to point you at the problem.
> 
> Ok, there is already a QEMU bug report for this [1].
> 
> Adrian
> 
>> [1] https://bugs.launchpad.net/qemu/+bug/1673976
> 

We found out this potential bogus assert on 2.27 development [1] which
resulted in two fixes [2][3].

It should not be an issue for generic posix_spawn usage where there is
no expectation system/user/program kills random pids (since posix_spawn
auxiliary process has not yet returned). Some say the possible kind of
behaviour is rather undefined, but it shouldn't also trigger an assert.

I am not really sure what is happening in qemu usermode because comment
#4 in the bug reports states clone is returning an error and it should
not trigger the assert in first place.  What seems to be happening in
this scenario is clone is actually returning a success, but the auxiliary
process is being killed before actually calling execve.

In any case I think both fixes I pointed out (which are also on 2.26 and
2.25) should avoid the assert issue. Regarding the CLONE_VFORK support
I think we will need to address it on qemu.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=22273
[2] https://sourceware.org/git/?p=glibc.git;a=commit;h=fe05e1cb6d64dba6172249c79526f1e9af8f2bfd
[3] https://sourceware.org/git/?p=glibc.git;a=commit;h=aa95a2414e4f664ca740ad5f4a72d9145abbd426
