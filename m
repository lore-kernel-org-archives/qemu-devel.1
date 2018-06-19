Received: from eggs.gnu.org ([2001:4830:134:3::10]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVHAL-0000Xz-Lg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVHAI-0005cK-K3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:59:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVHAI-0005cE-En
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:59:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-6-peterx@redhat.com>
Date: Tue, 19 Jun 2018 15:59:07 +0200
In-Reply-To: <20180619053426.13065-6-peterx@redhat.com> (Peter Xu's message of
	"Tue, 19 Jun 2018 13:34:24 +0800")
Message-ID: <87wouuubbo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 5/7] docs: mention shared state protect
 for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Out-Of-Band handlers need to protect shared state if there is any.
> Mention it in the document.  Meanwhile, touch up some other places too,
> either with better English, or reordering of bullets.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 1366228b2a..fb486d4050 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -664,22 +664,27 @@ command:
>  
>  - They are executed in order,
>  - They run only in main thread of QEMU,
> -- They have the BQL taken during execution.
> +- They run with the BQL held.
>  
>  When a command is executed with OOB, the following changes occur:
>  
>  - They can be completed before a pending in-band command,
>  - They run in a dedicated monitor thread,
> -- They do not take the BQL during execution.
> +- They run with the BQL not held.
>  
>  OOB command handlers must satisfy the following conditions:
>  
> -- It executes extremely fast,
> -- It does not take any lock, or, it can take very small locks if all
> -  critical regions also follow the rules for OOB command handler code,
> +- It terminates quickly,
>  - It does not invoke system calls that may block,
>  - It does not access guest RAM that may block when userfaultfd is
> -  enabled for postcopy live migration.
> +  enabled for postcopy live migration,
> +- It takes only "fast" locks, i.e. all critical sections protected by
> +  any lock it takes also satisfy the conditions for OOB command
> +  handler code.
> +
> +The restrictions on locking limit access to shared state.  Such access
> +requires synchronization, but OOB commands can't take the BQL or any
> +other "slow" lock.
>  
>  If in doubt, do not implement OOB execution support.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
