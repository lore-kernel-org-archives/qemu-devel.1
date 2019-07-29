Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC47206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeJOEEpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC47206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5DU-0003du-BC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37895)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hs5CN-00039r-3D
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hs5CM-0004Az-32
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:56:19 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hs5CL-00048e-T4
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:56:18 -0400
Received: by mail-ed1-x544.google.com with SMTP id v15so59248931eds.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6+1Xo1JKRLGZhHUPvCnrMs5zjxqMyM+joIlmjMhTwqE=;
 b=GeJOEEpTpifkp4+P8w41a1+1BVbQq+RfTwIs+iJHPGikAyqegNiZz+bgecA1U3GoaS
 MpFiTjIJSL4MGTvAWKmNa4UatB72C47jlHn4WvDaFPNg2yEfqWLgq9GGEZMVmsi9Ipiw
 GdrQHZFof5lxNMe6moe0lDg7Z6FjsVzFkqwM3solYrzJHeCftNfr4SR5sNESbUiGjs/3
 ILl3ARAZTjWVlsuwVX1jkOMuZqSqXi46/MnGebr1MEb/J74BcitJ3U/XTerJ6Q2bXgOk
 4iW7kOVLtScgre3TSMT8OREPx3zKeCfKpLqjJGIkUM81LQh9Rdm0+f+tZGwUjfNU/Hyp
 Rflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=6+1Xo1JKRLGZhHUPvCnrMs5zjxqMyM+joIlmjMhTwqE=;
 b=CLLok6lR86Twmlw8vGaPTaFc0NjsoWMtfA5Cy5Gq4X+5/dz9/wwORRLlVzJ0VmuULe
 26bhVKJz3CW/7LUpWFDjLgj4NjPu95BKfk9ucdDARzKN6mf2eXsLMu87C2nvRVWGP3zt
 MBVqPxBgOX0mGdUyfHixaY5ytv/MNaIEJQZNR8RurtCfzwKkbe/K5ruAD2fHVwGihPs1
 ZXc2erxcmvcneM14iSOTjwqAfj+suufprdnediI1uCnAVtNT7MSqodKyfxdDfWdlg899
 Al5c30qk7PeaA5jMjySC+q1Zc3npJUdTh2YBkYyUThl0/hXfpVHPVpmY/nSd5DVuwYMZ
 UgMg==
X-Gm-Message-State: APjAAAXsP2BGulCO5nIABOkQ+ryj/Gx9idl+I4pYT2lBiP2x5TuCVL4/
 9NB8zzsplprB4WvWZ2zQpgQ=
X-Google-Smtp-Source: APXvYqxXvaAeKzhvvinlnoambtchudtxl3xV1K1DDaHkJABe6ewBDpSVl8RweIvaLLGk9tAcjKYzkg==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr98144604edq.23.1564404975784; 
 Mon, 29 Jul 2019 05:56:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id ng6sm4069335ejb.13.2019.07.29.05.56.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jul 2019 05:56:15 -0700 (PDT)
Date: Mon, 29 Jul 2019 12:56:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190729125614.wpn4jyl7lstk2odz@master>
References: <20190728131304.1282-1-richardw.yang@linux.intel.com>
 <20190728131304.1282-4-richardw.yang@linux.intel.com>
 <690fd825-3553-6dee-5ff4-2ad7652afe46@redhat.com>
 <20190729103056.42f423ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729103056.42f423ff@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-device: break the loop if tmp
 exceed the hinted range
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 10:30:56AM +0200, Igor Mammedov wrote:
>On Mon, 29 Jul 2019 09:49:37 +0200
>David Hildenbrand <david@redhat.com> wrote:
>
>> On 28.07.19 15:13, Wei Yang wrote:
>> > The memory-device list built by memory_device_build_list is ordered by
>> > its address, this means if the tmp range exceed the hinted range, all
>> > the following range will not overlap with it.
>> > 
>> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> > ---
>> >  hw/mem/memory-device.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> > index 413b514586..aea47ab3e8 100644
>> > --- a/hw/mem/memory-device.c
>> > +++ b/hw/mem/memory-device.c
>> > @@ -180,7 +180,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>> >                  range_make_empty(&new);
>> >                  break;
>> >              }
>> > -        } else if (!hint) {
>> > +        } else if (!hint || range_lob(&tmp) > range_upb(&new)) {
>> >              break;
>> >          }
>> >      }
>> >   
>> 
>> Lower bound is inclusive, upper bound is exclusive. Shouldn't this be
>> 
>> range_lob(&tmp) >= range_upb(&new)
>> 
>> Also, I wonder if patch #2 is now really needed?
>Indeed, it looks like 3/3 will break early in both hinted and
>non-hinted cases so 2/3 looks not necessary (in case 2/3 is dropped
>this commit message needs to be amended). 
>

ok, let me drop #2

-- 
Wei Yang
Help you, Help me

