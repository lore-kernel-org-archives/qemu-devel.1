Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B91AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4603320732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfBuDvnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4603320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k946W-00022t-JI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k945W-0000zk-9M
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:15:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k945U-0000hZ-7P
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ats/FiRgABBYzc8KQfZxcdEKo1wxQoKBn1OdTxH+Qg=;
 b=QfBuDvnZHDCIjx+Uyy65fAkcXohXps3DkXBYG/1kcKQSv+V6GkwwFHMef1oXVR2Mj0lQqT
 gfRXHyLMlj+ic7sKNH1NL5/AV+ot6HIOP2XuJpgd2xqEkgqGUwQSHABCQzOmWed7vWlyaj
 yjtDXA0ajd5QdyhY22k3I6vKm80zxbU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-GuyIx1nMMZS1avSpAgaAXw-1; Fri, 21 Aug 2020 06:15:53 -0400
X-MC-Unique: GuyIx1nMMZS1avSpAgaAXw-1
Received: by mail-wm1-f70.google.com with SMTP id a66so725357wmc.4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2Ats/FiRgABBYzc8KQfZxcdEKo1wxQoKBn1OdTxH+Qg=;
 b=MC1LbbtI6ZOlbPzAz1Clar1lj+xgTrgvkPJNoTWUsi/KSxM8aRe2BJlUG/pD8zMx9Q
 dDSYAx9o6ZhIwlMZjsR4TAlW1Z7X/359HJSqKs8cPCaF+ecf8zG5ydaOiL13gl96BORf
 1zoGGvlegaDFhvIvWJ4BVmCxDSqnY0MS5vwqRFEy3djyUCCZSpQSrM1xfksB6r+nZC0p
 NcDJwFDE1Bxda0V899CO8D6OU17sOiEoWlIU8Bk2u7n7Qt8ftKuUCIzbUnzaM6atsSyy
 6HhXuyn5g/DlvwF1UHgNWcUMMMoGffly555Sao5GlYC4djBYLdHAzxJ5kVDvETK/DZi9
 pg9A==
X-Gm-Message-State: AOAM533XGfJ6xI79vDwCixaqX4IyFslo64536jjKF1+8bG1t2ayctWWL
 eLM1nA1MFyBqSezNM404snWG7VxoYoROeVSnZ/2eVbxD5R2qm/Ydwyvb/Sz03PKBhJmrhE2e8OD
 HrTeHnNA0L1HfWu8=
X-Received: by 2002:a05:6000:150:: with SMTP id
 r16mr2009800wrx.63.1598004952514; 
 Fri, 21 Aug 2020 03:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZoc+IA5Ea6hnwLQaH7ReAsw4jB8of9sVhk/yyOJjB4p4emZQCTAPM+SiUTuf7xcwtCyuWQw==
X-Received: by 2002:a05:6000:150:: with SMTP id
 r16mr2009778wrx.63.1598004952234; 
 Fri, 21 Aug 2020 03:15:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id 69sm4573633wmb.8.2020.08.21.03.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:15:51 -0700 (PDT)
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200820173124.243984-1-berrange@redhat.com>
 <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
 <20200821100426.GB5153@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df28e5c2-ee4a-23d6-dcb2-04003a5d2757@redhat.com>
Date: Fri, 21 Aug 2020 12:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821100426.GB5153@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 12:04, Kevin Wolf wrote:
>> So I'm not sure why the first build gets as far as it does, but does NOT
>> complete things and yet does not fail make, but my advice is that you should
>> NOT try to an incremental build on in-tree build when crossing the meson
>> epoch.  If you are a fan of in-tree convenience, you need a ONE-TIME
>> distclean when pulling in these changes (the fact that you HAVE to clean up
>> trace.h files to merge in the meson stuff should be a hint for that).  After
>> that has been done, you can go back to pretending meson supports in-tree.
> Sounds like it will be painful to switch between branches based on make
> and branches based on meson. By extension, it will also be painful to
> check out and build old versions for comparison, or doing that even more
> than once during git bisect. :-(

Not if you switch to out-of-tree builds...

Paolo


