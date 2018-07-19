Received: from eggs.gnu.org ([2001:4830:134:3::10]:47070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgAM7-0007Tg-FU
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgAM4-00069K-Dv
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:56:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgAM4-000687-9u
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57A2840200A9
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 14:56:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620071040.28729-1-peterx@redhat.com>
	<87y3e8lfks.fsf@dusky.pond.sub.org> <20180719050145.GD4071@xz-mi>
	<87va9bitdp.fsf@dusky.pond.sub.org> <20180719080306.GF4071@xz-mi>
	<87fu0fh9y9.fsf@dusky.pond.sub.org> <20180719094601.GJ4071@xz-mi>
	<878t67fmm7.fsf@dusky.pond.sub.org> <20180719124636.GK4071@xz-mi>
Date: Thu, 19 Jul 2018 16:56:24 +0200
In-Reply-To: <20180719124636.GK4071@xz-mi> (Peter Xu's message of "Thu, 19 Jul
	2018 20:46:36 +0800")
Message-ID: <87muuncm07.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 19, 2018 at 02:14:56PM +0200, Markus Armbruster wrote:
[...]
>> Here's my try:
>> 
>>     monitor: Fix unsafe sharing of @cur_mon among threads
>> 
>>     @cur_mon is null unless the main thread is running monitor code, either
>>     HMP code within monitor_read(), or QMP code within
>>     monitor_qmp_dispatch().
>> 
>>     Use of @cur_mon outside the main thread is therefore unsafe.
>> 
>>     Most of its uses are in monitor command handlers.  These run in the main
>>     thread.
>> 
>>     However, there are also uses hiding elsewhere, such as in
>>     error_vprintf(), and thus error_report(), making these functions unsafe
>>     outside the main thread.  No such unsafe uses are known at this time.
>>     Regardless, this is an unnecessary trap.  It's an ancient trap, though.
>> 
>>     More recently, commit cf869d53172 "qmp: support out-of-band (oob)
>>     execution" spiced things up: the monitor I/O thread assigns to @cur_mon
>>     when executing commands out-of-band.  Having two threads save, set and
>>     restore @cur_mon without synchronization is definitely unsafe.  We can
>>     end up with @cur_mon null while the main thread runs monitor code, or
>>     non-null while it runs non-monitor code.
>> 
>>     We could fix this by making the I/O thread not mess with @cur_mon, but
>>     that would leave the trap armed and ready.
>> 
>>     Instead, make @cur_mon thread-local.  It's now reliably null unless the
>>     thread is running monitor code.
>
> Looks good to me.

With that commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
