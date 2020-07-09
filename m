Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011A3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DDA206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g39LzxGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DDA206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtT3e-0002PX-2M
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtT2n-0001a8-O0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:40:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtT2m-00026P-5x
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594287639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xbQ8iOEvwFHTFmdAAa+KCodPVGRxe0/QZyaqZET0+c=;
 b=g39LzxGxF8EW+mpIQgam1YKBQxig7DCAXWdOqtsr88l5wfR2J/zT5y208EDa8ZT8GANCx7
 fMxX4+esVpJGQtLrOkipxaNUTEbtoaSB8+xs/e97520ZT02nj1hh8XRPDhJrcb3SkNSjgT
 UzSMaEqd4d+daQNRYWFBeLhU24b5SO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-2LMOHpjgPrOCH40wTiYzzA-1; Thu, 09 Jul 2020 05:40:38 -0400
X-MC-Unique: 2LMOHpjgPrOCH40wTiYzzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0294E1DE7;
 Thu,  9 Jul 2020 09:40:37 +0000 (UTC)
Received: from starship (unknown [10.35.206.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61B8C79CE9;
 Thu,  9 Jul 2020 09:40:29 +0000 (UTC)
Message-ID: <63efc1928cb7e4fe6bd119f72faf2e76bba9c6f1.camel@redhat.com>
Subject: Re: [PATCH v2 3/7] device-core: use RCU for list of childs of a bus
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 09 Jul 2020 12:40:28 +0300
In-Reply-To: <20200527144539.GI29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-4-mlevitsk@redhat.com>
 <20200527144539.GI29137@stefanha-x1.localdomain>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-05-27 at 15:45 +0100, Stefan Hajnoczi wrote:
> On Mon, May 11, 2020 at 07:09:47PM +0300, Maxim Levitsky wrote:
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index d87d989e72..ef47cb2d9c 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -3,6 +3,8 @@
> >  
> >  #include "qemu/queue.h"
> >  #include "qemu/bitmap.h"
> > +#include "qemu/rcu.h"
> > +#include "qemu/rcu_queue.h"
> >  #include "qom/object.h"
> >  #include "hw/hotplug.h"
> >  #include "hw/resettable.h"
> > @@ -230,6 +232,7 @@ struct BusClass {
> >  };
> >  
> >  typedef struct BusChild {
> > +    struct rcu_head rcu;
> >      DeviceState *child;
> >      int index;
> >      QTAILQ_ENTRY(BusChild) sibling;
> 
> Please add a doc comment to struct BusState saying the children field is
> an RCU QTAILQ and writers must hold the QEMU global mutex.
> 
> Stefan
Done.


Best regards,
	Maxim Levitsky


