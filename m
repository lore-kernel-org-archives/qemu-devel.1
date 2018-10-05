Received: from eggs.gnu.org ([2001:4830:134:3::10]:52013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g8QLd-0007FP-56
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g8QLZ-000888-Ht
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAFEAcA95awvCWT8FA-qfcpYiovpmprSFeA5yxa1BbhZX12BbeA@mail.gmail.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
	<20181001171901.11004-9-kwolf@redhat.com>
	<CAFEAcA95awvCWT8FA-qfcpYiovpmprSFeA5yxa1BbhZX12BbeA@mail.gmail.com>
Date: Fri, 05 Oct 2018 15:40:09 +0200
Message-ID: <w51bm88se9y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Fri 05 Oct 2018 02:55:13 PM CEST, Peter Maydell wrote:
>> +    rs->check_cache_dropped =
>> +        qemu_opt_get_bool_del(opts, "x-check-cache-dropped", false);
>> +
>> +    /* This driver's reopen function doesn't currently allow changing
>> +     * other options, so let's put them back in the original QDict and
>> +     * bdrv_reopen_prepare() will detect changes and complain. */
>> +    qemu_opts_to_qdict(opts, state->options);
>
> Hi. Coverity is suspicious about this call to qemu_opts_to_qdict()
> because it returns a value which this callsite is ignoring but almost
> all others don't ignore (CID 1395991). Is it correct?

It's a false positive because qemu_opts_to_qdict() returns the same
value that is passed (unless that value is NULL).

We can fix the warning by doing

   state->options = qemu_opts_to_qdict(opts, state->options);

or by modifying qemu_opts_to_qdict() to get a QDict ** and return void.

Berto
