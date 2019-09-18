Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ACC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D98218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D98218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWbv-00089p-No
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iAWaN-0006vC-IX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iAWaM-000429-CJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:49:19 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:54172
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iAWaM-00041L-5n
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:49:18 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iAWaJ-0007ln-8h; Wed, 18 Sep 2019 11:49:15 +0200
Message-ID: <317365a128caca1e683b94677d93dea98c2928c2.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 18 Sep 2019 11:49:14 +0200
In-Reply-To: <20190918093932.GC26027@stefanha-x1.localdomain>
 (sfid-20190918_113946_369130_4FBC46BB)
References: <20190917122559.15555-1-johannes@sipsolutions.net>
 <20190918093932.GC26027@stefanha-x1.localdomain>
 (sfid-20190918_113946_369130_4FBC46BB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 10:39 +0100, Stefan Hajnoczi wrote:
> 
> >  vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> >      int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> > +    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
> >  
> >      if (index >= dev->max_queues) {
> >          vmsg_close_fds(vmsg);
> > @@ -927,8 +928,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
> >          return false;
> >      }
> >  
> > -    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
> > -        vmsg->fd_num != 1) {
> > +    if (nofd) {
> > +        vmsg_close_fds(vmsg);
> > +        return true;
> > +    }

So in this particular code you quoted, I actually just aligned to have
the same "bool nofd" variable - and I made it return "true" when no FD
was given.

It couldn't make use of what you proposed:

> With the following change to vmsg_close_fds():
> 
>   for (i = 0; i < vmsg->fd_num; i++) {
>       close(vmsg->fds[i]);
>   }
> + for (i = 0; i < sizeof(vmsg->fd_num) / sizeof(vmsg->fd_num[0]); i++) {
> +     vmsg->fds[i] = -1;
> + }
> + vmsg->fd_num = 0;
> 
> ...the message handler functions below can use vmsg->fds[0] (-1) without
> worrying about NOFD.  This makes the code simpler.

because fd_num != 1 leads to the original code returning false, which
leads to the ring not getting started in vu_set_vring_kick_exec(). So we
need the special code here, can be argued if I should pull out the test
into the "bool nofd" variable or not ... *shrug*

The changes in vu_set_vring_kick_exec() and vu_set_vring_err_exec()
would indeed then not be necessary, but in vu_set_vring_call_exec() we
should still avoid the eventfd_write() if it's going to get -1.


So, yeah - could be a bit simpler there. I'd say being explicit here is
easier to understand and thus nicer, but your (or Michael's I guess?)
call.

johannes


