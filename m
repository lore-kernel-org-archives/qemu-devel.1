Received: from eggs.gnu.org ([2001:4830:134:3::10]:45868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQrkW-0000AQ-G7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQrkR-00075k-G0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:25:44 -0500
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:51591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQrkR-00075Y-8v
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:25:39 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 436EDFDFA
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:25:36 +0100 (CET)
Date: Tue, 10 Jan 2017 09:25:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170110092522.36354170@bahia.lan>
In-Reply-To: <1483981368-9965-4-git-send-email-ashijeetacharya@gmail.com>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-4-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] migration: disallow
 migrate_add_blocker during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: dgilbert@redhat.com, jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Mon,  9 Jan 2017 22:32:47 +0530
Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
> [...]
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index faebd91..c823a44 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1013,20 +1013,28 @@ static void coroutine_fn v9fs_attach(void *opaque)
>          goto out;
>      }
>      err += offset;
> -    memcpy(&s->root_qid, &qid, sizeof(qid));
> -    trace_v9fs_attach_return(pdu->tag, pdu->id,
> -                             qid.type, qid.version, qid.path);
> +
>      /*
>       * disable migration if we haven't done already.
>       * attach could get called multiple times for the same export.
>       */
>      if (!s->migration_blocker) {
> -        s->root_fid = fid;
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        migrate_add_blocker(s->migration_blocker);
> +        err = migrate_add_blocker(s->migration_blocker, NULL);
> +        if (err < 0) {
> +            error_free(s->migration_blocker);
> +            s->migration_blocker = NULL;
> +            clunk_fid(s, fid);
> +            goto out;
> +        }
> +        s->root_fid = fid;
>      }

Hmm... my suggestion was to deal with the migration blocker before the call
to pdu_marshal() since there's no point in copying the qid if we're about
to return an error back to the guest.

> +
> +    memcpy(&s->root_qid, &qid, sizeof(qid));
> +    trace_v9fs_attach_return(pdu->tag, pdu->id,
> +                             qid.type, qid.version, qid.path);
>  out:
>      put_fid(pdu, fidp);
>  out_nofid:
