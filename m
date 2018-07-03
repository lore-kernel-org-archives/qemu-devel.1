Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAnK-0002J3-1C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAnF-0002PS-PE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:11:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAnF-0002OX-IU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0096581A4EB9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:11:49 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6669f076-7cbd-33eb-d423-47bd474dcb3d@redhat.com>
Date: Mon, 2 Jul 2018 21:11:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/32] qmp: Don't let malformed in-band
 commands jump the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> handle_qmp_command() reports certain errors right away.  This is wrong
> when OOB is enabled, because the errors can "jump the queue" then, as
> the previous commit demonstrates.
> 
> To fix, we need to delay errors until dispatch.  Do that for semantic
> errors, mostly by reverting ill-advised parts of commit cf869d53172
> "qmp: support out-of-band (oob) execution".  Bonus: doesn't run
> qmp_dispatch_check_obj() twice, once in handle_qmp_command(), and
> again in do_qmp_dispatch().  That's also due to commit cf869d53172.
> 
> The next commit will fix queue jumping for syntax errors.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/dispatch.h |  2 -
>   monitor.c                   | 79 +++++++++----------------------------
>   qapi/qmp-dispatch.c         | 12 +++++-
>   tests/qmp-test.c            |  4 +-
>   4 files changed, 30 insertions(+), 67 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com

Fixing bug and reducing code size. I'm glad I made oob experimental in 
2.12, because I obviously didn't review it as closely in your absence 
for that release as you have done now (and changing it to be 
non-experimental early in the release cycle has also been good for 
letting us chase down these bugs in the original implementation).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
