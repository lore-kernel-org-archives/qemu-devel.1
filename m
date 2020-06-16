Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74EEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCA7208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="aHs5ZgDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCA7208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEnl-0002Re-Pj
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jlEmY-0001VC-RZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:49:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jlEmX-0003Gb-0f
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:49:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id x14so21513486wrp.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QWN36qdLF9i8dA/BKA95mxJrrIci1d69q/Tde7p9pEY=;
 b=aHs5ZgDESflFw2n3F5c4VJwhjgF5hKVbtgMR1OMD8uI+2X9D+KgaEcTo/ND7HjX5np
 YNltvEb+uS5RLTPXfOkP0EUTkpzeALkghLaxOI9MyIiipC7OdVJ6fe+Ly+mMge4/mldT
 rXc2YmRW3SNVUv22l7AtPncKLIOfKt3RvUamQsLGDF9glO9/gHFNhiq96vHz373ggWof
 NtPc2xhEoDGgDHvVbiKnSowsbYFjuaTIbBjUjXQQfUo9+DgHXxa0+dukayaQjYQgObQg
 KZZ9caAEXzXMJPs6oqEoLrP7o9lvE/NrrgSZivXEKFSb+1PGM7g9CaE1fzSb+j3sxQVz
 LmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QWN36qdLF9i8dA/BKA95mxJrrIci1d69q/Tde7p9pEY=;
 b=kAyhFBVmTzRurz+qLv26kDsue7dFqeu5lsQyV61G9XfOV4uCYGaACSNObi8xxZz/iH
 d38cQrSQps1ph9u4VQBwDKHDEutaMmfCYXSq/geb1yzuBvRItTFjPTLsMOukdnuIJIV/
 P4idS+jDFP8u4BOxf88qTImBrHVoXpSdKfQcoUyV3rlXsMC5eemC7MjT5uIpzeRe9xFH
 5Y80UUdyTkdu3iRARp9Es1GSPcIrbaA3DA4eQXsNPxXAtBFcgOyQW7Lt6DQlWkiFYvyo
 y9tj2G6Y/GAaB95CKiZXNUwwrIC6Ju1NTv0E0R/H60SnIGOtntZ5gQNL59sMKvyGg8WP
 pWjA==
X-Gm-Message-State: AOAM530O9Rh84u9bKDN+7IsYj4LaZzRxXFkyrSEmtTAYbgB8D7rFdgh1
 vcYJaIIpwGjLLN6Qhj56Km6kNna/wClsgg==
X-Google-Smtp-Source: ABdhPJx2JwfvmEZaykaQqLOd/47pkvwGRKEX+ArfHZr/zK79FwXuQgHWNI+EHpWyMiMT+7wbmBXG6g==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr3979641wrq.21.1592326190078; 
 Tue, 16 Jun 2020 09:49:50 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id d28sm686535wrc.50.2020.06.16.09.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:49:49 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id af5b4b36;
 Tue, 16 Jun 2020 16:49:48 +0000 (UTC)
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 3/5] crypto/linux_keyring: add 'secret_keyring' secret
 object.
In-Reply-To: <20200615103633.300208-4-berrange@redhat.com>
References: <20200615103633.300208-1-berrange@redhat.com>
 <20200615103633.300208-4-berrange@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Tue, 16 Jun 2020 17:49:47 +0100
Message-ID: <m2y2on6jmc.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::429;
 envelope-from=dme@dme.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-06-15 at 11:36:31 +01, Daniel P. Berrang=C3=A9 wrote:

> +if test "$secret_keyring" !=3D "no"
> +then
> +    if test "$have_keyring" =3D=3D "yes"

This generates a complaint when building on Debian testing:

./configure: 6319: test: yes: unexpected operator

Perhaps should be a single =3D ?

> +    then
> +	secret_keyring=3Dyes
> +    else
> +	if test "$secret_keyring" =3D "yes"
> +	then
> +	    error_exit "syscall __NR_keyctl requested, \
> +but not implemented on your system"
> +	else
> +	    secret_keyring=3Dno
> +	fi
> +    fi
> +fi
> +

dme.
--=20
The sound of a barking dog on a loop, a plane rises in the crystal blue.

