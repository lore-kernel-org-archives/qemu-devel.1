Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtXo-0001xp-TD
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtXm-0008Hx-NC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:23:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhtXm-0008Hp-IC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:23:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34C3B805A530
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 09:23:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180723123305.24792-4-peterx@redhat.com> (Peter Xu's message of
	"Mon, 23 Jul 2018 20:33:04 +0800")
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-4-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 11:23:38 +0200
Message-ID: <8736w9gf6t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 3/4] tests: only update last_byte
 when at the edge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The only possible change of last_byte is when it reaches the edge.
> Setting it every time might let last_byte contain an invalid data when
> memory corruption is detected, then the check of the next byte will be
> incorrect.  For example, a single page corruption at address 0x14ad000
> will also lead to a "fake" corruption at 0x14ae000:
>
>   Memory content inconsistency at 14ad000 first_byte = 44 last_byte = 44 current = ef hit_edge = 0
>   Memory content inconsistency at 14ae000 first_byte = 44 last_byte = ef current = 44 hit_edge = 0
>
> After the patch, it'll only report the corrputed page:
>
>   Memory content inconsistency at 14ad000 first_byte = 44 last_byte = 44 current = ef hit_edge = 0
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Good catch.  I was having this problem in the past, but never
investigated the problem so far.
