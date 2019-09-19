Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A29C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9479921924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+eDMQxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479921924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47441 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0hw-0006oA-NM
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iB0Ji-0004oP-GR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iB0Jh-0000et-BC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iB0Jh-0000dJ-3B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568914443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=FgMSUEMLTcQQd072cUBgIejALGIZYCF3cz20sMMFYz0=;
 b=I+eDMQxDxgIPlGG/mRv/ie66azevLGIaG2YyqbbNHa8vobcIDOcx8SuYNi/aVb382KI6ts
 2WjrCiR2cfLVFwJUhOS8b1n0ohfW9vy0nVXAymojscGxQ4Tsy/WvycQdOw7iQUNPnaexq9
 5ttAK634zLnwrrM8EiV4TPXQldwQDFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-OOdWeArbOJKMYWLwN7HRsw-1; Thu, 19 Sep 2019 13:33:59 -0400
Received: by mail-wm1-f72.google.com with SMTP id o188so2150093wmo.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FgMSUEMLTcQQd072cUBgIejALGIZYCF3cz20sMMFYz0=;
 b=Hl1OsFyztA97zJM5NE2E9C9eTT4zb3CSP/AZiK9bK+R74dFYVcsyHu66qhMpH1rXsT
 uUs5y8LiF3EH65WlAqcG867grtCFed0EOKZZ9tE8fkLBgI931GFri/gpnkJPtC6XbkRQ
 zfy9tkgEKZvXQIMVvh38uXqr2wlrsNkxY8HPAhPjB5N1JGbQ1JCTPifNH3a2zaTtMuNA
 MpzO2Q4pjDMGiqPWQwhWJSMPss2pYFqymR2YF+t+JGdIaythYIF7RSrobnC8+cOi333Z
 fQF5UoibBkljQ+hXCPoYMZxiuG2/QlwyV4NfJ6GCYTufx9dqbCs6pWo2+6M4X0mFlwix
 YpqQ==
X-Gm-Message-State: APjAAAVTVMuXs0YLqcFiRTJFbNnEwrrjjPN6g1LX1dePjzNYD8ExrZNH
 6tKqKhMvBnoV3B9GTCcYVWbNqFaWV7Thd4KtBYFtcOeo7iV6l8J+dsPlDoZuc5kkMMoiftvAkav
 uB7f2CI1q8LoEr+s=
X-Received: by 2002:a1c:c589:: with SMTP id v131mr3683449wmf.163.1568914437981; 
 Thu, 19 Sep 2019 10:33:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/jUs+zkjYhc9aHWNBHVkHW9r6cojJY8/IpgWt7cvmmrnp0OPtz8KL1ChYOjsV3J1Xj08+hQ==
X-Received: by 2002:a1c:c589:: with SMTP id v131mr3683438wmf.163.1568914437807; 
 Thu, 19 Sep 2019 10:33:57 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d78sm8986184wmd.47.2019.09.19.10.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 10:33:57 -0700 (PDT)
Subject: Re: Will the qemu-devel prefix in the mails come back?
To: Martin Schrodt <martin@schrodt.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41127b88-93af-a1ea-232b-ed5290102396@redhat.com>
Date: Thu, 19 Sep 2019 19:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9c6bf92a-0869-cf5d-222b-305e55393ebb@schrodt.org>
Content-Language: en-US
X-MC-Unique: OOdWeArbOJKMYWLwN7HRsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Martin,

On 9/19/19 7:04 PM, Martin Schrodt wrote:
> Does anybody know?

This change has been announced here:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01645.html

> My mail filter would appreciate :)
In the previous link there is a hint about updating your mail filter :)

Regards,

Phil.


