Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E55C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E272520658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKQffMIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E272520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa3f-0004Mm-PY
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVZkX-0004BD-Az
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVZkU-0002o7-Sk
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588593540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f00XMw2WmZ2IXgswVXoqL1T0m/J+vQsMkVuxlMiMxBI=;
 b=fKQffMIKtUbIXeJlW+CKlRvF+CSSoqOCn/qAAn8k0ZRuKrz6OzDcdlI7/z8tQk2/mRzrIL
 BDi2SGtJy3Och8sGCfz0lyW8bwglbPy5BLXCfsk4fFursj54tL9XWuJoPeMVoK2IndboOy
 1xn0ssipqROUS3+c/OS3dJ3kGtmIlVA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-C6EFhInbO3aylyvzrWLYWA-1; Mon, 04 May 2020 07:58:56 -0400
X-MC-Unique: C6EFhInbO3aylyvzrWLYWA-1
Received: by mail-wr1-f71.google.com with SMTP id a12so7490835wrv.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oO/iu3UeUdTSXDym5RiLub/rV3CVtXEs+KdcrwWJw6I=;
 b=nIdUTUvDimWkDSPvORJ5GH7EDDWch3f62fsJ1HLPZN0igCk40MuzUIHjZHuMG/6f1j
 cvKBxxzM1Rk25pV0JRuXHUb+F1nArflqsB1319q7itN0BiYs2ZEE7hn+rPND2Ksy0ZKq
 hyhLisTpzMTZX3QSXu6NsWdjcP92ZMnYol0N0/TQXuWci86xX0Ef6jEin+fOg4P4uaa/
 8fd+Vmxn0b80gWsUtc2A8UNycTIz1h1eljMskPzunm1LWPX67HZWImvib+THupEHjLwL
 evYbe4M66KkpjJkFaE4ghSl19GMs9nKXc/BuvfQ0v9jk64ozbK9DoJ9Nh3N5s4kRTVDQ
 PLaQ==
X-Gm-Message-State: AGi0Puaina1ZRV7bqMz/Fzu8iqcftz80E6wKzlURXG2gr/SL3brZ22SZ
 j95QnqfaTZdtlDu4oy4d3YhGUbagPEO4U0X30P97Yv7FY4Loa+FWaqu1kpaf45nQiZNhELiEA8v
 o0LVo3TCCI7Tu4bg=
X-Received: by 2002:adf:a297:: with SMTP id s23mr19244148wra.54.1588593535676; 
 Mon, 04 May 2020 04:58:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPhlUXu8rWHPoFsD6HX7WGZCiO9akHqScGBpiWSv1QwWacrFlAogoDcsVBJPHFR4JaaqGDcQ==
X-Received: by 2002:adf:a297:: with SMTP id s23mr19244137wra.54.1588593535527; 
 Mon, 04 May 2020 04:58:55 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id d143sm13124083wmd.16.2020.05.04.04.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 04:58:54 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] net/colo-compare.c: Only hexdump packets if
 tracing is enabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <8a940c893b26ec19d741d2efe929b85df559d850.1588587700.git.lukasstraub2@web.de>
 <1339c364-a0ee-5e21-040f-22c0c61fd59b@redhat.com>
Message-ID: <02ff279b-4c6b-7137-e4f3-57716abdb2b3@redhat.com>
Date: Mon, 4 May 2020 13:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1339c364-a0ee-5e21-040f-22c0c61fd59b@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On 5/4/20 1:27 PM, Philippe Mathieu-Daud=E9 wrote:
> On 5/4/20 12:28 PM, Lukas Straub wrote:
>> Else the log will be flooded if there is a lot of network
>> traffic.
>>
>> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
>> ---
>> =A0 net/colo-compare.c | 10 ++++++----
>> =A0 1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 2a4e7f7c4e..56db3d3bfc 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -483,10 +483,12 @@ sec:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 g_queue_push_head(&conn->primary_list, ppkt)=
;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 g_queue_push_head(&conn->secondary_list, spk=
t);
>> -=A0=A0=A0=A0=A0=A0=A0 qemu_hexdump((char *)ppkt->data, stderr,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "colo-comp=
are ppkt", ppkt->size);
>> -=A0=A0=A0=A0=A0=A0=A0 qemu_hexdump((char *)spkt->data, stderr,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "colo-comp=
are spkt", spkt->size);
>> +=A0=A0=A0=A0=A0=A0=A0 if=20
>> (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_hexdump((char *)ppkt->data, stde=
rr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=
colo-compare ppkt", ppkt->size);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_hexdump((char *)spkt->data, stde=
rr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=
colo-compare spkt", spkt->size);
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 colo_compare_inconsistency_notify(s);
>> =A0=A0=A0=A0=A0 }
>>


