Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97391C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D429420872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgiS+eMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGNQ-0004vj-Rf
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJGK9-00015Z-Rw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:21:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJGK3-0001Qq-6A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600435265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OljBgQWH1o/YapSFq+n0Nms+XYR7jDEp2Uu6M89wJw=;
 b=FgiS+eMCxqLzpGudNz0BhrH8b2ipjo2qvfqgRBW6FBtDEeCzZajC1/HU2l16dyeBRPFChA
 XSHiUNbQQ1Qr33nsK+qkUpPtobtQIQV6BOEs89FDL3z5VR6bJK4bIl/L5HOWB5MQjAk4Ke
 qS2Btq/3f6BdoLCbTmb7QfXsKL7cOUk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-FrVKf3zvNVyvjrkNH0X6PQ-1; Fri, 18 Sep 2020 09:21:00 -0400
X-MC-Unique: FrVKf3zvNVyvjrkNH0X6PQ-1
Received: by mail-wr1-f72.google.com with SMTP id b7so2132331wrn.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+OljBgQWH1o/YapSFq+n0Nms+XYR7jDEp2Uu6M89wJw=;
 b=mKYrLsFEB0FFVhoCQkqv+XOEuZzHbmG7sRC+BCaXmB5x10r85YjcydftroiQOTGwqs
 N6BoZa+8kKJy6qAMDb0cvNvZB3bb6gWKYrIqCbX0ERt46S3obYPZvjrOf9asSZ4vKB2o
 Fg+0wfDJKINVnTw9PoV87WbcN43uVBUygIYLPCNUUVig5GC5JikM39NcUG/vSrvMHGoO
 tYOqmejnYDazMM4quGQl3KwjK+mP30CoWHCzGaTtmOVufCVOxCjtVZIsRCwbAoSahKPe
 gmYCJ8HRjQFkRViUv8FByOdinmbmxDqCuL/lpCVoNLagtCFSiNE9RCD/cIOKzLgP58uL
 2gpg==
X-Gm-Message-State: AOAM533CLggV9txMnQiAGxSGFuUOoSwSbkTLZ4lKbPVpVKYu4ereKYvO
 Rh2v8uZHBD8gYKM0f18wNByblXwIYszJAbE8bnby9Wy/fPguNhBxl9qZYpnXzQXA17z6x8YTMwa
 Y5UVfjidq4MEXaRg=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr39000421wrq.203.1600435259044; 
 Fri, 18 Sep 2020 06:20:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8RX6a+B1RHYEpJx+rwnAyQIf0fw59CM/F+iC7BCRYGhMfTkfdTAeADIVrCY5JCWW3vjlwEA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr39000407wrq.203.1600435258834; 
 Fri, 18 Sep 2020 06:20:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id y6sm5347383wrn.41.2020.09.18.06.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 06:20:58 -0700 (PDT)
Subject: Re: [PATCH] configure: move malloc_trim/tcmalloc/jemalloc to meson
To: luoyonggang@gmail.com
References: <20200916080608.17689-1-pbonzini@redhat.com>
 <CAE2XoE82=BjoGF5sXUBE+rTJzDwphBRL8CqRp2Z9FAq83dHXJw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c21e60d-9bc9-e90d-5df1-31345cee7a7a@redhat.com>
Date: Fri, 18 Sep 2020 15:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE82=BjoGF5sXUBE+rTJzDwphBRL8CqRp2Z9FAq83dHXJw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:09:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-level <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 14:55, 罗勇刚(Yonggang Luo) wrote:
> 
>>  if test "$tcmalloc" = "yes" && test "$jemalloc" = "yes" ; then
>>      echo "ERROR: tcmalloc && jemalloc can't be used at the same time"
>>      exit 1
>> -fi
> This patch looks good for me, but I still have a small advice than move
> thse judgement from
> configure to meson, because finally they need to be converted.
> and getting tcmalloc /  jemalloc to be "enabled" "disabled" for consistence
> 

This error cannot apply to meson.build because it uses a single
multi-choice option "-Dmalloc=system|tcmalloc|jemalloc".

Paolo


