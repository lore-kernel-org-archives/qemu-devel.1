Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7982467F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lsxrc5ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7982467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaMV-0005dd-5Z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuaLt-0005BL-Mc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuaLr-0002zH-GG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:08:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuaLr-0002z2-Cc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579777722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTWsY908R4dLUygDWANLbBrU2YN2NEDuLI8nPVqTHEk=;
 b=Lsxrc5MLbon3zy+6ya7IcLJAPnsKShfWMPhF7OwgQmYrB6ywGXMtZ2jkx7/8sqKWYw5dnX
 nu4GuUFbIq3f18m4W96unbfkl3l07Kpa+xp6G99kg0V9JwAJrpEUnlemmYE05HumlUy2u7
 Uk6G63ijWkO/YyecASNwR9WfJltGutc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ojTtDui9NgmI5bS1FsJBFw-1; Thu, 23 Jan 2020 06:08:40 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so1532069wrq.12
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRXhWVgip0OH3ojCVEsbFi8S2lN/tA5FaRzidam+rKA=;
 b=Qdb2+EbFXZ3hcx16MNmT6GRi5+d14+G09N15oYt6kCG8eX0+hqtQtBPqvPwSIwNE4X
 sNyG1QbJKbgPLPAqnj1ExkmhSq6UM4LUIeCER72iVVItCJPyD1vRUWrclgtgd0xJXXjz
 z6RDAhwXJ1H1a84D4UQvCFfNiHQfUqnOHwi16eKl9S34FglbaedE8TRITgdHqf6+aklN
 3MvAtKviG3RueId2WUUZZnc0GC5ZsyqqOKOnheTkQn0vAkPcifblrYoK4ekqR+nIzyqf
 KnYH033MROIj+YgGUf9KCMbhCOWweXwyUGKBMci2wxZXdHz57Mw07rhcX9FBXJqKAPcs
 Lb4w==
X-Gm-Message-State: APjAAAWLfUIq29n5ZP45cAuHuFtKqTyxIj6CVI/W9wxbjocLDnRwBPFz
 /gyYr4rhJ7F9PL/cBqc4YQ72I/w2/D8CJ/jkRpCUoQt4scBsHIK8mGFqaxfOeaRFBMOI31m4L8W
 mUszvXF1xtJnIYp0=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr16713664wrr.309.1579777719388; 
 Thu, 23 Jan 2020 03:08:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPALBUO/VSqM4RlCxWfEOU8njf1JyCmKQk8NiXmRVz4GbMQfcRyHuzn2dL+Xda2hN1dyPw7g==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr16713644wrr.309.1579777719151; 
 Thu, 23 Jan 2020 03:08:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id z11sm2616978wrt.82.2020.01.23.03.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 03:08:37 -0800 (PST)
Subject: Re: [PATCH 19/26] qdev: set properties with device_class_set_props()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-20-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5974b974-d3a9-dd1f-d226-6912d7d97365@redhat.com>
Date: Thu, 23 Jan 2020 12:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110153039.1379601-20-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: ojTtDui9NgmI5bS1FsJBFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/20 16:30, Marc-Andr=C3=A9 Lureau wrote:
> The following patch will need to handle properties registration during
> class_init time. Let's use a device_class_set_props() setter.

If you don't mind, I'll also rename "props" to "props_" so that we can
more easily catch conflicts (which will be syntax errors and not just
bugs) in the future.

Paolo


