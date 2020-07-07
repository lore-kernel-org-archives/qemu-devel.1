Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60629C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AFA20672
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaXVQ03u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AFA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr0K-0000kM-Ey
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsqvw-0002Ft-IX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:59:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsqvu-0007se-6H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594141140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SfeJ/vj+M3yf9rXIvyOj4ZjJll2c/cM0AvJ1PxK4Gk=;
 b=AaXVQ03uW8gJFQyfOiZ6YWBTqbv5DEj+0jHBQrl6VrLYvHkX0CDqYdwuzKmDS/Wdn7SGnr
 R8+mgSnoUzhwwgqrKtS/Qv+jlPmZj5MhoZ4Uy8eiHtNcqkyVnk66GvVNXKRbLvAYou8bgl
 a5Ne8X8Hjb/rpB7hO9AaznPldbWqP1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-La0Mf6M2N6uRnnIcpvGrjw-1; Tue, 07 Jul 2020 12:58:59 -0400
X-MC-Unique: La0Mf6M2N6uRnnIcpvGrjw-1
Received: by mail-wm1-f70.google.com with SMTP id l5so10027672wml.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1SfeJ/vj+M3yf9rXIvyOj4ZjJll2c/cM0AvJ1PxK4Gk=;
 b=JUWUZVVwKFuBXHLprGheruE2PvccUWUfoghfjovVzxFhvRAIwal/BoeIHMn9GTc5S2
 jYBt5xYajlhoNGMGSEjOg9LvbXn9BR2bo0rKo8CFMa1OUq+XDyCkGSxGPWq4FK1pjmpF
 i+i+VON5nUfoBC6FyBDHtBPlMZc7hD/HKaOcx5/KGzRbedB8B7WDYPR4f14dF/xYtcV0
 JKJ9L/38Tye6yUJIIsxp9S3R1ISOG/m4Z0vexL428ycDaL9E/+AEeUJP4YxJYC9tVGir
 64wtnvqrIofL8IGT0/CynSs51erd0ejY8wq1ScP2UJMyawybxoIjRFyRwPATCwR/UAOw
 8NrA==
X-Gm-Message-State: AOAM533dpb+Y0E3iCx1gnWEfu9nCO/8A5YWH8BC/L3z5eX6iOOolB89P
 k1MxoRPvVCWxo3h9tBBb+h3pc85TVrt46IV8LK6FYk/0trvQ9wiaWCpIBduf0x697oX4dbjcgoj
 Xrvp0UqaYXiAC1c0=
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr5328181wme.107.1594141138337; 
 Tue, 07 Jul 2020 09:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAYl1yhbvsN7mvsBmL5GOGoQXjnXpA8qUj+QGjgCd2kOf2HrjaR013kbjUiggkvHCFbE3npw==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr5328150wme.107.1594141138158; 
 Tue, 07 Jul 2020 09:58:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id l3sm1803412wrx.22.2020.07.07.09.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:58:57 -0700 (PDT)
Subject: Re: [RFC v2 1/6] cpus: extract out TCG-specific code to accel/tcg
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-2-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8e8eab6-370b-46c9-ba51-e1e1416aaac2@redhat.com>
Date: Tue, 7 Jul 2020 18:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707135808.9241-2-cfontana@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 15:58, Claudio Fontana wrote:
> +
> +CpusAccel tcg_cpus = {
> +    .create_vcpu_thread = tcg_start_vcpu_thread,
> +    .kick_vcpu_thread = tcg_kick_vcpu_thread,
> +
> +    .synchronize_post_reset = tcg_cpu_synchronize_noop,
> +    .synchronize_post_init = tcg_cpu_synchronize_noop,
> +    .synchronize_state = tcg_cpu_synchronize_noop,
> +    .synchronize_pre_loadvm = tcg_cpu_synchronize_noop,
> +};

Could this struct reside in AccelClass instead, so that there's no need
to register the operations explicitly?  We could still cache it in a
global variable in accel_init_machine, in order to avoid pointer chasing.

Thanks,

Paolo


