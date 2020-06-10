Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4407520656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrwNDIl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4407520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiyAI-0003Rc-H1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jiy98-00029n-3H
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:39:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jiy97-0004bv-1i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591785587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqeQoVDiLPzj+oC5QtOy6LovzAN1dPCLUPcGsxZ1w+E=;
 b=LrwNDIl/UigaxQN/qy3FkfplDLOBKCzVXha1j4YHwwh2JXQDVfPcPbACaC96DEmLypzbjc
 iYU9fvM50BELu+NGfXmW/I5J03bLd19Y8rdgnJdW7NfAvtbm9EhjB3NDi5VfRPKCYiqJAP
 5I0GOjJEkwNT0dgCtedo6a1Ty9fnRYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-XZ19JbkCMf-YdvfX-QgA4g-1; Wed, 10 Jun 2020 06:39:46 -0400
X-MC-Unique: XZ19JbkCMf-YdvfX-QgA4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2E4461
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 10:39:45 +0000 (UTC)
Received: from work-vm (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B889F7890A;
 Wed, 10 Jun 2020 10:39:40 +0000 (UTC)
Date: Wed, 10 Jun 2020 11:39:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] hmp: Make json format optional for qom-set
Message-ID: <20200610103938.GF2718@work-vm>
References: <20200610075153.33892-1-david@redhat.com>
 <5653183f-0d7b-fb39-5da3-868dec0fb2c2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5653183f-0d7b-fb39-5da3-868dec0fb2c2@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 10.06.20 09:51, David Hildenbrand wrote:
> > Commit 7d2ef6dcc1cf ("hmp: Simplify qom-set") switched to the json
> > parser, making it possible to specify complex types. However, with this
> > change it is no longer possible to specify proper sizes (e.g., 2G, 128M),
> > turning the interface harder to use for properties that consume sizes.
> > 
> > Let's switch back to the previous handling and allow to specify passing
> > json via the "-j" parameter.
> > 
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > v1 - v2:
> > - keep the "value:S" as correctly noted by Paolo :)
> > ---
> >  hmp-commands.hx    |  7 ++++---
> >  qom/qom-hmp-cmds.c | 20 ++++++++++++++++----
> >  2 files changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 28256209b5..5d12fbeebe 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1806,9 +1806,10 @@ ERST
> >  
> >      {
> >          .name       = "qom-set",
> > -        .args_type  = "path:s,property:s,value:S",
> > -        .params     = "path property value",
> > -        .help       = "set QOM property",
> > +        .args_type  = "json:-j,path:s,property:s,value:S",
> > +        .params     = "[-j] path property value",
> > +        .help       = "set QOM property.\n\t\t\t"
> > +                      "-j: the property is specified in json format.",
> 
> Stupid mistake:
> 
> "-j: the value is specified in json format

oops; can fix that in commit

> 
> -- 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


