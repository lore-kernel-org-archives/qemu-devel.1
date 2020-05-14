Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D43C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CC320575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/qE3Z2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CC320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7CU-0008Ax-TT
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6vm-0003qE-5E
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:01:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6vk-00036C-G6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeDwlGWx3ZqhE8D/gGBgtPLp37FytOeHufMEx63Pq9Y=;
 b=C/qE3Z2Vvv9M2k1dvsPk8nS1Ttw4UJseHemJDPpNyToixdKglEkMDIo8lZMGOSo+Cg22CL
 yw51Z9WMXz9ODNfML86c51b7GI9YLxMzvYacxEVAlxYErwL+nCOz8gwDCfwWVXKlXlrhED
 vK2rQ/bHKYMeOktujhDyIEqFw25nr8s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-UbFz24cyMxW_oTRIgA0Eeg-1; Thu, 14 May 2020 02:01:07 -0400
X-MC-Unique: UbFz24cyMxW_oTRIgA0Eeg-1
Received: by mail-wr1-f71.google.com with SMTP id z10so1015722wrs.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BeDwlGWx3ZqhE8D/gGBgtPLp37FytOeHufMEx63Pq9Y=;
 b=ZXrphdDPVIhnaOXwLL+9mZwwYQM4mOitXWpyBQeS61/cia1cMoK9iFvEQLrPxjMi5r
 DyHFuYEuseMZCEcQrT11HbJ4MZnRatnAYtglQh6lQHCBrBubail8CePsjL9LWBIfdIXX
 E4w8/c3ufbADeUEbpPo2z5GXc7FIb9UrcQVKA2lhcewH//fVH9wfm1RIyTzt03WH9jT8
 0oNUw8vnghZH12RxEsG2lB4CyRyBy4w+8XzqwH7xLoLKMdLqV7k13ayLI83hPxseNWDt
 /eCGIe8roPZBSbpoRKTws9j/uFRVxaPNzsxZJBDBusK/He4Nyt3TOXr2LcqqwlkPnUvv
 MsFQ==
X-Gm-Message-State: AOAM532ou0dgVBKiZQc001MyhgJoBldCAGHAPfkrN5/aloZFFor+Wlem
 9zTta/R774vwHBTFkndqPqMi4t76vqZ3ETd8v27ujtAJ6kJbyId/XoCLX9l+IbMb8VfUPaNmgN0
 cv66ZJf6AsOt4u4I=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr3445831wrw.5.1589436065261;
 Wed, 13 May 2020 23:01:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZbfmabApQtCK4F/NHKEvGC+BQU4tfiPPFb869OY+EWmXR59MvZzFEzgsjblHgk/5cDt+4Pw==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr3445802wrw.5.1589436064996;
 Wed, 13 May 2020 23:01:04 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t6sm14418940wma.4.2020.05.13.23.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:01:04 -0700 (PDT)
Subject: Re: [PATCH RFC 11/32] python/qemu/lib: remove Python2 style super()
 calls
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-12-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05a73825-eef9-57b5-c782-746388f5a27f@redhat.com>
Date: Thu, 14 May 2020 08:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-12-jsnow@redhat.com>
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
> Use the Python3 style instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   python/qemu/lib/machine.py |  2 +-
>   python/qemu/lib/qtest.py   | 15 +++++++--------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index 4b260fa2cb..b2f0412197 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -55,7 +55,7 @@ def __init__(self, reply):
>               desc = reply["error"]["desc"]
>           except KeyError:
>               desc = reply
> -        super(MonitorResponseError, self).__init__(desc)
> +        super().__init__(desc)
>           self.reply = reply
>   
>   
> diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
> index 53d814c064..7943487c2b 100644
> --- a/python/qemu/lib/qtest.py
> +++ b/python/qemu/lib/qtest.py
> @@ -101,29 +101,28 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
>               name = "qemu-%d" % os.getpid()
>           if sock_dir is None:
>               sock_dir = test_dir
> -        super(QEMUQtestMachine,
> -              self).__init__(binary, args, name=name, test_dir=test_dir,
> -                             socket_scm_helper=socket_scm_helper,
> -                             sock_dir=sock_dir)
> +        super().__init__(binary, args, name=name, test_dir=test_dir,
> +                         socket_scm_helper=socket_scm_helper,
> +                         sock_dir=sock_dir)
>           self._qtest = None
>           self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
>   
>       def _base_args(self):
> -        args = super(QEMUQtestMachine, self)._base_args()
> +        args = super()._base_args()
>           args.extend(['-qtest', 'unix:path=' + self._qtest_path,
>                        '-accel', 'qtest'])
>           return args
>   
>       def _pre_launch(self):
> -        super(QEMUQtestMachine, self)._pre_launch()
> +        super()._pre_launch()
>           self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
>   
>       def _post_launch(self):
> -        super(QEMUQtestMachine, self)._post_launch()
> +        super()._post_launch()
>           self._qtest.accept()
>   
>       def _post_shutdown(self):
> -        super(QEMUQtestMachine, self)._post_shutdown()
> +        super()._post_shutdown()
>           self._remove_if_exists(self._qtest_path)
>   
>       def qtest(self, cmd):
> 


