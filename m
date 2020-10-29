Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9375A20725
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsvPu3/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9375A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYC2h-0002Tc-IO
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYC1a-0001db-N7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYC1X-0007Po-Lf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603993660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4S5cV67yMqNZZig0vFthskt2Z9MyX0eg+1GTopYz/4w=;
 b=gsvPu3/NEreuINmpCs/c6+Nr8S15rjEurvZaZgrtpX8DsOtY82FenuPeDKKQvDYR+azglp
 1MnH918XE8kxpYcZ5OYIwjA5kIrjaUwrSsZLvfr3Ymg7zjS6Wa6cudriSYoeu5VqkTgSDh
 FPlV+lzpNoEHz+VWpfHP242pj+qtBkI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-MZyMZer3Oae-SnePtGf4Ew-1; Thu, 29 Oct 2020 13:47:39 -0400
X-MC-Unique: MZyMZer3Oae-SnePtGf4Ew-1
Received: by mail-wr1-f71.google.com with SMTP id v5so1588617wrq.6
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 10:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4S5cV67yMqNZZig0vFthskt2Z9MyX0eg+1GTopYz/4w=;
 b=E/JyIQLiF59+hPoYFlr+yYqUyI15VFGK4IFsbnrqA3gEN7gQswFatVvKrCFjJH8txj
 PGl3ZxOHEg4ZSWr4Mr1EDEZPNBFJcU/FaQcqco2dQF7tmMBl5Y9z/HHer3Xdtgb5Edw4
 q2g7BfpkPmt05dokN4uFEWF2+8H0B0EnBR+cO9jklFZHJUHCpmhfTXe+3pIa2tgtyxwE
 h8stzXHV2ZF1l7gM/qcTmTOkMT0QoPhIDnVBn/qMkr8zML5/nVdj/a17TVm5n6zN26OU
 6hiE812sg8lqyugHviIlrf6wflItefbE38fduviiiDGGHMuDDFIOJ/amLG/pMk15JKBU
 DwqQ==
X-Gm-Message-State: AOAM5323pxE31NlLFUc4wSgv5o5MlA0SQiXRjKwbZfX2l7NBaBm7F9Fh
 uNiryDyWoy8sJ8T98VqFMZpduVZCzQvTtH1xJu2K3OrBfRfHHLMluUAIQ7s9aIboFJ70C3avqMt
 llmfKQugieEQmPC0=
X-Received: by 2002:a05:6000:104c:: with SMTP id
 c12mr6851479wrx.133.1603993658112; 
 Thu, 29 Oct 2020 10:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyup+TbAZStJNsJBNgU7OocRx0GP8HmGMNjatwlL/uwo1+ckrkCJvddXmzWgMqj10ZBuApUkg==
X-Received: by 2002:a05:6000:104c:: with SMTP id
 c12mr6851448wrx.133.1603993657886; 
 Thu, 29 Oct 2020 10:47:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p9sm885641wma.12.2020.10.29.10.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 10:47:37 -0700 (PDT)
Subject: Re: [PATCH 08/11] sockets: Fix socket_sockaddr_to_address_unix() for
 abstract sockets
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-9-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81648f6a-5eae-d8a2-f9a2-518dc1331cd7@redhat.com>
Date: Thu, 29 Oct 2020 18:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-9-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 14:38, Markus Armbruster wrote:
> +        /* Linux abstract socket */
> +        addr->u.q_unix.path = g_strndup(su->sun_path + 1,
> +                                        sizeof(su->sun_path) - 1);
> +        addr->u.q_unix.has_abstract = true;
> +        addr->u.q_unix.abstract = true;
> +        addr->u.q_unix.has_tight = true;
> +        addr->u.q_unix.tight = !su->sun_path[sizeof(su->sun_path) - 1];
> +        return addr;

I think this should be

    addr->u.q_unit.tight = salen < sizeof(*su);

Paolo


