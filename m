Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DBC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68FE208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdSFM8t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68FE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0j5-0002LF-Uk
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jX0iA-0001Pt-8D
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:58:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jX0i8-0001nK-H0
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588935511;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyCZiIMXk1Y28WNZr1AkdRRZAp+HQiTOsMdv91zL4Pg=;
 b=OdSFM8t91oNypsAq7uWM5slpNmOyL25D47PX18lNymQ6Vi7J3cFtBPVhdN5Cn/wILfS3IU
 X5CoDd2Gk6Sv9xqYu9FDmmdfzw4sWN5pm02FVHJ3kzjF87amuSvkwDTcxmOwygntZb5HBo
 jy9DTIfX0azs0in3gXbwV1otzaU4hoI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-WwDjjL_aNrK3I2H_EQvkfw-1; Fri, 08 May 2020 06:58:29 -0400
X-MC-Unique: WwDjjL_aNrK3I2H_EQvkfw-1
Received: by mail-wr1-f71.google.com with SMTP id h12so689241wrr.19
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cyCZiIMXk1Y28WNZr1AkdRRZAp+HQiTOsMdv91zL4Pg=;
 b=X5+f8Oqm2+dbhQ+KTHUTaWJpnO10n61laJc2mfr6rCSDCEyHghtB9IqJMY1fElsiX9
 w4a/rVvOGpo7HfNc2zrkQZQ4Vf8/N6yuW9XWiVC5bS2D50lolJdUmks1qIPA59V0dYK2
 WksROAvaO2fLAegxURURl2o3TIqcKNAPnOtoIPMXsOtEez498t6b2/Uw72Oj8+5SbgQ9
 XydkGU/CmPwiohJUc8ouhz4tijXp4SMEu/zsl2OBJ3kT1Kodaz7RHK6t0BMc6iG3APdi
 Qi9lzgOUQzZu43BU7TyWMSaxiZaWGQj4UWEziW85jmT+2R6LQtWjM0Z9mca0H6nPtElx
 pohw==
X-Gm-Message-State: AGi0PuYXyoae43LS3Axmzx/Y2Fzs9unqWsMVe5Me1eEztYqyR8s5B7FD
 sdSOlQxY4xN1/vYC0YrawUU0sujcEfLOjIkpx0NlLWU7Z1JpzBYGyHOqFrFcVL7ejYB7pygSKi+
 KFWlwL3334dRYHIs=
X-Received: by 2002:a05:600c:24cf:: with SMTP id
 15mr14926195wmu.94.1588935508552; 
 Fri, 08 May 2020 03:58:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypL77NI34TbDDfERPCrxkNpOhsGcev4KtdXrtLP6r59dCngh8fw4wlAQoNf/ixkyz3h4JhDTQA==
X-Received: by 2002:a05:600c:24cf:: with SMTP id
 15mr14926177wmu.94.1588935508281; 
 Fri, 08 May 2020 03:58:28 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id r11sm1265076wrv.14.2020.05.08.03.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 03:58:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3] accel: Move Xen accelerator code under accel/xen/
In-Reply-To: <20200508100222.7112-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 May 2020 12:02:22
 +0200")
References: <20200508100222.7112-1-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 12:58:26 +0200
Message-ID: <87368ad771.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Reply-To: quintela@redhat.com
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> This code is not related to hardware emulation.
> Move it under accel/ with the other hypervisors.
>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


