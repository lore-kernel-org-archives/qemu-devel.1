Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A69C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0129F20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUQxVIER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0129F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTav-0005Qs-4H
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPTZv-0004Xu-T3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPTZu-0000Up-9N
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601916189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bx9ny2N/hJHfH080rCM9p5MudFlrDdrUBXo/4kq13As=;
 b=BUQxVIEROle+8lyxLl/obhWDPSXmuTl17SAK+72SaRvhE7VgUEGXW40aqy8j2Z6D8dwV0b
 +JHowoyPLJJ1VMCXHeUhNlZNgx4oWUkGO+ch35JhD398kJJOzIsLXrYzKw4hIb/l4eiNXp
 voXsnCdGuiE5tDtAQYaeShoS88di9WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-rPQyvLqyMN-yZAtw0oPN7A-1; Mon, 05 Oct 2020 12:43:07 -0400
X-MC-Unique: rPQyvLqyMN-yZAtw0oPN7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAFE718FE86C;
 Mon,  5 Oct 2020 16:42:44 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC2BF277CF;
 Mon,  5 Oct 2020 16:42:44 +0000 (UTC)
Date: Mon, 5 Oct 2020 12:42:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qom: Improve error message displayed with missing object
 properties
Message-ID: <20201005164244.GK7303@habkost.net>
References: <20200920155340.401482-1-f4bug@amsat.org>
 <0263e47d-549e-8acb-a6cb-93a7436f5f6d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0263e47d-549e-8acb-a6cb-93a7436f5f6d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 10:46:38AM +0200, Paolo Bonzini wrote:
> On 20/09/20 17:53, Philippe Mathieu-Daudé wrote:
> > Instead of only displaying the property missing, also display
> > the object name. This help developer to quickly figure out the
> > mistake without opening a debugger.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > ---
> >  qom/object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qom/object.c b/qom/object.c
> > index 387efb25ebe..257914b1fe3 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
> >          return prop;
> >      }
> >  
> > -    error_setg(errp, "Property '.%s' not found", name);
> > +    error_setg(errp, "Property '%s.%s' not found",
> > +               object_get_typename(obj), name);
> >      return NULL;
> >  }
> >  
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I think it's okay for qemu-trivial.

It would be okay, but it doesn't apply on master anymore due to
the object_propert_find_err() refactor.  I've fixed the conflicts
and queued it on machine-next.

-- 
Eduardo


