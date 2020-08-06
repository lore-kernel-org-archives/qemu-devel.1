Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F97C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B33206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxo5yrsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B33206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kHg-0002Ft-4e
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3kDL-0000DL-FH
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:02:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3kDI-0006Bu-Fc
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596736919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKDx5KmC3UkG6QS7DqUNrcuRy1Ad4WTnKKgYOa6T8Ok=;
 b=Uxo5yrsUkRZSDgl0K4RFW+Aoog6Yo6w7dzLiebtzEPD8T/YvVWEA/L1grAjqUe79wqkyK2
 hV5if1pOSwxTFYGTKdCJaSeu/rc0mDtnSZQjT6gueVjhucPTYSiSDIZJdf8WsIPNdOVvAo
 +N4J/Yuw+0UTcmpeWIfQfgq1+X5HACE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-XGsCN8euOEK9ka_uZzd7zQ-1; Thu, 06 Aug 2020 14:01:56 -0400
X-MC-Unique: XGsCN8euOEK9ka_uZzd7zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D700100AA21;
 Thu,  6 Aug 2020 18:01:55 +0000 (UTC)
Received: from localhost (ovpn-112-108.rdu2.redhat.com [10.10.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE3311D3;
 Thu,  6 Aug 2020 18:01:54 +0000 (UTC)
Date: Thu, 6 Aug 2020 14:01:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/4] crypto: use QOM macros for declaration/definition of
 secret types
Message-ID: <20200806180154.GE1700540@habkost.net>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-4-berrange@redhat.com>
 <20200723185006.GR1274972@habkost.net>
 <20200724091245.GC3146350@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200724091245.GC3146350@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 10:12:45AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jul 23, 2020 at 02:50:06PM -0400, Eduardo Habkost wrote:
> > On Thu, Jul 23, 2020 at 07:14:09PM +0100, Daniel P. Berrangé wrote:
> > > This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
> > > families in the secret types, in order to eliminate boilerplate code.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >  crypto/secret.c                 | 24 ++++--------------------
> > >  crypto/secret_common.c          | 32 +++++++++-----------------------
> > >  crypto/secret_keyring.c         | 28 +++++++++-------------------
> > >  include/crypto/secret.h         | 11 ++---------
> > >  include/crypto/secret_common.h  | 13 ++-----------
> > >  include/crypto/secret_keyring.h | 18 ++----------------
> > >  6 files changed, 28 insertions(+), 98 deletions(-)
> > > 
> > 
> > Beautiful.
> > 
> > I wonder how hard it would be to automate this.  I'm assuming
> > Coccinelle won't be able to deal with the macro definitions, but
> > a handwritten conversion script would be really useful for
> > dealing with our 1226 static TypeInfo structs.
> 
> Probably possible to do a reasonably good job with a perl script or
> similar. The code patterns to be replaced are reasonably easy to
> identify with a few regexes.

I've attempted to parse all the TypeInfo structs in the tree.
The data I've extracted is available at:
https://gist.github.com/ehabkost/7a398640492f369685c789ffed0f67aa

It turns out 230 of our 1259 TypeInfo variables don't have
instance_size set and don't have their own struct type defined.

We could:
* Make that a supported use case, and add helper macros that don't
  require MyDevice to be defined;
* Make that not supported, and convert those 230 types automatically; or
* Make that not supported, and convert those 230 types manually.

-- 
Eduardo


