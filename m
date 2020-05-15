Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4344BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BEE204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeG/EvYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BEE204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYTX-0008CA-A1
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZYS5-0005Vy-AM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:24:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZYS3-0003zb-D1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589541865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJqY+ijpUCAOAqx2fRVXuIfzlSitvU540jPbICSwG60=;
 b=DeG/EvYIY8Q1M0XDzks6BUM3wKdpexfL9xom53F4ETyEk7ghTF/IdbHpNWNt1PR9GoXBhS
 qIHKJrkgXvmS7GtvJ4ChYe5ehNFSmtrD+fUkimU6OSNfcUwIolRbJ94PqMZu3I/8XroL+r
 WMkjzgXt01DFo5bScmwxqadXn2cJ+CY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-vagwkF_8OlKEVKFK-bZo0Q-1; Fri, 15 May 2020 07:24:24 -0400
X-MC-Unique: vagwkF_8OlKEVKFK-bZo0Q-1
Received: by mail-wm1-f71.google.com with SMTP id l21so1049415wmh.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 04:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJqY+ijpUCAOAqx2fRVXuIfzlSitvU540jPbICSwG60=;
 b=KEpGKcAUyPY6A4E4OWxROi5n9lHgVioTiXbUObIZMdIuY7mVNb+Uex3oQMECDTVx3/
 hRQg4pWqplkfq/W7TrL0ebXb+mzvCB2ni1RVU8h0PyQE5ggC6uev1Ee7OEbsaPPRoaDM
 MMPkYxGCjPVPUcGj69zLuD/W9EhUyBtuTV6ClruBcmTXGivuL/68cR7xEGLPpVE65a/X
 JrGcO8yprmOYeR6hKisDSPrE0PUgGCPG9PhZ4DMlUBGJWq3lwYRXREi+Qlr8M1wOpDwp
 8LYyXYOpzKh+wECTHETBUPs4L695jtZcJFGPDsJ9GuFYgTjkouz++Lfie1aNqzF6uxu0
 c+gw==
X-Gm-Message-State: AOAM533D9r0FbYjn2UGXqp2CvswRqtm73512F+ZJDMwI+GYXtpHlXeEQ
 Gjlwi3cLukKWjeFY881v8MFIET0yU2sW5tHf1czkMmaLCtlGC+BsOiNtdRkiMoBxXUhEhvty5+w
 H060bZn7gdu55+cU=
X-Received: by 2002:a05:6000:128b:: with SMTP id
 f11mr3765425wrx.227.1589541862492; 
 Fri, 15 May 2020 04:24:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEW1dvLvDc8THADMKWZspXUuzno9pTwRK9tG6WTPgQ8T8GXGgIpmwjahsQMtQaOjPv8qaupA==
X-Received: by 2002:a05:6000:128b:: with SMTP id
 f11mr3764896wrx.227.1589541854683; 
 Fri, 15 May 2020 04:24:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:60bb:f5bd:83ff:ec47?
 ([2001:b07:6468:f312:60bb:f5bd:83ff:ec47])
 by smtp.gmail.com with ESMTPSA id h20sm3110404wma.6.2020.05.15.04.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 04:24:14 -0700 (PDT)
Subject: Re: QEMU 5.1: Can we require each new device/machine to provided a
 test?
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <CAAdtpL7gSqz+R5LfbvsuxeeCzf1K-omHSeYo2eTOFYaMS1bp6A@mail.gmail.com>
 <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
 <20200515105118.zbslitc64hvjuhlt@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b23e643-925e-105e-f7a3-886a21be422e@redhat.com>
Date: Fri, 15 May 2020 13:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515105118.zbslitc64hvjuhlt@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-discuss@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 12:51, Gerd Hoffmann wrote:
>> If a qtest is feasible, yes, I think we should require one for new
>> devices.
> qtest is not feasible, at least not for all kinds of devices.  You can't
> talk to usb devices for example, and changing that effectively requires
> writing uhci/ohci/ehci/xhci drivers so one can submit usb transfers in
> qtest.

Yes, but that's just because no one has written a test for a USB device.
 It would be completely feasible to plug USB into qgraph, the code for
USB in SeaBIOS is 4.5 kLOC so that's more or less the ballpark of what
you'd need.  You can then stimulate keyboard or mouse devices via
chardev (-serial msmouse), or run SCSI tests for MSD and UAS.

Paolo


