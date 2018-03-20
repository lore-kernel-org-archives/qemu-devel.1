Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyF4o-00015C-79
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyF4j-0007z0-6A
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyF4j-0007yc-1p
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:05 -0400
Date: Tue, 20 Mar 2018 11:04:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180320110451.GA7665@work-vm>
References: <CC0ED444C2C80B429092A9F3715307D9D457069E@H3CMLB12-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CC0ED444C2C80B429092A9F3715307D9D457069E@H3CMLB12-EX.srv.huawei-3com.com>
Subject: Re: [Qemu-devel] [PATCH] HMP: Initialize err before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhangjixiang <jixiang_zhang@h3c.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Zhangjixiang (jixiang_zhang@h3c.com) wrote:
> When bdrv_snapshot_delete return fail, the errp will not be
> assigned a valid value in error_propagate as errp didn't be
> initialized in hmp_delvm, then error_reportf_err will use an
> uninitialized value(call by hmp_delvm), and qemu crash.
> 
> Signed-off-by: zhangjixiang <jixiang_zhang@h3c.com>

Queued.
Note, that even in this version something is corrupting the
patch; something has lost the space at the start of the line in the
first two lines of the patch; so something is still a bit odd in
your mail/patch generation.

Dave

> ---
> hmp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 7870d6a300..4a4da004e9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1340,7 +1340,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
> void hmp_delvm(Monitor *mon, const QDict *qdict)
> {
>      BlockDriverState *bs;
> -    Error *err;
> +    Error *err = NULL;
>      const char *name = qdict_get_str(qdict, "name");
>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> --
> 2.11.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
