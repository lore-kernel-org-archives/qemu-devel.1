Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E72C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EC920725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkNKTV8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EC920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvEy-0005O1-LT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtvDi-0004N0-OU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:45:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtvDh-0008NY-69
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594395947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lz5G2H6f5V29k6eHdICD/l/Xbqcp2DbhTnjDYQtOVkM=;
 b=DkNKTV8NxVNkTb2lRuchEobg9MYnNgZfw8u3hzSRKIzsrxSEj1LYhh8/vUfYOSkceED1fv
 KJCYmzitZnZMFc4jpVg1dbBYrOAobX1qsaxfnabgDhOlOzGpI6/bW9i3FkwMuG97UhFCGo
 ACRs5lmPkDz20bm5Jcnx0sFYFKUomTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-Z4ZrjnzRPTymUu0ySUqrow-1; Fri, 10 Jul 2020 11:45:46 -0400
X-MC-Unique: Z4ZrjnzRPTymUu0ySUqrow-1
Received: by mail-wr1-f70.google.com with SMTP id f5so6364255wrv.22
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=DytXzLV8SAHzkbW5xUKQTbTJkvCc2JKF6EoeCFnJ3gs=;
 b=PZlbL5eWgC9gnTALsEJ0Hwxnrp0sLVc1rkxitxJnoxIvoJ5cEftPNaUGRtOoQfjHxt
 oAqRcsP4wSZ2rE61dYBELsncMVTwWt1KqCcflzr6OGID9XU4pw9QGFB+ENjKxIIQ0zeh
 2mmiklXzZokHKyDhNbEmC0kTMVCYkvP2K8qy++2mRSmu9YrPba+A2SLfMWtdhSsNSXLK
 offJ0bBW2t1jjY+wI88virMmA7BNItMWXB9URUxyb+Kkti9K2H2uZvfqjVzD2bE0GxLV
 nQaASwfsDSY/zdE65gbgxEnp9b3e+mB1af0EvNsIwM/kN2xvDTOxD1So3P/0oz2eDo8v
 xWUg==
X-Gm-Message-State: AOAM5314rvoXMR0BRjVwPFp7Xouy1DmEBSv/dH73drXBUzXcRusSt9w5
 9K1gp2XdorZ7yX8CsKKAWv9EOAMjilN6Mrh1R2zf08AiBDGptbLj2NHQ4f/EVjgHqHEQhHguxNr
 HZP0fWKZXZ1kDmt8=
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr67308184wrn.20.1594395945133; 
 Fri, 10 Jul 2020 08:45:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygqZVeic02m2U1SbN0GX2ycuSK7PvlU1kVc2n7j6qi9TTSt3SlfXZC+HA6srptAV5MzpAC2Q==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr67308170wrn.20.1594395944911; 
 Fri, 10 Jul 2020 08:45:44 -0700 (PDT)
Received: from ?IPv6:2a01:598:b902:a219:a4a6:bc3a:36a3:3b20?
 ([2a01:598:b902:a219:a4a6:bc3a:36a3:3b20])
 by smtp.gmail.com with ESMTPSA id l1sm10218542wrb.12.2020.07.10.08.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 08:45:44 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Date: Fri, 10 Jul 2020 17:45:42 +0200
Message-Id: <50DB9C15-AE46-4F41-83F3-A18D1E86B6FA@redhat.com>
References: <20200710154302.GD14845@osiris>
In-Reply-To: <20200710154302.GD14845@osiris>
To: Heiko Carstens <hca@linux.ibm.com>
X-Mailer: iPhone Mail (17F80)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 10.07.2020 um 17:43 schrieb Heiko Carstens <hca@linux.ibm.com>:
>=20
> =EF=BB=BFOn Fri, Jul 10, 2020 at 05:24:07PM +0200, David Hildenbrand wrot=
e:
>>> On 10.07.20 17:18, Heiko Carstens wrote:
>>> On Fri, Jul 10, 2020 at 02:12:33PM +0200, David Hildenbrand wrote:
>>>>> Note: Reading about diag260 subcode 0xc, we could modify Linux to que=
ry
>>>>> the maximum possible pfn via diag260 0xc. Then, we maybe could avoid
>>>>> indicating maxram size via SCLP, and keep diag260-unaware OSs keep
>>>>> working as before. Thoughts?
>>>>=20
>>>> Implemented it, seems to work fine.
>>>=20
>>> The returned value would not include standby/reserved memory within
>>> z/VM. So this seems not to work.
>>=20
>> Which value exactly are you referencing? diag 0xc returns two values.
>> One of them seems to do exactly what we need.
>=20
> Maybe I'm missing something as usual, but to me this
> --------
> Usage Notes:
> ...
> 2. If the RESERVED or STANDBY option was used on the DEFINE STORAGE
> command to configure reserved or standby storage for a guest, the
> values returned in Rx and Ry will be the current values, but these
> values can change dynamically depending on the options specified and
> any dynamic storage reconfiguration (DSR) changes initiated by the
> guest.
> --------
> reads like it is not doing what you want. That is: it does *not*
> include standby memory and therefore will not return the highest
> possible pfn.
>=20

Ah, yes. See the kernel patch, I take the max of both values (SCLP, diag260=
(0xc)) values.

Anyhow, what would be your recommendation?

Thanks!


