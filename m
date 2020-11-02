Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6AC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31AA2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp4oWmaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31AA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVgH-00063R-Pz
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVfE-00059u-76
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVfC-0004p4-4x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604307484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFyd6yrYnzeoH9383g4QgOoOnsP41+A2C8gZ2pXdo+4=;
 b=cp4oWmaay4uMF3orygSlY5gB/JppawAdljWYFjX0NyoCiPVVG26ge8zDq9RA/AX6iKQEHq
 Yae9wblTORRGzkQJZyFUPhDLT6MWRVjUuEuImZRVj01oFibriuqaAKBKqsKQCtoBtRPiPH
 SDqIA2A3nK4qklgF1VguzuE8/uZflgk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-CVG-xM54NTOcDJ5RSubt4g-1; Mon, 02 Nov 2020 03:58:02 -0500
X-MC-Unique: CVG-xM54NTOcDJ5RSubt4g-1
Received: by mail-wr1-f71.google.com with SMTP id e3so6168365wrn.19
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 00:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dFyd6yrYnzeoH9383g4QgOoOnsP41+A2C8gZ2pXdo+4=;
 b=JrVmXJ2j37xNqsjmZvYeI/7BZVrl6gHQem5wcykOSZJnyudJQdFGJGPWVo0BHvIjuY
 0kbZbpPpE71yYDb1h/wqoMiaMLe1WAKakpcsuY+NxV+h4xCoG4p5wHZTUnDMJaL7jr1l
 01PL4/UVqZDLqKmS3D1nfhMglGgMCyryPNBFmbSd3NU/LXGp9sQU6kHOqmkyoJ8ISza0
 uGDUVULF89BTokYcQTQLsirgfUuN2GkleeFyAh0d9a3zbqdgjPgmzcPdWocwjaqjEe2q
 +QWZbRdy5XXSq0oYy6gQ1s5aOZzDuqfNmUrq7HrbuQR1uWkIKU5GVjiHIlYBoO2ZODO1
 5kpg==
X-Gm-Message-State: AOAM532GDXufWCn9SFrCkgn6HlfuLv+RrlBoQIJkIirZ9e7nF45jrAV9
 8qQ2EaziEYxurNFjE7PQyfpDxO//EMJmtrL+YE5Kprl3U7l8CDsmcRKqCdambxC4w9/A0NBeDeC
 hq3M+UCzzucFDDJA=
X-Received: by 2002:a5d:568a:: with SMTP id f10mr18735359wrv.30.1604307481665; 
 Mon, 02 Nov 2020 00:58:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySvmHcfWe10HaMrwn0xAHV28SOgWXsW8k1osPgnrTlPh3CV+FPf9TDLJmbaScbhlcXe95ArQ==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr18735336wrv.30.1604307481436; 
 Mon, 02 Nov 2020 00:58:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id c18sm20702152wrt.10.2020.11.02.00.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 00:58:00 -0800 (PST)
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
 <CAJ+F1CLW=zfWq3apgrKear2v42LYarSMQKw07BHadM-rYjcmoA@mail.gmail.com>
 <87pn50vxa0.fsf@dusky.pond.sub.org> <20201030102049.GI99222@redhat.com>
 <87zh40no5a.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d76e90fb-3646-66ae-0efc-dfcbc187896e@redhat.com>
Date: Mon, 2 Nov 2020 09:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87zh40no5a.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, xiaoqiang zhao <zxq_yx_007@163.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/20 09:44, Markus Armbruster wrote:
>>> Reverting the feature requires rough consensus and a patch.
>>>
>>> I can provide a patch, but let's give everybody a chance to object
>>> first.
> Daniel, do you object, yes or no?

I think we should keep the patch, especially since you have cleaned up
everything already.  The interaction with namespaces is interesting.

Abstract sockets also do not have the usual issue with needing to unlink
the socket before bind(), because they are cleaned up automatically when
their last file descriptor is closed, including on SIGKILL.

Paolo


