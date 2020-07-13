Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D969DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12BE206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiWEC+6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juz9c-00043W-RL
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juz93-0003Vg-Hq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:09:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juz91-0006CT-2Y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aiSZxFTJtbaQEGkqp390a8xbH3Q4T/pAfl6LhtEnqJM=;
 b=EiWEC+6okcTmo0NW276hy/Jq6jbAy3gOs9QkYlfjYfTWUCZ7L8Iu1rgLHL2GYZIx+IzI3d
 2zB2DYT1tyPnOOkPzsrej16m7LAiFm7t3xvTCuxqHgm370BB52+XGCs0ryrqIDDiRXv0lF
 4fGpZvlMd3o+f8QXrsZV+5vJCcyNoNc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-GQFccH_4OzyI-hKbTN_sYA-1; Mon, 13 Jul 2020 10:09:18 -0400
X-MC-Unique: GQFccH_4OzyI-hKbTN_sYA-1
Received: by mail-ed1-f69.google.com with SMTP id c25so21291168edr.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aiSZxFTJtbaQEGkqp390a8xbH3Q4T/pAfl6LhtEnqJM=;
 b=re86PprN8/3Vw3xoSmJHhf1IUns+VLT6d02hnOqc4bQW+jojDnZo1eKnuU+/iOhXZV
 +TTZcYoXvr23GXZSpQDVDGgv+txL0kZYvoxLBmvgtqzh7mU2IPznBqxEcUKkZsIuh3qc
 YjvTp5Qy6wzNquAtv+ZRCG0qNTlrq0wdCTitqaWgxRIydPxjbblxsaFgQg4CXwcIjHTQ
 lknUHcHnnrmasu+NYePR8jGusYGgPThUnHFcQ42BgcSO8XCZS56bdCm4VIUyFw6UMyIm
 s1iHYTe/gporjlHeg8PVFYVHOY5YDeLEOd/1GmXLc1+3b/yXE16q5Tm1DK2k3XogLXRz
 W7cw==
X-Gm-Message-State: AOAM531vFLqt9FR2Ix0eUSZ6qnXoEBOU/bKda1wrdUo7rK/kQVjlcXmO
 54d5W5h9F95EaYJYWY6Vp84a5dnMVa+bK/236FetbZ96/FCjV6f9++O5gqOCuOZOu1A6Vue6N9o
 pfOPsMkW8nXiurdQ=
X-Received: by 2002:a17:906:35cd:: with SMTP id
 p13mr73153991ejb.172.1594649357669; 
 Mon, 13 Jul 2020 07:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwuuQurSSzIS2DutklcbowqH0cQnQS80y10twtTA7JmEtNlZAZumKx86NOsOfH7c/m085zDw==
X-Received: by 2002:a17:906:35cd:: with SMTP id
 p13mr73153969ejb.172.1594649357460; 
 Mon, 13 Jul 2020 07:09:17 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t20sm9848929ejd.124.2020.07.13.07.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 07:09:16 -0700 (PDT)
Subject: Re: [PATCH] vfio: fix use-after-free in display
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200713124520.23266-1-kraxel@redhat.com>
 <efedf130-518d-fd3a-04b6-b501bf06cc8c@redhat.com>
 <20200713140028.yoxn77csag7cbbfh@sirius.home.kraxel.org>
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
Message-ID: <7e76540f-6d3e-de4b-c26b-2806162f72cb@redhat.com>
Date: Mon, 13 Jul 2020 16:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713140028.yoxn77csag7cbbfh@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 4:00 PM, Gerd Hoffmann wrote:
> On Mon, Jul 13, 2020 at 02:51:05PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> On 7/13/20 2:45 PM, Gerd Hoffmann wrote:
>>> Calling ramfb_display_update() might replace the DisplaySurface with the
>>> boot display, which in turn will free the currently active
>>> DisplaySurface.
>>>
>>> So clear our DisplaySurface pinter (dpy->region.surface pointer) to (a)
>>> avoid use-after-free and (b) force replacing the boot display with the
>>> real display when switching back.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  hw/vfio/display.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>>> index a57a22674d62..342054193b3c 100644
>>> --- a/hw/vfio/display.c
>>> +++ b/hw/vfio/display.c
>>> @@ -405,6 +405,7 @@ static void vfio_display_region_update(void *opaque)
>>>      if (!plane.drm_format || !plane.size) {
>>>          if (dpy->ramfb) {
>>>              ramfb_display_update(dpy->con, dpy->ramfb);
>>> +            dpy->region.surface = NULL;
>>>          }
>>>          return;
>>>      }
>>>
>>
>> More generic fix:
>>
>> -- >8 --
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -1580,10 +1580,10 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>>                               DisplaySurface *surface)
>>  {
>>      DisplayState *s = con->ds;
>> -    DisplaySurface *old_surface = con->surface;
>> +    QemuConsole *old_con = con;
>>      DisplayChangeListener *dcl;
>>
>> -    assert(old_surface != surface || surface == NULL);
>> +    assert(con->surface != surface || surface == NULL);
>>
>>      con->surface = surface;
>>      QLIST_FOREACH(dcl, &s->listeners, next) {
>> @@ -1594,7 +1594,8 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>>              dcl->ops->dpy_gfx_switch(dcl, surface);
>>          }
>>      }
>> -    qemu_free_displaysurface(old_surface);
>> +    qemu_free_displaysurface(old_con->surface);
>> +    old_con->surface = NULL;
> 
> No.
> 
> That doesn't clear VFIODisplay->region.surface, but it sets
> QemuConsole->surface to NULL no matter what got passed to
> dpy_gfx_replace_surface().
> 
> Guesswork based just on the patch chunk doesn't always work,
> sometimes you have to consult the source code to see what the
> patch actually does ;)

I'm certainly not a source of trust producing perfect code :)
I appreciate being reviewed on snippets, so I can learn from my
mistakes and improve. I looked at the code (ui/console.c was not
in the previous context) but I missed to look at the other call
sites for dpy_gfx_replace_surface() and how it is used.

Thanks,

Phil.

> 
> take care,
>   Gerd
> 


