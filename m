Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC485C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F86204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVTXQ5a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F86204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCXf-00085O-PI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqCSM-0007ZW-JV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:21:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqCSK-0005rD-Ls
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593508892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwV5XnHgV7hMyuN+o8JqEMoqKDiYnwYZBd0qhi2m0pE=;
 b=XVTXQ5a+xFwTWqBYRs49GsvrMoqjYXAj5rLwAbJ1SOaGWngsahFOKFiu7T6B2kGaeD4Zbo
 HXNfAagvV1KPa0JzDzMjbKcd2/vIYiyF6oBXFbiUeGo7U7o4phY5gp6EBPWfSDStDyfg2S
 dia2HE9zsrCNk1Q2ArVOuHl1WSeRTLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-5fXLub9iMdCnuSxmiCUcSA-1; Tue, 30 Jun 2020 05:21:28 -0400
X-MC-Unique: 5fXLub9iMdCnuSxmiCUcSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD531005512;
 Tue, 30 Jun 2020 09:21:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E0FF741A9;
 Tue, 30 Jun 2020 09:21:25 +0000 (UTC)
Date: Tue, 30 Jun 2020 10:21:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 03/26] Clean up some calls to ignore Error objects the
 right way
Message-ID: <20200630092123.GD1370404@redhat.com>
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-4-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-4-armbru@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Jerome Forissier <jerome@forissier.org>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 11:03:28AM +0200, Markus Armbruster wrote:
> Receiving the error in a local variable only to free it is less clear
> (and also less efficient) than passing NULL.  Clean up.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Jerome Forissier <jerome@forissier.org>
> CC: Greg Kurz <groug@kaod.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  chardev/char-socket.c | 6 ++----
>  hw/9pfs/9p.c          | 6 ++----
>  hw/arm/virt.c         | 4 +---
>  hw/ppc/spapr_drc.c    | 4 +---
>  ui/vnc.c              | 3 +--
>  5 files changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


