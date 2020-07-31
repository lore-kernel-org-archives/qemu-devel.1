Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4957021744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TX0Qp/PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4957021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Y13-00060K-Io
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Y0L-0005TV-1V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:35:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Y0J-00013A-0W
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596213330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJeZgmwGIuva2psfK1i0BsBiKAAwVEZNFjtcVS8lA/E=;
 b=TX0Qp/PNUlJpTpM1Jl3hOFCGYSxpNHb3drTimmwEr6vAPwI00sHSxThLPcMaDoX1EMuqjc
 2V/e5fast7bNIblqNaT/ywbRz5ZH5QvmyhIqv2iJH0D0WJY2dOvmdy1ZGv8UUVMvg/Rj0G
 CbOAkGOp4Emv3bpgNuL6UpBDFByy5BY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-JRY9F3-nNoeFUHHwMaHmSg-1; Fri, 31 Jul 2020 12:35:28 -0400
X-MC-Unique: JRY9F3-nNoeFUHHwMaHmSg-1
Received: by mail-wr1-f71.google.com with SMTP id z1so9359970wrn.18
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 09:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vJeZgmwGIuva2psfK1i0BsBiKAAwVEZNFjtcVS8lA/E=;
 b=Qk5GDycod/7Fb8CYYpFV0YTMIh/TRWmnhT7QdhMIUsBqWbfyQUFHoBFORMAPGaIi3a
 AnfZygHLV8DlTPdR3C+L4vckcaSchOrqTbGzweXLBKflQ41Wv2rOm70n9hrkyyM4kIvG
 maCYZmztymRaeF0qpeks03GggV+FI00A18M3x2oQpZWyNXh4NWbixQf5ctNRGP9j76pc
 cmR5EvsorKDdICoybi110f6II0v48xRbfNnSZGEUdRgUxSNcPANSNS6pA1/jQnSbyufB
 AOosXaw9KQYUdTJ66IOw1o8BRPWzih0fYEcCM6PmALJbrRad55YkLK8uZKo2eFhYo1+O
 jxEw==
X-Gm-Message-State: AOAM533DH3ImKeVn6/p3pHw3CoqmcsLuDuC12blv+4mBpfao+SZIHYvp
 21al2WM5Lw8UySAYVtNCxkUBirOAN/hKk2PGr7sLl61YeaJfnUQs0F74xZMCuBSMhJv3tf0E/yV
 2Jdkevlg/HZ7zmyY=
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr2760773wmc.94.1596213325699; 
 Fri, 31 Jul 2020 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzTpW6gyzwmeL4622Dcc+jDrJTXFAVsmEGKyORh0MCt1QGUjVa1TKZghu2fpeL8aoviG7JwA==
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr2760746wmc.94.1596213325473; 
 Fri, 31 Jul 2020 09:35:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id s125sm13939694wmf.14.2020.07.31.09.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 09:35:24 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
Date: Fri, 31 Jul 2020 18:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 17:26, John Snow wrote:
> I saw the critique that we still use JSON-ish for the runtime QMP
> protocol, and moving the QAPI IDL to a standard wouldn't remove all
> instances of a custom format from our tree.

Sorry, but "still using JSON" is not a critique that makes any sense.

99% of the websites you use daily use JSON as their RPC
frontend-to-backend language; OpenAPI is essentially JSON over HTTP.
There must be something good in JSON.

Whenever you hear a complaint about "using JSON", it's actually a
complaint about bindings for your language, which can be a sensible
critique: gRPC is essentially {protobuf,FlatBuffers} over HTTP/2 plus a
boatload of language mappings.  Unfortunately C is not one of those
mappings.

Paolo


