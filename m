Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0227C2399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9ObvbYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0227C2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhrJ-00031H-GJ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhpo-0002V3-EV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhpl-0003fO-U7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600779349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rw/tuAvGlecug5HxJuzsSatMasPRdb7o1gJdGTBAp+0=;
 b=H9ObvbYDu6vlNa7IYAO/usxdd8NUN8WF35Gg3m6KGyclTMDsMXn8RUoDokgk1fjXDxrBuR
 fdZythS18a0Wr073GjYkIcHPi5SJ9V5D4IbGD5fCf/VdqAF7KmptXSTg8Z+AskRE92tNkT
 FdTWHgq6fwoc3nbA0YYawEHLQPhzadY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-LAGy8mHWNjWCx_bBJxPOHQ-1; Tue, 22 Sep 2020 08:55:48 -0400
X-MC-Unique: LAGy8mHWNjWCx_bBJxPOHQ-1
Received: by mail-wm1-f71.google.com with SMTP id c200so877348wmd.5
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rw/tuAvGlecug5HxJuzsSatMasPRdb7o1gJdGTBAp+0=;
 b=daAOALhflLTpbs6fsfQgB+DCZmL3RKpWbSdQHuNOqtrqGyRRR4/GSq5PiZyHkpa4FK
 O6sY95hHTrPqjz0WOvACAKs6gW9K3K7FCZkaSKRuB8PZRcVAsndJ5vFyYDByfac3gbb7
 gS4AyHQr+F0EpStEnGh+E9GvPb+zxg451y0IxJ13dZ2hNF38Ty8EASySS0G9yfyBQ/K5
 YMBwbZ2YjecKBkHmLXkL96b6t7ExMwG1yx2K1hOtzjWkRK5bI36//FRrQ1b8O9wqP+kG
 8kDPw529S45jWtlyjbou98fIieFAgulvRDhrVWhAZTTCA0DaA/166jnPNA3pcrK8Ja5D
 RaQg==
X-Gm-Message-State: AOAM530P0lziu/seb+x+W5zlElR+M5c/Gqfa3f6ejAqP4XWufOZzY54p
 zqdVl0YS6VAXa6G433353Xn/tDbwvCQADxVBn927S5Bn2SXrNWI+9LhJZhJo8Xw5S//hPqoKw8H
 A4NVROm54ZQVrr3o=
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr5188890wrw.348.1600779345168; 
 Tue, 22 Sep 2020 05:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm/9c40CP7pk59V/E5zrpnOtJchrqhKF5UmWW6FVkPsNqA96RjJ6zJMZgZTI86f39vJSKv1Q==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr5188869wrw.348.1600779345009; 
 Tue, 22 Sep 2020 05:55:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d2sm26356795wro.34.2020.09.22.05.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 05:55:44 -0700 (PDT)
Subject: Re: [PATCH v5 14/15] replay: create temporary snapshot at debugger
 connection
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
 <160077701869.10249.1932448449161159554.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7173ee94-3250-d3cc-5f43-a2435de36902@redhat.com>
Date: Tue, 22 Sep 2020 14:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160077701869.10249.1932448449161159554.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On 9/22/20 2:16 PM, Pavel Dovgalyuk wrote:
> When record/replay does not uses overlays for storing the snapshots,
> user is not capable of issuing reverse debugging commands.
> This patch adds creation of the VM snapshot on the temporary
> overlay image, when the debugger connects to QEMU.
> Therefore the execution can be rewind to the moment
> of the debugger connection while debugging the virtual machine.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  gdbstub.c                 |    1 +
>  include/sysemu/replay.h   |    2 ++
>  replay/replay-debugging.c |   16 ++++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index ac92273018..f19f98ab1a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -3321,6 +3321,7 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
>          s->g_cpu = s->c_cpu;
>  
>          vm_stop(RUN_STATE_PAUSED);
> +        replay_gdb_attached();
>          gdb_has_xml = false;
>          break;
>      default:
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index b6cac175c4..2aa34b8919 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -94,6 +94,8 @@ bool replay_reverse_continue(void);
>  bool replay_running_debug(void);
>  /* Called in reverse debugging mode to collect breakpoint information */
>  void replay_breakpoint(void);
> +/* Called when gdb is attached to gdbstub */
> +void replay_gdb_attached(void);
>  
>  /* Processing the instructions */
>  
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index d02d4e0766..bb9110707a 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -316,3 +316,19 @@ void replay_breakpoint(void)
>      assert(replay_mode == REPLAY_MODE_PLAY);
>      replay_last_breakpoint = replay_get_current_icount();
>  }
> +
> +void replay_gdb_attached(void)
> +{
> +    /*
> +     * Create VM snapshot on temporary overlay to allow reverse
> +     * debugging even if snapshots were not enabled.
> +     */
> +    if (replay_mode == REPLAY_MODE_PLAY
> +        && !replay_snapshot) {
> +        Error *err = NULL;
> +        if (save_snapshot("start_debugging", &err) != 0) {
> +            /* Can't create the snapshot. Continue conventional debugging. */

If you deliberately ignore the error, then use NULL;
else display the error.

> +            error_free(err);
> +        }
> +    }
> +}
> 


