Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldgI-0007vu-Ij
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldgH-0007gJ-Mo
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:43:46 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eldgH-0007fm-H3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:43:45 -0500
Received: by mail-ot0-x243.google.com with SMTP id s4so17822783oth.7
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:43:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aff1a8c0-4e99-b52e-f933-fdc900bd91fd@redhat.com>
References: <20180128221510.13722-1-richard.henderson@linaro.org>
	<CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
	<18af5519-95cd-f00e-1915-75183e94eb38@twiddle.net>
	<aff1a8c0-4e99-b52e-f933-fdc900bd91fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 16:43:24 +0000
Message-ID: <CAFEAcA-xRtcaRA6_ApZ2Ohfpz0ZCED1y3SyLpGCOWThPFpUr_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 16:38, Eric Blake <eblake@redhat.com> wrote:
> On 02/13/2018 09:31 AM, Richard Henderson wrote:
>>>
>>> I wonder if there are guest programs that make assumptions about
>>> file descriptor numbers such that it would be worthwhile dup2'ing
>>> the interp_dirfd away from the presumably low number fd it will
>>> get by default into something larger...
>>
>>
>> Hmm.  Using dup2(probe, probe) to test if the new (high) fd itself has not
>> been
>> allocated?
>
>
> fcntl(F_DUPFD[_CLOEXEC]) is smarter than dup2/3, if you plan on atomically
> guaranteeing a dup to a not-in-use fd.
>
> Will dup'ing to a high fd violate assumptions of programs that assume that
> open() and friends favor the next available fd by default, rather than
> having a gap?  (Probably not, but skipping fds is not usual, so it's worth
> asking.)

Well, the idea is that this fd is qemu-internal, so we want the guest
to see that from its point of view the first fd it opens will be 3
if it starts with the usual stdin/stdout/stderr. If we don't move it
then interp_dirfd gets 3 and the guest sees a "gap" from its POV.

(Not being able to hide this qemu-internal fd from the guest properly
is the one awkward part of this patch.)

OTOH, maybe we should just go ahead without weird games with dup2 and
see whether any real code gets confused...

thanks
-- PMM
