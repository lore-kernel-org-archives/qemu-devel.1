Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37491C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026E520708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTNptWrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026E520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6jQ-00014U-6V
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Oi-0000rd-GN
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:15:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22659
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Oh-0006xG-Oa
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589195698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SaINzKai802fTlrpKB04eMIdZm3zzjmjJTDzHyKI76s=;
 b=PTNptWrLnURB2pZnw7Ub8iXJtlyxShBPFORbnievmzY4LKG1qoHsLE0lJkow2WZK0pQ+Xh
 E+zvPfGuWb/yiLgDuHbuUq8iqTPuapKnnUbhPXPPaPod6dKKIQ8ma4ON6mjVfJsS4w0Pgk
 RSnsgRptMyLz2aCjUJDg9QaHpveoJ98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-fCshEwQQN46RoKNd0HBaIQ-1; Mon, 11 May 2020 07:14:56 -0400
X-MC-Unique: fCshEwQQN46RoKNd0HBaIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1CF5460;
 Mon, 11 May 2020 11:14:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A7215C1B2;
 Mon, 11 May 2020 11:14:50 +0000 (UTC)
Message-ID: <6f02830942ac3d4812344d7ecfa1841fa668c177.camel@redhat.com>
Subject: Re: [PATCH 3/4] device-core: use atomic_set on .realized property
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2020 14:14:49 +0300
In-Reply-To: <82d51a76-fd38-d72e-2d22-c4de1a76d5f9@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-4-mlevitsk@redhat.com>
 <20200504104538.GC354891@stefanha-x1.localdomain>
 <b265d4ee-400e-bb80-cc37-e89c5dab2a8c@redhat.com>
 <948c2e2f293c08b6411030dc5ad91c23a2f773f0.camel@redhat.com>
 <82d51a76-fd38-d72e-2d22-c4de1a76d5f9@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Mon, 2020-05-11 at 13:11 +0200, Paolo Bonzini wrote:
> On 11/05/20 13:00, Maxim Levitsky wrote:
> > On second thought, I think both cases matter, after I examined the device removal case.
> > In device removal case, the device is first un-realized and then removed from the bus,
> > so just like in device hotplug case, the scsi_device_find can give you an unrealized device.
> > 
> > I will change this patch to set .realized to false at the start (if needed) of the function and to true at the end (also if needed)
> > Will atomic_rcu_set work? or atomic_store_release?
> > (Both are the same thing, but former documents the purpose of using with RCU.
> 
> atomic_rcu_set is more to store pointers, in this case you want to store
> the value after any other change to the struct so atomic_store_release
> is more appropriate.
> 
> Paolo
> 
All right then.
Best regards,
	Maxim Levitsky


