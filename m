Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78DC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E920D2074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aq1ZnIdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E920D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytgE-0002R7-85
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jytfW-0001vN-85
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:07:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jytfT-0003hn-Ey
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595581622;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnVw0kXA0Ec2o0GkyE9hdHCgjEzrPCHTTEZ7Lv/XNq4=;
 b=aq1ZnIdig1tKPP7jmSjYwdUIkNIeR0oHeLN8i7fKOp1k++ubLX00v/cNgdzXODs6bP+/db
 miH5CfgBG2371/7OEqfMb1QGUvfqmXLrah1pHg6TIzBRfXVbUq/BXvHCanXbTO4+QFGiC1
 0j6X+rIZsDss84O6V8T4ymC8nKTELiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-NfutU0SvNc2WjJ7ti3OSyw-1; Fri, 24 Jul 2020 05:06:56 -0400
X-MC-Unique: NfutU0SvNc2WjJ7ti3OSyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71FD491271
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:06:55 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4052E10013D9;
 Fri, 24 Jul 2020 09:06:54 +0000 (UTC)
Date: Fri, 24 Jul 2020 10:06:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] qom: make object_ref/unref use a void * instead of
 Object *.
Message-ID: <20200724090651.GA3146350@redhat.com>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-2-berrange@redhat.com>
 <c8ac5a99-6a66-e0ad-6876-aa1064e07541@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c8ac5a99-6a66-e0ad-6876-aa1064e07541@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 02:04:45PM -0500, Eric Blake wrote:
> On 7/23/20 1:14 PM, Daniel P. Berrangé wrote:
> > The object_ref/unref methods are intended for use with any subclass of
> > the base Object. Using "Object *" in the signature is not adding any
> > meaningful level of type safety, since callers simply use "OBJECT(ptr)"
> > and this expands to an unchecked cast "(Object *)".
> > 
> > By using "void *" we enable the object_unref() method to be used to
> > provide support for g_autoptr() with any subclass.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/qom/object.h | 4 ++--
> >   qom/object.c         | 6 ++++--
> >   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> Is it worth a followup patch (probably with Coccinelle) that changes:
> 
> object_ref(OBJECT(dev));
> 
> to the now-simpler
> 
> object_ref(dev);

Yes, its worth a cleanup.

> But I don't think it belongs in this patch, so
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


