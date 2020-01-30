Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609E22083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJ/v4UAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609E22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIMh-00052S-KA
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixILx-0004WG-T5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixILv-0003YR-Hq
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:32:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixILv-0003VV-7O
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580423518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgHUGLtjWZ9vDF4bHTbCnHR0fMXtXmfycNAIw98OBy0=;
 b=MJ/v4UAKCVUb3tUJym5VSyV0QzN6Fneg90DptndyWD1tX6Tth1EcupmWp5ds3lm98MhZ/K
 KvGLDZNF8AGjEFgoHHCDIxmPzR4J3HktgEXMpEDcdalDeOU057N7FaccirIApZbhEQvpXZ
 SGna3uJen5Y3zHX2yvCApOersYjaZ/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-3OwqCHK5O5aP9lMIBR5cpQ-1; Thu, 30 Jan 2020 17:31:54 -0500
Received: by mail-wm1-f69.google.com with SMTP id y24so1328786wmj.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QgHUGLtjWZ9vDF4bHTbCnHR0fMXtXmfycNAIw98OBy0=;
 b=QCA6gSshwja7hL+4tAaQz01+kYZMuQTaiTk1n/7NRa+/4O3RDWtlXvGk0thajZNlmB
 d7pp9j7HSLKUv9F9qZ0lMiYigYZVvNJHyJYa6JSnGP7HE1JauAviTjtrxjbPn4C/q9EW
 0jmXMjrvradU68GKEuVXL70ywh7VWFUP6VE9KWEBJorEjCzIQPD7DammxeTcdKzoBPov
 KkIOkNTxeVtST11tc9c7Jwtd3hxjLg4oVCUUyn3w0ukgIb2lzU8Sd2zk7bINxgHkpQUA
 XtPj5mpY7tFL7banndopVaZz4lGqw+d7bYKhMcRr07kOdtldGrdcV3jYhg9nVngsFNSs
 1pnQ==
X-Gm-Message-State: APjAAAWZp4H8JOXft3rATx+KhsgEklIXJOqlaRC0BZUlWRtSzjmnwEhY
 cu1FePJA8y51gyjD5wJZpa5Q9LdIIzSmuXy3H7tMKcmnBj8xGnALjuoxkvLiy/gOwZnYtJLHfy0
 AAd2TzUcwI7BudkI=
X-Received: by 2002:a1c:a382:: with SMTP id m124mr7843137wme.90.1580423513474; 
 Thu, 30 Jan 2020 14:31:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxA7g9Nm5LElgAQxKqUpluIlCehILB8fCVHRya1DZtHczg7jwPeo7Uo2BwxWgiyXVkow4/4kg==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr7843122wme.90.1580423513164; 
 Thu, 30 Jan 2020 14:31:53 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d14sm9586265wru.9.2020.01.30.14.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:31:52 -0800 (PST)
Subject: Re: [PATCH v5 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200121095205.26323-1-thuth@redhat.com>
 <20200121095205.26323-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef7deb82-e2da-f572-8e17-aaf59b34dd4c@redhat.com>
Date: Thu, 30 Jan 2020 23:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121095205.26323-6-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 3OwqCHK5O5aP9lMIBR5cpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 10:52 AM, Thomas Huth wrote:
> We are going to enable some of the python-based tests in the "auto" group,
> and these tests require virtio-blk to work properly. Running iotests
> without virtio-blk likely does not make too much sense anyway, so instead
> of adding a check for the availability of virtio-blk to each and every
> test (which does not sound very appealing), let's rather add a check for
> this a central spot in the "check" script instead (so that it is still
> possible to run "make check" for qemu-system-tricore for example).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/check | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 2890785a10..1629b6c914 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -642,7 +642,15 @@ fi
>   python_usable=false
>   if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >= (3,6) else 1)'
>   then
> -    python_usable=true
> +    # Our python framework also requires virtio-blk
> +    if "$QEMU_PROG" -M none -device help | grep -q virtio-blk >/dev/null 2>&1

FYI I proposed a patch adding a binary_get_devices() helper:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07314.html

You could use something such

   @SkipUntil('virtio-blk' in binary_get_devices(qemu_bin))

> +    then
> +        python_usable=true
> +    else
> +        python_unusable_because="Missing virtio-blk in QEMU binary"
> +    fi
> +else
> +    python_unusable_because="Unsupported Python version"
>   fi
>   
>   default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
> @@ -830,7 +838,7 @@ do
>                   run_command="$PYTHON $seq"
>               else
>                   run_command="false"
> -                echo "Unsupported Python version" > $seq.notrun
> +                echo "$python_unusable_because" > $seq.notrun
>               fi
>           else
>               run_command="./$seq"
> 


