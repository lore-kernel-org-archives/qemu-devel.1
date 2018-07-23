Received: from eggs.gnu.org ([2001:4830:134:3::10]:60311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhd2I-00019i-Oz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhd2E-0002GY-R2
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:46:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhd2E-0002GK-MT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:46:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
Date: Mon, 23 Jul 2018 17:46:03 +0200
In-Reply-To: <B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	(liujunjie's message of "Mon, 23 Jul 2018 14:36:39 +0000")
Message-ID: <87k1pm551g.fsf@dusky.pond.sub.org>
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

> Thanks for your reply.
>> Really?  How exactly can this happen?  Please explain step by step.
> There exist a qemu core related to this. You have mention that "The conversion truncates when strlen(str) - 1 exceeds INT_MAX".
> Later in function qstring_from_substr, this truncated "end" will be assigned to "qstring->length" again, which is size_t. This is the key point why qemu coredumped.
> Because when "end" is truncated, it can be negative number. If we assign a negative number to a size_t variable, this size_t variable can become very large.
> At last, we call g_malloc to try to alloc a large number of member which cannot success. So qemu coredump.
> In my example, use gdb to debug function qstring_from_substr, I can get the following message.
> (gdb) p	qstring->length
> $4 = 18446744072383980732  (too large to allocate)
> (gdb) p	(int) (qstring->length)
> $5 = -1325570884
> (gdb) p/x (int)	qstring->length
> $6 = 0xb0fd64bc
> (gdb) p/x qstring->length
> $7 = 0xffffffffb0fd64bc
> (gdb) p	end
> $8 = <optimized out>

Can you provide a stack backtrace, too?
