Received: from eggs.gnu.org ([2001:4830:134:3::10]:58799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq1XN-0000dm-9C
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq1XM-0004b3-9a
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:32:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fq1XM-0004ad-1i
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A936F40241C6
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:32:55 +0000 (UTC)
References: <20180815141945.10457-1-armbru@redhat.com>
	<20180815141945.10457-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d715b662-6956-e8a7-d8b9-5f6ecba5a0fd@redhat.com>
Date: Wed, 15 Aug 2018 14:32:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180815141945.10457-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] libqtest: Improve error reporting for
 bad read from QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com

On 08/15/2018 09:19 AM, Markus Armbruster wrote:
> When read() from the qtest socket or the QMP socket fails or EOFs, we
> report "Broken pipe" and exit(1).  This commonly happens when QEMU
> crashes.  It also happens when QEMU refuses to run because the test
> passed it bad arguments.  Sadly, we neglect to report either.
> 
> Improve this by calling abort() instead of exit(1), so kill_qemu()
> runs, and reports how QEMU died.  This improves error reporting to
> something like
> 
>      /x86_64/device/introspect/list: Broken pipe
>      tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 6 (Aborted) (dumped core)

Matches your touchup to my v4 patch.

> 
> Three exit() remain in libqtest.c:
> 
> * In qmp_response(), when we can't parse a QMP reply read from the QMP
>    socket.  Change to abort() for consistency.
> 
> * In qtest_qemu_binary(), when QTEST_QEMU_BINARY isn't in the
>    environment.  This can only happen before we start QEMU.  Leave
>    alone.
> 
> * In qtest_init_without_qmp_handshake(), when the fork()ed child fails
>    to execlp().  Leave alone.

exit() after failed execlp() is often wrong (in particular, if you are 
fork()ed from a multi-threaded process, you REALLY want to be using 
_exit() instead).  But as you say, not the goal of this particular patch.

> 
> exit() elsewhere are unlikely due to QEMU dying on us.  If that should
> turn out to be wrong, we can move kill_qemu() from the abrt handler to
> atexit() or something.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/libqtest.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
