Received: from eggs.gnu.org ([2001:4830:134:3::10]:52206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwEU-0007se-2D
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwEQ-0003tX-5f
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:57:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exwEP-0003t1-W8
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:57:50 -0400
References: <20180316140508.863778-1-eblake@redhat.com>
	<CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
	<20180319092618.GF2477@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a7260c1-bb51-63a0-5a1b-588a7b1757b3@redhat.com>
Date: Mon, 19 Mar 2018 09:57:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180319092618.GF2477@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/19/2018 04:26 AM, Peter Xu wrote:

>>> for you to fetch changes up to 75eb57e3ed3682f011a6694863044e8b143a9821:
>>>
>>>    qapi: Pass '-u' when doing non-silent diff (2018-03-16 09:00:07 -0500)
>>>

>> Hi. I get a bunch of test assertion failures with this:
>>
>> ppc64 host:
>>
>> QTEST_QEMU_BINARY=nios2-softmmu/qemu-system-nios2
>> QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
>> ${RANDOM:-0} % 255 + 1)
>> )} gtester -k --verbose -m=quick  tests/qmp-test
>> tests/device-introspect-test tests/qom-test tests/test-hmp
>> TEST: tests/qmp-test... (pid=49431)
>>    /nios2/qmp/protocol:                                                 OK
>>    /nios2/qmp/oob:                                                      OK
>>    /nios2/qmp/query-status:                                             OK
>>    /nios2/qmp/query-block:                                              OK
>>    /nios2/qmp/query-blockstats:                                         OK
>>    /nios2/qmp/query-block-jobs:                                         OK
>>    /nios2/qmp/query-named-block-nodes:
>> qemu-system-nios2: /home/pm215/qemu/chardev/char-io.c:91: io_watc
>> h_poll_finalize: Assertion `iwp->src == ((void *)0)' failed.
>> Broken pipe
>> FAIL

I haven't been able to reproduce the testsuite failures on my Linux box, 
but if it's a race, then that doesn't make me all the more confident on 
what it takes to reproduce and/or fix the race.


>> One or two of the build hosts did pass, so that plus the varying
>> tests which failed suggests that the iwp->src assert is an
>> intermittent or timing based one. The tpm error on NetBSD
>> is probably a separate issue.
> 
> I think I still need this to be squashed into "monitor: allow using IO
> thread for parsing", which I dropped during respin from v7 to v8:
> 
> diff --git a/monitor.c b/monitor.c
> index f9ef3e5266..121194111f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4556,6 +4556,11 @@ void monitor_init(Chardev *chr, int flags)
>           qemu_chr_fe_set_echo(&mon->chr, true);
>           json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
>           if (mon->use_io_thr) {
> +            /*
> +             * Make sure the old iowatch be gone.  It's possible when
> +             * e.g. the chardev is in client mode, with wait=on.
> +             */
> +            remove_fd_in_watch(chr);
>               /*
>                * We can't call qemu_chr_fe_set_handlers() directly here
>                * since during the procedure the chardev will be active
> 
> I thought there should be no pending task on main thread after the QIO
> and CHARDEV fixes, but I missed the most general io watch and we still
> possibly need the line.

So, should I squash in the fix and keep OOB as part of my v3 attempt, or 
are we getting close enough to rc0 that my qapi v3 pull request should 
just drop OOB, and save that as a feature for 2.13 instead?

> 
> We should fix the assertion problem with above, but not sure about
> whether it can fix the QIO issue since I haven't seen that before (and
> I can't reproduce that too in my environment).
> 
> I hope the fix can work for us.  But in all cases, please feel free to
> drop the series if needed.  Sorry for the trouble.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
