Received: from eggs.gnu.org ([2001:4830:134:3::10]:39343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0N0i-00075A-Fq
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0N0e-0007aI-HI
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:30:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0N0e-0007Yv-AH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:29:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so4671884wrr.4
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 01:29:56 -0700 (PDT)
References: <20180912171040.1732-1-pbonzini@redhat.com>
	<20180912171040.1732-2-pbonzini@redhat.com>
	<20180913065639.GL2526@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4190f46-474b-38fb-5028-703754f598a6@redhat.com>
Date: Thu, 13 Sep 2018 10:29:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180913065639.GL2526@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] aio-posix: fix concurrent
 access to poll_disable_cnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 13/09/2018 08:56, Fam Zheng wrote:
>> +    /* No need to order poll_disable_cnt writes against other updates;
>> +     * the counter is only used to avoid wasting time and latency on
>> +     * iterated polling when the system call will be ultimately necessary.
>> +     * Changing handlers is a rare event, and a little wasted polling until
>> +     * the aio_notify below is not an issue.
>> +     */
>> +    atomic_set(&ctx->poll_disable_cnt,
>> +               atomic_read(&ctx->poll_disable_cnt) + poll_disable_change);
>
> Why not atomic_add?

This is not lockless, it's protected by list_lock, so there's no race
condition involved.  I'm just mimicking what is done for other similar
cases, for example involving seqlocks.

The alternative would be to add a full set of
atomic_{add,sub,...}_relaxed atomics.

Paolo
