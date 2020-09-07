Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F77C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44EF207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ar/2A52f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44EF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFa7-0005Ic-Pf
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFYZ-0002Wy-T8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:43:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFYX-0003ad-Jd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599479008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1bmStzOLmeDaBr4Gjfc3zF7uHyIspy5pDfqAN3GNXo=;
 b=ar/2A52f4ZIUpa65XveKTjgHiW6kDKorUryi1Hnzwf+UNST0anEjkLTnWaeGXsuGTuNPbi
 QE+XqgDH9CZZQyq9owTdGHFL4L0hzWAyHR5Ai26pASbRzpUq21CgUqJ3GGnJc7+NFV6MQh
 A1ZMTXH1cDpezcBaW9IY9DesPqOuY6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-z8PAa6F4OjKXx5hWEz5DVA-1; Mon, 07 Sep 2020 07:43:24 -0400
X-MC-Unique: z8PAa6F4OjKXx5hWEz5DVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A77425CC;
 Mon,  7 Sep 2020 11:43:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A32C757E4;
 Mon,  7 Sep 2020 11:43:18 +0000 (UTC)
Subject: Re: [PATCH] hw/s390x/css: Remove double initialization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907024020.854465-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0529dba0-435e-ab3d-d7c6-7100df4c86c3@redhat.com>
Date: Mon, 7 Sep 2020 13:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200907024020.854465-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/09/2020 04.40, Philippe Mathieu-Daudé wrote:
> Fix eventual copy/paste mistake introduced in commit bc994b74ea
> ("s390x/css: Use static initialization for channel_subsys fields").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/s390x/css.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 519dc91316d..9961cfe7bf6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -353,7 +353,6 @@ static ChannelSubSys channel_subsys = {
>      .pending_crws = QTAILQ_HEAD_INITIALIZER(channel_subsys.pending_crws),
>      .do_crw_mchk = true,
>      .sei_pending = false,
> -    .do_crw_mchk = true,
>      .crws_lost = false,
>      .chnmon_active = false,
>      .indicator_addresses =
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


