Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E2A206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASEXmpYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E2A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ74R-00046E-Le
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6yO-0000fH-Qe
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:04:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6yN-0003RW-VY
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGW3RUch33ya2J1J5/pynTT6T/7O/1Cf3BmPxfN1/Ro=;
 b=ASEXmpYgLZnptp/e/bE44pK0RqCkV2/Tt5fRpDJkiWqEPlEIGtui/zThtNda3f0H7pzWg6
 gwspQCDK9sNxuHOpg0qRGiQj2Y0dyRCdl06pM8DksPFz/kr4OTtAnvJ3QJujwe6c0vHGsP
 V3nfMQAC6U6Dy+89Me6vj88jmXATet4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Xm2ofBUuPymrjP4v4BRx5w-1; Thu, 14 May 2020 02:03:57 -0400
X-MC-Unique: Xm2ofBUuPymrjP4v4BRx5w-1
Received: by mail-wm1-f71.google.com with SMTP id x11so3316507wmc.9
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MGW3RUch33ya2J1J5/pynTT6T/7O/1Cf3BmPxfN1/Ro=;
 b=gza9fpLByKc72ELZODCZ2bPKt2kjZdzF3U5y+Gc5fTYi6xt2td2URobSs0KCVx3Jsb
 5xs6aMWgYzjvOqfWNoSX++qDsA3iDA0abV6glNWXjzdvaRNEQ/T2EfHP8sxn1GwEy5G4
 zyIRVxtxWh9Os6ryPLsQ7ihWrrdpHamFs+O69StPsbO+LHydn/evgD8XPugDLA0bcJJt
 GRzYP+zIYLys2Hv8rOHWWYyk4VkejaeFdsKna4tw1QHXbzzRBlYQz2QNFeCSVIc9RQLT
 A1wywTCx5NmOYM4+OdEDq7jQL+iDbS1yi3WWkyG166xAZTFC+JhodrwxxKBE3svuk+oo
 Nexw==
X-Gm-Message-State: AOAM533yFSdAyG3Ab65imSk3msskeaUFLryh06valx0rJpsjr5HE4oNZ
 dR5BVimLsZ4wNW3uzNZWa/RSRTGzjBfAeQF0vkD/NasZkmgOaoCEsM6GQdQFXK5higE2tyQLKJp
 zgC5+2BgIPrksjMQ=
X-Received: by 2002:adf:f102:: with SMTP id r2mr3205092wro.376.1589436235994; 
 Wed, 13 May 2020 23:03:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhIPmUPnq6kT3Jj+dU3R6+XdYS+5q/g9bfOvbMypbYCCSeiB64xwKPw3aidwqMW7o7aVyYXA==
X-Received: by 2002:adf:f102:: with SMTP id r2mr3205067wro.376.1589436235790; 
 Wed, 13 May 2020 23:03:55 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d9sm14724563wmd.10.2020.05.13.23.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:03:55 -0700 (PDT)
Subject: Re: [PATCH RFC 16/32] python//qmp.py: re-absorb MonitorResponseError
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-17-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1fcd2bd-bb9c-3c5c-a625-11710c9a0c2b@redhat.com>
Date: Thu, 14 May 2020 08:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-17-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
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
> When I initially split this out, I considered this more of a machine
> error than a QMP protocol error, but I think that's misguided.
> 
> Move this back to qmp.py and name it QMPResponseError. Convert
> qmp.command() to use this exception type.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   python/qemu/lib/machine.py    | 15 +--------------
>   python/qemu/lib/qmp.py        | 17 +++++++++++++++--
>   scripts/render_block_graph.py |  4 ++--
>   3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index 2f94c851ed..c31bf7cabb 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -48,19 +48,6 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
>       """
>   
>   
> -class MonitorResponseError(qmp.QMPError):
> -    """
> -    Represents erroneous QMP monitor reply
> -    """
> -    def __init__(self, reply):
> -        try:
> -            desc = reply["error"]["desc"]
> -        except KeyError:
> -            desc = reply
> -        super().__init__(desc)
> -        self.reply = reply
> -
> -
>   class QEMUMachine:
>       """
>       A QEMU VM
> @@ -433,7 +420,7 @@ def command(self, cmd, conv_keys=True, **args):
>           if reply is None:
>               raise qmp.QMPError("Monitor is closed")
>           if "error" in reply:
> -            raise MonitorResponseError(reply)
> +            raise qmp.QMPResponseError(reply)
>           return reply["return"]
>   
>       def get_qmp_event(self, wait=False):
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index 911da59888..82f86b4e45 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -61,6 +61,19 @@ class QMPTimeoutError(QMPError):
>       """
>   
>   
> +class QMPResponseError(QMPError):
> +    """
> +    Represents erroneous QMP monitor reply
> +    """
> +    def __init__(self, reply: QMPMessage):
> +        try:
> +            desc = reply['error']['desc']
> +        except KeyError:
> +            desc = reply
> +        super().__init__(desc)
> +        self.reply = reply
> +
> +
>   class QEMUMonitorProtocol:
>       """
>       Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP) and then
> @@ -250,8 +263,8 @@ def command(self, cmd, **kwds):
>           Build and send a QMP command to the monitor, report errors if any
>           """
>           ret = self.cmd(cmd, kwds)
> -        if "error" in ret:
> -            raise Exception(ret['error']['desc'])
> +        if 'error' in ret:
> +            raise QMPResponseError(ret)
>           return ret['return']
>   
>       def pull_event(self, wait=False):
> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
> index 8048d9fbbe..332ab49a91 100755
> --- a/scripts/render_block_graph.py
> +++ b/scripts/render_block_graph.py
> @@ -26,7 +26,7 @@
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
>   from qemu.lib import QEMUMonitorProtocol
> -from qemu.lib.machine import MonitorResponseError
> +from qemu.lib.qmp import QMPResponseError
>   
>   
>   def perm(arr):
> @@ -103,7 +103,7 @@ def command(self, cmd):
>           reply = json.loads(subprocess.check_output(ar))
>   
>           if 'error' in reply:
> -            raise MonitorResponseError(reply)
> +            raise QEMUResponseError(reply)
>   
>           return reply['return']
>   
> 


