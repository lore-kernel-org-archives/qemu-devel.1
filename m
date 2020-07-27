Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E2CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23472075D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St/jgGLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23472075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzps-0003Lj-5w
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzp8-0002ej-0E
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:53:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzp6-0006uP-FS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595843611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJ6bXqJqnQvjdEfe/zSrkOmWsXEi8NFyhUfcd1eB9wk=;
 b=St/jgGLrRsLk6ImfKSyq/QghE5y00aEojJWc/4LZ3oXNyaug3U4QkDKU8SZSF/qfc0gQSJ
 4gfXFhUnSpMsEJb7SRV1hqX+6PJWPdYcBQQFUBvU934VLXwLDRDu5sV15QiTLB/hb7mCHS
 O912H9jteRea8/X7bt6u1xqre3ONTMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-8C7O55SgOc2kie3GIG_AvQ-1; Mon, 27 Jul 2020 05:53:29 -0400
X-MC-Unique: 8C7O55SgOc2kie3GIG_AvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8DD21005504
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 09:53:28 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7CC560C87;
 Mon, 27 Jul 2020 09:53:24 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:53:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727115322.4e7fe1aa.cohuck@redhat.com>
In-Reply-To: <20200727053954-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 05:41:17 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
> > We try to get config from peer unconditionally which may lead NULL
> > pointer dereference. Add a check before trying to access the config.
> > 
> > Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> > Cc: Cindy Lu <lulu@redhat.com>
> > Tested-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>  
> 
> I am a bit lost here. Isn't this invoked
> when guest attempts to read the config?
> With no peer, what do we return to guest?

Same as with a non-vdpa peer? It's the dereference that needs to be
guarded.

> A code comment might be helpful here.
> 
> > ---
> >  hw/net/virtio-net.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)


