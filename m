Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D187C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6F320736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y72I6SR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6F320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6CA-000728-8k
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Af-0005q9-9T
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:00:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Ae-0003R5-46
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589194826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhrettcp94RBHJyxvG960QV8myZ0Z8FPZjodV32hsKA=;
 b=Y72I6SR0MEij2R7282lThvRluwByzoEQupxTy33UO/pk0kObppDu8LQ9HZQI0xNzQnM+Mh
 p7X0Md01mjm9qeyB4Ms5y5Trni4roWES23NKPx1X5+XJVlCz77kbj9NopWamM+PRd0LGdw
 JgAWGEctvONNKYhKy1Hf/D3W+5y5DXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-B2P6YAkxN_OAfUZ5YWLxpQ-1; Mon, 11 May 2020 07:00:24 -0400
X-MC-Unique: B2P6YAkxN_OAfUZ5YWLxpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9881899520;
 Mon, 11 May 2020 11:00:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ACCA5C1D2;
 Mon, 11 May 2020 11:00:17 +0000 (UTC)
Message-ID: <948c2e2f293c08b6411030dc5ad91c23a2f773f0.camel@redhat.com>
Subject: Re: [PATCH 3/4] device-core: use atomic_set on .realized property
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2020 14:00:17 +0300
In-Reply-To: <b265d4ee-400e-bb80-cc37-e89c5dab2a8c@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-4-mlevitsk@redhat.com>
 <20200504104538.GC354891@stefanha-x1.localdomain>
 <b265d4ee-400e-bb80-cc37-e89c5dab2a8c@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 13:22 +0200, Paolo Bonzini wrote:
> On 04/05/20 12:45, Stefan Hajnoczi wrote:
> > > @@ -983,7 +983,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> > >      }
> > >  
> > >      assert(local_err == NULL);
> > > -    dev->realized = value;
> > > +    atomic_set(&dev->realized, value);
> > 
> > A memory barrier is probably needed so that the atomic_read() thread
> > sees up-to-date dev fields.
> 
> Yes, it should be a store-release for the false->true case.  The
> true->false case probably doesn't matter as much.

On second thought, I think both cases matter, after I examined the device removal case.
In device removal case, the device is first un-realized and then removed from the bus,
so just like in device hotplug case, the scsi_device_find can give you an unrealized device.

I will change this patch to set .realized to false at the start (if needed) of the function and to true at the end (also if needed)
Will atomic_rcu_set work? or atomic_store_release?
(Both are the same thing, but former documents the purpose of using with RCU.

Best regards,
	Maxim Levitsky



> 
> Paolo
> 



