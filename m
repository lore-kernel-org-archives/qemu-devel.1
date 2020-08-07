Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F3EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5139720855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwer9KiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yga-0002q7-Kt
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yfw-00027f-9R
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:28:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yfu-0002Zz-Mz
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clKlOhwQpIAzW78hcJMVjxNauxhrIsgp4RR3i95RSq0=;
 b=dwer9KiIBtIjlvshv/7VzSh8+CBgdahQJl4ctHEpr2iRLXMAbHqi2SflbAcnnbitF2xe4p
 UrQFppxq3ObXJi2fmHrR2Ei9UPQ0gHagIdWTqxOGr0xWBcTVQnGWay9peOjL+6iAmjujVb
 yFTIeRYYMWn+i38qKPqQnk+c3Tz6jCE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ZIQ79NLSN8uvtb_MfYnvsw-1; Fri, 07 Aug 2020 05:28:26 -0400
X-MC-Unique: ZIQ79NLSN8uvtb_MfYnvsw-1
Received: by mail-wr1-f71.google.com with SMTP id z7so514746wrw.21
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=clKlOhwQpIAzW78hcJMVjxNauxhrIsgp4RR3i95RSq0=;
 b=K/4J8V0bq8vhfi/qVSWWc/YIl3byChmKHPIM7ILwm53ndWlL2HHR47RjCt2Cql7bLI
 juQUfYLHDGr4jGyrm3Pp7Nc3BN0VKI1l0LOscyAF+v+baAfv+nEnE/uXNGXlOq8w1NAM
 9UsJxIcMmExOUyHaeX4exAA1YXZXrQ8G5bgSncmd0TjzLxIIGEmLufIqkFag6P/y4Fjm
 8A5c/EQHOiLRgMZYZ6NNOB7W1BbW0yNrp06ocyG2uZcY+9rJg5m72asMku6On9J8omTe
 SKl5wRVMMGKIzcQp4wP/eWNX8UbCnPvNyjush5K5JXiGgmdkrFjE8tvaMYr8hWomI+Dy
 koJw==
X-Gm-Message-State: AOAM533oD06iVSfA+tSbZWT4FQP/BCC8IrGsK/rE2qheCUAt+lzSqEiC
 tibxcew0Y8z9TJpknbeY9kf+PPYVUnAY9DJiVW5j/VWdIAABRXbQr609Qyyw9bGr/6Etv6N/MrM
 PJG8GbpxiI3Hdgok=
X-Received: by 2002:a5d:4947:: with SMTP id r7mr11084140wrs.165.1596792505156; 
 Fri, 07 Aug 2020 02:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO7iLOGNi+iqYw+8QKjafGPZnvSRXqO89nXGBMHUfXz+EC6DiJEtHSLihXEOyChEppMOzicg==
X-Received: by 2002:a5d:4947:: with SMTP id r7mr11084066wrs.165.1596792504044; 
 Fri, 07 Aug 2020 02:28:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id j5sm10014302wmb.15.2020.08.07.02.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:28:23 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
 <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
 <8dedfe22-8659-5684-99a6-e9d503a5b3e2@redhat.com>
 <20200807091841.GG120942@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9d3dec8-90d2-54a3-4fce-65703bc619a2@redhat.com>
Date: Fri, 7 Aug 2020 11:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807091841.GG120942@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:18, Daniel P. Berrangé wrote:
> If we bundle Meson, there's a risk that we see a new shiny feature
> in next meson, and bump our sub-module to the next release. And
> again. And again. And again. If we do that we'll never get to a
> place where we can rely on distro Meson. That will be bad.
> 
> So I think we need to be very mindful of this and strongly resist
> the urge to further increase our min meson version in future.

Agreed.  Marc-André has a couple patches left, but they're just nice to
have.  Another possibility could be adding first-class Sphinx support to
Meson (e.g. parsing the conf.py file to figure out the manpages directly).

Otherwise, 0.55.0 (or 0.56.0 if we want to avoid the warnings) should
have all that we need, and we're already doing some pretty complicated
things.

Paolo


