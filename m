Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C07C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF132071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIizXwWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF132071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugQk-0005bt-Rp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iudFJ-0004MF-Dp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iudFI-0004Nu-8b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:14:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iudFI-0004NW-44
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579788847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZHH/Nt38nF9Sq6A5y+ioOtlKSLL1dqIN/eV26kf7Xk=;
 b=UIizXwWFYDpBfdjWhDn/F8G4+I8RFzyJCZCpPdwxprm5ndvUh58QUmvVlB1F15BVzOshNC
 tTHpvrLVWRvvmY+JXQhGPFrACevBTxavE/CgLXACwlqHX/6n4wQVOAJl1xgrvVeGwFTfrL
 pkELA0vt/oU7TCnbOEcdZ6dWGNRuTKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-ZiMmNWSWPyyJ1K_BZSTHMQ-1; Thu, 23 Jan 2020 09:11:51 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so1787374wrm.16
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ZHH/Nt38nF9Sq6A5y+ioOtlKSLL1dqIN/eV26kf7Xk=;
 b=jX8AioisnfGGDhZdJhN+2w1Sfd2Qyc3b2rKCvwaqc6DSsv4yvO5uyxln4jFKaHQTqZ
 oXpwz37vXe26XdeDvagMFpEJ8hW/TcE6swRXIGyaz6Hhac0zMHXqxi47mguwD/fmeT0r
 Lk4hCCWiSYMUZSYfXkNJyD3CTq0x/CoAzg52cKH7MH9pumca/cOPRrlYXovHcjAsNZ50
 AK4MzX9FO0BjKZbfwMXwj/72keb5CyliR5X4eTWOMWxL/we/X825s8Dn8+1+F0D/vZSb
 z0zYEktbuOFZbU+3vYHV3LsedaeBT7eLnTzvUobbsdoo/hhFn4wfaRIatuz6U0wuNlx+
 L8fg==
X-Gm-Message-State: APjAAAXLhV4E1gOX671DlWtr0kJKbmwNrt6bAotOxwaQSqYLX8JMpKku
 pYbz1hZNJlVRAJgcBs9jN7Dy6h7Wwhqs+uMZozoRlPoLAiVSZyNKIaU3Mv0uKHptV7gv/fCP+U9
 uJYmwN1JOTwlbMTE=
X-Received: by 2002:a05:600c:2507:: with SMTP id
 d7mr4248852wma.28.1579788710003; 
 Thu, 23 Jan 2020 06:11:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzadLvuQYoVae0ZOjko2Oy7RgtCmYqFfFDLuFwFW7aAVrwURprw/L5u/8cyw9MySyEH5JhuDQ==
X-Received: by 2002:a05:600c:2507:: with SMTP id
 d7mr4248823wma.28.1579788709776; 
 Thu, 23 Jan 2020 06:11:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id g2sm3093698wrw.76.2020.01.23.06.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 06:11:49 -0800 (PST)
Subject: Re: [qemu-web PATCH] Add "Security Process" information to the main
 website
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200123135900.22175-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f30a14a4-779f-865d-14d2-8ffc8cbf94b7@redhat.com>
Date: Thu, 23 Jan 2020 15:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123135900.22175-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: ZiMmNWSWPyyJ1K_BZSTHMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pjp@redhat.com, sstabellini@kernel.org, pmatouse@redhat.com,
 mdroth@linux.vnet.ibm.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/20 14:59, Thomas Huth wrote:
> Anyway, it looks more trustworthy if we present the "Security Process"
> information in the static website instead. Thus this patch adds the
> information from the wiki to the Jekyll-based website now.

Fair enough; here are some edits so that we can improve the text a bit
in the meanwhile.

> +We use a GNU Privacy Guard (GnuPG or GPG) keys to secure communications. Mail

Remove "a".

> +sent to members of the list can be encrypted with public keys of all members
> +of the list. We expect to change some of the keys we use from time to time.
> +Should we change the key, the previous keys will be revoked.

Should a key change, the previous one will be revoked.

> +* Is QEMU used in conjunction with a hypervisor (as opposed to TCG binary
> +  translation TCG)?

Two "TCG"s.

> +Whenever some or all of these questions have negative answers, what appears to
> +be a genuine security flaw might be considered of low severity because it could
> +only be exercised in use cases where QEMU and everything interacting with it is
> +trusted.

s/genuine/major/

> +Prima facie, this bug appears to be a genuine security flaw, with potentially
> +severe implications. But digging further down, it shows that there are  only
> +two ways to use SD Host Controller emulation, one is via 'sdhci-pci' interface
> +and the other is via 'generic-sdhci' interface.

I can understand some Latin, but perhaps s/Prima facie/On the surface/

Also, s/it shows that//

> +Of these two, the 'sdhci-pci' interface is relatively new and had actually been

s/is relatively new and//

Thanks,

Paolo


