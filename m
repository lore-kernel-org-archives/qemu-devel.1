Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d32HJ-0001Bs-Jd
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d32HG-0008Uy-Dv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d32HG-0008Ue-6y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:21:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 351477E9CB
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 15:21:17 +0000 (UTC)
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-7-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <486c3746-e254-677d-7709-54670eafa6b0@redhat.com>
Date: Tue, 25 Apr 2017 17:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170425102446.4008-7-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 25/04/2017 12:24, Juan Quintela wrote:
> This way we use the "normal" way of printing errors for hmp commands.
> 
> --
> Paolo suggestion

"Suggested-by" tag?

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                    |  9 +++++++--
>  include/sysemu/sysemu.h  |  4 ++--
>  migration/savevm.c       | 51 ++++++++++++++++++++++++------------------------
>  replay/replay-snapshot.c |  6 ++++--
>  vl.c                     |  4 +++-
>  5 files changed, 41 insertions(+), 33 deletions(-)
> 
...
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 8cced46..fdc4353 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -62,14 +62,16 @@ void replay_vmstate_register(void)
>  
>  void replay_vmstate_init(void)
>  {
> +    Error *err = NULL;
> +
>      if (replay_snapshot) {
>          if (replay_mode == REPLAY_MODE_RECORD) {
> -            if (save_vmstate(replay_snapshot) != 0) {
> +            if (save_vmstate(replay_snapshot, &err) != 0) {
>                  error_report("Could not create snapshot for icount record");
>                  exit(1);
>              }
>          } else if (replay_mode == REPLAY_MODE_PLAY) {
> -            if (load_vmstate(replay_snapshot) != 0) {
> +            if (load_vmstate(replay_snapshot, &err) != 0) {
>                  error_report("Could not load snapshot for icount replay");
>                  exit(1);
>              }

You can use "&error_fatal" in these cases.

Thanks,
Laurent
