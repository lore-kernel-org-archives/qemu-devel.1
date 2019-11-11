Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B743720679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3pY3Mq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B743720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCeF-0002Ma-Bc
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUCXq-0004eg-90
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUCXo-0006xs-V6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:28:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUCXo-0006xA-Qu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573489679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X7O/cqtMcg6XrCBbeKbaTJ248Krlc0TUhzZ0EY0fJGI=;
 b=L3pY3Mq8lEneq0tkuA5q54/BR/tCX6XS0H8/kyX363vTKF+Hj5sQx7ilk3CTL8ZugZS+jo
 XE7uCsrWbuc3vvV55qJSdSSBV+f79xTtt9H1XJmQm0X1uhqazv1UH/eQKdHFxPUtWRIO6H
 LpvoiP0dBLgyAVJ1Q5xjt7+mJ3ZWmO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-6xkMT9aTN3-vGbssSvgDVw-1; Mon, 11 Nov 2019 11:27:58 -0500
X-MC-Unique: 6xkMT9aTN3-vGbssSvgDVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14C018B9FE1;
 Mon, 11 Nov 2019 16:27:56 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266DB600CC;
 Mon, 11 Nov 2019 16:27:50 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:27:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 30/49] multi-process: send heartbeat messages to
 remote
Message-ID: <20191111162750.GJ402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <14c33104778e77fcf2e7f0df2a1dd96fbcaf49d7.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <14c33104778e77fcf2e7f0df2a1dd96fbcaf49d7.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hk6Zb6cduJ+I0Tmj"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hk6Zb6cduJ+I0Tmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:09:11AM -0400, Jagannathan Raman wrote:
> +static void broadcast_msg(MPQemuMsg *msg, bool need_reply)
> +{
> +    PCIProxyDev *entry;
> +    unsigned int pid;
> +    int wait;
> +
> +    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
> +        if (need_reply) {
> +            wait = eventfd(0, EFD_NONBLOCK);
> +            msg->num_fds = 1;
> +            msg->fds[0] = wait;
> +        }
> +
> +        mpqemu_msg_send(entry->mpqemu_link, msg, entry->mpqemu_link->com);
> +        if (need_reply) {
> +            pid = (uint32_t)wait_for_remote(wait);

Sometimes QEMU really needs to wait for the remote process before it can
make progress.  I think this is not one of those cases though.

Since QEMU is event-driven it's problematic to invoke blocking system
calls.  The remote process might not respond for a significant amount of
time.  Other QEMU threads will be held up waiting for the QEMU global
mutex in the meantime (because we hold it!).

Please implement heartbeat/ping asynchronously.  The wait eventfd should
be read by an event loop fd handler instead.  That way QEMU can continue
with running the VM while waiting for the remote process.

This will also improve guest performance because there will be less
jitter (random latency because the event loop is held up waiting for
remote processes for short periods of time).

--hk6Zb6cduJ+I0Tmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JjAUACgkQnKSrs4Gr
c8h/rgf+PIiKNXeSwLkcmPSgzkNWcEJabvhrjF8/6RVp1kIarA2L7wbOVhKNKYIS
0ra9en2c82X8y6PL2yQxJ6c/ZMm6yfPwLE+kU8VsTDMJqsubLqf28jAc2u8BKzyf
WTBlUEjyt3fweBXH7RlsqgJqJF05+KZZlVZieeo8euy7WanIN8J3sWoW2tf4Du+Z
3chMwETQeSpIxHr4aV5bQm7Kz9qesZU9iARcDMIhNS/Q1Q4ixZZeVfZDZHNxtKD8
wS+rAmdlTr9AquAGqrK0tjrFgO/sLiygY8/JNAxOMRj6ZylhXXHFR3cZoEwR+LYP
sGniBr7Sdsc9X5tALeZR8XE5kBAZlA==
=QTtD
-----END PGP SIGNATURE-----

--hk6Zb6cduJ+I0Tmj--


