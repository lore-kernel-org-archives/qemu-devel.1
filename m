Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE2C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAED221BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bL1AzCq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAED221BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHn2R-0007Hz-Vp
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kHn1h-0006gG-T4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kHn1g-0003Ro-5x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600084322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJ4NYO1Dt624pfEiozpZuGH7MWA7rgC6HJsFqEauHlA=;
 b=bL1AzCq66MfGE18HzJxdTUNTyCFPl1aoBWfv3E5vBKc6t6aAX/lf8kQO7Nwfv34GWdVnu5
 G5YZdG6JpEcwA7UYPDOk/7HdtRtpbk78FTTPlMs6SZNgKiTKId9+bLHtUxM03xIQB79XtN
 4lpxo9tl2nMA30YM0CvA+rd2ROjTMf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-7G4B47TdN5OlRcUsDYlx0g-1; Mon, 14 Sep 2020 07:51:14 -0400
X-MC-Unique: 7G4B47TdN5OlRcUsDYlx0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4251F8015C5;
 Mon, 14 Sep 2020 11:50:42 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D73B60BE5;
 Mon, 14 Sep 2020 11:50:40 +0000 (UTC)
Date: Mon, 14 Sep 2020 13:50:38 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 1/8] qemu-options: New -compat to set policy for
 deprecated interfaces
Message-ID: <20200914115038.GV2486@angien.pipo.sk>
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-2-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200914084802.4185028-2-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 10:47:55 +0200, Markus Armbruster wrote:
> Policy is separate for input and output.
> 
> Input policy can be "accept" (accept silently), or "reject" (reject
> the request with an error).
> 
> Output policy can be "accept" (pass on unchanged), or "hide" (filter
> out the deprecated parts).
> 
> Default is "accept".  Policies other than "accept" are implemented
> later in this series.
> 
> For now, -compat covers only syntactic aspects of QMP, i.e. stuff
> tagged with feature 'deprecated'.  We may want to extend it to cover
> semantic aspects, CLI, and experimental features.
> 
> The option is experimental.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

I wasn't able to find any good anchor point which would allow me to
detect that this command line option/feature is present.

Is there anything in e.g. in query-qmp-schema or query-command-line-options
I could base this capability on?


