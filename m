Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86118C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9C2208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG+xWbK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9C2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRXE-0005PT-G8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jwRWP-0004nv-Ex
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:39:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jwRWL-0003jK-VL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594996768;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8M+uY+RybNVzwhc2pzbHC+RSCnfY5ndjfad5pC0aZCo=;
 b=iG+xWbK0WbBV3F8yt4pa1DUSxqJT0a3aE/g+kYiQET8XVO0hJBqMLMDPSv0zWPZqjoI9tc
 xMXtDYtrsQdEvglOmKOIfekgm6p/l3kk/ExmuEQGp+Fa+Nkiv2tS5ERYHa7au4kBpySFhG
 k4QC4zidUXW0Ir/tfuRn5iwIydCqEdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-b4ysf6p7OUuSIvjVZvuY7w-1; Fri, 17 Jul 2020 10:39:24 -0400
X-MC-Unique: b4ysf6p7OUuSIvjVZvuY7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D91108C303;
 Fri, 17 Jul 2020 14:39:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B1A3100EBA7;
 Fri, 17 Jul 2020 14:39:10 +0000 (UTC)
Date: Fri, 17 Jul 2020 15:39:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 5/5] accel/tcg: better handle memory constrained
 systems
Message-ID: <20200717143908.GI244185@redhat.com>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-6-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200717105139.25293-6-alex.bennee@linaro.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: fam@euphon.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 11:51:39AM +0100, Alex Bennée wrote:
> It turns out there are some 64 bit systems that have relatively low
> amounts of physical memory available to them (typically CI system).
> Even with swapping available a 1GB translation buffer that fills up
> can put the machine under increased memory pressure. Detect these low
> memory situations and reduce tb_size appropriately.
> 
> Fixes: 600e17b261
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
>  accel/tcg/translate-all.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2afa46bd2b1..2ff0ba6d19b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
>  {
>      /* Size the buffer.  */
>      if (tb_size == 0) {
> -        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        size_t phys_mem = qemu_get_host_physmem();
> +        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {
> +            tb_size = phys_mem / 4;
> +        } else {
> +            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        }

I'm not convinced this is going to work when running QEMU inside a
container environment with RAM cap, because the physmem level is
completely unrelated to the RAM the container is permitted to actually
use in practice. ie host has 32 GB of RAM, but the container QEMU is
in only has 1 GB permitted.

I don't have much of a better suggestion, as I don't think we want
to get into reading the cgroups memory limits. It does feel like the
assumption we can blindly use a 1GB cache though is invalid even
with this patch applied.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


