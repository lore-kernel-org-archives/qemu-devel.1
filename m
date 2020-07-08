Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6543BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF94206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SieTjQ3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF94206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIxs-0001l1-C3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIqq-000457-Gf
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:47:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIqo-0004YB-A5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594248457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiyIxZ7CUeF0HnnMPp2yyDeLiebXBI+TQF5nIb9c4f8=;
 b=SieTjQ3E+O8clm4OUs6pGgAe2Xe1x9LrlGA/mLTalV7RAzMU5sWdKb90YruU8pXrrhQS7a
 U+fGXuy/2UNPBi7wOsmawKsxrg+BYeBcbZ7gk0PXrj69z6gDThn3hF401NS/d8Dh0oxv/B
 zNFD7dekivkYJ/0h47LjIe9/ajIUfu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-cuedHaboMQ2WB6wr7wbNxA-1; Wed, 08 Jul 2020 02:45:14 -0400
X-MC-Unique: cuedHaboMQ2WB6wr7wbNxA-1
Received: by mail-wr1-f70.google.com with SMTP id s16so38058026wrv.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 23:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yCo7V6vNCnoPWpHHcmHGWjcrqL3FwLWhxNQvDdBr9Yw=;
 b=YgpBz5UHZ9AMDl2OuPgKAWXplmbGbaB7MPwEqsn/7N6zeDhqzc9HDY7DO6qCej6hbq
 ZHBIMMSTaX6CZRiVI++CFAnf9CjwXQyBLKpQs46cshgk0dGeLJ7YThZlLDVZQGNbOPwa
 zGMSOKdbZdfAnytal6J3edEqwfnfy7NT50088a/vvJ1jz9zxzjYy5Ro8alR3ssIqWxbe
 XNFHtL0b6CzMsjQGkpkmSEiA+BJt1OQ/icUIKs6ylBo5x51KgpGM4UfZnJpdiV+AxyME
 Ctx4xytPtznMIuAtfGYHEqYfRUV5cBafw2CeZMr97ALI7tue7HYI/xX5dIB/xt4aKuyN
 1rwg==
X-Gm-Message-State: AOAM532ZXEUmCEdTwtJVCFB7YAUpedoJ+f0S8iAjBPSWktP5UnerJNEU
 HhFOBdFB7/2CHB1Vgz0dkFAtm7qBZMrajmKJs6xZSAYNiQtaLrWBDkSgZrwSW+bn7pv4bFCJ7Cd
 m8GfUjkooM8qCYjI=
X-Received: by 2002:a5d:424f:: with SMTP id s15mr49321003wrr.342.1594190713413; 
 Tue, 07 Jul 2020 23:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKxEXxwA10YZ5MUmAuGieTYH0KS1M7yGOYEjC0RfR9sAdzsB/Y+fmVdAg4dGeUypdlyhkCEA==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr49320987wrr.342.1594190713228; 
 Tue, 07 Jul 2020 23:45:13 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v12sm4272208wrt.31.2020.07.07.23.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 23:45:11 -0700 (PDT)
Date: Wed, 8 Jul 2020 02:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200708024434-mutt-send-email-mst@kernel.org>
References: <20200703183450.32398-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703183450.32398-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 08:34:50PM +0200, Philippe Mathieu-Daudé wrote:
> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
> schema that describes the different uses and properties of
> virtual machine firmware).
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> ---
> Since RFC v1:
> - Added Daniel & Kashyap as reviewer
> - Added myself as co-maintainer with Laszlo
> 
> Based on a comment from Laszlo:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
> Background info from Kashyap:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..64bcea658d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2601,6 +2601,14 @@ F: include/hw/i2c/smbus_master.h
>  F: include/hw/i2c/smbus_slave.h
>  F: include/hw/i2c/smbus_eeprom.h
>  
> +Firmware schema specifications
> +M: Laszlo Ersek <lersek@redhat.com>
> +M: Philippe Mathieu-Daudé <philmd@redhat.com>
> +R: Daniel P. Berrange <berrange@redhat.com>
> +R: Kashyap Chamarthy <kchamart@redhat.com>
> +S: Maintained
> +F: docs/interop/firmware.json
> +
>  EDK2 Firmware
>  M: Laszlo Ersek <lersek@redhat.com>
>  M: Philippe Mathieu-Daudé <philmd@redhat.com>
> -- 
> 2.21.3


