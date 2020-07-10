Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE3BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6FB2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjpEc0fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6FB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtnMV-00082y-9H
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 03:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtnLr-0007ba-PE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:21:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtnLo-0005GD-Nn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594365698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thZZhjE96lspt7ZWi/AjVIw8iXBnP2Haw9UKtlJ1Dbo=;
 b=cjpEc0fnNItHvJPMn/hJw/Ml3KtcO1MVC+hZsxbflqX1ZNx5phbqtm+Xr9V0S0noJ+sfAI
 620pkIdRsgwF4TXmTJAaLtIpPk4LB7GIdDM8bZDPX0xD305zGbunqUmkDYDzEwWXYFdVK6
 g2T3F5cmPEgc+F7drBUX313iyFWKnd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-2Jk4dw5_PdiHkxGuwd-VfA-1; Fri, 10 Jul 2020 03:21:37 -0400
X-MC-Unique: 2Jk4dw5_PdiHkxGuwd-VfA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so4948216wrp.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 00:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=thZZhjE96lspt7ZWi/AjVIw8iXBnP2Haw9UKtlJ1Dbo=;
 b=A2SkhSIwyltxYfOq4jTfjzFlDg/Fbwh0+hfakMF2vzYWG6yQDrOEtTUXdvA7sOW2e8
 VYW8aXkYbw0PTlcDzw5KTuvwKvLEQYpdaaxi+cxqRX7sGDmSsNvFLf6ICitY3AQB6XGN
 2beDSjKQPjDUgS22SONcI608lYgY4lS+7ckayx8diNLu51rlEsrC7RJi/n5IUa5EGuuh
 8qd+fsBu9ypPY+rFsv9cfL4iJKEMYyYSWIJkJg3P4CDNwrwMrlbbO8qvsitC5DXNSult
 kFmtGAgXR7GWhRHATn+kGyKjbSkxnpXMvHWgjL/T42HB5WSxDyDegsKA/YpNHcKslP2W
 FPhQ==
X-Gm-Message-State: AOAM532FGRqE8TIbo9PLh/n/8jWVLDYPNDNrWPsqqeOQKzAICZ47w4Pg
 LdG++anZPzDlHXodRxmhdxRzDOd97lfkVK1+7F4q9yX8CTk95++l6WAZlVjKWqVxWAAKKIrvnG4
 b4XoUPgxd2VbpyN0=
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr3784738wmg.110.1594365696057; 
 Fri, 10 Jul 2020 00:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztrqfFhLUoPqzGe81U1WJL4B0m7Zi1Hwk37qAkI4LJiFVNWEfsHtmUroXU+sw+Zb85GHLflA==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr3784712wmg.110.1594365695812; 
 Fri, 10 Jul 2020 00:21:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id w7sm8311083wmc.32.2020.07.10.00.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 00:21:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
To: Jim Mattson <jmattson@google.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net> <20200708172653.GL3229307@redhat.com>
 <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
 <CALMp9eQnrdu-9sZhW3aXpK4pizOW=8G=bj1wkumSgHVNfG=CbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c81254b6-e6ae-9d2e-917c-4ce42c8baab0@redhat.com>
Date: Fri, 10 Jul 2020 09:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQnrdu-9sZhW3aXpK4pizOW=8G=bj1wkumSgHVNfG=CbQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>,
 libvir-list@redhat.com, Dann Frazier <dann.frazier@canonical.com>,
 mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Mohammed Gamal <mgamal@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 19:00, Jim Mattson wrote:
>>
>>     Mostly fine.  Some edge cases, like different page fault errors for
>>     addresses above GUEST_MAXPHYADDR and below HOST_MAXPHYADDR.  Which I
>>     think Mohammed fixed in the kernel recently.
> Doesn't this require intercepting MOV-to-CR3 when the guest is in PAE
> mode, so that the hypervisor can validate the high bits in the PDPTEs?

In theory yes, but in practice it just means we'd use the AMD behavior
of loading guest PDPT entries on demand during address translation
(because the PDPT would point to nonexistent memory and cause an EPT
violation on the PDE).

Paolo


