Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKUr-0007D2-MM
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKUo-0000Vw-Gv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cWKUo-0000VO-BH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:08:06 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D2BB80F7D
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:08:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-5-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 6 Jan 2017 18:28:12 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-5-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jan 2017 11:08:00 +0100
Message-ID: <87sho778qn.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/15] Fold postcopy_ram_discard_range into
 ram_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> I'd created this weird pair of:
>   ram_discard_range   that lived in migration/ram.c
>      Which is built target-dependent so can access the insides of
>      RAMBlock
>
>   postcopy_ram_discard_range
>      Which actually does the discard.
>
> Flatten these down into ram_discard_range, this relies on the
> CONFIG_MADVISE check to be sure we have the real DONTNEED madvise
> rather than the posix variant that isn't guaranteed to discard pages.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> @@ -1877,7 +1879,15 @@ int ram_discard_range(MigrationIncomingState *mis,
>                           host_endaddr);
>              goto err;
>          }
> -        ret = postcopy_ram_discard_range(mis, host_startaddr, length);
> +        errno = ENOTSUP;
> +#if defined(CONFIG_MADVISE)
> +        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> +#endif

This really looks weird, we shouldn't arrive here if CONFIG_MADVISE is
not configured, no?

Later, Juan.
