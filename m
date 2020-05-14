Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7953FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49604206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDfMJRXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49604206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ76I-0007NW-FI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ72b-0001A1-9m
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:08:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ72Z-0004BU-LM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YktV8Jjv+RFhP+q0aGBN/iX3gZKOLcpwmQN4AG/uZDw=;
 b=iDfMJRXOaMk2EJiV1hMBAptEsqYBOxrKYU0Xzwk97/hOqDqblGRZ4z4L4IubbPhVTk44DV
 Y8ndnDxA6Vjr16s1+hLlf/2UzFLD42WUKBQeswqwxM67/HKFnoAD5CU0kUL6wl8jFLJHdu
 xD0LxRHaObllzoXUzAxBm450mKlj/pE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-AJrC83wwNPKSegM9_xttsw-1; Thu, 14 May 2020 02:08:17 -0400
X-MC-Unique: AJrC83wwNPKSegM9_xttsw-1
Received: by mail-wm1-f69.google.com with SMTP id a67so6782142wme.6
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YktV8Jjv+RFhP+q0aGBN/iX3gZKOLcpwmQN4AG/uZDw=;
 b=WFwgh56PsweiJ6U9tObGY4fHK5AyKPsGBUhppvIEIzid/xS5QqtddMhqaYdT0tMmT1
 afuz5k1GozOhVuy9p8kRhCstORMYGCt1mYC0Q0NiGOs0/H4PY1E0XLkHWKrbQ0sQJjQ4
 ePRHdqzV3hWXE8DhwnabYVWAww5P5A0mWrvQ3/YVd2DdWWPZdOZAMI4cZItZ4WFES0+D
 WTfdlVf05fV8t80/u0RWnyA3Q8Y5NPST10sRfGlnOy26pNHdSi7lVuR5W6VL3cKZ/PhT
 wnCyOm5lCa9EBGSWHN/hZHGhWNlLYdcjlF51vRTsNGs//6yK+PoJUan0OwRdgwyKI3c1
 KN/Q==
X-Gm-Message-State: AOAM530X3xP8DJ1IeDAh4Bs7QbVqJghEm0pUSmleLQMcrq9QvWE5VbJ7
 Fd+o3M5m3Bc2b65SQ10hQySgghAyQFrQCJp0rUHxmMseDyNVRMG/NN3gmcXuEclMeglSOr43vrC
 BGOtrp7INtzHNAnk=
X-Received: by 2002:a5d:4651:: with SMTP id j17mr3206798wrs.50.1589436495975; 
 Wed, 13 May 2020 23:08:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjiLJuRp3PQZebPclIpW2GrFr0HGu/5dFXeOP7rPFR57jEnRxcIH70037nojvoal5uxIMXwA==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr3206767wrs.50.1589436495721; 
 Wed, 13 May 2020 23:08:15 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s17sm37548986wmc.48.2020.05.13.23.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:08:15 -0700 (PDT)
Subject: Re: [PATCH RFC 23/32] python//machine.py: reorder __init__
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-24-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fbe1ee7-2077-0bd1-370f-96bb526db9cf@redhat.com>
Date: Thu, 14 May 2020 08:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-24-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:
> Put the init arg handling all at the top, and mostly in order (deviating
> when one is dependent on another), and put what is effectively runtime
> state declaration at the bottom.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/lib/machine.py | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index 6a4aea7725..beb31be453 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -80,38 +80,43 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>           @param socket_scm_helper: helper program, required for send_fd_scm()
>           @note: Qemu process is not started until launch() is used.
>           '''
> +        # Direct user configuration
> +
> +        self._binary = binary
> +
>           if args is None:
>               args = []
> +        # Copy mutable input: we will be modifying our copy
> +        self._args = list(args)
> +
>           if wrapper is None:
>               wrapper = []
> -        if name is None:
> -            name = "qemu-%d" % os.getpid()
> -        if sock_dir is None:
> -            sock_dir = test_dir
> -        self._name = name
> +        self._wrapper = wrapper
> +
> +        self._name = name or "qemu-%d" % os.getpid()
> +        self._test_dir = test_dir
> +        self._sock_dir = sock_dir or self._test_dir
> +        self._socket_scm_helper = socket_scm_helper
> +
>           if monitor_address is not None:
>               self._monitor_address = monitor_address
>               self._remove_monitor_sockfile = False
>           else:
>               self._monitor_address = os.path.join(
> -                sock_dir, f"{name}-monitor.sock"
> +                self._sock_dir, f"{self._name}-monitor.sock"
>               )
>               self._remove_monitor_sockfile = True
> +
> +        # Runstate
>           self._qemu_log_path = None
>           self._qemu_log_file = None
>           self._popen = None
> -        self._binary = binary
> -        self._args = list(args)     # Force copy args in case we modify them
> -        self._wrapper = wrapper
>           self._events = []
>           self._iolog = None
> -        self._socket_scm_helper = socket_scm_helper
>           self._qmp_set = True   # Enable QMP monitor by default.
>           self._qmp = None
>           self._qemu_full_args = None
> -        self._test_dir = test_dir
>           self._temp_dir = None
> -        self._sock_dir = sock_dir
>           self._launched = False
>           self._machine = None
>           self._console_index = 0
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


