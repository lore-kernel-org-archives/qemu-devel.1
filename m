Received: from eggs.gnu.org ([2001:4830:134:3::10]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCh3M-0004TN-0U
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCh3I-0007l7-24
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCh3H-0007il-SH
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:19:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
	<20181016174158.15229-9-armbru@redhat.com>
	<20181017091516.35af8b13@bahia.lan>
Date: Wed, 17 Oct 2018 10:19:28 +0200
In-Reply-To: <20181017091516.35af8b13@bahia.lan> (Greg Kurz's message of "Wed,
	17 Oct 2018 09:15:16 +0200")
Message-ID: <87a7ndm1db.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/38] 9pfs: Fix CLI parsing crash on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

Greg Kurz <groug@kaod.org> writes:

> On Tue, 16 Oct 2018 19:41:28 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  9p-handle.c's handle_parse_opts() does that, and then
>> fails without setting an error.  Wrong.  Its caller crashes when it
>> tries to report the error:
>> 
>>     $ qemu-system-x86_64 -nodefaults -fsdev id=foo,fsdriver=handle
>>     qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: warning: handle backend is deprecated
>>     qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: fsdev: No path specified
>>     Segmentation fault (core dumped)
>> 
>> Screwed up when commit 91cda4e8f37 (v2.12.0) converted the function to
>> Error.  Fix by calling error_setg() instead of error_report().
>> 
>> Fixes: 91cda4e8f372602795e3a2f4bd2e3adaf9f82255
>> Cc: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Greg Kurz <groug@kaod.org>
>> ---
>
> Hi Markus,
>
> FWIW you had a Reviewed-by from Eric.
>
> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03297.html

Fixed in v4.  Thanks!
