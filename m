Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B30C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692DD20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMdxxROZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692DD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEhl-00008h-Jc
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFEgy-0007uk-Je
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFEgx-00065r-JG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFEgx-00065O-FO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584699351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luvbjMONIPdToqe3xLeiXQoskPih0iczv0T0v4GDIDY=;
 b=PMdxxROZxIH86BTOYLhCmp/Nfiw+Zs5Qy8xWMDRRoSfyeg9/OFMvZMwgRZO/gouTDjHbnw
 OtyLtETFIGY0HZRxzf+aedm2T5MCKSDNhHSJQFLg95cO1KNqu+t2CkZwt46ogdnVmMLDbR
 pe4EBIYyqd8IqT1P46vaH/haCs9LJBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-xnwzP1zsNA-YZIibGHJILA-1; Fri, 20 Mar 2020 06:15:49 -0400
X-MC-Unique: xnwzP1zsNA-YZIibGHJILA-1
Received: by mail-wm1-f71.google.com with SMTP id f185so2185124wmf.8
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iaLJUwSh3dl5GpG112FsmhLtQ34BosAIELAXykxI6BM=;
 b=rYlZRnuPyvas9jZVdCrguZJuGdSZDikHsaNUJYLN8rAku9ZqZCqJdwUqNDqXB62G6Q
 l82roKLQBBB/kpOhREJOS9lbdY/XIQ8jwMrN33hoGzng5vAZtEUvTXDd+sTO19ePQJNY
 ZPDsAEondcTTr6lyWIawxMGGcOJLZSVbvO4LOFOJ8JH/LcGu2H0XxPCJwX1dJuc4H2Ol
 oV0w733Y1UFmr2eo5gHdlrMVTM1pg4xpY5KXbJOU7yKauhhMqs5YEm/aim/ssNfksfc4
 z9egHxFnJPu3+oqEsb6iubCPPd+cRA0Lg47O/tGimDMpyifHWjI98S8HGs5nBsqkGgR7
 06lQ==
X-Gm-Message-State: ANhLgQ2vBEZh49nAkpgHLauzubNZ6lDLZNQcg3YNDhXyK95FUluTRiEE
 sQKNT6TbXm3DIW6TXwVKNDzBs8WeWV5mlV41AGnmL5PcSi5BziEjz9mDF8nNRoPweOHPQCHY+11
 hi+CJRYK86liSJ2Q=
X-Received: by 2002:a1c:6285:: with SMTP id w127mr9756052wmb.133.1584699348525; 
 Fri, 20 Mar 2020 03:15:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCdAMrtfBnrP2Rt6Kc4iE3zr0OkO051Ks7Xp3LsQ6nktXs4MJa60RouxAGeJfA/2ZMSxallQ==
X-Received: by 2002:a1c:6285:: with SMTP id w127mr9756039wmb.133.1584699348339; 
 Fri, 20 Mar 2020 03:15:48 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m17sm7753942wrw.3.2020.03.20.03.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 03:15:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] python/qemu: Kill QEMU process if 'quit' doesn't work
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200313083617.8326-1-kwolf@redhat.com>
 <20200313083617.8326-3-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5b97975-2b89-3d45-0680-4df15d9452e7@redhat.com>
Date: Fri, 20 Mar 2020 11:15:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313083617.8326-3-kwolf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 9:36 AM, Kevin Wolf wrote:
> With a QEMU bug, it can happen that the QEMU process doesn't react to a
> 'quit' QMP command. If we got an exception during previous QMP
> communication (e.g. iotests Timeout expiring), we could also be in an
> inconsistent state where after sending 'quit' we immediately read an old
> response and close the socket even though the 'quit' command wasn't
> processed yet. Both cases would lead to a hanging test.
>=20
> Fix this by waiting for the QEMU process to exit after sending 'quit'
> with a timeout, and if it doesn't happen within three seconds, send
> SIGKILL.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   python/qemu/machine.py | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 183d8f3d38..c837ee8723 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -358,6 +358,7 @@ class QEMUMachine(object):
>                       if not has_quit:
>                           self._qmp.cmd('quit')
>                       self._qmp.close()
> +                    self._popen.wait(timeout=3D3)
>                   except:
>                       self._popen.kill()
>               self._popen.wait()
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


