Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1111FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856720725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzgazNqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856720725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpHh-00059u-Tj
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtpH2-0004RU-CZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:24:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtpH0-0003t2-8k
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594373089;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIrgIk1qKi1QoeUsBn+/K7pRr8i1oMBhqMLOdW+Bvjc=;
 b=CzgazNqKhSqpECEY6BzUADki7HsPW/TsltLVNEMkMdvqTqGnfxF+EQGz81ylBe3kLYC/Bx
 tASgxdrxyeKOvE2ZYmnhDMzu3w3VVbQpkC+3pTTUrpjE0vKbnn24fWv4RVY8PCOEX+PZrh
 H8OfhsarOkZsH2btk40gwGAlRErX9tY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-cE4WdzEaO---jheEIlBIMQ-1; Fri, 10 Jul 2020 05:24:47 -0400
X-MC-Unique: cE4WdzEaO---jheEIlBIMQ-1
Received: by mail-wm1-f71.google.com with SMTP id g6so6062492wmk.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uIrgIk1qKi1QoeUsBn+/K7pRr8i1oMBhqMLOdW+Bvjc=;
 b=jo2autes27XOsLa8fLcHjoOFwGKhSTINSoDbhaRT4MWHfEa/JjIT5oX26f5nbDRl/H
 C4v2qWlDn17BO7tupupUxacNYUb/FIx8WSDn+/w7LbMJvi+pYXAO0GBVGbteky4cvLEF
 4F0M66f3nUfnJEnV7qsZhLwFMsaaCM1KldnPkNQAazuHxmionimv7Th15BkW66TBFkmn
 E9Y1pD7HYnyZa7UxGNBUi7JX19Gn5UNsDordVOh1deWoUH25kv86L08IOaoAF7+w0yBc
 FRwxOtDIXF/wg/Cr+BbEidBJAeBkXz3KvrbDM2IIsTsrfv1kVJKUvrpj+XUet/7oVmfP
 +awQ==
X-Gm-Message-State: AOAM532bBM3+OL18nyJfPjMaTYDXBiiRls0QnrXfqhhEMVRXJuBcGQuh
 Eq6lPcpBjwZwm9rd6YyPJ6wZRuBMhbQcOYKOBUgPKEdKHZ3kFGD4vUnXE/ZVw/rzqkS71MGFPLd
 TW5ZquCDn635rJi8=
X-Received: by 2002:a1c:4086:: with SMTP id n128mr4448407wma.118.1594373086000; 
 Fri, 10 Jul 2020 02:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw59A04AAEV0Q1FdPAwQzvM1K0P5M9MepLcmUu27s6ijUX8ZB9SwlM+HBfK+RfbkJp/nlAi0w==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr4448384wma.118.1594373085725; 
 Fri, 10 Jul 2020 02:24:45 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id p8sm9384025wrq.29.2020.07.10.02.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 02:24:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/2] hw/char/serial: Separate and document static
 properties
In-Reply-To: <20200703185809.5896-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Jul 2020 20:58:08
 +0200")
References: <20200703185809.5896-1-f4bug@amsat.org>
 <20200703185809.5896-2-f4bug@amsat.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 10 Jul 2020 11:24:44 +0200
Message-ID: <87eepjzpr7.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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
Reply-To: quintela@redhat.com
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Add more descriptive comments to keep a clear separation
> between static property vs runtime changeable.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


