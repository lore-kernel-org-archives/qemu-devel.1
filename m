Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C5EC43465
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21132098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmC+I6s+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21132098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJecO-000138-QF
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJean-0008Ru-5v
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJeai-0001Cr-LC
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600528555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mclS9n8Ey7BzfLL28dat+5z/H6phZdHWvFfT7Zoe+2Y=;
 b=DmC+I6s+1QRyzC2EpzbvytyrjoXyHUACOH2pgZogmg0pOhDX/zZt0obMiabdI8zdpPDRcB
 6VIBdQRwmfo0LrnPY8DSY7ZrLrN9kIjnX6IJ6th/tulnf7cu7pW4SOPpuWl2DOAobRoOjR
 /E6ea3ghm/JYFYAFrrD/ROjjvrpnNYk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-yObmAC41N1KyN2vtVArZjQ-1; Sat, 19 Sep 2020 11:15:54 -0400
X-MC-Unique: yObmAC41N1KyN2vtVArZjQ-1
Received: by mail-wr1-f69.google.com with SMTP id w7so3566340wrp.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 08:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mclS9n8Ey7BzfLL28dat+5z/H6phZdHWvFfT7Zoe+2Y=;
 b=V26LnymZ2F50Eh/VWbetU9+gFyYjwEQJUJzlpvuz8eR37VZP78fpTh6s4ufjeC7VXt
 IVbQmXkH9ThctXbWtY9heyHcnktoKOTvqwAwqbCNIo6eo1hOsBGf47RLVWD3yqAjzcjZ
 Gz+Dk3Mm0JvRp4JVY0giNwN8ZUJvZnl5iNHqZh7BDrAk4zwZCC26mZ0b0DH/DA7EsoxM
 CMT/WKOLqMrwGkqDVaE6g8PGit9Ju0+ZedkG8cy/7Y/sz3Ye88r8reEdAOIMnw9nM044
 2NB7MYMbvnbIf/WVErGjGM1Q7zfG8oAp280uiN+g7Tts4FHnVqrzLZ4+P2WUzGhrWQDX
 ZuHw==
X-Gm-Message-State: AOAM530pDu0dptX5m8ayNoey5ise9kMEEcBFOBH+3v3ycjTm3lvWCJWt
 /gPvxSjsHB7T5sC/PwkYqd6gJ5+UA1R7w3Nu3K3azytFpbWsR2gAsLcQb9FoEbe2zyhIpN6HSWP
 BC0B3vzftZjkFwUs=
X-Received: by 2002:a7b:c095:: with SMTP id r21mr22394353wmh.133.1600528552193; 
 Sat, 19 Sep 2020 08:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkqR8leyPvA1wNHeIUTtjteLnaz3RbhfdVx6PHNQwfF1al3155ywHeH1Af7bpZsm8XiyJ13A==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr22394319wmh.133.1600528551824; 
 Sat, 19 Sep 2020 08:15:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d?
 ([2001:b07:6468:f312:b20a:b600:521c:512d])
 by smtp.gmail.com with ESMTPSA id z19sm10552727wmi.3.2020.09.19.08.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 08:15:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
To: Max Reitz <mreitz@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
 <20200811225122.17342-2-dmitry.fomichev@wdc.com>
 <808e395e-6f99-acdb-03dc-400f6bd32311@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2998e3eb-306f-62d4-0588-dae0a097d0ba@redhat.com>
Date: Sat, 19 Sep 2020 17:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <808e395e-6f99-acdb-03dc-400f6bd32311@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 15:16, Max Reitz wrote:
> So is this path ever taken, or can we just replace it all with the ioctl?
> 
> (Before 867eccfed84, this function was used for all host devices, which
> might explain why the code even exists.)

Because 867eccfed84 is wrong.  If you use /dev/sda* with SG_IO you do
need to take into account the hardware max segment size/max segment count.

Probably ->sg needs to be set by the front-end, not by the back-end.  An
even better way (but for which I'd leave the task to you and Kevin)
could be to have a new permission BLK_PERM_WRITE_BYPASS and to reduce
the limits to the hardware limits if anybody has requested that
permission.  I tried to implement that a couple years ago but I just
couldn't wrap my mind around the permission code.

Paolo


