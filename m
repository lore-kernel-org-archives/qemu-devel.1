Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C56C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C33F208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWUOcPjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeoK-0006mC-Ip
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSenS-0006GN-Fr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSenP-0004XD-VC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602674293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpuAjCDFMBWYAfANmHitKJK20UhxVwuW+QDkbbKiNBA=;
 b=NWUOcPjswqlegLgZd9697TMwRTDb1xGLqUJAebKirOnOr99qOzPUfaihs39o0cYDR6uKS5
 b6k4XyufpsYx5+ReDO5RsKGCM+WFxNESuDCj0vtZCbZQIluWP3pzShS8aD6fhtYH4Y4H1y
 MTjhqOsWAK6cQVTw7SoZvo8zAw4cCfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-U4euK33XPHGAmbHrk4Pv3g-1; Wed, 14 Oct 2020 07:18:10 -0400
X-MC-Unique: U4euK33XPHGAmbHrk4Pv3g-1
Received: by mail-wm1-f72.google.com with SMTP id z7so498064wme.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KpuAjCDFMBWYAfANmHitKJK20UhxVwuW+QDkbbKiNBA=;
 b=kGZkUBdx6Gbetbjuo9zrx/bG0cuxhKTLBQb1TkYnjz2e+QrAPciXOkBi6lmQrslTIt
 /Ns45X0NXhWtTetT9ZeF5/RanJTHYfgvOCk33GrN1R9Ju/n72WUzGIriO+bgqVnSzx3S
 tI9cYOpBaEg5elyE+WVAia8/2SSvnqnkCDyGKJYM6XMLwov9GuElRKfDil9lZ3xbK2Is
 yT3SOJNU/+m79z9auPHnYtUguCIpuv3+HWRDagzPOjPkGGeJJh3b977UadFVziLwmMDj
 u72Ig1cCWkmVX1wyB3Et6GMGHHujR3NIbcLUsAgEDmxtf6dyMarNHlzZ2xYeEvSqEDZ7
 XrMA==
X-Gm-Message-State: AOAM532VkmhXNHrwmEtMScu6wUsga1jfbz9iygFJgBpF1Z09w0f/J/BV
 UbdBBWIg+ub+mM8ACyCbCWmhFSLjVrMTKRC6c4eWZ/+Xxt8+V4Q43JDLF5KALAx2JIWcc6z2cXh
 fj9vJXYSqm5WZ2vs=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr4739875wrq.270.1602674288704; 
 Wed, 14 Oct 2020 04:18:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcTkXtfn5CGcxVkle9v5W1DxBzYTu1MTRzwOGex7wi+McjNnOcFSTIf8edNXQ2aIgYv+pp4A==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr4739847wrq.270.1602674288390; 
 Wed, 14 Oct 2020 04:18:08 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l5sm4535157wrq.14.2020.10.14.04.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 04:18:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] qga: add ssh-{add,remove}-authorized-keys
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
 <20201013202502.335336-3-marcandre.lureau@redhat.com>
 <af872421-2215-72e5-77a2-7d496325c413@redhat.com>
 <CAMxuvazo_3pJzwCRkwjaLro2h=SR8xzJ3XFfDcFx_xtDfGOAtQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <426ad5c6-3063-4604-49bf-78236d5a06b4@redhat.com>
Date: Wed, 14 Oct 2020 13:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvazo_3pJzwCRkwjaLro2h=SR8xzJ3XFfDcFx_xtDfGOAtQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:37 AM, Marc-André Lureau wrote:
> On Wed, Oct 14, 2020 at 1:14 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>> On 10/13/20 10:25 PM, marcandre.lureau@redhat.com wrote:
>>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>>> index cec98c7e06..50e2854b45 100644
>>> --- a/qga/qapi-schema.json
>>> +++ b/qga/qapi-schema.json
>>> @@ -1306,3 +1306,35 @@
>>>    ##
>>>    { 'command': 'guest-get-devices',
>>>      'returns': ['GuestDeviceInfo'] }
>>> +
>>> +##
>>> +# @guest-ssh-add-authorized-keys:
>>> +#
>>> +# @username: the user account to add the authorized key
>>> +# @keys: the public keys to add (in OpenSSH format)
>>
>> You use plural but the code only seems to add (remove) one key
>> at a time.
> 
> Uh, what makes you believe that?

The code in your patch:

+static bool
+check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
+{
+    size_t n = 0;
+    strList *k;
+
+    ERRP_GUARD();
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (!check_openssh_pub_key(k->value, errp)) {
+            return false;
+        }
+        n++;
+    }
+
+    if (nkeys) {
+        *nkeys = n;
+    }
+    return true;
+}

> 
>>
>> 'OpenSSH format' is confusing. From sshd(8):
>>
>>     Each line of the file contains one key (empty lines and lines
>>     starting with a ‘#’ are ignored as comments).
>>
>>     Public keys consist of the following space-separated fields:
>>
>>       options, keytype, base64-encoded key, comment.
>>
>>     The options field is optional.
>>
>>     Note that lines in this file can be several hundred bytes long
>>     (because of the size of the public key encoding) up to a limit
>>     of 8 kilobytes, which permits RSA keys up to 16 kilobits.
>>
>>     The options (if present) consist of comma-separated option
>>     specifications.  No spaces are permitted, except within double
>>     quotes.
>>
>> @openssh_authorized_key_line is ugly, maybe use @authorized_key
>> to make it clearer?
> 
> Why? the name of the function already implies we are talking about
> authorized keys. The documentation says it's a public key in openssh
> format (the ones you expect in ~/.ssh/authorized_keys files)

OK then.

> 
> Yes the format isn't very well defined, so I did simple sanity checks.
> After all, people usually append keys with shell >>. I can't find a
> common command to do it with some checking.


