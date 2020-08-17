Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E281C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71D9205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1Im34xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71D9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7i3O-0008Op-Sh
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7i2E-0006pv-6B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:30:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7i2C-0006qF-Fb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597681855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yc1VOsjRPXpIHQ/MkEJCgXChN2T2RDJ5oVL6QI0b+Fk=;
 b=L1Im34xOXCJb0S6eNya8ldgRsIIQ/uSPhZQSxwVXAkwuIX/lnfXMTusyPlBsJ8qqLtZXlG
 2lF6cI31DRQeWPO1R+tjkXp/CWH99vRxXGgwVmuhP+we1jKUHU3jxbsIDpDJ52bhuV46J/
 9TQIfX6052sFtX1L9e2o4qE2NX4dDgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-mP7l8UiDOmeMhpnZzvB0nQ-1; Mon, 17 Aug 2020 12:30:53 -0400
X-MC-Unique: mP7l8UiDOmeMhpnZzvB0nQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D47185E531;
 Mon, 17 Aug 2020 16:30:52 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C666BABA;
 Mon, 17 Aug 2020 16:30:51 +0000 (UTC)
Date: Mon, 17 Aug 2020 18:30:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
Message-ID: <20200817183048.30cb6f9e.cohuck@redhat.com>
In-Reply-To: <20200817141734.5109-1-jjherne@linux.ibm.com>
References: <20200817141734.5109-1-jjherne@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Aug 2020 10:17:34 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> The POP states that the IPLB location is only written to 0x14 for
> list-directed IPL. Some operating systems expect 0x14 to not change on
> boot and will fail IPL if it does change.
> 
> Fixes: 9bfc04f9ef6802fff0

Should be

Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")

> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 767012bf0c..5e3e13f4b0 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
>  {
>      /* store the subsystem information _after_ the bootmap was loaded */
>      write_subsystem_identification();
> -    write_iplb_location();
> +
> +    if (iplb.pbt != S390_IPL_TYPE_CCW) {
> +            write_iplb_location();
> +    }

What happens for ipl types other than CCW and FCP? IOW, should that
rather be a positive check for S390_IPL_TYPE_FCP?

>  
>      /* prevent unknown IPL types in the guest */
>      if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {


