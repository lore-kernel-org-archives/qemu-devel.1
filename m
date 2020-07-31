Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B872121744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW76UL3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Z96-0001wO-V0
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Z7d-0001M2-E6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:47:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Z7b-0001XT-US
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596217627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVlyJuQTu0R6jWx2impwBDJnusFeWgozBou6qSs72hA=;
 b=NW76UL3fWNUmVZZt3/imdhLMcc1LKS2TuFYXIMCzcFsuOTPpB0eDoIiu8fi4cbsfM3FYFy
 VS4AgJ0rQLJR9mtl3dxBaZyvVr2sovgzNNvr6yWG4yswHc4DN6R2o3oKRZzNRcu9Pi4deI
 qKeFuzpVxZi/sJUEy4C47NbAWmMHqhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-BuwIRhapP36oAW9T8QNUTw-1; Fri, 31 Jul 2020 13:47:05 -0400
X-MC-Unique: BuwIRhapP36oAW9T8QNUTw-1
Received: by mail-wm1-f72.google.com with SMTP id a5so3459107wmj.5
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hVlyJuQTu0R6jWx2impwBDJnusFeWgozBou6qSs72hA=;
 b=mVb33L/n/WoyFUYOLVfDNX48zJ0TRVvQpEbbyJFDNyXjQGQN62g8sbs4qLsdwI44mF
 xnARg8R6xq756V1WLXz58ENArrkGECbTgBQkOTRrvOe8xiM41UJMaRgsUfkQqtnNIlOU
 YHS4YlWIrSzQPwWZXP77qrV09zAaHPM03sHwgnPhcDizyLipqtKsQSPSfewB6MW1mvjq
 KiO/XQW3BDdHiLhmFmkspn58sABTdygAqu9C6P6enIU6LdGi8Yr2Y9zMruDE0vhJTczE
 uKTE1q9yV3OS6kYI6lNcpB6pWAlIy4ofqp5eBq8KsW5D60N/V2QD+UDJycl/4L4rL+pA
 /7Pw==
X-Gm-Message-State: AOAM5317s8YAgsCq/rXHlG1rK1IrYC7qAnmmRSZNAh2sjy7schD5wihV
 DvUK11U8wnZ6r1sUCfBq0dXCyAInRPTvrnY9ZhQC60OxLRvvzFaAkf10cF7eAhnk1QkdcGOJZmI
 lAalZiLqLwP/aB5I=
X-Received: by 2002:a1c:df02:: with SMTP id w2mr5200807wmg.137.1596217624151; 
 Fri, 31 Jul 2020 10:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy2OOOtDQR9DBkhfNf+ryCHPk+aESiKWrK1TOO4ThDAB3p+CGHty8vsj4Y9WRzCPUWR030CQ==
X-Received: by 2002:a1c:df02:: with SMTP id w2mr5200783wmg.137.1596217623809; 
 Fri, 31 Jul 2020 10:47:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id w10sm13450451wmk.0.2020.07.31.10.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:47:03 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
 <20200731172010.GG3660103@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4640e038-b0b0-e6f9-24c5-9e2aae7eb4ea@redhat.com>
Date: Fri, 31 Jul 2020 19:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731172010.GG3660103@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 19:20, Daniel P. Berrangé wrote:
> It also means QMP isn't easily extensible. eg if we used
> HTTP as our base, then we'd get remote TLS support for free from
> whatever library we used.

... and we would lose events, unless we do something with HTTP/2 and
streaming responses.  We would also have to pass the TLS certificates to
whatever library we used (which might even be using openssl instead of
gnutls).  So it's not that simple, and that's why I'm hesitant to see
things as a universal improvement without seeing the code.

Paolo

> We could do TLS with QMP, but again we
> get to build the pieces for this on both client/server side.
> Using a standard like HTTP would open door to other interesting
> ideas, like putting a HTTP proxy on a host, so you can have 1
> HTTP server fronting all 1000 VMs on the host, meaning only need
> a single port instead of 1000 ports in the firewall.  Again you
> can build such an architecture on top of QMP but its all wheel
> reinvention.


