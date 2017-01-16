Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6ek-00027K-3g
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6eg-0002zk-7o
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT6eg-0002zP-2B
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:44:58 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24BB231B305
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:44:58 +0000 (UTC)
Date: Mon, 16 Jan 2017 20:44:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116124453.GA10221@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-2-pbonzini@redhat.com>
	<20170116110942.GB14226@lemon.Home>
	<b4f6ed6c-8f57-104e-50c5-f7102acb64c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f6ed6c-8f57-104e-50c5-f7102acb64c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, 01/16 13:19, Paolo Bonzini wrote:
> >> +static void co_schedule_bh_cb(void *opaque)
> >> +{
> >> +    AioContext *ctx = opaque;
> >> +    QSLIST_HEAD(, Coroutine) straight, reversed;
> >> +
> >> +    QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
> >> +    QSLIST_INIT(&straight);
> > 
> > Worth special casing 1 element case?
> 
> Sounds like premature optimization; the QSLIST_MOVE_ATOMIC is going to
> be pretty expensive anyway.  Do you mean something like:
> 
> 	if (QSLIST_EMPTY(&reversed)) {
> 	    return;
> 	}
> 	Coroutine *co = QSLIST_FIRST(&reversed);
> 	if (!QSLIST_NEXT(co, co_scheduled_next)) {
> 	    straight = reversed;
> 	} else {
> 	    do {
>                 ...
> 	    } while (!QSLIST_EMPTY(&reversed);
> 	}
> 
> 	do {
> 	    ...
> 	} while (!QSLIST_EMPTY(&straight);
> 
> ?  Looks a but busy.  However, removing the QSLIST_EMPTY case and then
> using do/while may be a nice middle.

I think QSLIST_EMPTY is very unusual. I don't know if these are premature or
not, just asked because the !QSLIST_NEXT() case will be the most common one.

Fam
