Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77054C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4C6214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSDNd1eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C6214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKX8-00031T-R9
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKKWF-0002Y4-D5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKKWC-0005De-5N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600689722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeiBwT1v+hEcbIfIHCoGmCcObKwEzhD0CtqmONFtLuE=;
 b=ZSDNd1eDA773DmSodnId13Y4QO5ZZPqrxZfOzPdKcnOaxIPqvfvAYWnIVMbex0L29D3+A0
 iqwFK3AgF1/kbrIFR9y3+KF3EJ/nnd+91g4zxri4EnQRoje2xzKiv3RnRID02lqgbAjglF
 CNjnvZ4R4a+FSilyqL4iOM7vZEMaMD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-FdD3GEO-NZu0gqftxv_fGw-1; Mon, 21 Sep 2020 08:01:57 -0400
X-MC-Unique: FdD3GEO-NZu0gqftxv_fGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E33CCD062;
 Mon, 21 Sep 2020 12:01:55 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3635D9D5;
 Mon, 21 Sep 2020 12:01:54 +0000 (UTC)
Date: Mon, 21 Sep 2020 13:01:54 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 1/8] qemu-options: New -compat to set policy for
 deprecated interfaces
Message-ID: <20200921120154.GA27434@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-2-armbru@redhat.com>
 <f17c7dcf-9b37-dd2e-072d-1fd47bba9222@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f17c7dcf-9b37-dd2e-072d-1fd47bba9222@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 10:08:50AM -0500, Eric Blake wrote:
> On 9/14/20 3:47 AM, Markus Armbruster wrote:
> >Policy is separate for input and output.
> >
> >Input policy can be "accept" (accept silently), or "reject" (reject
> >the request with an error).
> >
> >Output policy can be "accept" (pass on unchanged), or "hide" (filter
> >out the deprecated parts).
> >
> >Default is "accept".  Policies other than "accept" are implemented
> >later in this series.
> >
> >For now, -compat covers only syntactic aspects of QMP, i.e. stuff
> >tagged with feature 'deprecated'.  We may want to extend it to cover
> >semantic aspects, CLI, and experimental features.
> >
> >The option is experimental.
> >
> >Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >---
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> But as Peter points out, where is the introspection for whether this
> command line argument exists?

FWIW libguestfs still tests some qemu features by grepping -help
output.  That's actually what I'm intending to do with this one, at
least for now.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


