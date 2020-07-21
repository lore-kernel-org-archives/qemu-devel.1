Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5CC206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNo/wPea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5CC206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxu28-0000LP-0P
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxu1M-0007yt-J1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:17:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxu1K-0004ZF-PP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595344649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HS1VIDuP1YINGt35gQ1+L+fhifaAatthJ6cqCJKlM/M=;
 b=VNo/wPeaDmV60s2NKdaVyHWL++tIAiloqxXrZJPwSfvmNr+O+cEQLA+er+Zf9PlgPSRk4b
 KOTvrXbvx1JFiNNp8OXDoykPiLS/48F/P5nMLkahvDY1hYCQanB7A+VFmBj+CoCkJhrPq1
 DlorZhXLLKGNbm0Hr4y4dpigtQX2aLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Y8kSjh-2Ormn5WO06Wq31Q-1; Tue, 21 Jul 2020 11:17:26 -0400
X-MC-Unique: Y8kSjh-2Ormn5WO06Wq31Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 877251005510;
 Tue, 21 Jul 2020 15:17:25 +0000 (UTC)
Received: from work-vm (ovpn-114-151.ams2.redhat.com [10.36.114.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7002DE6F;
 Tue, 21 Jul 2020 15:17:14 +0000 (UTC)
Date: Tue, 21 Jul 2020 16:17:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.1 1/5] qdev: Fix device_add DRIVER, help to print
 to monitor
Message-ID: <20200721151712.GA27840@work-vm>
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-2-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714160202.3121879-2-armbru@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:20:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Help on device properties gets printed to stdout instead of the
> monitor.  If you have the monitor anywhere else, no help for you.
> Broken when commit e1043d674d "qdev: use object_property_help()"
> accidentally switched from qemu_printf() to printf().  Switch right
> back.
> 
> Fixes: e1043d674d792ff64aebae1a3eafc08b38a8a085
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 71ebce19df..e9b7228480 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -300,7 +300,7 @@ int qdev_device_help(QemuOpts *opts)
>      }
>      g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
>      for (i = 0; i < array->len; i++) {
> -        printf("%s\n", (char *)array->pdata[i]);
> +        qemu_printf("%s\n", (char *)array->pdata[i]);
>      }
>      g_ptr_array_set_free_func(array, g_free);
>      g_ptr_array_free(array, true);
> -- 
> 2.26.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


