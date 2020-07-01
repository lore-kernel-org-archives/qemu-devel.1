Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B4920772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtwxNOE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B4920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcUu-0003jF-K5
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqcUH-0003Ja-Fg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:09:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqcUF-0006lb-1e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593608953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PRdl/KOwu970WNGXTs6OP1H1VPcrhYKynp8Ye58lM0=;
 b=GtwxNOE5dwH0opeWxE0EvSjqvt7/4UxrtEcjS7sr23cDgoylEN1s29tP2Idrmult634V4Y
 UdTrgd9dueoGqMgnB53D1X8ZshSNo+oWbKzCaewObBzjYeu7pR+QA6/nPkQ2t8QZ+t9EiF
 T4chjKwtrTyT8zrkjqH2tcIZnMu6dGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-MtObnRw-PQ6a8eCO0aJdBg-1; Wed, 01 Jul 2020 09:09:11 -0400
X-MC-Unique: MtObnRw-PQ6a8eCO0aJdBg-1
Received: by mail-wr1-f70.google.com with SMTP id p9so20489656wrx.10
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2PRdl/KOwu970WNGXTs6OP1H1VPcrhYKynp8Ye58lM0=;
 b=FYLjug0K/Tr2vTa5zNeVALyiTWgWAIxseviC3G3Xe+0LNN4fRZ3LO2VIg4+GYDqG5k
 aTBrL2a7epjBmimwur2/9wUJd7JBZfY0OD+GHwuE84g3cvuBQRYDGQkn1K0YS7e7+T8q
 Cpncv4mMxKXVI3QFe697EkYDADWn+Y/0Ch91oXZvat8D4jIRA8HJuIU5CB7SaZjmBxau
 0+/exI2TOw679G+6k1yu9xLNeGKNx9wHJ8to4niuONgiPXqfejAD1kvR5DkWWWYiH067
 xemh6fKY9w1N9XDD84OQ9l6jZDQJqY+N5/YQ9JigJHwEXdLZZyOU0W6rxQ+v0dTSESSJ
 g5WQ==
X-Gm-Message-State: AOAM531FyMIHE1THIlrzyxRYrMFMFh7cJfOBtC7AN3gnCGvW93RrXfBh
 EyD9Avh/8AVWYm4FGAGwNHH7KmPISaU/15BNBIw5OJr1qoRxKMg6QdSbNq/LB6EaPaQ5Cimffmj
 WMy3ntPjspZ7PLZc=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr26571370wme.160.1593608950486; 
 Wed, 01 Jul 2020 06:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEgUJIA2FD0TKT66SwYLUk0faW6+J68hyNZMRogkbqDuwNH5vR2YLNrRrNItkNzrB6rh2FDg==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr26571355wme.160.1593608950274; 
 Wed, 01 Jul 2020 06:09:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id f186sm7013581wmf.29.2020.07.01.06.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 06:09:09 -0700 (PDT)
Subject: Re: [PATCH v2] chardev/tcp: fix error message double free error
To: Markus Armbruster <armbru@redhat.com>, lichun <lichun@ruijie.com.cn>
References: <20200621213017.17978-1-lichun@ruijie.com.cn>
 <87zh8jbtpd.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <309b915a-9ddc-95a7-f579-7cf66a7c0253@redhat.com>
Date: Wed, 1 Jul 2020 15:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87zh8jbtpd.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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

On 01/07/20 09:06, Markus Armbruster wrote:
> lichun <lichun@ruijie.com.cn> writes:
> 
>> Signed-off-by: lichun <lichun@ruijie.com.cn>
>> ---
>>  chardev/char-socket.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index afebeec5c3..569d54c144 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr,
>>                            "Unable to connect character device %s: ",
>>                            chr->label);
>>          s->connect_err_reported = true;
>> +    } else {
>> +        error_free(err);
>>      }
>>      qemu_chr_socket_restart_timer(chr);
>>  }
>> @@ -1086,7 +1088,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>>      if (qio_task_propagate_error(task, &err)) {
>>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>>          check_report_connect_error(chr, err);
>> -        error_free(err);
>>          goto cleanup;
>>      }
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> and queued, thanks!
> 

Can you please add a note to the commit message?

    Errors are already freed by error_report_err, so we only need to call
    error_free when that function is not called.
    
and Cc qemu-stable?  Or I can queue it too since it's chardev stuff.


