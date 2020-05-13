Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDCCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F71206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSnLVz/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F71206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYq2m-0003sV-K2
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYq1w-0002zT-AU
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:58:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYq1u-0006Z3-Lq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589371109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWJyNQVKgrUyNCt+zQHT1NAcgEKebIL9E/9pqa5EzB0=;
 b=HSnLVz/O48yHDDbel0wZv7JjJSlset/g45zaPC/kP0knR7nH3naRFpa7fmtsF93aFEA+Dh
 kRsPQvbmHZw3uIjWJ7NufUHbtObGhBGgeUXGxKf9ZSbWCfxuks9RDH4ziGshygLW6pK2Kh
 BZsgeXR5yr4m190WHgMrOX13gAAMQwk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-RAO0Yfb1MIK-Sv8Y1S-6fg-1; Wed, 13 May 2020 07:58:27 -0400
X-MC-Unique: RAO0Yfb1MIK-Sv8Y1S-6fg-1
Received: by mail-wm1-f69.google.com with SMTP id e15so2459975wme.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xWJyNQVKgrUyNCt+zQHT1NAcgEKebIL9E/9pqa5EzB0=;
 b=mClLFlK4z9dx3zbmtzjZNfiReOPQOZG/GHakBf4kupQMXnMaauW7YFaf0Ad1eyGLnf
 hrnLzKPv/W6/W2G5gO8lKHQLD+hNJO2n8U5O5hpXklNy0Tjk+p64kQrrdLvg5VI4dtt9
 fWosq1/Zp1vD0LFfw8lmJPNHerjpERig8HgtoQIWGmIaiaPE8yV49lO5vK4OiUBpMDQf
 bmZ3nLEQ1IC94H74SZIKQBlHz5ZRWHm099l4cMT7f01Ul1pDEau5Z9okCgdG5taODi4/
 /Wkvp3swnLzUJwTdV2PdIM75Ea7L7Oiy4Nwxorjux+Iaj5hwDfkM59Pg+V++MrvMVWaG
 GmLA==
X-Gm-Message-State: AGi0PuZCrkWcLydyctRnTVxnRKyaA8m2BEYxbcDxUgtE67MZp4Yvx1/G
 XUR2fpsnKAyOSZrluv4V/f1KVQqQf/6YB+sd7dg5dlLbjTheSZowfsrfPR11JAUfhqaFgcnN45Q
 PNWgnFoR2x/Tb/tA=
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr22421624wmd.79.1589371106205; 
 Wed, 13 May 2020 04:58:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIo1GE5CnnXoN1bYbe8KntzpKtMfKNjGEbnaTNtyJOeL6CYft+nTWv8kJYfhZeIDj7jSECstA==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr22421596wmd.79.1589371105889; 
 Wed, 13 May 2020 04:58:25 -0700 (PDT)
Received: from [192.168.43.81] (93-33-23-152.ip42.fastwebnet.it.
 [93.33.23.152])
 by smtp.gmail.com with ESMTPSA id s8sm26257276wrt.69.2020.05.13.04.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 04:58:25 -0700 (PDT)
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com> <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com> <20200511154645.GI2811@work-vm>
 <20200512113206.62836e44@luklap> <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box> <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box> <20200513112630.GJ1215285@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31bb69c3-5149-70cf-7527-54680b1e3f6b@redhat.com>
Date: Wed, 13 May 2020 13:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513112630.GJ1215285@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/20 13:26, Daniel P. Berrangé wrote:
> Are you referring to the in-kernel NFS client hangs here ?  AFAIK, it is
> impossible to do anything to get out of those hangs from userspace, because
> the thread is stuck in an uninterruptable sleep in kernel space.
> 
> If using the in-QEMU NFS client, then there is a network connection that
> can be yanked just like the NBD client.

But it's a bad idea to yank it (and also the NBD client) because you're
not sure which wites have made it to the server (and to the medium) and
which haven't.

Effectively, the in-QEMU NFS client and NBD client are always operating
in "soft" mode, but we should always treat that as a bug (which cannot
be fixed) and not a feature for read-write images.

Paolo


