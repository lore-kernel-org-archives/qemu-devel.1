Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA300C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE0320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfPI377e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE0320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmZx-000299-Gu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDmZF-0000py-Rf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:34:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDmZE-0001Fm-09
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599129247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIL4e5wx7rbJ4qVaP+iBN5/huVBAPp41cLHsJcRh+Es=;
 b=RfPI377eBW9EMqEXiUM3eEiNGCx3Ci8qIIwvylW965s9ktWwqcwp8O+AUl6QegWYAzyvcT
 3nPrtpjryMI03whhoe0cgh/ETdnYqZUdVIpdHsyBSyhM2bT97DDe8PZaZRLGHzRCTwQyxr
 NI/mAZefVyegp59DC+Q/Mr0GlPAqDFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-nYD7GwPDM56y2k7nqGfh1w-1; Thu, 03 Sep 2020 06:34:05 -0400
X-MC-Unique: nYD7GwPDM56y2k7nqGfh1w-1
Received: by mail-wr1-f71.google.com with SMTP id 33so912254wrk.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIL4e5wx7rbJ4qVaP+iBN5/huVBAPp41cLHsJcRh+Es=;
 b=I4/vW7gptPL1NQKPlzZtb0Fp10Xr5DiaFWgYev7g1fnOqrILyTYyYUk5NRiqzBzHpI
 5OOxRDJAlRy9QZllzyaJjW/hzi9Yv79/2vhaV6krk+buO7SCfo59CCpq+EgWDHnG5hCo
 rJpEygQGlrfEV1cMma+t9zntRWrthJZrpn/WIlHYk51CBjcck+dks4SGp6eFpaiKDizc
 QzFA09yOUl3jmCtEKmlL4Xx6cmsAcwbLUPWZPBlY5TLDwoN/Ahi5mqgmTqcnjvWDv2Fn
 yO/8xR+JZx1M4YVrH+wdc0bl0lF35Lys7XTZN1VIkF4yin9DxPDy+QW9jnjZii7Ks434
 O7jA==
X-Gm-Message-State: AOAM533LuwjqUMK/bceln09OA9EWy4qPUYrvCEzObIUw8I3OKr7qG2lW
 2G/JcAJ9/5u/VFmaQm4xTqsWOcdlb4hlFCzpZsjTF+hx4iPibonDaniTMM+z/sQXhugrq34kwoE
 Gu3PSZ2cmIh0GEJ8=
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr1780310wmf.143.1599129244330; 
 Thu, 03 Sep 2020 03:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDESJv4Nfdl10vM8uZgwnKWmtbQ1LlKkmALvP6QV8d9LgskQl+S5efXMRnSeLZ/Fic3uDcjA==
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr1780303wmf.143.1599129244096; 
 Thu, 03 Sep 2020 03:34:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8ca5:2b7e:a83f:507b?
 ([2001:b07:6468:f312:8ca5:2b7e:a83f:507b])
 by smtp.gmail.com with ESMTPSA id c9sm3745466wmf.3.2020.09.03.03.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:34:03 -0700 (PDT)
Subject: Re: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200903054503.425435-1-thuth@redhat.com>
 <20200903082425.GC441291@redhat.com>
 <862e304a-fd86-6da4-4e19-fa907c8956dc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f8b48b6-6127-4a49-98fd-0ca614745113@redhat.com>
Date: Thu, 3 Sep 2020 12:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <862e304a-fd86-6da4-4e19-fa907c8956dc@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 12:22, Thomas Huth wrote:
>> Since you didn't remove that conditional, I assume that nothing
>> built in a "if not have_block" scenario was relying on the existing
>> stub ?

Technically there would be a user:

scripts/tracetool/backend/log.py
  -> (qemu_get_thread_id) util/oslib-win32.c

which brings in qemu_try_set_nonblock and that calls qemu_fd_register.

Likewise,

util/qht.c
  -> (qemu_vfree) util/oslib-win32.c

Windows builds actually don't build anything on a --disable-system
--disable-tools build so it happens to work.

However, as a follow-up qemu_set_block/qemu_try_set_nonblock and
qemu_set_nonblock probably should be moved from util/oslib-* to
util/main-loop.c.

Paolo


