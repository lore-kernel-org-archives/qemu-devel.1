Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7520C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AE72067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NalfAOXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AE72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqahS-0000ZV-ML
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqagp-00009K-VS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:14:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqago-0005nV-6L
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593602045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQ5/bHeXwnWd1jfMZaTRHrFbjocAWvpemFv/3L7C24Q=;
 b=NalfAOXib3h8tV1mrLk09L+xbGzhUh+4TUR76sq57PwgQ5lLbA5OjFxYxq1zj2lwfwRS/f
 MqM07Y2ZNdvULVyXktYPY5ajwym4xcdkPwUzNLKbcpAUnNV06Mqd9xUqNuQDJHP8lVqawj
 hvIRkiUOGwoawzu+GDcrYNp+1gz1CVQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-dBQCDyqqNHGGgFamdeqKCQ-1; Wed, 01 Jul 2020 07:14:03 -0400
X-MC-Unique: dBQCDyqqNHGGgFamdeqKCQ-1
Received: by mail-ed1-f72.google.com with SMTP id 64so19079476edf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 04:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQ5/bHeXwnWd1jfMZaTRHrFbjocAWvpemFv/3L7C24Q=;
 b=Ag094PRX9G4oFJuQZK+fkmS2RF2Q2yX734vdasxZgKHLXfcpW+iget0916QntpouTu
 rY2qO9sCbNdADNuESH5/DbDZvF8oK4yIqMOBgnHDbwnNhx3vdlLXF6qLnry0G+quh+1k
 BWblmk5qEiDT8UDrt9JPNi9Ux28a1lShx1Lj1Ht/iBQ62ZbkllQphG0XmFtyl/oFG7dm
 7T/jaoHLU0+CYi1iQiA0DibzkvoC+TFCFqH05JBeZTTUdjGJKFkNJNDHo2AiP3TfWDW1
 DPunKGSRREVtPw7SO2ZNf0E0cY+WKhHcsHgMKlsBOj/0BOyoGg2/Ev69GOZPQ4JU9IOs
 otEA==
X-Gm-Message-State: AOAM532OKOS33y/TZqD5vW675E130Tskgv6MAncUBAAhKszW/bnLHKip
 lYx48iIih/KtpSuss9HqKZir7KIZ7kmcEq4hLeoL5mFzfBIhr9y6C1WnyngNUd8usiq1pt6RUCZ
 z6NnfrGqJkjo3ToU=
X-Received: by 2002:a17:906:e2ca:: with SMTP id
 gr10mr21592418ejb.81.1593602042663; 
 Wed, 01 Jul 2020 04:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7gJN14r6fai0FwPbK7gIPk0WSnnk/vryMNP3zRcAJdLgySNqSgfhWHNj5IFPFsezI8fFxTQ==
X-Received: by 2002:a17:906:e2ca:: with SMTP id
 gr10mr21592399ejb.81.1593602042477; 
 Wed, 01 Jul 2020 04:14:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id d24sm5515760edp.83.2020.07.01.04.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 04:14:01 -0700 (PDT)
Subject: Re: Race with atexit functions in system emulation
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
References: <87v9j7qyuh.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06ce5fd3-01fe-0d93-7147-8195e329c449@redhat.com>
Date: Wed, 1 Jul 2020 13:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87v9j7qyuh.fsf@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 13:05, Alex Bennée wrote:
> Should we maybe defer the exit to once the main loop has been exited
> with a some sort of vmstop? Or could we have an atexit handler that
> kills the main thread?

Yes, I think the way to do "exit" is to use
qemu_system_shutdown_request.  Possibly halt the CPU?  This way you can
also obey -no-shutdown and give the user an occasion to inspect the
program.  You can add a global to pass back the exit code.

Alternatively, replay_finish could just take the lock.

Paolo


