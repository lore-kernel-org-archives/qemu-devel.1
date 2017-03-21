Received: from eggs.gnu.org ([2001:4830:134:3::10]:35741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqG5M-0000q2-If
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqG5J-0006AQ-FP
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqG5J-00069d-9h
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC0CC04B946
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:28:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170321031705.22291-1-eblake@redhat.com>
Date: Tue, 21 Mar 2017 10:28:05 +0100
In-Reply-To: <20170321031705.22291-1-eblake@redhat.com> (Eric Blake's message
	of "Mon, 20 Mar 2017 22:17:03 -0500")
Message-ID: <87shm7rnbu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] Fix QemuOpts regression on
 bogus keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Igor Mammedov <imammedo@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> Reported to me off-list by Laurent Vivier, who found the
> problem while working on https://bugzilla.redhat.com/1433193
> Broken since 2.7, but the fix is a one-liner (pointing out my
> embarrassing mistake of mis-converting a pre-decrement operator);
> as a bug fix, it still qualifies for 2.9 in spite of hard freeze,
> on the other hand, as the regression was not introduced in 2.9,
> I also understand if it is postponed.
>
> Eric Blake (2):
>   tests: Expose regression in QemuOpts visitor
>   qapi: Fix QemuOpts visitor regression on unvisited input
>
>  qapi/opts-visitor.c       |  6 +++---
>  tests/test-opts-visitor.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 6 deletions(-)

Regresses

    $ qemu-system-x86_64 -object memory-backend-ram,id=mem1,size=4k
    qemu-system-x86_64: -object memory-backend-ram,id=mem1,size=4k: Invalid parameter 'id'

I guess the culprit is commit 3a4641:

    pdict = qemu_opts_to_qdict(opts, NULL);
    qdict_del(pdict, "qom-type");
    qdict_del(pdict, "id");

    v = opts_visitor_new(opts);
    obj = user_creatable_add_type(type, id, pdict, v, errp);
    visit_free(v);

This deletes "qom-type" and "id" from pdict, but not opts.  The deletion
makes user_creatable_add_type() skip visiting them as intended, but it
also makes visit_check_struct() fail, because the opts visitor still
expects the two to be visited.
