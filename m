Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A78C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B942076A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL6ono5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B942076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUJF-0007tb-4M
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtUHw-00071Y-8M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:00:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtUHt-00045N-RF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594292420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cExasC8GEMYNNmhd3jSDg5Iq+NU5pyg5DEffnXARvvE=;
 b=RL6ono5jB9lCJF9cJToQ1/+LUvSW4ZvYLvxVPmMGGT/VAkFsb9HM8DJKOM0z+h19XUys9R
 Qy4t5LVanDXwJKiqO3bYqxyfKXHbmHmB2yBA5vZlFi8FVjimxx0N4AtBbZ55ohikks6e+1
 t/p2FFgEAR8zwlJjELnElt8+anVM6S0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-rZSwdkmDNrK60u5lIXRotg-1; Thu, 09 Jul 2020 07:00:18 -0400
X-MC-Unique: rZSwdkmDNrK60u5lIXRotg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B008819253C7;
 Thu,  9 Jul 2020 11:00:16 +0000 (UTC)
Received: from gondolin (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 182712B6F1;
 Thu,  9 Jul 2020 10:59:51 +0000 (UTC)
Date: Thu, 9 Jul 2020 12:59:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 3/5] s390x: prepare device memory address space
Message-ID: <20200709125949.7870d454.cohuck@redhat.com>
In-Reply-To: <20200708185135.46694-4-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-4-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 Jul 2020 20:51:33 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's allocate the device memory information and setup the device
> memory address space. Expose the maximum ramsize via SCLP and the actual
> initial ramsize via diag260.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 43 ++++++++++++++++++++++++++++++
>  hw/s390x/sclp.c                    | 12 +++++++--
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  target/s390x/diag.c                |  4 +--
>  4 files changed, 58 insertions(+), 4 deletions(-)

(...)

> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index c3b1e24b2c..6b33eb0efc 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -32,8 +32,8 @@ void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>      ram_addr_t addr, length;
>      uint64_t tmp;
>  
> -    /* TODO: Unlock with new QEMU machine. */
> -    if (false) {
> +    /* Support for diag260 is glued to support for memory devices. */

I'm wondering why you need to do this... sure, the availability of a
new diagnose could be perceived as a guest-visible change, but does the
information presented change anything? Without memory devices, it will
just duplicate the information already reported via SCLP, IIUC?

> +    if (!memory_devices_allowed()) {
>          s390_program_interrupt(env, PGM_OPERATION, ra);
>          return;
>      }


