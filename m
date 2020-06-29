Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F188FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD50F239ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiKNVL2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50F239ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprVi-0006PX-Sw
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jprV8-0005zu-Vo
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:59:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jprV6-0005WY-Ge
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593428339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2N45i+FKpa8lwICM5IAi35VzUX0667Td8zW0RlkjSSo=;
 b=EiKNVL2VmYROKjWkQzdxE8tMXzk56ub7+BgtVNagp+cCEbNpaONTImkjV2dmWNeG/jZp7W
 aqkV7GglSDQdRvhFiHPkGMNb/rwT9PqKGcOReu3J8wMXHXuMcM8pHjuNsYoR1wMAb/0Ajq
 fxud3PESAciBdXK93DwCmVuo7t7J4+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-RHuqFGiROEiY2GdnuoLbMg-1; Mon, 29 Jun 2020 06:58:55 -0400
X-MC-Unique: RHuqFGiROEiY2GdnuoLbMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9E6800C64;
 Mon, 29 Jun 2020 10:58:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-140.ams2.redhat.com [10.36.112.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 428488203A;
 Mon, 29 Jun 2020 10:58:47 +0000 (UTC)
Subject: Re: [PATCH v3 28/30] gitlab: split build-disabled into two phases
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-29-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2cf0d51-adca-db86-8af1-a3ac280f9a50@redhat.com>
Date: Mon, 29 Jun 2020 12:58:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-29-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 f4bug@amsat.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 cota@braap.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2020 20.13, Alex Bennée wrote:
> As we run check-qtest in "SLOW" mode this can timeout so split into
> two jobs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.yml | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index eb5b335c1e9..c6f1addc2f3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -110,7 +110,7 @@ check:system-fedora-alt:
>       IMAGE: fedora
>       MAKE_CHECK_ARGS: check-acceptance
>   
> -build-disabled:
> +build:system-fedora-disabled:
>     <<: *native_build_job_definition
>     variables:
>       IMAGE: fedora
> @@ -121,6 +121,17 @@ build-disabled:
>         --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>         --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
>       TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
> +  artifacts:
> +    paths:
> +      - build
> +
> +qtest:system-fedora-disabled:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-fedora-disabled
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
>       MAKE_CHECK_ARGS: check-qtest SPEED=slow

Reviewed-by: Thomas Huth <thuth@redhat.com>

I still wonder why the test got slower in the recent weeks ... and maybe 
we should also change the target list now that the test runs in a 
separate stage? ... well, I guess that's also something for later ...

  Thomas


