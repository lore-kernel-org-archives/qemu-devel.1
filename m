Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F522C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68883206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzNKZNjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68883206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyUho-0006OO-OT
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 02:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyUgo-0005tw-N9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:26:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyUgl-0007OU-SP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595485602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoNuoPdeh4DWa8etcPs+o471eSo3FeektVf/mvEbqfU=;
 b=BzNKZNjHXOuXv38CqKX5of9UXT9AaPgqz0eenz+qp+iJJ9F9yZ+0csPUNzh359cWDOE0nF
 4nlU7cKO99wL2wlKIND/ugPVpGa7IcElErdikiNOOwioRNyNXLfD63SCII2rVwirB/sBfe
 b3nyzaEu1VfCHs4eMRrGUtmJGvhRF/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-9f6cxhuwMT-5aGH5ZXhy2g-1; Thu, 23 Jul 2020 02:26:38 -0400
X-MC-Unique: 9f6cxhuwMT-5aGH5ZXhy2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A5FA80183C;
 Thu, 23 Jul 2020 06:26:37 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7995160E1C;
 Thu, 23 Jul 2020 06:26:29 +0000 (UTC)
Date: Thu, 23 Jul 2020 08:26:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 3/8] s390/sclp: rework sclp boundary and length checks
Message-ID: <20200723082626.5f2bda1b.cohuck@redhat.com>
In-Reply-To: <a4e80383-b244-e47b-8980-8b35fb6a7468@linux.ibm.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-4-walling@linux.ibm.com>
 <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
 <c7ba363c-a142-9fb9-2ecf-a8dc56a6e6f8@linux.ibm.com>
 <bd373fb2-20d3-baf4-f2bc-4eca1f033c2b@redhat.com>
 <a4e80383-b244-e47b-8980-8b35fb6a7468@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 14:40:14 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 7/21/20 4:41 AM, David Hildenbrand wrote:

> > The options I would support are
> > 
> > 1. "sccb_boundary_is_valid" which returns "true" if valid
> > 2. "sccb_boundary_is_invalid" which returns "true" if invalid
> > 3. "sccb_boundary_validate" which returns "0" if valid and -EINVAL if not.
> > 
> > Which makes reading this code a bit easier.
> >   

Of these, I like option 1 best.

> 
> Sounds good. I'll takes this into consideration for the next round. (I
> may wait just a little longer for that to allow more reviews to come in
> from whoever has the time, if that's okay.)

We have to wait for (a) QEMU to do a release and (b) the Linux changes
to merge upstream anyway, so we're not in a hurry :)

As said before, it already looked good from my side, but the suggested
changes are fine with me as well.


