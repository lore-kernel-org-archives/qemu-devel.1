Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QS3-00041P-NR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QS3-0008Qp-0Y
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:47:31 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8QS2-0008QR-Dp
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:47:30 -0400
Received: by mail-ot1-x343.google.com with SMTP id h15-v6so12742697otj.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:47:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <w51bm88se9y.fsf@maestria.local.igalia.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
	<20181001171901.11004-9-kwolf@redhat.com>
	<CAFEAcA95awvCWT8FA-qfcpYiovpmprSFeA5yxa1BbhZX12BbeA@mail.gmail.com>
	<w51bm88se9y.fsf@maestria.local.igalia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 14:47:09 +0100
Message-ID: <CAFEAcA9k0iORT3KM0rzh8GoKE7rT5-0JP8yaLNYY56e4hD1WGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 08/23] file-posix: Forbid
 trying to change unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 5 October 2018 at 14:40, Alberto Garcia <berto@igalia.com> wrote:
> On Fri 05 Oct 2018 02:55:13 PM CEST, Peter Maydell wrote:
>>> +    rs->check_cache_dropped =
>>> +        qemu_opt_get_bool_del(opts, "x-check-cache-dropped", false);
>>> +
>>> +    /* This driver's reopen function doesn't currently allow changing
>>> +     * other options, so let's put them back in the original QDict and
>>> +     * bdrv_reopen_prepare() will detect changes and complain. */
>>> +    qemu_opts_to_qdict(opts, state->options);
>>
>> Hi. Coverity is suspicious about this call to qemu_opts_to_qdict()
>> because it returns a value which this callsite is ignoring but almost
>> all others don't ignore (CID 1395991). Is it correct?
>
> It's a false positive because qemu_opts_to_qdict() returns the same
> value that is passed (unless that value is NULL).
>
> We can fix the warning by doing
>
>    state->options = qemu_opts_to_qdict(opts, state->options);
>
> or by modifying qemu_opts_to_qdict() to get a QDict ** and return void.

I think just marking the issues as false-positives in the coverity
UI is sufficient here.

thanks
-- PMM
