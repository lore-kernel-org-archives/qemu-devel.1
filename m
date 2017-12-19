Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eR9pz-0001TV-PV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eR9pi-0003w6-8V
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:49:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eR9ph-0003rs-JL
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC71785363
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 04:48:46 +0000 (UTC)
Date: Tue, 19 Dec 2017 12:48:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171219044842.GY22308@xz-mi>
References: <20171215115123.12959-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171215115123.12959-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Guard ram_bytes_remaining
 against early call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Fri, Dec 15, 2017 at 11:51:23AM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Calling ram_bytes_remaining during the early part of setup is unsafe
> because the ram_state isn't yet initialised.
> 
> This can happen in the sequence:
>    migrate
>    migrate_cancel
>    info migrate
> 
> if the migrate sticks trying to connect (e.g. to an unresponsive
> destination due to the connect timeout).  Here 'info migrate' sees
> a state of CANCELLING and so assumes the migrate has partially happened.
> 
> partial fix for:
> RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1525899
> Reported-by: Xianxian Wang <xianwang@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Now we fetch this as long as !COMPLETE:

    if (s->state != MIGRATION_STATUS_COMPLETED) {
        info->ram->remaining = ram_bytes_remaining();
        info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
    }

Maybe we should also narrow this down some day.  Thanks,

-- 
Peter Xu
