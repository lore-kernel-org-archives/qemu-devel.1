Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F42AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 01:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAD22087C
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 01:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhVgPjk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAD22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4Dr2-0006bp-Db
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 21:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k4DpD-00069H-Jp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 21:39:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k4DpA-00030P-Dy
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 21:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596850742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOs+Txjsncb0n0AmiMGnwc0sOau+Ot9y87JuiIGXrx8=;
 b=EhVgPjk7ZiqSRSTgAq8g0R0mJa7GhaUMMJFjsCz/BsT9J/fD11QJPQ7nC5uczNBxfRaT9G
 TdBpSQjVugFPUhL0sXS/vjMOkZ39j2laMSUXm6mfpWaf6M2ML/CP7o5oOSOIFiWWe0kMpT
 mZvzCvKKU9l6CfjK5a6Ii1kN2mwglE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-NhiNJlFOMTuNxdo8jzXIYw-1; Fri, 07 Aug 2020 21:38:59 -0400
X-MC-Unique: NhiNJlFOMTuNxdo8jzXIYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD02801A03;
 Sat,  8 Aug 2020 01:38:58 +0000 (UTC)
Received: from localhost (ovpn-113-123.rdu2.redhat.com [10.10.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 627FC59;
 Sat,  8 Aug 2020 01:38:58 +0000 (UTC)
Date: Fri, 7 Aug 2020 21:38:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/4] crypto: use QOM macros for declaration/definition of
 secret types
Message-ID: <20200808013857.GF1700540@habkost.net>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-4-berrange@redhat.com>
 <20200723185006.GR1274972@habkost.net>
 <20200724091245.GC3146350@redhat.com>
 <20200806180154.GE1700540@habkost.net>
 <20200807111148.GI120942@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200807111148.GI120942@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 20:01:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 12:11:48PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 06, 2020 at 02:01:54PM -0400, Eduardo Habkost wrote:
> > On Fri, Jul 24, 2020 at 10:12:45AM +0100, Daniel P. BerrangÃƒÂ© wrote:
> > > On Thu, Jul 23, 2020 at 02:50:06PM -0400, Eduardo Habkost wrote:
> > > > On Thu, Jul 23, 2020 at 07:14:09PM +0100, Daniel P. BerrangÃƒÂ© wrote:
> > > > > This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
> > > > > families in the secret types, in order to eliminate boilerplate code.
> > > > > 
> > > > > Signed-off-by: Daniel P. BerrangÃƒÂ© <berrange@redhat.com>
> > > > > ---
> > > > >  crypto/secret.c                 | 24 ++++--------------------
> > > > >  crypto/secret_common.c          | 32 +++++++++-----------------------
> > > > >  crypto/secret_keyring.c         | 28 +++++++++-------------------
> > > > >  include/crypto/secret.h         | 11 ++---------
> > > > >  include/crypto/secret_common.h  | 13 ++-----------
> > > > >  include/crypto/secret_keyring.h | 18 ++----------------
> > > > >  6 files changed, 28 insertions(+), 98 deletions(-)
> > > > > 
> > > > 
> > > > Beautiful.
> > > > 
> > > > I wonder how hard it would be to automate this.  I'm assuming
> > > > Coccinelle won't be able to deal with the macro definitions, but
> > > > a handwritten conversion script would be really useful for
> > > > dealing with our 1226 static TypeInfo structs.
> > > 
> > > Probably possible to do a reasonably good job with a perl script or
> > > similar. The code patterns to be replaced are reasonably easy to
> > > identify with a few regexes.
> > 
> > I've attempted to parse all the TypeInfo structs in the tree.
> > The data I've extracted is available at:
> > https://gist.github.com/ehabkost/7a398640492f369685c789ffed0f67aa
> > 
> > It turns out 230 of our 1259 TypeInfo variables don't have
> > instance_size set and don't have their own struct type defined.
> > 
> > We could:
> > * Make that a supported use case, and add helper macros that don't
> >   require MyDevice to be defined;
> > * Make that not supported, and convert those 230 types automatically; or
> > * Make that not supported, and convert those 230 types manually.
> 
> When we force an instance struct, we also force definition of an
> instance init and finalize function.
> 
> 230 types is probably enough to justify a further macro that allows
> the instance struct, init & finalize funtions to be omitted.

Status update: the TypeInfo parser evolved to become a converter
able to replace the type checking macros (automatic conversion of
TypeInfo declarations will be done soon).

https://github.com/ehabkost/qemu-hacks/commits/work/qom-macros-autoconvert

Additional obstacles we'll need to address:

- Sometimes the struct typedefs are in a completely different
  file from the type checking macros.  I've worked around this
  problem by introducing macros that will only add the type
  casting functions, but no typedefs.
- There's some usage of const object pointers in the code,
  which breaks the new type cast functions:
  https://travis-ci.org/github/ehabkost/qemu-hacks/jobs/716033062#L1417

We can probably use _Generic to make the type cast functions
const-safe, but I'm sure this will break existing code that
expects the type casts to always return non-const pointers.

-- 
Eduardo


