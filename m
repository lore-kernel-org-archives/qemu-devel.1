Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBFC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019C620714
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWXeVfKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019C620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOVn-0007YN-6h
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYOUg-0006SP-79
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:34:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYOUd-0006jN-W1
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589265257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JCusBzwy8B1uDd17LgzWIUtUKGYE2Mkj9ONUU1JKpj4=;
 b=WWXeVfKAnDHBHmkHxzu++fNH6F54oGm9DWk+9o62LrlpSRZ7A1S559QRdNzrzyjWWLMA8W
 6DHxI0hujRJ0uVwv43pAePG+aYaPti/K/eqWDPb24TOJ/strUehRxW3z47uwmmvYK4kOCi
 w2AlUgqLyq3y7u5r04V6GIZC7Ib/fZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-_A9S6lvVNI2tal9blTIijQ-1; Tue, 12 May 2020 02:34:16 -0400
X-MC-Unique: _A9S6lvVNI2tal9blTIijQ-1
Received: by mail-wm1-f72.google.com with SMTP id w2so9510086wmc.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 23:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=JCusBzwy8B1uDd17LgzWIUtUKGYE2Mkj9ONUU1JKpj4=;
 b=dPS5ZvjU17bg2DnFna14ww1GowU2xXuK66UTEO041Xn9hqHS9PKRNy9E+jiUumr0ap
 B3Nv9SWwn0hTw5IZo9ZVjb9qsxaZ8GTBwl1gglAxFP/BS0e5d1zr/8/qzOF/XDHcQ1hw
 /fbUkv92i6QKTg2pQEgHvpqwmlpklH5epJw0TJ0HM94L1iH9kuWNQS/xK0JnkVEqO45e
 ewshHErK9QE+FYlx/uMzbZ7bqJX5sYhqAL2F84D3VDV9TVCEHgc4krjjA4ONvUgWbR9B
 1PxtK/ZtmttyIe8Ddfqopw0oBAmnTgWr0un7TEJXwPpjS3LU/LTuu90nj5dUR0W1msG5
 qTYQ==
X-Gm-Message-State: AGi0PuZHB31VLNzkeKig0W8leU8tqH0DGtSZDD7fGL9t0AQD9b5644Xa
 M3j2GaEh6kgHo/yWEJAynTRoYNzrtKTUBhBe5AsZXvuI8a4ljACcbavPPRRO2/jbhd6Tt42U4bb
 SfsFPXUMP8g+EFcE=
X-Received: by 2002:a1c:a3c5:: with SMTP id
 m188mr14416897wme.160.1589265255108; 
 Mon, 11 May 2020 23:34:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpKhozts0g+POWfEzRrK8E/6xqXXwecqAOWqx5HKD6RPNtzQ0iJbPvf6wBTqyA+7cC3AyVUQ==
X-Received: by 2002:a1c:a3c5:: with SMTP id
 m188mr14416878wme.160.1589265254938; 
 Mon, 11 May 2020 23:34:14 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm14215476wra.36.2020.05.11.23.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 23:34:14 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: SBSA-REF maintainer email bouncing
Message-ID: <dcb8d325-a2af-0c68-ad64-87f41521d4bb@redhat.com>
Date: Tue, 12 May 2020 08:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: radoslaw.biernacki@gmail.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Radoslaw Biernacki is listed as maintainer for the SBSA-REF board.

His radoslaw.biernacki@linaro.org email address no longer works,
apparently "Radoslaw Biernacki no longer works for Linaro".

   SBSA-REF
   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
   M: Peter Maydell <peter.maydell@linaro.org>
   R: Leif Lindholm <leif@nuviainc.com>
   L: qemu-arm@nongnu.org
   S: Maintained
   F: hw/arm/sbsa-ref.c


