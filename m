Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BDC4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5952376F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2xq8LqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5952376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9mh-0004o2-Om
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL9aK-0000RI-1u
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL9aI-00018x-Fw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600886020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68FkNmfWIFcGXUD5OgLtA0A+efm0wWatunVxxa/z0QU=;
 b=H2xq8LqQxbrK47OroKL4PFn8zqo8iOVNUPs4J3Tf1BFCxDieWLBX98Fc0TvBvPsdGEjb+Y
 LLT0QGjZ9jilWQkSxx2d1yUUVgA1xR1zo+2+ymjn1tEzfAwUiNYepbhUp5z/D6XRnK3e/e
 isZuLwTXbJtUQy+Ppxg0w/SDoBesTmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-c194hjYnNM6MXIXfCuktWQ-1; Wed, 23 Sep 2020 14:33:38 -0400
X-MC-Unique: c194hjYnNM6MXIXfCuktWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D44BB84E245;
 Wed, 23 Sep 2020 18:33:36 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 960975D98D;
 Wed, 23 Sep 2020 18:33:36 +0000 (UTC)
Date: Wed, 23 Sep 2020 14:33:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 24/38] qapi/gen.py: Fix edge-case of _is_user_module
Message-ID: <20200923183335.GU3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-25-jsnow@redhat.com>
 <20200923151743.GK3312949@habkost.net>
 <5723714c-e784-ece7-5523-d6d3b5f981a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5723714c-e784-ece7-5523-d6d3b5f981a1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 02:29:28PM -0400, John Snow wrote:
> On 9/23/20 11:17 AM, Eduardo Habkost wrote:
> > This changes behavior if name=='', and I guess this is OK, but
> > I'm not sure.  I miss documentation on `visit_module()`,
> > `visit_include()`, and `_is_user_module()`.  I don't know what
> > `name` means here, and what is a "user module".
> > 
> 
> Good spot, I missed that.
> 
> I can probably do: bool(name and not name.startswith('./'))
> 
> to convert explicitly the empty string to false. I will allow Markus the
> chance to explain the module stuff.

Sound good to me.  If the current behavior needs to be changed,
it can be fixed later.

-- 
Eduardo


