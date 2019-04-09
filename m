Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9409C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC80F2084B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC80F2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDt01-00079N-Th
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:49:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hDsz1-0006sI-Ef
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hDsz0-0006VT-Es
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hDsz0-0006RZ-4X
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBCEF308622A;
	Tue,  9 Apr 2019 15:42:21 +0000 (UTC)
Received: from redhat.com (ovpn-116-51.ams2.redhat.com [10.36.116.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EAFD600D4;
	Tue,  9 Apr 2019 15:42:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20190409151830.6024-1-peter.maydell@linaro.org> (Peter Maydell's
	message of "Tue, 9 Apr 2019 16:18:30 +0100")
References: <20190409151830.6024-1-peter.maydell@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date: Tue, 09 Apr 2019 17:46:42 +0200
Message-ID: <87ef6byye5.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 09 Apr 2019 15:42:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix
 use-after-free in multifd_recv_unfill_packet()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409154642.WI6azhBHuiVOp-496Dkixp80r6HU6EaKToVPQg5F4N8@z>

Peter Maydell <peter.maydell@linaro.org> wrote:
> Coverity points out (CID 1400442) that in this code:
>
>     if (packet->pages_alloc > p->pages->allocated) {
>         multifd_pages_clear(p->pages);
>         multifd_pages_init(packet->pages_alloc);
>     }
>
> we free p->pages in multifd_pages_clear() but continue to
> use it in the following code. We also leak memory, because
> multifd_pages_init() returns the pointer to a new MultiFDPages_t
> struct but we are ignoring its return value.
>
> Fix both of these bugs by adding the missing assignment of
> the newly created struct to p->pages.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

ouch,

good catch.

Reviewed-by: Juan Quintela <quintela@redhat.com>



> I don't know anything about the multifd code, but this seems like
> the obvious fix based on looking at what the clear and init
> functions are doing. I have only run 'make check' on this,
> so review and testing definitely in order. I think we should
> really put this into 4.0, which means ideally I'd like to
> commit it to master today or tomorrow, though...
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index f68beeeeffc..1ca9ba77b6a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -851,7 +851,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       */
>      if (packet->pages_alloc > p->pages->allocated) {
>          multifd_pages_clear(p->pages);
> -        multifd_pages_init(packet->pages_alloc);
> +        p->pages = multifd_pages_init(packet->pages_alloc);
>      }
>  
>      p->pages->used = be32_to_cpu(packet->pages_used);

