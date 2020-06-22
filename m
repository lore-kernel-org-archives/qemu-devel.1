Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072A320720
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhUIwiSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072A320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnK7u-0003wH-6y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnJxX-0003LT-2q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:45:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnJxV-0005u7-Ai
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQ8HakB7ZbOWyB4Yh3QhjSoK4c42rgj7fcN30BSDmzc=;
 b=YhUIwiSw1DdVDRa97pVC9L+RUW6vbneiDYp+lkNoS734HWQPCm8pTwSKqsKp/lqp/zUupR
 968oBlGD9zWzNQ+PN/h6qb1ILEfDHIfBLihFdnVkmmrozGuAUa/I2aac5YzRPprocBDSV4
 lJ/IKwSY5zFqLOTcFCf+IfjgngsVmi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-HvYVR4JnNR6BvDfJ0DuGLA-1; Mon, 22 Jun 2020 06:45:47 -0400
X-MC-Unique: HvYVR4JnNR6BvDfJ0DuGLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B76A464;
 Mon, 22 Jun 2020 10:45:45 +0000 (UTC)
Received: from gondolin (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC0C060BEC;
 Mon, 22 Jun 2020 10:45:34 +0000 (UTC)
Date: Mon, 22 Jun 2020 12:45:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] s390/sclp: read sccb from mem based on sccb length
Message-ID: <20200622124532.23dd722a.cohuck@redhat.com>
In-Reply-To: <20200618222258.23287-5-walling@linux.ibm.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-5-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 18:22:54 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> The header of the SCCB contains the actual length of the SCCB. Instead
> of using a static 4K size, let's allow for a variable size determined
> by the value set in the header. The proper checks are already in place
> to ensure the SCCB length is sufficent to store a full response, and
> that the length does not cross any explicitly-set boundaries.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/sclp.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


