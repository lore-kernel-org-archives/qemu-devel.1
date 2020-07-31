Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8762083B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF8iMvEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8762083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Z4d-0008Bd-Gi
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Z3c-0007eq-Vy
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:43:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Z3a-00015G-LQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596217377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4AxsnG5ycXUO3pTH1fMQ8bWO1DhpjCnOcAIkkdIt9E=;
 b=WF8iMvEVr31LbQMs6CVSnPSc1ElDKqnLfs2lTj4HUZgzF/39Kfpj0xM07ivbyHEYe46aNF
 hkWu4JzT1rEhINDUbQXhNxChkMDFIfv0Ilc3i5SDvS6o5ksznBHna2Vvl+CUaOzAn+5Hnf
 T//kRLkadFWmY9atpq1DXkZlXzM+DSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-u2jYQ1LYM9OruOJvPz8U5Q-1; Fri, 31 Jul 2020 13:42:55 -0400
X-MC-Unique: u2jYQ1LYM9OruOJvPz8U5Q-1
Received: by mail-wm1-f69.google.com with SMTP id y204so3459989wmd.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f4AxsnG5ycXUO3pTH1fMQ8bWO1DhpjCnOcAIkkdIt9E=;
 b=jGmw8lkfAB+7N/P7aqYV9G45X5GDLbgj+MFS1n/4OV0bCqJx9jiWpUYbJa+WOGzvLe
 s3fFb4DbSsZ7cXY+aO72pJ+8xiXBuq9CN7Vtw9JyE6uv82a7w1iihLg3+IfTFDYKykgM
 KUMxiTfLWzZn8tgfhNXy0v3MmSIeUWdQFRYCkMbgIlR00DhNZ8UNMU9SNk2U0XtACST9
 njIxo6y9phG5g1LwtnxYfx3U1F05U4o0hiZHc9CzCLY9FciekNHQlP4B0h1/ELvpZ0Wi
 SLHRORAMyhc5KTwhwh271fNiuZSXb0DIREhfr+/3Le5vgVSzfBbEzXzSCLax/L4pG3xw
 O7IQ==
X-Gm-Message-State: AOAM5330NT/7FCLQdGIDAJdan1YrOuRLr+/YkKyN4A+CoK6SCWrtvNPo
 6ik3SMogNG/fOCqN9b91nE8s4dBFTYt8gaCxCe0M+rfJWGbN+u6T2ATcos1Xc+FDMPoHdcJi0Jp
 iy0hk5F5C2HuiDOE=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr4401637wrs.78.1596217374267; 
 Fri, 31 Jul 2020 10:42:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRCeGlHNnGlTeieG+mMy45nf4xTM1HpnJ7S8LJPRRiSG2ZGit0Laomz5EgOnr6jBgj3VpZCA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr4401601wrs.78.1596217373952; 
 Fri, 31 Jul 2020 10:42:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id c7sm14223819wrq.58.2020.07.31.10.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:42:53 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <20200731170500.GF3660103@redhat.com>
 <c2ad1dd6-d53e-b4fa-79e2-0006ddf2f5b2@redhat.com>
 <20200731172723.GH3660103@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebf67ce1-d46a-9da1-a75c-7b821fb589f6@redhat.com>
Date: Fri, 31 Jul 2020 19:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731172723.GH3660103@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:39:31
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 19:27, Daniel P. Berrangé wrote:
> You say "main feature", I say "biggest flaw" ;-P
> 
> Doing checks on patches is the single worst thing about the way
> we do code style validation, at it means the bulk of committed code
> is never in compliance. The need to check patches is precisely because
> the committed code is unclean and so can't be checked without raising
> pages of problems.

This is true for code formatting but not for style warnings.  A stupid
example is that you need to use strtol to implement the recommended
replacement qemu_strtol. We could invent our own "allow-this" lint
syntax but it would be a much bigger job.

Paolo


