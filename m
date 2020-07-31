Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83283C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6E32177B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRyDYppU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6E32177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Xu4-0003Ch-EJ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 12:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1XtK-0002iu-6N
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:28:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1XtH-0000En-Jz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596212893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa1di6Z6b3auLj4M6CxeugsboArDn5TZWXYRu9cnXDE=;
 b=cRyDYppUkRxC0JDtKxYGcPYWPhWnVtiFChUIFLMNZhsHp+Ig62Z9g0ZHM9o+8cvb7/w5L1
 xfDH9JLl77/w8FCpJVjfC1LHpQndPXAG00KZ129XpzI2xIG4JQEzzRkkr/K6cMHj/d0PU8
 ePrJzxuBLLKQ3vIRXuGAfZf0Fm/Xg2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-MbBt3kaIOC6SPAa1NYUUmA-1; Fri, 31 Jul 2020 12:28:09 -0400
X-MC-Unique: MbBt3kaIOC6SPAa1NYUUmA-1
Received: by mail-wr1-f70.google.com with SMTP id 89so9358928wrr.15
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 09:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qa1di6Z6b3auLj4M6CxeugsboArDn5TZWXYRu9cnXDE=;
 b=ByIot35Y416xlDXtCnMejQs6lZUeryuDtvH8kiNttIc3Q5y4WgsonLFyjZM6X/tnze
 Yxzgs6N/xuogitA7X9yBmyAJflX6kFaLfB83RTDOy79ibvqAGzZeQD/WQOLLaPBjy0G8
 PVfz8hKaiS5/FhK1Oukm8S7mzk+teghrwHI/ZOoexp3gcQ0tPCMhgPo1Yk98xDie2Jsp
 UUscEwNQ5tFctmEajlh8vbkKxSi1Lv613nJzgZDwncMMa8MDLpGmuojtd5YXzbgyjUAi
 YjBkpepyR+d/mtwLw1JLnfEFuGIj8AB8P9laIj6ZCzCK/L4MP3MA7PYBPrObT8ZoMgEI
 WLMw==
X-Gm-Message-State: AOAM530Y13F2wCfO/0YlUSRq67NBZBmh96kkUEpSJMIbXQnmNTu8yFit
 lQIbN8WT5F4iI80IWoAsavA3b0J53E7hLvK/WdhTlbxmqHsSgbK3Bjs7OtBB6fNsmPdUxcWrMWi
 ZlByWw0W9LfS98Os=
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr3646356wrx.277.1596212888579; 
 Fri, 31 Jul 2020 09:28:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpqZbv/xsVw8HQGvLmh/TK9guceu7fZO4HH4ZpMM3+BvA88PnxHbxmkG3CBNcZRxxoVdPgoA==
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr3646333wrx.277.1596212888328; 
 Fri, 31 Jul 2020 09:28:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id l18sm14040439wrm.52.2020.07.31.09.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 09:28:07 -0700 (PDT)
Subject: cleanups with long-term benefits (was Re: [PATCH] schemas: Add vim
 modeline)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
Date: Fri, 31 Jul 2020 18:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731150738.GB3660103@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 17:07, Daniel P. Berrangé wrote:
> The QAPI JSON-but-not file format is a case where I think we should just
> adopt a standard file format no matter what. A conversion will have some
> short term work, but this is really simple data to deal with and the code
> involved is nicely self contained. Again I'm not saying QAPI maintainers
> must do it, just put the idea out there as a piece of work that would
> be welcomed if someone is interested in working ont.

The main issues with JSON-but-not in QEMU are:

- the 64-bit integers, which does not apply to the QAPI schema though

- the comments, which are a common extension to JSON (see JSON5, NodeJS
config files, json_verify's -c option, etc.) so I find it quite surprising
that no off-the-shelf Python component can parse JSON + comments

- the single-quote strings, which are not particularly useful in QAPI schema

If we changed the single-quote strings to double-quote, jsonc.vim
(https://github.com/neoclide/jsonc.vim) seems to support JSON + comments.
In Emacs you'd probably add an epilogue like

(defconst json-mode-comments-re (rx (group "#" (zero-or-more nonl) line-end)))
(push (list json-mode-comments-re 1 font-lock-comment-face) json-font-lock-keywords-1)

Did I miss anything?

Besides that, why are we using Python and not JavaScript in the mode line?

> Another example would be elimination of anything in QEMU code that is
> duplicating functionality in GLib, even if there zero functional
> difference between the two impls.

Would you consider intrusive lists vs. GList/GSList to be duplicating 
functionality?  I don't think we have that many duplicates at this 
point.

We have qemu_strto*, but unfortunately the GLib function g_ascii_strtoll
does nothing to fix the awful design of the C standard strto* functions
(especially the overloading of the return value for error and result).
If there are cases that are clear cut against adopting the GLib version,
I think patches would be easily accepted.

> Another example would be adopting a standard code style and using a
> tool like clang-format to enforce this for entire of existing code
> base and future contributions and throwing away our checkpatch.pl
> which nearly everyone is scared of touching as it is Perl code.

Checkpatch does much more than that, though the scary part is indeed the 
one that enfoces coding style.  I wouldn't have a problem with using
clang-format and calling it a day.

Paolo


