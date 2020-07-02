Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50426C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151DF20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFa3FAqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DF20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4fI-0005oe-9G
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jr4eR-0005Ah-LV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:13:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jr4eQ-0002ox-B9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593717217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mk5HCLGOev702+QEdJeJepDhUcXVTL4w6F8hUadowNg=;
 b=ZFa3FAqzzeBTRqI6HAT/P4T8S8QDDvO/wvaunbdYmFUedVfOBQAA+wfc51myH1O+k0V3Oa
 dY363JcSNzLqFq7l+blm6k0Ecm7lU9a7sDFIKCJ9Mxdr2zrPH94uT5fSNqEwMzmVc/neIQ
 PgYF8M2DH69kUIdr6tVQ8c+tf0PTb4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-TlenPzREOeq9dO7zI_d7Rg-1; Thu, 02 Jul 2020 15:13:27 -0400
X-MC-Unique: TlenPzREOeq9dO7zI_d7Rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA4DA0BD7;
 Thu,  2 Jul 2020 19:13:26 +0000 (UTC)
Received: from work-vm (ovpn-114-239.ams2.redhat.com [10.36.114.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5549360C81;
 Thu,  2 Jul 2020 19:13:24 +0000 (UTC)
Date: Thu, 2 Jul 2020 20:13:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/6] migration: improve error reporting of block driver
 state name
Message-ID: <20200702191321.GH14863@work-vm>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-2-berrange@redhat.com>
 <353f3015-ac0b-9332-ba7b-327e30ac0bd2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <353f3015-ac0b-9332-ba7b-327e30ac0bd2@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> > With blockdev, a BlockDriverState may not have an device name,
> 
> s/an/a/
> 
> > so using a node name is required as an alternative.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   migration/savevm.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Why don't you send this one to trivial.

Dave

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


