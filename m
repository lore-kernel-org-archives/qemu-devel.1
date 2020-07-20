Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC262070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wa6ugJTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC262070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUQB-0003mV-7t
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxUPM-0003M5-06
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:56:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxUPJ-0007eh-QX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595246192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=PW633/sUAVYWtBug3hNsmaW9T9AZq9yBjW/hV1PWpEE=;
 b=Wa6ugJTtN5sYPC28klg6Qq4smiHxwLQ/o19jYTYU/j0yGpBYIjvSVUnZL90u4sRqpUcOJU
 dU4FwWaSn2xoCW0SDofz2siU6YJMm8Uckp1N09vrF1I9+NDdZ9se/PCxrt2LHFlvTcPu8e
 usNx2WM9j2NnV74VfpBMDWlFiL8Ndpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-gR9SROGWMviWuFyZ48CEAg-1; Mon, 20 Jul 2020 07:56:31 -0400
X-MC-Unique: gR9SROGWMviWuFyZ48CEAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30CA1805721;
 Mon, 20 Jul 2020 11:56:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC2451002391;
 Mon, 20 Jul 2020 11:56:25 +0000 (UTC)
Subject: Re: [PATCH 4/7] pc-bios: s390x: Rework data initialization
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200715094045.381984-1-frankja@linux.ibm.com>
 <20200715094045.381984-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b7650c7e-4cd9-09ea-57af-0d2982423d0e@redhat.com>
Date: Mon, 20 Jul 2020 13:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715094045.381984-5-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 11.40, Janosch Frank wrote:
> Sometimes a memset is nicer to read than multiple struct->data = 0;
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/dasd-ipl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index e8f2846740..0543334ed4 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -167,16 +167,13 @@ static void ipl1_fixup(void)
>      ccwSeek->cda = ptr2u32(seekData);
>      ccwSeek->chain = 1;
>      ccwSeek->count = sizeof(*seekData);
> -    seekData->reserved = 0x00;
> -    seekData->cyl = 0x00;
> -    seekData->head = 0x00;
> +    memset(seekData, 0, sizeof(*seekData));

Sounds ok for me if the whole struct gets cleared (though I wonder
whether this is really worth the effort)...

>      ccwSearchID->cmd_code = CCW_CMD_DASD_SEARCH_ID_EQ;
>      ccwSearchID->cda = ptr2u32(searchData);
>      ccwSearchID->chain = 1;
>      ccwSearchID->count = sizeof(*searchData);
> -    searchData->cyl = 0;
> -    searchData->head = 0;
> +    memset(searchData, 0, sizeof(*searchData));
>      searchData->record = 2;

... but that looks rather worse to me, and the generated code will
likely also be slightly worse (since ->record is cleared first and then
set to 2 again).

Maybe rather drop this patch?

 Thomas


