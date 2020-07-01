Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DE1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA8C207F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJLSdZqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA8C207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeda-0008No-09
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeRp-0003S5-05
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:14:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeRm-0002nO-Ak
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTDIjcY8W3zr9BSp6L1ugq05qWwbERXKD+GKnkcf6ok=;
 b=XJLSdZqw84X5+Ft6H3B1d493Bpnb3jtR9pgz+KZRLDgzh/O+kUSWJ0N2VnhWAjk71HKVHG
 tRLQrLSk6/KmdVKfy6Q4KEb3sjeQMSDbd9I8fRMvTa/IWyRqMp9P5fadnObdVFVslYs3vb
 /i1BhIVuU9UyajIuY5+s6BF+8MZc8F8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-7BaJaqvUN_ip-PWOi6-LfA-1; Wed, 01 Jul 2020 11:14:47 -0400
X-MC-Unique: 7BaJaqvUN_ip-PWOi6-LfA-1
Received: by mail-wr1-f69.google.com with SMTP id h28so21039523wrc.18
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fTDIjcY8W3zr9BSp6L1ugq05qWwbERXKD+GKnkcf6ok=;
 b=IxlzeHymRxmup30mgboieymbUp5TOATlTYVzNcRA9S98ub+v6x61+H3ZM559LwOzEH
 tvuT2kFVIBD0Sdv5zAGEv5U7QFTf5kih26qiFSZVWHq/mkGcgxnKuUF1Yt0+hoAyywk6
 llP2OF3/25Nnii+SDv3Pc5biTcy0ntcgyctXGCtU2S57JgsJkN7t9tfCyyv4ucKoE2z2
 4kdREb/jfCrcp5QBfgGfsG0E+lznd8lVOPXEpeXwTl7gz1JHFIWzjv2JXHm9LPDTMIos
 gKKw7MxAZpAHJLaqfg+XegU8awRrpx0W7aAJm7nfGYXr4A3j3+2JSh7rADhIosq5yZ7V
 weBQ==
X-Gm-Message-State: AOAM5339VvavUcEWHRw2M6PFicGaILpa6GW0nzuMwXoUVEYdvyNScFj+
 58xhqYkyw5HgCK++fVgTkF+EfWuKhHvus1xv+TFk4dNNkaVgjbsryXj7Itur/0NSpnro26Bzhum
 NeqkWqNlO2HG73E8=
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr27121373wrw.197.1593616486381; 
 Wed, 01 Jul 2020 08:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFaXMG4GChkUCCK155lvEU1vPxIuAdZzyoo6H9SHUlvI3HfbagazJnapbBCuD8PrsyGkrxww==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr27121358wrw.197.1593616486135; 
 Wed, 01 Jul 2020 08:14:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d66:2ca3:22cf:9fa9?
 ([2001:b07:6468:f312:9d66:2ca3:22cf:9fa9])
 by smtp.gmail.com with ESMTPSA id k126sm8002057wme.17.2020.07.01.08.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:14:45 -0700 (PDT)
Subject: Re: [PATCH v2] chardev/tcp: fix error message double free error
To: lichun@ruijie.com.cn, armbru@redhat.com
References: <20200621213017.17978-1-lichun@ruijie.com.cn>
 <87zh8jbtpd.fsf@dusky.pond.sub.org>
 <309b915a-9ddc-95a7-f579-7cf66a7c0253@redhat.com>
 <EEB2AE3E67807845A92E2350C6F5E02E0131DC6F73@FZEX3.ruijie.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c32fe799-a4bd-d334-1764-db64a1a69794@redhat.com>
Date: Wed, 1 Jul 2020 17:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <EEB2AE3E67807845A92E2350C6F5E02E0131DC6F73@FZEX3.ruijie.com.cn>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 17:12, lichun@ruijie.com.cn wrote:
>> On 01/07/20 09:06, Markus Armbruster wrote:
>>> lichun <lichun@ruijie.com.cn> writes:
>>>
>>>> Signed-off-by: lichun <lichun@ruijie.com.cn>
>>>> ---
>>>>   chardev/char-socket.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>>>> index afebeec5c3..569d54c144 100644
>>>> --- a/chardev/char-socket.c
>>>> +++ b/chardev/char-socket.c
>>>> @@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr,
>>>>                             "Unable to connect character device %s: ",
>>>>                             chr->label);
>>>>           s->connect_err_reported = true;
>>>> +    } else {
>>>> +        error_free(err);
>>>>       }
>>>>       qemu_chr_socket_restart_timer(chr);
>>>>   }
>>>> @@ -1086,7 +1088,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>>>>       if (qio_task_propagate_error(task, &err)) {
>>>>           tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>>>>           check_report_connect_error(chr, err);
>>>> -        error_free(err);
>>>>           goto cleanup;
>>>>       }
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> and queued, thanks!
>>>
>>
>> Can you please add a note to the commit message?
>>
>>     Errors are already freed by error_report_err, so we only need to call
>>     error_free when that function is not called.
>>   
>> and Cc qemu-stable?  Or I can queue it too since it's chardev stuff. 
> Ok,  I'll post v3.

No need for that, thanks!  (My message was for Markus).

Paolo


