Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC87C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2C5204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkiCt0Vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2C5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Zfm-0002tQ-FE
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2Zf4-0002HO-JL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:33:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2Zew-0005ej-ED
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596458020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ys0l82h7xrTNHf9Xrks+GJOE5/N04vaCHpxufbf7yNk=;
 b=MkiCt0VcXn181L3JKAVT+EMVkYNIiCoWpwfYTvpU6HIqLaSMbJ86Z+Zuhz86reLlT9F7RX
 b+/zcG/1G76I2Lkvh7r+8j76HNOBvihNE8TDXD8QjwuoDK4Rb/sJMjYT3gH2uY8IjI58za
 RIUIpGFlKUCfd5e8RsUob37RFGHkRZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-0NO5aHH7NIucj6kWhFkmtA-1; Mon, 03 Aug 2020 08:33:39 -0400
X-MC-Unique: 0NO5aHH7NIucj6kWhFkmtA-1
Received: by mail-wm1-f71.google.com with SMTP id h6so4741391wml.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 05:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ys0l82h7xrTNHf9Xrks+GJOE5/N04vaCHpxufbf7yNk=;
 b=I787JS/riis86+B858ER1yLIhaHpRin7U9lna6Y1WxuBmuyCBFiA30kg/egZwaSBBK
 mLyP+HPCtgzrLHjzdQpxXpb6Qlr9KmdUmm/Myt0odmyK53UuhZ7JLKBpmBr+HPI31gjG
 uBP+aJAkejsu1dcBEMpJRr2hO62oYAHNGqpmG/6KB4ix4ePu8HjsUAncmh5o+aekBy32
 AB+tcj0geIH1kEO2osp6sFmbL+idOEWJ7b1cSQh3xb35hGkSO/eDxvNjPLeLWra4SLdR
 PujshpFKTwbSPFvHO4GlujtjEWossy1dfTIoFSA4h7WcQsEpBdAOV9lKsJcrfaImK/q3
 ULDg==
X-Gm-Message-State: AOAM5338FdJySQa89hIcphW3+aMH71ipbJFHpmp6hsSEMfn06S/iNGQc
 hFoPbyre3SEL93cD+G5B9edtuh9JWsQILRkK+HvrS49bfAfaKkzv7AaIodZQ5RXc6sIpOoEU1Uu
 HfYJXYzgw5+XHNGM=
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr14454886wrw.31.1596458018161; 
 Mon, 03 Aug 2020 05:33:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX/IeA7i6pxM/uDS3XuosjJd8FowTcm32s1UtNirdz4CEr5x8jAmSo60uI74G9rSKPTeHSEg==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr14454862wrw.31.1596458017941; 
 Mon, 03 Aug 2020 05:33:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id l11sm23211453wme.11.2020.08.03.05.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 05:33:37 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
 <20200803113655.GI3670709@redhat.com>
 <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
 <20200803122304.GJ3670709@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f96e8cd5-0e64-adde-ff91-315876a0df00@redhat.com>
Date: Mon, 3 Aug 2020 14:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200803122304.GJ3670709@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 14:23, Daniel P. Berrangé wrote:
> We'd really love to move off YAJL for JSON parsing

What are the issues with YAJL?

>> It could be avoided by using a schema in Libvirt, just like QEMU has no
>> problem with it on the other side; it's just a different design choice
>> with different trade-offs, I don't think it's enough of an issue to
>> declare JSON "the wrong choice of format for QMP".
>
> The schema doesn't help - the problem is many JSON parsers don't allow
> use of full uint64 values when parsing - alot will simply report an
> error for anything bigger than LLONG_MAX and offer no workaround.

Sure, but this problem is not at all unique to QEMU and JSON parsers
have a way to support large integers in pretty much every language
(including Javascript).  In some of them like Python or Ruby it's even
the default behavior.

Paolo


