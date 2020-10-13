Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE5E25334
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giaeNQ1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE5E25334
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNsx-0003Lf-L2
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSNr4-00013D-JI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSNr2-00008D-0D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602609170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiOesNXARGnwO8Qb8ruD/E5nkbJYRr5mySBeE8Vjnkw=;
 b=giaeNQ1vbW69xKoMZelVGBctYg9X4MtnkqvXoLGlNvVRxjuLssLX/H61yFEZ2eyuBKH26o
 VP7h3NfV8QHf8bsdVDDFYL9IU95nO+0kxxqsCcMRlVmUSnBU54tFKYJmlAlQ9ZT76dD6Fc
 CJSNiDuLFGdeHP13EXMZSFWP2kznLnk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-uUVhJzczPZO-yUqUojwC7A-1; Tue, 13 Oct 2020 13:12:46 -0400
X-MC-Unique: uUVhJzczPZO-yUqUojwC7A-1
Received: by mail-wr1-f69.google.com with SMTP id k14so80853wrd.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PiOesNXARGnwO8Qb8ruD/E5nkbJYRr5mySBeE8Vjnkw=;
 b=eOck3jzqDnYgCt1PbpJYN1O0RuQ4Ybg3jjGghseWDjUU6+odwuiKoUM+Hue9uihOYa
 WqpkGKaPqlV+yW2xjIcCOicomoIJwzSzckZoPj81Evdw4EXJUA91gu2+etfHkC/Ir+R/
 c8MW/HndZC5J/cmN6CQjZruZKkVwcGkSwwLvNT/Y7NP2wLhGN3bhg4jx8RX2blTAG1qD
 WlMYYnmXEVgXGX+8m/hKV+m7/kqFRF2s6MFRtQ/e7E1AjQydLgKmy7E8pIO1p5PPUhdI
 wQfuQD9XWOrpSuoFf8SjyvOH6XiC1btXlVXrvltLOnpgo+pGlG+/UzBqXpPxEL8k43dA
 RnWQ==
X-Gm-Message-State: AOAM531dZejgyt0mIgBIeDNv0aiPPQiTOCM29YSCz+KtAsAKffqas3lF
 Pk0/0YktG7wkYJWCu1apKtHecSPBhpHE/e7fzw2DJFLD7QBaVHHv4eeAw8tqXugTph3StbIrp4Y
 8jRxTdyUpzAyebkI=
X-Received: by 2002:adf:dd46:: with SMTP id u6mr704596wrm.295.1602609165070;
 Tue, 13 Oct 2020 10:12:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP8cuhKsTK+61wlpxR5lDMEgTqRnLkrtvOAVk2Xst5nb6CgbAedRXBeUGKCcaYGtP5GCwGGA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr704572wrm.295.1602609164889;
 Tue, 13 Oct 2020 10:12:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id o6sm262150wrm.69.2020.10.13.10.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:12:44 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201013143806.14321-1-cfontana@suse.de>
 <20201013143806.14321-4-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edc078b6-71b4-0650-1c23-fd437cd3fd25@redhat.com>
Date: Tue, 13 Oct 2020 19:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201013143806.14321-4-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 16:38, Claudio Fontana wrote:
> +void bdrv_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
> +{
> +    if (replay_events_enabled()) {
> +        replay_bh_schedule_oneshot_event(ctx, cb, opaque);
> +    } else {
> +        aio_bh_schedule_oneshot(ctx, cb, opaque);
> +    }
> +}
> +
> +void bdrv_bh_schedule(QEMUBH *bh)
> +{
> +    if (replay_events_enabled()) {
> +        replay_bh_schedule_event(bh);
> +    } else {
> +        qemu_bh_schedule(bh);
> +    }
> +}

This is definitely better, but I'll defer to Kevin with respect to the
naming of the function; having a bdrv_* function that has nothing to do
with the block layer is still smelly of a sub-optimal API, and I'm not
sure why the API change belongs in the series.

Paolo


