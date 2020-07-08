Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5656C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD656206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnF8weti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD656206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtICM-0001g4-Ri
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtHmA-0007Hy-2L
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:38:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtHm8-0003S3-5C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0Ma7ijg3Nvpwxwl5uTE3a13so6FxTARUYgVyjWwO9k=;
 b=BnF8wetis5V+1zJK5wQ66Fz/r6okzMIImkk3ykyNEsRb2nvv+QnHbma0d5hnSBoZtyBiku
 /dCZRgEs9O/md1oZlRNDrib/VFbcBVBl1utgJwU0smSudH3NfZAx7ZOXl/eFz2LzChi5WC
 OdQ4Ek1mT6TxgWEMqm0sKRwNtSCAqV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-hvzt-rUvNTa5xgiLk_M6eA-1; Wed, 08 Jul 2020 06:37:49 -0400
X-MC-Unique: hvzt-rUvNTa5xgiLk_M6eA-1
Received: by mail-wr1-f69.google.com with SMTP id j16so46241651wrw.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 03:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b0Ma7ijg3Nvpwxwl5uTE3a13so6FxTARUYgVyjWwO9k=;
 b=tQk3QwYDwaURY8CrJ8gko4pcVX71bs7lahHk0y05NrehJd3KB6s4+s/oXHPvbm2FjK
 XeVWV/wQxy288fbcZKg0FxsUbQOLXBetCeC5A+jlG51IyaEuYwNo7/KechehK/ur7kQK
 aFGUx4C3zDKtCP93BXuU2OlBlJtKU65ZJ1f3N7ZWEzsg5c88sN+f9imHXsPwZP+U8SVK
 mpEKOS5ra8xkCQ+NjV6vrOtaTN5ciLZQc0YGeJAhy+fSfRr6QQekDLlgl72Vx4Ki8OEV
 DA1GMYhIYKqwUBT7AMmvRSEtEUUmbqDW9JPGhYCl0OO0R/j03lNKHx9BW9zwGEwTKlw4
 7eVA==
X-Gm-Message-State: AOAM530jF71otgawdQ85+w3oqRv2VfGgY7wcGznTM9MxwQo0lK3X0sxO
 +vkUyWYTtdJ3FPdJRtSJbBtdsVmoOxbBNlDrlWiC0OuQUKe68npdHcVQZ0WiDy0F62ZnsFBXRYI
 tDzAAL7auPP9smPg=
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr8578692wmd.104.1594204668555; 
 Wed, 08 Jul 2020 03:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbpeZoGStBwww98/41W96R4yDpqf+YUwDklw7WGwqzqdlbIblYxjnu3Tise3Dv1+JK3pUKmw==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr8578659wmd.104.1594204668216; 
 Wed, 08 Jul 2020 03:37:48 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 133sm5923591wme.5.2020.07.08.03.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 03:37:47 -0700 (PDT)
Date: Wed, 8 Jul 2020 06:37:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200708063659-mutt-send-email-mst@kernel.org>
References: <20200703183450.32398-1-philmd@redhat.com>
 <20200708024434-mutt-send-email-mst@kernel.org>
 <3dafd514-f66c-96c5-3217-86ef990dda1b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3dafd514-f66c-96c5-3217-86ef990dda1b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
 Kashyap Chamarthy <kchamart@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 10:57:31AM +0200, Philippe Mathieu-Daudé wrote:
> +qemu-trivial
> 
> On 7/8/20 8:45 AM, Michael S. Tsirkin wrote:
> > On Fri, Jul 03, 2020 at 08:34:50PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
> >> schema that describes the different uses and properties of
> >> virtual machine firmware).
> >>
> >> Cc: Laszlo Ersek <lersek@redhat.com>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> >> Cc: Daniel P. Berrange <berrange@redhat.com>
> >> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> >> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> > 
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks Michael. If you plan to do a pull request, can you
> include this patch please? (modulo the weird UTF8 mojibakes)

I'll try, hopefully utf8 will be fine when I do.

> Else it can simply go via the trivial tree.
> 
> > 
> >> ---
> >> Since RFC v1:
> >> - Added Daniel & Kashyap as reviewer
> >> - Added myself as co-maintainer with Laszlo
> >>
> >> Based on a comment from Laszlo:
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
> >> Background info from Kashyap:
> >> https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
> >> ---
> >>  MAINTAINERS | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index dec252f38b..64bcea658d 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2601,6 +2601,14 @@ F: include/hw/i2c/smbus_master.h
> >>  F: include/hw/i2c/smbus_slave.h
> >>  F: include/hw/i2c/smbus_eeprom.h
> >>  
> >> +Firmware schema specifications
> >> +M: Laszlo Ersek <lersek@redhat.com>
> >> +M: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >> +R: Daniel P. Berrange <berrange@redhat.com>
> >> +R: Kashyap Chamarthy <kchamart@redhat.com>
> >> +S: Maintained
> >> +F: docs/interop/firmware.json
> >> +
> >>  EDK2 Firmware
> >>  M: Laszlo Ersek <lersek@redhat.com>
> >>  M: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >> -- 
> >> 2.21.3
> > 


