Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F9C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF40E206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRklYU2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF40E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJBm-0000MM-JE
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iiJ1d-0001UO-9V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iiJ1b-0001ta-67
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:13:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iiJ1a-0001rv-IP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576851181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=twfYvP7Rti+Ll6qhjoYOHdpbOLgfz64KQuSFiOtxCqs=;
 b=HRklYU2FwYdBOiFRoOYITQNZuzgA+tanH2UzXydh+g/tqEgrMaTTHUTVBGY/WkcW89+tpX
 IL/BHEzwMoCJtgFFmouTtAxQSXtN7f3lnoSMjQnrcQG7zSJWxHts/z3vjtTLJJfh79AQwe
 XJt9dZIiWesM4fCxKm6bNDGG0mTvan4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Kck_GJ98MuWwA9m5W8nBWg-1; Fri, 20 Dec 2019 09:11:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so3815595wrx.22
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=rSstiuPwsxCdOdbtt6QYA+NFPFZfCutVCRv5Y4LrQtg=;
 b=Z5qAdvJuVTWL6UdWxxFC3jn9knR/0blS4u/7rE0Pc7hsEirFzOjgiCX+ffM2A/+GnB
 zj19Qzp+yz7YWlOjxo8kpZsJrzOaDBjCr1OiAqn1Xf0wGTzoSUTTsesUuTGUKyVGcCQZ
 Md8jMEBH3e+E4gqFVUqVBw5jnd4wa64mcGaZzCe4BdR3JH3FQZgpXxV0vFh0t+u7X4b7
 H9pobkMc0qZBzHfcwrZ8h9Qce1CO1tQVz5iWM19vZ0p9y6T2dUjcZCEjRQbGiGfRPBbr
 eVrlu5e/2kdq4+XFWApgDqkTz3dsq2VSAs5sshhfT8i9bpRxS7fsTQuZDJ5RqdbUGbJ5
 wT/w==
X-Gm-Message-State: APjAAAUlQR07hGFkKZp8oyGzT3DCj30iHB1rSfUCAWNJ0FnmGG92yjxq
 BYkEyCuwbfgHxgnqiVDNzvyxi86Cb2B8URASt9RRXXSBpirmYUeDKfmYKR5jzKVBeS++y544qiJ
 bn6PPJqJngna4nFk=
X-Received: by 2002:adf:fc08:: with SMTP id i8mr16345963wrr.82.1576851089424; 
 Fri, 20 Dec 2019 06:11:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMUu7aoQKbmLpTX1OqBrK+7q5P8Ruf92MUKJlD/sDm5ZPDJF+w+Y74x7f+sZjaU0bPtkdPzw==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr16345938wrr.82.1576851089223; 
 Fri, 20 Dec 2019 06:11:29 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id z124sm3083131wmc.20.2019.12.20.06.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:11:28 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [BUG] No irqchip created after commit 11bc4a13d1f4 ("kvm: convert
 "-machine kernel_irqchip" to an accelerator property")
Date: Fri, 20 Dec 2019 15:11:27 +0100
Message-ID: <87eewz84ts.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: Kck_GJ98MuWwA9m5W8nBWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I apologize if this was already reported,

I just noticed that with the latest updates QEMU doesn't start with the
following configuration:

qemu-system-x86_64 -name guest=3Dwin10 -machine pc,accel=3Dkvm -cpu host,hv=
_vpindex,hv_synic ...

qemu-system-x86_64: failed to turn on HyperV SynIC in KVM: Invalid argument
qemu-system-x86_64: kvm_init_vcpu failed: Invalid argument

If I add 'kernel-irqchip=3Dsplit' or ',kernel-irqchip=3Don' it starts as
usual. I bisected this to the following commit:

commit 11bc4a13d1f4b07dafbd1dda4d4bf0fdd7ad65f2 (HEAD, refs/bisect/bad)
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Nov 13 10:56:53 2019 +0100

    kvm: convert "-machine kernel_irqchip" to an accelerator property
   =20
so aparently we now default to 'kernel_irqchip=3Doff'. Is this the desired
behavior?

--=20
Vitaly


