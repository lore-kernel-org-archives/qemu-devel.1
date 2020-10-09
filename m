Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED431C4363A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9B922247
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoLJ59vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9B922247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR02D-0006nL-6W
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kR01K-00068u-2V
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kR01H-0000j5-Uj
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602279223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNf+5fli6/mWNzlh+aayEgtNW4idk4BpOTgo3K8+LfQ=;
 b=hoLJ59vcwbAbtG8zLV/7QlaXDBPm1B4/QU50I2DsItklDshd4VSF+B6Pdd21ElSkRAQa0+
 DiBA7WYs0zupMNjs4inPVOJmNvxoorKLhVgr17XIy7St8RekxgoyWmVr5pbpbcqyq2bBxs
 Ej+nZsgh3fURKaGcwDLdGda+6f+s8R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-_cF22ScgPkqEs3yDAsFdww-1; Fri, 09 Oct 2020 17:33:38 -0400
X-MC-Unique: _cF22ScgPkqEs3yDAsFdww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648EC107AFC6;
 Fri,  9 Oct 2020 21:33:37 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DDDB19C78;
 Fri,  9 Oct 2020 21:33:37 +0000 (UTC)
Date: Fri, 9 Oct 2020 17:33:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH] vmbus: Don't make QOM property registration conditional
Message-ID: <20201009213336.GJ7303@habkost.net>
References: <20201009200701.1830060-1-ehabkost@redhat.com>
 <4caca0ac-f3a0-bf45-c3d8-7b8c3ec18857@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4caca0ac-f3a0-bf45-c3d8-7b8c3ec18857@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jon Doron <arilou@gmail.com>,
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 11:05:47PM +0200, Maciej S. Szmigiero wrote:
> On 09.10.2020 22:07, Eduardo Habkost wrote:
> > Having properties registered conditionally makes QOM type
> > introspection difficult.  Instead of skipping registration of the
> > "instanceid" property, always register the property but validate
> > its value against the instance id required by the class.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Note: due to the lack of concrete vmbus-dev subclasses in the
> > QEMU tree, this patch couldn't be tested.
> 
> Will test it tomorrow since I have a VMBus device implementation.

Thanks!

Is anybody willing to volunteer to be listed as maintainer (or
reviewer, at least) of hw/hyperv/vmbus.c?

-- 
Eduardo


