Received: from eggs.gnu.org ([2001:4830:134:3::10]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhw6T-0006PC-ET
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhw6P-0000Fr-1L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:07:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhw6O-0000FT-Qh
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:07:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	<87k1pm551g.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C8382@dggemm521-mbx.china.huawei.com>
	<87r2jt40g1.fsf@dusky.pond.sub.org>
	<87zhyh2f7v.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C86D6@dggemm521-mbx.china.huawei.com>
Date: Tue, 24 Jul 2018 14:07:38 +0200
In-Reply-To: <B526101FCAB4654DB0892B650DEFC555086C86D6@dggemm521-mbx.china.huawei.com>
	(liujunjie's message of "Tue, 24 Jul 2018 09:18:52 +0000")
Message-ID: <87sh4825x1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "liujunjie (A)" <liujunjie23@huawei.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

"liujunjie (A)" <liujunjie23@huawei.com> writes:

> Even using gdb command: set print elements 0, is still too large to print the whole string.
> So I try to obtain the string in another way.
> After several attempts(not easy in fact), I finally obtain the real length. The way is as follows:
> (gdb) p (int *)str
> $1 = (int *) 0x7f13a2e67010
> (gdb) p *(char*) (0x7f13a2e67010 + 0x8B0FD63FF)@192
> $2 = "--W\r\nffffffffffd17000: 00000000fec00000 XG-DACT-W\r\nffffffffffd18000: ", '0' <repeats 11 times>, "77000 XG-DA---W\r\nffffffffffd19000: ", '0 "78000 XG-DA---W\r\nffffffffffd1a000: ", '0' <repeats 11 times>, "79000 XG-DA---W\r\n\000\000"
> With \000 at the end, we can find out the length is 0x8B0FD63FF + 192 - 2, that is 37329134781.

Awesome, thanks!

37329134781 is 0x8B0FD64BD.  That's almost 35 GiB.  How on earth can
"info tlb" print several Gigabytes?  That's a not a sane use of QMP!  No
excuse for crashing, of course.

> With this length, we can write a simple c code demo to reproduce the result we obtain before. Such as:
> -----------------------------
> #include<stdio.h>
> int main()
> {
>     char * tmp = "";
>     size_t a =  37329134781;
>     int end = a;
>     size_t b = end;
>     printf("%zu", b)
>     return 0;
> }
> -----------------------------

Yes.

When strlen(str) exceeds INT_MAX - 1 in qstring_from_str(), the @end
argument for qstring_from_substr() gets truncated.  This is what
appeared to happen in your case: it got truncated to -1325570883.

qstring_from_substr() has an (unstated) precondition: start >= 0 && end
>= 0 && end - start >= -1.  This precondition is violated.  end - start
+ 1 gets sign-extended to a huge value, and g_malloc() duly fails.

All callers of qstring_from_substr() outside tests pass arguments of
type size_t or ptrdiff_t.  They'd fail just like qstring_from_str() for
sub-strings exceeding 2 GiB.  Your patch fixes them all.  Good, I'll
take your patch, but the commit message needs a bit of polish.  Here's
my attempt:

    qstring: Fix qstring_from_substr() not to provoke int overflow

    qstring_from_substr() parameters @start and @end are of type int.
    blkdebug_parse_filename(), blkverify_parse_filename(), nbd_parse_uri(),
    and qstring_from_str() pass @end values of type size_t or ptrdiff_t.
    Values exceeding INT_MAX get truncated, with possibly disastrous
    results.

    Such huge substrings seem unlikely, but we found one in a core dump,
    where "info tlb" executed via QMP's human-monitor-command apparently
    produced 35 GiB of output.

    Fix by changing the parameters size_t.

If this works for you, please reply with your corrected Signed-off-by.

However, please note that allocating the correct 35 GiB may not behave
much better for you than allocating 16 EiB.  I doubt it'll succeed, and
if it does, then memcpy() will dirty 35 GiB of virtual memory, which is
unlikely to end well.

Are you sure "info tlb" is supposed to print that much?  Or is there
another bug still in hiding that somehow enlarged this string?
