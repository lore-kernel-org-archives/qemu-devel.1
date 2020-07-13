Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7625C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7145820738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTxO1gVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7145820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwqA-0003ra-IY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juwon-0002ga-Dq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juwoe-0002KI-P9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594640410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5btOSnoodjFBjezWJA6lx/RJBkRf2VDFeTOIWsvz5aI=;
 b=KTxO1gVOx+K/GMrRkWWSCEiB5n0CNurRNgcIeT8IfbfwENsWYIImCkwxBXn6gCNkzI56PU
 daronzzySGrorsCAzvyY5Ib3ZkbrFzdoSwNoSoAkw0zszyF0adYdxZlca4Wn+9QJF/v8dP
 wATaSJUo8rLeMuiOfwnbgtOCGv/BL08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-A7iTE2jeM7mezrak1KW_yQ-1; Mon, 13 Jul 2020 07:40:09 -0400
X-MC-Unique: A7iTE2jeM7mezrak1KW_yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 909A380040A;
 Mon, 13 Jul 2020 11:40:07 +0000 (UTC)
Received: from gondolin (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E39F45C1D0;
 Mon, 13 Jul 2020 11:39:59 +0000 (UTC)
Date: Mon, 13 Jul 2020 13:39:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: migration: broken snapshot saves appear on s390 when small
 fields in migration stream removed
Message-ID: <20200713133957.148716a7.cohuck@redhat.com>
In-Reply-To: <20200713110333.GE3122@work-vm>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <20200713110333.GE3122@work-vm>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 Claudio Fontana <cfontana@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 12:03:33 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Claudio Fontana (cfontana@suse.de) wrote:

> > The following workarounds hide the problem (make the test pass):
> > 
> > 1) always including the icount field in the (unrelated) timers field that are sent before in the migration stream (ie not applying the reproducer patch).
> > 
> > 2) increasing the IO_BUF_SIZE also hides the problem:
> > 
> > ----------------------cut--------------------------
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index be21518c57..f81d1272eb 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -30,7 +30,7 @@
> >  #include "trace.h"
> >  #include "qapi/error.h"
> >  
> > -#define IO_BUF_SIZE 32768
> > +#define IO_BUF_SIZE 65536
> >  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> >  
> >  struct QEMUFile {
> > ----------------------cut--------------------------
> > 
> > 3) adding a qemu_fflush in hw/s390x/s390-skeys.c after EOS also "fixes" the problem:
> > 
> > ----------------------cut--------------------------
> > diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> > index 1e036cc602..47c9a015af 100644
> > --- a/hw/s390x/s390-skeys.c
> > +++ b/hw/s390x/s390-skeys.c
> > @@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
> >      .class_size    = sizeof(S390SKeysClass),
> >  };
> >  
> > +extern void qemu_fflush(QEMUFile *f);
> > +
> >  static void s390_storage_keys_save(QEMUFile *f, void *opaque)
> >  {
> >      S390SKeysState *ss = S390_SKEYS(opaque);
> > @@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
> >      g_free(buf);
> >  end_stream:
> >      qemu_put_be64(f, eos);
> > +    qemu_fflush(f);
> >  }
> >  
> >  static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
> > ----------------------cut--------------------------
> > 
> > Do any of you with better understanding of migration/, block and s390 have a suggestion on what could be the issue here,
> > and what could be the next step in the investigation?
> > 
> > Is the fact that migration/ram.c always does fflush after writing the EOS have any relevance here? why does it do it,
> > and should s390 code also follow the same pattern?  
> 
> I didn't think it was required.
> And qemu_put_buffer loops if needed and calls qemu_fflush internally.
> It's possible here that the storage key code is just the canary - the
> first thing that detects that the stream is invalid after it all goes
> wrong.

Yes, that seems possible. Especially as we end up with all zeroes after
the skeys section in the bad case -- it seems like weird problem to
have to be cured by an individual device. No good idea *what* actually
goes wrong, though.


