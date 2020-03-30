Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD826206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVn+STio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD826206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2Y6-0003Dv-3L
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 18:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJ2XS-0002oS-08
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJ2XP-0006Xu-9X
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:05:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJ2XN-0006Ud-Vx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585605939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sVmu3XG6lUbj/FSulAWU1kll/8q8UjGkhbcYLj1m7s=;
 b=eVn+STioPrUbkiBfOpxeykMhwB7TIyV6RfdzPgnWlbmkLCyYxvq6I/MlnRCZz/RRKIMgr2
 NIctH992orLG6bNeUD4FzljUrHhFFWVaj1yUWC4C7rOG3+2RV43DSONm9WViXZBma4W/QP
 qzbtEUrzT8X3yElj9oMi5iDu5RwLPTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-4kHED2VgNXGo2SuaWlxtqA-1; Mon, 30 Mar 2020 18:05:37 -0400
X-MC-Unique: 4kHED2VgNXGo2SuaWlxtqA-1
Received: by mail-wm1-f70.google.com with SMTP id v8so187760wml.8
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 15:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2sVmu3XG6lUbj/FSulAWU1kll/8q8UjGkhbcYLj1m7s=;
 b=DohHImkvKGHHq7u/ZV4OH0JTrRjIZZKb3h+Cd+iqPecbzZqyPS2zK8+1Mt9WECkZSm
 f6EBpebOkYRWbYOqGToSO86wv+KuH3H+ra2MOEwQhn34Q6BkffBi4Vf0sJSZmFfB/kPC
 nHKUwrfFMDnMuN0K328Bwx4AZ1huXQCZ99qmY10MlNwcygJX4Jj/uuBq/GQv5xRVTjkL
 biL2yBD5F27LExuJuh2v4XEGupfLtvJnjjvpHwtl4xqZ+mAFjbtlDURjZev46dAN/sFO
 HkR43erGNQ77APFgBpZMxgcF9soWC3KNn6BNc52GrZ0QccdjFH9wwbouSHIKCOZWRuWD
 E1wg==
X-Gm-Message-State: ANhLgQ1vgKfECxk+EsVETl4vJZApEfPe+BgL34Kd4SiMvSVnavI2raCW
 aPAxNVhp9UilMdbENuOvWOTTn995uS9yob9Tt0lW6ZwmWfGZhDg5pEcLBoAyrzhF8zFLXoqNbk/
 m1z41wNbse6+H6c8=
X-Received: by 2002:a1c:2404:: with SMTP id k4mr180606wmk.87.1585605936404;
 Mon, 30 Mar 2020 15:05:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvHIKSrCM7oMo1orwC0LWKAAPU5IjpTs2I8fAl69jTNcYc/w4+j7oXjzy+Yh1sKVLzczZTuaQ==
X-Received: by 2002:a1c:2404:: with SMTP id k4mr180588wmk.87.1585605936179;
 Mon, 30 Mar 2020 15:05:36 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s11sm24745439wrw.58.2020.03.30.15.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 15:05:35 -0700 (PDT)
Subject: Re: linux-user: keep the name-ending parenthesis in /proc/self/stat
To: Brice Goglin <Brice.Goglin@inria.fr>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <f7720d36-a5ea-ae13-220a-2e436e6a22a4@inria.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f2cb9a1-00aa-cc59-d685-2c88e6f986c7@redhat.com>
Date: Tue, 31 Mar 2020 00:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f7720d36-a5ea-ae13-220a-2e436e6a22a4@inria.fr>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 9:07 PM, Brice Goglin wrote:
> When the program name is very long, qemu-user may truncate it in
> /proc/self/stat. However the truncation must keep the ending ") "
> to conform to the proc manpage which says:
>      (2) comm  %s
>             The  filename of the executable, in parentheses.  This
>             is visible whether or not the  executable  is  swapped
>             out.
> 
> To reproduce:
> $ ln -s /bin/cat <filenamewithmorethan128chars>
> $ qemu-x86_64 ./<filenamewithmorethan128chars> /proc/self/stat
> 
> Before the patch, you get:
> 1134631 (<filenametruncated>0 0 0 0 0 0 0 0 ...
> After the patch:
> 1134631 (<filenametruncat>) 0 0 0 0 0 0 0 0 ...
> 
> This fixes an issue with hwloc failing to parse /proc/self/stat
> when Ludovic Courtes was testing it in guix over qemu-aarch64.
> 
> Signed-off-by: Brice Goglin<Brice.Goglin@inria.fr>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5af55fca78..a1126dcf5b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7305,7 +7305,10 @@ static int open_self_stat(void *cpu_env, int fd)
>           snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>         } else if (i == 1) {
>           /* app name */
> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
> +        len = snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
> +        if (len >= sizeof(buf))
> +          /* bring back the ending ") " that was truncated */
> +          strcpy(buf+sizeof(buf)-3, ") ");

Maybe we can avoid the sprintf() call:

-- >8 --
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7305,7 +7305,11 @@ static int open_self_stat(void *cpu_env, int fd)
          snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
        } else if (i == 1) {
          /* app name */
-        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
+        char *ptr = buf;
+
+        *ptr++ = '(';
+        ptr = stpncpy(ptr, ts->bprm->argv[0], sizeof(buf) - 3);
+        strcpy(ptr, ") ");
        } else if (i == 27) {
          /* stack bottom */
          val = start_stack;
---

>         } else if (i == 27) {
>           /* stack bottom */
>           val = start_stack;
> 


