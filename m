Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF3C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D897920826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0I/1ROz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897920826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDMUy-0004Kq-PA
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 02:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDMTn-0003EZ-6f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:42:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDMTl-0007YC-1F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599028964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzM1DzRVL/n2TB90t4MdAXjdGRJNek7MVjYEWzqQoR0=;
 b=R0I/1ROzKsz3lD28pxhApAABo++zx36OBBlskmjkEABkydM9Ca3OtMgbeu0E2IepIZxUuw
 YBHADjehk00oGjhvxNHoiOEktK4B7f7PYF8GpHznF7bW42IcjlDr/uHlz645Mbo+TzuSvU
 dSYNwT20NxkeA/bnuWPUOR0JQAL4oaw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-vQl9_OPhP7-p6owS3dO0cg-1; Wed, 02 Sep 2020 02:42:42 -0400
X-MC-Unique: vQl9_OPhP7-p6owS3dO0cg-1
Received: by mail-wm1-f69.google.com with SMTP id 23so1206567wmk.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 23:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzM1DzRVL/n2TB90t4MdAXjdGRJNek7MVjYEWzqQoR0=;
 b=rbdgfnrr8TXjrnaynSTWdRaSkfbV0VQBBkTs1Rnq2Q+yRcWLCrKb0PWraWADZu/u21
 h4ukTP94IbKdokYTiq7DkhL4oFtnGzXFkVGGuIwtAsQWQjJFuaYqJS992Ql7Zotuu78S
 Bs5XlNN84QP0B3dQfkoqClbIiRs40uuoZiqqAtT9GriYB0Vq8cOJsG3wAcgWTDkWdBJX
 JO4ubwqdu1dMleZy9FaCGdnSFuhO2CibLLFrT9jP14vLLNSVFxw74G4uJSFMea5eU4KG
 Wn1Z2GVwRt1/ed1Aoh6sBhuggYrs69lJEH/Vl+HBHkkoPsjWydvzFZ6KpyR0MRSy1qBz
 JmJw==
X-Gm-Message-State: AOAM533Wujnb7ClfMjVCIOuB2G41OfZF1Gd79MioNQGzrJHe9csGJ8YN
 Ge213izoowHlvpsR3V1GraPiuor+Rbpe01DcEX3bL+TUW7ABwmVq3DAAN9dF73WBd6TtO0Dv94/
 72f2pdl6PL6wc1Mk=
X-Received: by 2002:a05:6000:118a:: with SMTP id
 g10mr640885wrx.67.1599028961187; 
 Tue, 01 Sep 2020 23:42:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQR0B/FD2IzPydlXJYfZzN+q0qmYeIoheU0QoIlmnCpP+LtkUOajkACQhcdUjFZJT2akCnsA==
X-Received: by 2002:a05:6000:118a:: with SMTP id
 g10mr640865wrx.67.1599028960909; 
 Tue, 01 Sep 2020 23:42:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e108:3b03:aa6f:d766?
 ([2001:b07:6468:f312:e108:3b03:aa6f:d766])
 by smtp.gmail.com with ESMTPSA id b1sm5669643wru.54.2020.09.01.23.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 23:42:40 -0700 (PDT)
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
 <CABgObfYcaCsZNYof9nd7gzCOY_6qN5MV+xD6dw7W4D4ircsdaQ@mail.gmail.com>
 <7516c253-0448-b5cd-18a0-45caaebc1d05@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0db09727-a909-71db-3628-4edb3ce87f2b@redhat.com>
Date: Wed, 2 Sep 2020 08:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7516c253-0448-b5cd-18a0-45caaebc1d05@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 08:09, Mark Cave-Ayland wrote:
> diff --git a/configure b/configure
> index f6638abadf..cb56d31a5d 100755
> --- a/configure
> +++ b/configure
> @@ -1015,6 +1015,9 @@ if test "$mingw32" = "yes" ; then
>    prefix="/qemu"
>    confsuffix=""
>    libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32
> $libs_qga"
> +  ld_pwd=$(pwd -W)
> +else
> +  ld_pwd=$(pwd)
>  fi

That wouldn't work for cross-compilation, but I got the idea. :)

>  werror=""
> @@ -4290,7 +4293,7 @@ EOF
>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>            fi
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> -          fdt_ldflags="-L$PWD/dtc/libfdt"
> +          fdt_ldflags="-L${ld_pwd}/dtc/libfdt"
>            fdt_libs="$fdt_libs"
>        elif test "$fdt" = "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5275,7 +5278,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    capstone_libs="-L$PWD/capstone -lcapstone"
> +    capstone_libs="-L${ld_pwd}/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
> 
> @@ -6276,7 +6279,7 @@ case "$slirp" in
>      fi
>      mkdir -p slirp
>      slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
> -    slirp_libs="-L$PWD/slirp -lslirp"
> +    slirp_libs="-L${ld_pwd}/slirp -lslirp"
>      if test "$mingw32" = "yes" ; then
>        slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
>      fi

Since there is no recursive make anymore, these can be just
-Ldtc/libfdt, -Lcapstone and -Lslirp.  Nice. :)

> I'll try again with the relocatable install later - do I still need to pass --prefix
> into configure or should I leave that for now and just use DESTDIR?

You can just use DESTDIR.

Paolo


