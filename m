Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD6CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B87920771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI5Sc+xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B87920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uPV-0003Lw-Fe
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k5uOr-0002q0-UK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:18:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k5uOn-00013S-My
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597252726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiVWZH/4Hoop20V7RQ1ZYuq8YN7WPK89pvC4hTiqW3o=;
 b=AI5Sc+xVYujCPh92Git20PLhGaRaRHYYgsaEgiLKxC1Xg2Nkp3nEq0DA8CntnFRAWpqSrZ
 3D6liEhbMg/IBHL+DLgwTcbqPrWtnQypd1oeHflvSS9+qHjcjgin4va4GzK02/y2P8Px5v
 pP0YscZyMDsqOEHCNvBTJe8zKvbt8IU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-VPy4_HP_NbaP00rjiVGpCg-1; Wed, 12 Aug 2020 13:18:43 -0400
X-MC-Unique: VPy4_HP_NbaP00rjiVGpCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24B5102C84A;
 Wed, 12 Aug 2020 17:18:41 +0000 (UTC)
Received: from [10.10.112.89] (ovpn-112-89.rdu2.redhat.com [10.10.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91907100238C;
 Wed, 12 Aug 2020 17:18:40 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain all
 -prom-env data
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
 <159725213748.104309.14834084670144632611.stgit@bahia.lan>
From: John Snow <jsnow@redhat.com>
Message-ID: <fab0be50-a5a9-71c9-2b4a-e9620d6e42b0@redhat.com>
Date: Wed, 12 Aug 2020 13:18:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159725213748.104309.14834084670144632611.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 1:08 PM, Greg Kurz wrote:
> Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> support the -prom-env parameter"), pseries machines can pre-initialize
> the "system" partition in the NVRAM with the data passed to all -prom-env
> parameters on the QEMU command line.
> 
> In this cases it is assumed that all the data fits in 64 KiB, but the user
> can easily pass more and crash QEMU:
> 
> $ qemu-system-ppc64 -M pseries $(for ((x=0;x<128;x++)); do \
>    echo -n " -prom-env "$(for ((y=0;y<1024;y++)); do echo -n x ; done) ; \
>    done) # this requires ~128 Kib
> malloc(): corrupted top size
> Aborted (core dumped)
> 
> Call chrp_nvram_create_system_partition() first, with its recently added
> parameter dry_run set to true, in order to know the required size and fail
> gracefully if it's too small.
> 
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Fixes: 61f20b9dc5b7
RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1867739

Thanks :)

> ---
>   hw/nvram/spapr_nvram.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index 992b818d34e7..c29d797ae1f0 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
>   
>   static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       SpaprNvram *nvram = VIO_SPAPR_NVRAM(dev);
>       int ret;
>   
> @@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
>               return;
>           }
>       } else if (nb_prom_envs > 0) {
> +        int len = chrp_nvram_create_system_partition(nvram->buf,
> +                                                     MIN_NVRAM_SIZE / 4,
> +                                                     true);
> +
> +        /* Check the partition is large enough for all the -prom-env data */
> +        if (nvram->size < len) {
> +            error_setg(errp, "-prom-env data requires %d bytes but spapr-nvram "
> +                       "is only %d bytes in size", len, nvram->size);
> +            error_append_hint(errp,
> +                              "Try to pass %d less bytes to -prom-env.\n",
> +                              len - nvram->size);
> +            return;
> +        }
> +
>           /* Create a system partition to pass the -prom-env variables */
>           chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4,
>                                              false);
> 
> 
> 


