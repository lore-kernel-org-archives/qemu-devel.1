Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD83CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763BE206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4a07fbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763BE206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgyf8-0006Ht-Oo
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 18:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgyeP-0005kl-GV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 18:47:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgyeN-0002LV-LH
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 18:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591310870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XASiRYDVjPrE/pa/1MmZ5LDpkQAntZhxxgkJZkVE2R4=;
 b=h4a07fbegu2SMCfG1yJFXaMH4NaCWOnh8K2iq+cKDC6D+4c6YJO5/sR9N7Pj3/C82loxb5
 VPoEDy3SlFZouitd1e6mmLgubj9XNpkPab4ABNf8uR+b+JP4aGPLioCGOIVutDWDlia+lf
 4LIuUYpgwPfXpNp74AvSQcM2hNxDkCo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-g5jNol5wOsC1bAW27CM8_A-1; Thu, 04 Jun 2020 18:47:26 -0400
X-MC-Unique: g5jNol5wOsC1bAW27CM8_A-1
Received: by mail-wm1-f72.google.com with SMTP id b65so2405327wmb.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 15:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XASiRYDVjPrE/pa/1MmZ5LDpkQAntZhxxgkJZkVE2R4=;
 b=o4M/xfEheMCjnjVEhTJ41XoiP8aYcMNq5OihqIv4g72DT440mt6/sZDxq9d+GEmC6p
 Eyw6dj9YeTI79OkNYEvBUw4Eu/6Gxj6jozRRm+wUIbUvMg+yegLG5tfrUDYPScReOGan
 FmoAHjtGVns8hhTxQjYl1WyYGTBFJB7XizZB5X26lN3Xl9ioYBDGTIZHUN6BDSmervTx
 JjyqdYbVF2WuJ+QXU5Gs/M9d15cNJON4/tKDuEjJ7BX6EtHeLTRHJ+yj0PPHjuutX2Np
 za9ratYoiuNczKXYu6OFKG4Az1MdeiLsbiQRYIws1OxDP0CpplSBsz50iznLbNbbMyGH
 UcXA==
X-Gm-Message-State: AOAM533uRbqNn99lDGHol3liZvF17E2RJGE3CUV8ZuqjGef9VJlif+Po
 UK/+rgQ0rrfT9epAyNXj6Bksl2T3lQgsJLOWEMcebS44jCgCuwDLzCqBZc8bc7QtNfqLbR29LQ5
 VGdQR5fBpEXNc5ak=
X-Received: by 2002:a5d:4404:: with SMTP id z4mr6683890wrq.189.1591310845542; 
 Thu, 04 Jun 2020 15:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlkk5SvPBnPSUvXvWnaamBXc4TawEXxNTXO6msjT+msfHOTDq37cmuivNkSAgN0hreVjyO+Q==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr6683847wrq.189.1591310845161; 
 Thu, 04 Jun 2020 15:47:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id z16sm9711667wrm.70.2020.06.04.15.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 15:47:24 -0700 (PDT)
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604062124.GG228651@umbus.fritz.box>
 <87r1uu1opr.fsf@morokweng.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc56f533-f095-c0c0-0fc6-d4c5af5e51a7@redhat.com>
Date: Fri, 5 Jun 2020 00:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1uu1opr.fsf@morokweng.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:22:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 23:54, Thiago Jung Bauermann wrote:
> QEMU could always create a PEF object, and if the command line defines
> one, it will correspond to it. And if the command line doesn't define one,
> then it would also work because the PEF object is already there.

How would you start a non-protected VM?  Currently it's the "-machine"
property that decides that, and the argument requires an id
corresponding to "-object".

Paolo

> That way, compatibility with AMD SEV is preserved but we also get
> command line simplicity where it is not needed.


