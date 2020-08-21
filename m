Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44377C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054B8207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCf1DHCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054B8207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96sa-0004Hn-44
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96rr-00030l-J7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:14:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96rp-0006Lv-SC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYYvOCtTYt8YU8/H2wnL0QJNGjqXq/SeFcePaZoRv9g=;
 b=DCf1DHCtW8y+qSz0IUQs9tSCGs1IGfiA812yJYQap1krOYOm/Blg8T0JHRwHW/RvBZq/Si
 vIm+rfMFrKO+QOWWzpfy9dIE04iRZ4LBnzoYyNVk9tJNlZ/WOWLGiqzKJKtzrYLblsIFhW
 iSAcRjfNriAz4OwHdC5ujM6qYNLt/jM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-u1GDgbuRPkymaCgZwYh1jg-1; Fri, 21 Aug 2020 09:13:59 -0400
X-MC-Unique: u1GDgbuRPkymaCgZwYh1jg-1
Received: by mail-wm1-f70.google.com with SMTP id p184so957940wmp.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iYYvOCtTYt8YU8/H2wnL0QJNGjqXq/SeFcePaZoRv9g=;
 b=W9THIUg+MPNxmcUVEgnwpwelXV9WXV6J9oc8kW7dcqBxlpS9Z1E5/YXyIhUJGbODh0
 09s4HBqupeD8fJ2BYKKzawj4bb2FumtYja2/Uo1UxAL+cYgbX5AnroFaoIsfBj5SCROE
 ZQUdAcdlurSBNDb2ktorZns01ARLMU+Hvsdeqsac+cfEjoicAWtkc/lV2EvJk9G9UCeo
 NTP6R/0Lyo9iYl/LumdBMDlY54/WkY3d/CVluOWuh/fz6tW3kwvkU30U3B+pfDX7g/f+
 yTgNRV0MsfI0yqe+rMobB9i/6Z3TDUHX5jp4E2oFz0eyK130yQQh46IvLRSpWlDKmFUR
 4ghg==
X-Gm-Message-State: AOAM531rCwFWrBVfVxv+jZVyg+Hw+I3OlmkX1jIg1/GTBlI/bDEYuaOI
 tTVX+4CPWwt6NvDBUqGSjc845YJhs/NnurzhEpSR3IEj/69gntSCOY0zhV2S1zYC6EYQKUZNv3w
 D6nhswBHI25AC40I=
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3729637wmc.186.1598015637829; 
 Fri, 21 Aug 2020 06:13:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyid1AowhtjG87WcmMBzl3sMUWVxmVutc+0OMhn63IsSPTXO8z5L8HFWrw3MmNRDsw2TIQ6+Q==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3729621wmc.186.1598015637550; 
 Fri, 21 Aug 2020 06:13:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id u3sm4773833wml.44.2020.08.21.06.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:13:56 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
To: Geoffrey McRae <geoff@hostfission.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <5029913.bOW1W81TKx@silver>
 <20200820053728.kv7pngxqzp32uky3@sirius.home.kraxel.org>
 <3140676.b1PlGooJ8z@silver> <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
 <a165417b4d27c7fbce404e81f6c38cda@hostfission.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49a9b5f5-d1df-b6fb-d238-7c9e8d2aeb6c@redhat.com>
Date: Fri, 21 Aug 2020 15:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a165417b4d27c7fbce404e81f6c38cda@hostfission.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 13:28, Geoffrey McRae wrote:
> 
>> My suggestion is to work towards protecting the audio code with its own
>> mutex(es) and ignore the existence of the BQL for subsystems that can do
>> so (audio is a prime candidate).  Also please add comments to
>> audio_int.h about which functions are called from other threads than the
>> QEMU main thread.
> 
> Ok, so to get back on topic, what exactly is the best way forward to fix
> this issue in this patchset? Should I be managing a local mutex instead?

I think adding a local mutex for audio stuff would be best, if it's not
too hard.

Paolo


