Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F955C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2206D206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLyKzhqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2206D206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD518-0008CM-0R
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD50R-0007ly-5v
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD50P-0004P9-Eg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598961796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sJn2FVQZY3txKUwshRG2Ctr7EeyeQDnQPrvs5PQaZoE=;
 b=RLyKzhqCihfrJ4ELNG0w2CW3Or+4ZqNBJQyGZgB5V4NxCsRYnMus0jEzq6CKk26TdwedsG
 FjLfYPjQDWLFXfniMcOqfJBUXRMIwU6KFk1pEOqFkp7fxnkpWqxdlwRwp0geB9vW7QMCJW
 Ji2DhU4ixO9WDCpA/rcp7ilCQu1ilX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-nnKUNnJZOzSuDC10mJgt4w-1; Tue, 01 Sep 2020 08:03:14 -0400
X-MC-Unique: nnKUNnJZOzSuDC10mJgt4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27D678712FE;
 Tue,  1 Sep 2020 12:03:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB62418B59;
 Tue,  1 Sep 2020 12:03:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73D52113C418; Tue,  1 Sep 2020 14:03:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2 06/10] target/i386/cpu: Fix memleak in
 x86_cpu_class_check_missing_features
References: <20200831134315.1221-1-pannengyuan@huawei.com>
 <20200831134315.1221-7-pannengyuan@huawei.com>
Date: Tue, 01 Sep 2020 14:03:06 +0200
In-Reply-To: <20200831134315.1221-7-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Mon, 31 Aug 2020 09:43:11 -0400")
Message-ID: <87ft81ya9x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kuhn.chenqun@huawei.com,
 qemu-devel@nongnu.org, euler.robot@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> writes:

> 'err' forgot to free in x86_cpu_class_check_missing_features error path.
> Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
> - V2: no changes in v2.
> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..4678aac0b4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4872,6 +4872,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
       x86_cpu_expand_features(xc, &err);
       if (err) {
           /* Errors at x86_cpu_expand_features should never happen,
            * but in case it does, just report the model as not
            * runnable at all using the "type" property.
            */
           strList *new = g_new0(strList, 1);
>          new->value = g_strdup("type");
>          *next = new;
>          next = &new->next;
> +        error_free(err);
>      }
>  
>      x86_cpu_filter_features(xc, false);

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Recommended cleanup: change x86_cpu_filter_features() to return true on
success, false on failure, then pass NULL here and check the return
value.  Can be done on top.


