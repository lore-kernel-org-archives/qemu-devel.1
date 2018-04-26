Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBcH6-0005gg-Ko
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBcH3-0004mX-DT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:29:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBcH3-0004mL-7d
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B4FE406C74B
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 08:29:00 +0000 (UTC)
Date: Thu, 26 Apr 2018 16:28:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180426082852.GU9036@xz-mi>
References: <20180425112723.1111-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 00/21] Multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Apr 25, 2018 at 01:27:02PM +0200, Juan Quintela wrote:
> 
> Hi
> 
> 
> [v12]
> 
> Big news, it is not RFC anymore, it works reliabely for me.
> 
> Changes:
> - Locknig changed completely (several times)
> - We now send  all pages through the channels.  In a 2GB guest with 1 disk and a network card, the amount of data send for RAM was 80KB.
> - This is not optimized yet, but it shouws clear improvements over precopy.  testing over localhost networking I can guet:
>   - 2 VCPUs guest
>   - 2GB RAM
>   - runn stress --vm 4 --vm 500GB (i.e. dirtying 2GB or RAM each second)
> 
>   - Total time: precopy ~50seconds, multifd  around 11seconds
>   - Bandwidth usage is around 273MB/s vs 71MB/s on the same hardware
> 
> This is very preleminary testing, will send more numbers when I got them.  But looks promissing.
> 
> Things that will be improved later:
> - Initial synchronization is too slow (around 1s)
> - We synchronize all threads after each RAM section, we can move to only
>   synchronize them after we have done a bitmap syncrhronization
> - We can improve bitmap walking (but that is independent of multifd)

Hi, Juan,

I got some high level review comments and notes:

- This series may need to rebase after Guangrong's cleanup series.

- Looks like now we allow multifd and compression be enabled
  together.  Shall we restrict on that?

- Is multifd only for TCP?  If so, do we check against that?  E.g.,
  should we fail the unix/fd/exec migrations when multifd is enabled?

- Why init sync is slow (1s)?   Is there any clue of that problem?

- Currently the sync between threads are still very complicated to
  me... we have these on the sender side (I didn't dig the recv side):

  - two global semaphores in multifd_send_state,
  - one mutex and two semaphores in each of the send thread,

  So in total we'll have 2+3*N such locks/sems.

  I'm thinking whether we can further simplify the sync logic a bit...

Thanks,

-- 
Peter Xu
