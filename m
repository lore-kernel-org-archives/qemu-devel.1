Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7B520678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqhdq+zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7B520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZB2-0001q8-1r
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2ZAL-0001NL-Hf
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:02:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2ZAJ-0001p2-KY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596456122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPXz/UNtrigkacEXDa1dkvtLQjWhcTcUEgkfW+7AAvU=;
 b=aqhdq+zQOxA2yuxhj+6KwP9tSMTuvu6+AS8b/RHChag5E1CoPSi8B54e4UIgvEAYdhqmOX
 Bi2b9q07kDE92O+BasswS1Nn12bgG8bdP766qzgZxbRbf//ksDkGWRuG1dDw5I14WWKQ93
 OGVTnZ4SSwTMNMqRF24tio19C3DQ7pQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-1ezBm0NRPsquyJaWRrDjYw-1; Mon, 03 Aug 2020 08:02:01 -0400
X-MC-Unique: 1ezBm0NRPsquyJaWRrDjYw-1
Received: by mail-wm1-f69.google.com with SMTP id h6so4728083wml.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 05:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tPXz/UNtrigkacEXDa1dkvtLQjWhcTcUEgkfW+7AAvU=;
 b=Q5x/dlcCa+tQeatBT64d18aG9MB5uEPNjBabAZXCSDUoXTdIm6Tn2W3Lx7HN7JHCfW
 09lBJi2Od+CyTyu0/H9ThqSinG0j87QGoY39VnwlC4Rm/3OgQVkvZKjDe7DUjC+IaINU
 vod5fEeUF0Pe50Fp8THzeDHWu6kjogPg2vsNf65GVVZYhuMCeSE7qk8AHFaoq9wMVDGQ
 3rJNQRuL0jVgRy2QPgCRbRG5FM/QdJS0g68B58DOqHOyJ902n7+HA3S6JqWzoKJvf8KF
 OtcLl6s7ieZjPHtiXY71npo5/9SCyzE0jLqttQD6vGCy0wtD/bMctN0l9rLQbAMqVw+N
 GGYw==
X-Gm-Message-State: AOAM5335hGn8CbyuNrkQo0MnUHRlxifEDacLMpKxi2PhjWaaSTFU7OGs
 YDlRIyg9pEegk1NLWS4gZ1mnaiePPLT+3FxoQiE8oZGzmUYRFc6yh9dIWSSluJGQqKJI9CtNtQ1
 zDcnk1gPopHsmX/c=
X-Received: by 2002:a1c:8195:: with SMTP id c143mr6365615wmd.85.1596456119762; 
 Mon, 03 Aug 2020 05:01:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFYEd0YFV2FhiksNMPU1rKXFQ0rZoxqGaibwDhdu+tj6bM9VqcRRFUelcfa5Cj2yuQTjgOQA==
X-Received: by 2002:a1c:8195:: with SMTP id c143mr6365590wmd.85.1596456119484; 
 Mon, 03 Aug 2020 05:01:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id e16sm23946352wrx.30.2020.08.03.05.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 05:01:58 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
Date: Mon, 3 Aug 2020 14:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87ft94klyl.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 13:28, Markus Armbruster wrote:
>>> We could remove them from the QAPI schema language.  Flag day, and
>>> git-blame becomes pretty much useless for a couple of years.
>> Is that a nack or a "whatever"?
> It's "is this really worth the trouble?"  I guess that's halfway between
> NAK and whatever, ready to be moved in either direction by arguments :)

In general it seems like a good idea to use a standard file format and
not "a standard file format except for two characters". :)  We also
wouldn't be having discussions on editors.

That said, after a bit more research I'm skeptical about the possibility
of using an off-the-shelf parser because most of them either don't
support comments, or are based on YAJL which simply discards comments.

Since '//' comments are harder to parse than "#" comments, this would
actually _add_ code instead of removing it.  Also since our doc comment
syntax uses "##" as a delimiter, we'd have to bikeshed what the doc
comments would look like ("//!", "///", etc.).

This means the two parts might be considered separately:

- replacing single-quote with double-quote strings

- replacing # comments with //

Paolo


