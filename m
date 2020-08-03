Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA5020678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isQc4mW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA5020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2W3s-0008If-Fq
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2W35-0007gA-95
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:42:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2W33-0007RD-G5
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596444140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUoJKPqgWW71rc1brqyB7te5w1ncXMbeKMb5w21FVNQ=;
 b=isQc4mW9wiBUBTZQrZs23SVkSEMZ+yi72Tltt7oTkNjqQabhAxLVZ5AEOure0EKhc1hbST
 aAOyeefIX3/IG1sm+NjDvEEF30iXt3b0doE/8wdCdptvsDeYBSrRTS22gz7KWbE4LnJ8sG
 A1MU82WPw3vl5K3IJOoRmZ28RlqP5TI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-VJ8_6kGVPmSZhY59JKJI6g-1; Mon, 03 Aug 2020 04:42:18 -0400
X-MC-Unique: VJ8_6kGVPmSZhY59JKJI6g-1
Received: by mail-wr1-f72.google.com with SMTP id w7so9038201wre.11
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 01:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zUoJKPqgWW71rc1brqyB7te5w1ncXMbeKMb5w21FVNQ=;
 b=hUZj/3FF91rXGkiYLAZtU3P2Y2YeOSb4XA/dy49woZ7F5kFr0p9yXqN4WD5IaSeqsj
 HeZFs1Vc+o2JEi5t7GaurAOX2YrIsz8mo/g5CoknJrDFoa8S8neYMvcAvTXjpJB0/6NQ
 p5NZNTRssfjTI2d1sMsyfr2jq2da9Taf/Gu/iF9EnbvNJQJneRWEumYCYaB7RGoFRvtp
 Df07fDjrjm+z8yuaZqrhRqCsrZ65TmpCCJaOoGooWOsdVrU0f9KTD978p4N/2X6IlzKD
 UoYEwmTD5xVd+YzQ9heOXwfhiMT6IylH/A/kyQE6Re1hanubEzCMlLB2YPyMFS7iaWQ0
 xH1A==
X-Gm-Message-State: AOAM531to94Y+RD/dxZ8pVVjkPKNc8Wg0dAUqfD1yNisIQi95/Tu8jnI
 aFXSIlTWzrpMz6p+Gmzp8Uqodd59W/iOTB1DpD1c04JMYdJkbx1sZiZKYkH3A5JpUErjvyK9XfI
 hZsHb5YxsFcdkR9Q=
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr14654692wmf.60.1596444137499; 
 Mon, 03 Aug 2020 01:42:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhWQcvukZ4yLaO8mU++XipThbN8BXV7b0LDY7d7926Re+bgJYQ9H2/qyKlaTB6Xksd9BPxmA==
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr14654661wmf.60.1596444137132; 
 Mon, 03 Aug 2020 01:42:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id x4sm27174237wru.81.2020.08.03.01.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 01:42:16 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
Date: Mon, 3 Aug 2020 10:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87d048i1m2.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 10:18, Markus Armbruster wrote:
>> - the single-quote strings, which are not particularly useful in QAPI schema
> Every single string in the QAPI schema uses them, though.
> 
> I have no idea why Anthony put them in the QAPI schema language.
> 
> We could remove them from the QAPI schema language.  Flag day, and
> git-blame becomes pretty much useless for a couple of years.

Is that a nack or a "whatever"?

Paolo

> Removing them from QMP would be painless for QEMU itself, but could
> upset QMP clients that (unwisely) use them.
> 


