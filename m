Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9311EC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD762076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dod27rXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD762076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcdc-0006Xa-GQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRccx-00065a-S3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRccx-00046q-Dw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:14:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRccx-000437-0b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587651293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNoViXQYHOARPJuwhBLR6nEnbcMpvKMZVPBVGC0dMkY=;
 b=Dod27rXVOpOi2z3ZgmDdM+zFHM9VAPFv45R99p3ytETc6dkL65DUmW2/PKla/5EYYzZQKt
 pRRG3MnUkxSffZ32s+0Zpb6Vdi5KK1GePWvLW6LDNruWPWKj75Lwmi1Ir+yQM4lUhRGkL3
 axIAH6mUamPfn/J+VusGlXA82s/OzQE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-RcMT75apMJSqGc4ks3K4mA-1; Thu, 23 Apr 2020 10:14:52 -0400
X-MC-Unique: RcMT75apMJSqGc4ks3K4mA-1
Received: by mail-wr1-f69.google.com with SMTP id a3so2934078wro.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 07:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gNoViXQYHOARPJuwhBLR6nEnbcMpvKMZVPBVGC0dMkY=;
 b=Qn1lSqJmAIw8FPCnYZwffJWf+R72S+aB6XAeNITHtqHEXNWJ5UxHS0ZlHhJzHQfaN5
 8miMfPFgchgNuitP+w6+1ZDHJNKawL/RRpGiueYGgqdcCsCOR6ifTLFa8NTZeDTdWN72
 eVv8CXQI0P0131xKQN+rGNaPGNm1z28ILAhvrjcRR5iYlh7DEZW24wX9R2qIr/MctQFX
 7YOg92YsTYh4WivI5afO4fsXCdnKsID9qK7lSkluSaDHQsLz0sxOo1DjZ7wc9542Hxn0
 QbMmkDB9TsxB3RqQrLDl/zQRMt1onjvs+HnNcSLUVjdpQAPS2vVF+MSU2wm2EfaujD1k
 Gaxg==
X-Gm-Message-State: AGi0PuZ/tgRjaBPxzeSNGpHeOPBrFLNBOrc+p/VUYMi731PGrUQpOGp1
 8n3MSF5eTBYPEVFEofiZAqOm0WrdYQFAvy5yuFop+sHas8YS3BCLbNvLU32lFB9Asx8iwbUL5tC
 /mms5h9eJD5nr7js=
X-Received: by 2002:a5d:490f:: with SMTP id x15mr4986159wrq.37.1587651291023; 
 Thu, 23 Apr 2020 07:14:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLOfvVNFq8D0pzdqXmGqc9ZDkzB/baKGvqriD9VwBAG4tjFBUX0GPxccwaDTBxM8nhCKWKH1w==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr4986124wrq.37.1587651290816; 
 Thu, 23 Apr 2020 07:14:50 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d133sm4452990wmc.27.2020.04.23.07.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 07:14:49 -0700 (PDT)
Subject: Re: [PATCH RESEND v6 06/36] monitor: destaticize HMP commands
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <3dc3603df5b83576c7ec65589f144d44419cee52.1587614626.git.elena.ufimtseva@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3cca22d6-349c-10e0-c0ff-9c75f32e56e2@redhat.com>
Date: Thu, 23 Apr 2020 16:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dc3603df5b83576c7ec65589f144d44419cee52.1587614626.git.elena.ufimtseva@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Why 'destaticize HMP commands'?

On 4/23/20 6:13 AM, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hmp-commands.hx            |  4 +-
>   monitor/misc.c             | 76 +++++++++++++++++++-------------------
>   monitor/monitor-internal.h | 38 +++++++++++++++++++
>   3 files changed, 78 insertions(+), 40 deletions(-)


