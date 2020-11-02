Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB33EC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA7F22245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMJM/D1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA7F22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcn7-0003VC-LB
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZclx-0002Ts-Hu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZclu-0000zY-Tf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604334808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DoZ00KR8rZBrpYasgTIU9RE2GQv19L184y+3RVMTko=;
 b=KMJM/D1+SSmPRzzbANdYbHmZpjvpRcJQyaI3iokMgJrfZh4R/ZRR5FgpbIUmC+ACc2ZQRQ
 BbSSrU5Mf8B3qx5lZzrWcmhuqiKoC1UQsK4X4e0VH3j94qcDuuO1yXSdaDm9BpvehQRz1p
 UTYbD7YDo6d5JjNCPutZEw5aXefH8DA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-BxKXzPE2PZ-r9nUFzgOtDA-1; Mon, 02 Nov 2020 11:33:26 -0500
X-MC-Unique: BxKXzPE2PZ-r9nUFzgOtDA-1
Received: by mail-wr1-f72.google.com with SMTP id t14so6684291wrs.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/DoZ00KR8rZBrpYasgTIU9RE2GQv19L184y+3RVMTko=;
 b=pI9FrDEl5h++us3j1Ak5Cme9GEEa4I3tLYq9C+Sh7iRcQ+6HuroWrlf6Z14qS39/d8
 dlgA2DSZXClE5+H9iss3u4pAhTS4xEPQoFUOK7fVK2hmVjEHtqeA/aeof20Gp9Rm00Td
 /Paz5rkCXT1F3Y9tj86xLDdDuub5tAkVKWvR13sxiPITvLy3eZfaca0DejrYeToljTu6
 TM9yIluDZF+sy3V9w8/YX+dCLP0wOqFmL+x+w+oKs+xU5EqA9xt5TZ2SKg+j3Q8bhjsU
 XOAJVAxHuWZlbJbLAUYvccqBw85Fzv0GFu1dJZ4+87khFyhvfzefmcU6f/CC0wSmk2HA
 fFBg==
X-Gm-Message-State: AOAM53301WJ+OrRRZEobpyvEPqNtdLWW4bgnZ1y5uTdPQFD2IyX0l/iN
 jlNQkxeKhg14Yojw7PDp4GNmn6CRPMrjTzooKmDti2IyUKiCCE33ijbqTWXJBk12Q2Omh5+5Ukx
 oC2P0d0Zf3ixiZ4s=
X-Received: by 2002:a1c:a555:: with SMTP id o82mr18909767wme.188.1604334805221; 
 Mon, 02 Nov 2020 08:33:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylCbfq4odluc/xXrm5VPU/gQLkkCM8fW9jcP/Gq1G8XyoN/qpvD3RypFbYfp5kWeNiDpOt9A==
X-Received: by 2002:a1c:a555:: with SMTP id o82mr18909749wme.188.1604334804970; 
 Mon, 02 Nov 2020 08:33:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x22sm18019411wmj.25.2020.11.02.08.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 08:33:24 -0800 (PST)
Subject: Re: [PATCH 05/29] vl: split various early command line options to a
 separate function
To: Igor Mammedov <imammedo@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201027182144.3315885-6-pbonzini@redhat.com>
 <20201102163022.416bd0fa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c310973-79ee-34c8-d524-03853d943d99@redhat.com>
Date: Mon, 2 Nov 2020 17:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102163022.416bd0fa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/20 16:30, Igor Mammedov wrote:
> On Tue, 27 Oct 2020 14:21:20 -0400
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> Various options affect the global state of QEMU including the rest of
>> qemu_init, and they need to be called very early.  Group them together
>> in a function that is called at the beginning.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  softmmu/vl.c | 202 ++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 113 insertions(+), 89 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
> [...]
>> +
>> +static void qemu_maybe_daemonize(const char *pid_file)
> 
> why it's _maybe_ ?
> It looks to me as just deamonize (or die which could be omitted)

Because os_daemonize() in turn only daemonize if the corresponding
option was set:

    void os_daemonize(void)
    {
        if (daemonize) {
            pid_t pid;
            int fds[2];
    ...

Paolo

>> +{
>> +    Error *err;
>> +
>> +    os_daemonize();
>> +    rcu_disable_atfork();
>> +
>> +    if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
>> +        error_reportf_err(err, "cannot create PID file: ");
>> +        exit(1);
>> +    }
>> +
>> +    qemu_unlink_pidfile_notifier.notify = qemu_unlink_pidfile;
>> +    qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
>> +}
> [...]
> 


