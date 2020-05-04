Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EA5C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5F32073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxUCI7qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZGO-0003Nw-6m
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVZFc-0002t8-K0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:27:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVZFb-0006Cc-P3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588591626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FD9ujJYT8ftzStdCeg+WZdMyu6PkDSNMzff/zcBg9Bc=;
 b=HxUCI7qTHbpYKLyNVzJB0HeRAfdpeheuLRM60oOMebi2L0yaJJDepKyo/6+zCjceno+2Tl
 dW0z/9v3XlOmuUHzKQQKEkbll56M/yet+Tr24WTrvLW8LMpWtYEqeO5TiJ4KBaIp0jHWr5
 sjRAcwz3PoUMRo31FIyMVKmA13meqFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-N0pvixRqM3Gno-R6nThASg-1; Mon, 04 May 2020 07:27:05 -0400
X-MC-Unique: N0pvixRqM3Gno-R6nThASg-1
Received: by mail-wr1-f70.google.com with SMTP id v17so5765229wrq.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0G0anFJENUlo0hObtVHl5QNEXws4BuKa6cvvRN7D5Ys=;
 b=Fs6lUJVAq+zVfi1Z41bgij3/RA+fNGrVi1GKbzSOTFIBaqfonWEJa9WR0pT9NMu3Y2
 7xjoNotwGAvlTX2tQ16ne+NsomD4iC2Nev8War939ZNv1iLUZdY+bj5qBXtuHn4Y+Zsa
 I6MqJYMBA90M49qhLK0VMGiLzvucUJyYtlhwpbtp0+OEbdaCxBHqCc1anEyitD7jZo6h
 vcRYU6Y/K4x63IFM3ontGru6Hhvg4obWbTHI9w8WWBPAFoXQb/UukemNie6QElKz+1AC
 wbziQEyLMAdfmhnlK/mUUMXBu2bMoe9QzbEG0BE709t71DSlsT1zlUIjjM6gOarqeS4K
 JVfw==
X-Gm-Message-State: AGi0PuYgwqfSLIq/SDALaSGy73CPM6AJYcWNvikIE1Av4KJGpbT1Pveq
 KDZXBbOXAAU/SBvPCUjnhQq2xxSI7yatIbncP1mnMQo1qipS03b4YhmA8vTp5DHOHOgFOltP4H5
 D2Z9L+L+9iUxrvhw=
X-Received: by 2002:adf:e84f:: with SMTP id d15mr19901455wrn.296.1588591624138; 
 Mon, 04 May 2020 04:27:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLXrksSULN1K21ZybAy6fgpYmbhD6eEdkcELZMijnpyBv2FKrL9KNlkufJoi+ijOF2QZ8H0jQ==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr19901430wrn.296.1588591623900; 
 Mon, 04 May 2020 04:27:03 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id t4sm12172583wri.54.2020.05.04.04.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 04:27:03 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] net/colo-compare.c: Only hexdump packets if
 tracing is enabled
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <8a940c893b26ec19d741d2efe929b85df559d850.1588587700.git.lukasstraub2@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1339c364-a0ee-5e21-040f-22c0c61fd59b@redhat.com>
Date: Mon, 4 May 2020 13:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8a940c893b26ec19d741d2efe929b85df559d850.1588587700.git.lukasstraub2@web.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:28 PM, Lukas Straub wrote:
> Else the log will be flooded if there is a lot of network
> traffic.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 2a4e7f7c4e..56db3d3bfc 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -483,10 +483,12 @@ sec:
>           g_queue_push_head(&conn->primary_list, ppkt);
>           g_queue_push_head(&conn->secondary_list, spkt);
>  =20
> -        qemu_hexdump((char *)ppkt->data, stderr,
> -                     "colo-compare ppkt", ppkt->size);
> -        qemu_hexdump((char *)spkt->data, stderr,
> -                     "colo-compare spkt", spkt->size);
> +        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +            qemu_hexdump((char *)ppkt->data, stderr,
> +                        "colo-compare ppkt", ppkt->size);
> +            qemu_hexdump((char *)spkt->data, stderr,
> +                        "colo-compare spkt", spkt->size);
> +        }
>  =20
>           colo_compare_inconsistency_notify(s);
>       }
>=20


