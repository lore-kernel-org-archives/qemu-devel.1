Received: from eggs.gnu.org ([2001:4830:134:3::10]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faF5k-0003Qd-8T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faF5f-0005em-CC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faF5f-0005eK-6C
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 214BB81DF2
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:47:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-18-armbru@redhat.com>
	<6669f076-7cbd-33eb-d423-47bd474dcb3d@redhat.com>
Date: Tue, 03 Jul 2018 08:46:58 +0200
In-Reply-To: <6669f076-7cbd-33eb-d423-47bd474dcb3d@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 21:11:47 -0500")
Message-ID: <87muv86ckd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 11:22 AM, Markus Armbruster wrote:
>> handle_qmp_command() reports certain errors right away.  This is wrong
>> when OOB is enabled, because the errors can "jump the queue" then, as
>> the previous commit demonstrates.
>>
>> To fix, we need to delay errors until dispatch.  Do that for semantic
>> errors, mostly by reverting ill-advised parts of commit cf869d53172
>> "qmp: support out-of-band (oob) execution".  Bonus: doesn't run
>> qmp_dispatch_check_obj() twice, once in handle_qmp_command(), and
>> again in do_qmp_dispatch().  That's also due to commit cf869d53172.
>>
>> The next commit will fix queue jumping for syntax errors.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/qmp/dispatch.h |  2 -
>>   monitor.c                   | 79 +++++++++----------------------------
>>   qapi/qmp-dispatch.c         | 12 +++++-
>>   tests/qmp-test.c            |  4 +-
>>   4 files changed, 30 insertions(+), 67 deletions(-)
>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com
>
> Fixing bug and reducing code size. I'm glad I made oob experimental in
> 2.12, because I obviously didn't review it as closely in your absence
> for that release as you have done now (and changing it to be

In all fairness, it took me a while to see this.  The first clue was
"hmm, why does qmp_dispatch_check_obj() gets called in two places?"
Pulling that thread got me to this bug and more.

> non-experimental early in the release cycle has also been good for
> letting us chase down these bugs in the original implementation).

Running into that regression just in time was lucky :)
