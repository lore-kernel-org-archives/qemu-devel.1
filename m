Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDFDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF18E21670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGmAjU16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF18E21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB4h-0008FR-FQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAAyR-000301-GN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAAyQ-0002fO-A8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:44:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41132
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAAyP-0002cd-Or
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568717080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=GYRHiJ+owTPPegEv8FDm2efdl/frRhEQ1iE1eyQFru8=;
 b=aGmAjU1631piPQVTSVcFkszk0LKFsIXgYPY73wLEkYdEPO1KcfNLmOePTBNX/MVUMw/l5I
 9TEiB9obV8NcXXtrElDOHD83i5ndTEtGVU94rS9nxBLlUufj71Sug5GO+LhNxbFpaBOLTS
 VRkHMkUejBEckFWKqAFm0f0AW/o2QPY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-qiUCPO0hMQ-6qu4Z16h0vw-1; Tue, 17 Sep 2019 06:44:39 -0400
Received: by mail-wr1-f69.google.com with SMTP id n18so1156212wro.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CjcODW7E3h0WDqNOriOGUTFzt+pKCnYJPS20FUABpOI=;
 b=P4hd0yU+9TyIXjn5RXVQm7MUu3B+Mdlf3UwFzk2Cv3c9CMDBpk7xR89zOcnefN5fcK
 mxmOFVYNJnJlfh/4NEjIJMAcd02lPgI4SP5wk1bXz+8orkS2qzO7tbh+ZFTnJAj7iry9
 xd9zmCLsfw9pf0aNawTzIQQoKXE7EnmV8DWWq2CyBxYvgXIHptMEk6I7UjNtcF4tBE0D
 anwqonO/3TvdiYKSegKp4l1LjaWPOlrhgccDsOFdJkh073f8lZW1nnpLR7VYEmZuXiTs
 m+UPdR8BiJrDbIlnpual6n+mknOzOzGAgmqF0SltzvaY+1VIlwYiuqyK6aqfBW4LknFQ
 XbuQ==
X-Gm-Message-State: APjAAAUr4XrVXY3fURAaE97euMDerRyOAaFaqjKbEmifVP9qcGBIpS8Q
 6rKY87TbSI7wLr0EBz8Movqu7x3t1j/Qb6hIum1iTZthY9h8rq/vXsFmwjRPrSfFPOhJ+L8Ak84
 2IAEncYZtFxByQb0=
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr269546wml.29.1568717077443; 
 Tue, 17 Sep 2019 03:44:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxWiA5sBqWEJOz1cZa+oteKrrk8l7zd4fh/pjBqNiwuj+ncVluU/Z3hXksL+sxXmXysxNsJRQ==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr269523wml.29.1568717077155; 
 Tue, 17 Sep 2019 03:44:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id m11sm1750967wrn.59.2019.09.17.03.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:44:36 -0700 (PDT)
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156871404669.31913.13609976778909645749.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7ef051d7-8f92-3726-26b1-b62ae51ce432@redhat.com>
Date: Tue, 17 Sep 2019 12:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156871404669.31913.13609976778909645749.stgit@pasha-Precision-3630-Tower>
Content-Language: en-US
X-MC-Unique: qiUCPO0hMQ-6qu4Z16h0vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
Subject: Re: [Qemu-devel] [PATCH] replay: don't synchronize memory
 operations in replay mode
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
Cc: dovgaluk@ispras.ru, richard.henderson@linaro.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/19 11:54, Pavel Dovgalyuk wrote:
> Commit 9458a9a1df1a4c719e24512394d548c1fc7abd22 added synchronization
> of vCPU and migration operations through calling run_on_cpu operation.
> However, in replay mode this synchronization is unneeded, because
> I/O and vCPU threads are already synchronized.
> This patch disables such synchronization for record/replay mode.
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  exec.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index be8b2b7c06..a69745811f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3177,8 +3177,17 @@ static void tcg_log_global_after_sync(MemoryListen=
er *listener)
>       * by pushing the migration thread's memory read after the vCPU thre=
ad has
>       * written the memory.
>       */
> -    cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener);
> -    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
> +    if (replay_mode =3D=3D REPLAY_MODE_NONE) {
> +        /*
> +         * VGA can make calls to this function while updating the screen=
.
> +         * In record/replay mode this causes a deadlock, because
> +         * run_on_cpu waits for rr mutex. Therefore no races are possibl=
e
> +         * in this case and no need for making run_on_cpu when
> +         * record/replay is not enabled.
> +         */
> +        cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listene=
r);
> +        run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
> +    }
>  }
> =20
>  static void tcg_commit(MemoryListener *listener)
>=20

Looks good.

Paolo


