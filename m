Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A162074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2RRjdUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A162074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7oT-0003sS-Ra
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jh7ne-0002an-4e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:34:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27563
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jh7nd-0000E5-7c
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591346040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNn5FjO6kki+ZnsrHrTD8AKOT/6BjCOU6nWPGebLiyc=;
 b=f2RRjdUaDh4aPhYiUxAskjBztZMeS0rnbTBsas0dl7tMIO8W8g+UoUp4RTwQSaXhnpydIi
 rayb7QdpuT2TZaJ+oGLFS/22aCFn9I+WVdq5HebyluYvjQwP/RgDifa2TKht8QW4OkA/rR
 zCK/d0SiZeqSfLohiIWoRshGpO4XnUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-6N7oljinNtCo3Y71V6cL7A-1; Fri, 05 Jun 2020 04:33:59 -0400
X-MC-Unique: 6N7oljinNtCo3Y71V6cL7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D78835B42;
 Fri,  5 Jun 2020 08:33:56 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 516F810016E8;
 Fri,  5 Jun 2020 08:33:45 +0000 (UTC)
Date: Fri, 5 Jun 2020 10:33:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] numa: forbid '-numa node, mem' for 5.1 and newer
 machine types
Message-ID: <20200605103343.284a4268@redhat.com>
In-Reply-To: <5a4a1b6b-694c-6814-2ab8-93ba6eaa4b2e@redhat.com>
References: <20200602084151.480567-1-imammedo@redhat.com>
 <5a4a1b6b-694c-6814-2ab8-93ba6eaa4b2e@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 07:22:51 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 6/2/20 3:41 AM, Igor Mammedov wrote:
> > Deprecation period is run out and it's a time to flip the switch
> > introduced by cd5ff8333a.  Disable legacy option for new machine
> > types (since 5.1) and amend documentation.
> > 
> > '-numa node,memdev' shall be used instead of disabled option
> > with new machine types.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   - rebased on top of current master
> >   - move compat mode from 4.2 to 5.0
> >   
> 
> >   docs/system/deprecated.rst | 17 -----------------  
> 
> Lately, when we remove something, we've been moving the documentation 
> from 'will be deprecated' to a later section of the document 'has been 
> removed', so that the history is not lost.  But this diffstat says you 
> just deleted, rather than moved, that hunk.
> 
I didn't know that,
I'll send v2 with this hunk moved to removed section


