Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36727C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 04:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0224320738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 04:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbExphXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0224320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8G0a-0004qf-6M
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 00:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8G03-0004P4-55
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 00:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8Fzz-0000G0-Qc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 00:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597812414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bRoM0PHzquaAVLl3aIe/J0Sv5Y5r80AviJxRC4AW/Ks=;
 b=NbExphXWAuq/ToMVLCBRfg6wUu4PUyUiXxxvUSSVTOkF+Ivqzjtq+2HVcay1+iMfvhTUJG
 w0jpcxmi7s0kDzK9H0+kvXQKARuqVZ96JH/e51ddUa8+ogyWLRJJtLfTaM7kHhvZfuiY7v
 5J0UfE76sMfCcTxb5gC+ju+t7jkUc2g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-9rTyesrFOO27rLoCiR9MuA-1; Wed, 19 Aug 2020 00:46:51 -0400
X-MC-Unique: 9rTyesrFOO27rLoCiR9MuA-1
Received: by mail-wr1-f69.google.com with SMTP id r29so8933212wrr.10
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 21:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bRoM0PHzquaAVLl3aIe/J0Sv5Y5r80AviJxRC4AW/Ks=;
 b=t2LG8aFUra45/SibYDXfW+GUQ6up0uDXgb1QkpexCEECSOHupbvr3irB8tMgqG/pCQ
 D7O628iOHnyPsyFiILPvQPae2+r1Ybq6jxrqLBIQJAuPqGwX1HUGACgQMGsD5ezize1O
 brbsKHXaj3+LdoYB2I9ibwAuCGUwB8NcPUN53P2KsDuCoRp7bxyHgSu1s1QNmYIpWP/t
 gOCNo9EYxa/0bcWxHqUTKYqzplPCLWaRODWKNnTCkRXwPGFbTCgtvxv7ViAxr7EyZa/8
 0eT7PjVonDnciuzW1JfLZz4c8x2x+HfpBGHNhEG3pMTmWu732bQML1v2j8oCnLCrCvce
 E0Kg==
X-Gm-Message-State: AOAM531t7D25AaQ2VDbnms2HllYQEIB2rM0ekg+xY9I89l2USenWwYk9
 viur3ZCXUSiZLaJ3sPH8XJ6WFT3Yi4d4e0kjSgf2glbCIku8cUXGoYayY2LuBOXituy4lfD4NoB
 5stdo78yhZqgtDEw=
X-Received: by 2002:adf:e411:: with SMTP id g17mr24483706wrm.77.1597812410128; 
 Tue, 18 Aug 2020 21:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoyCJssBCOty8dwbZAQOZtkLWGUYXdDOeIzonMAKQaO120E5OjwqeYmrg1cPWQ7vH2utnNiA==
X-Received: by 2002:adf:e411:: with SMTP id g17mr24483690wrm.77.1597812409855; 
 Tue, 18 Aug 2020 21:46:49 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 188sm8738483wmz.2.2020.08.18.21.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 21:46:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] audio/jack: fix use after free segfault
To: Geoffrey McRae <geoff@hostfission.com>
References: <20200819011835.92737-1-geoff@hostfission.com>
 <20200819011835.92737-2-geoff@hostfission.com>
 <34c4c83a-c870-0d21-1a15-3da76b4e5488@redhat.com>
 <5c2a509c0807efbc1fab24f54fad150c@hostfission.com>
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
Message-ID: <36f399e3-028e-9187-fc90-288a6ad7f64c@redhat.com>
Date: Wed, 19 Aug 2020 06:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5c2a509c0807efbc1fab24f54fad150c@hostfission.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 5:36 AM, Geoffrey McRae wrote:
> 
> 
> On 2020-08-19 13:32, Philippe Mathieu-Daudé wrote:
>> Hi Geoffrey,
>>
>> On 8/19/20 3:18 AM, Geoffrey McRae wrote:
>>> The client may have been freed already by a secondary audio device
>>> recovering its session as JACK2 has some cleanup code to work around
>>> broken clients, which doesn't account for well behaved clients.
>>>
>>> https://github.com/jackaudio/jack2/issues/627
>>>
>>> As JACK1 and JACK2 are interchangeable and JACK2 has "cleanup" routine
>>> that JACK1 does not have, we need to determine which version is in use
>>> at runtime. Unfortunatly there is no way to determine which is in use
>>> other then to look for symbols that are missing in JACK1, which in this
>>> case is `jack_get_version`.
>>>
>>> An issue has been raised over this, but to be compatible with older
>>> versions we must use this method to determine which library is in use.
>>> If at some time the jack developers implement `jack_get_version` in
>>> JACK1, this code will need to be revisited.
>>>
>>> At worst the workaround will be enabled and this will introduce a small
>>> memory leak if the jack server is restarted. This however is better then
>>> the alternative which would be a use after free segfault.
>>>
>>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>>> ---
>>>  audio/jackaudio.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>  configure         |  4 +++-
>>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
>>> index 72ed7c4929..d1685999c3 100644
>>> --- a/audio/jackaudio.c
>>> +++ b/audio/jackaudio.c
>>> @@ -31,6 +31,7 @@
>>>  #define AUDIO_CAP "jack"
>>>  #include "audio_int.h"
>>>
>>> +#include <dlfcn.h>
>>>  #include <jack/jack.h>
>>>  #include <jack/thread.h>
>>>
>>> @@ -84,6 +85,7 @@ typedef struct QJackIn {
>>>  }
>>>  QJackIn;
>>>
>>> +static int QJackWorkaroundCloseBug;
>>>  static int qjack_client_init(QJackClient *c);
>>>  static void qjack_client_connect_ports(QJackClient *c);
>>>  static void qjack_client_fini(QJackClient *c);
>>> @@ -563,7 +565,10 @@ static void qjack_client_fini(QJackClient *c)
>>>          /* fallthrough */
>>>
>>>      case QJACK_STATE_SHUTDOWN:
>>> -        jack_client_close(c->client);
>>> +        if (!QJackWorkaroundCloseBug) {
>>> +            jack_client_close(c->client);
>>> +        }
>>> +        c->client = NULL;
>>>          /* fallthrough */
>>>
>>>      case QJACK_STATE_DISCONNECTED:
>>> @@ -662,6 +667,36 @@ static void qjack_info(const char *msg)
>>>
>>>  static void register_audio_jack(void)
>>>  {
>>> +    void *handle;
>>> +
>>> +    /*
>>> +     * As JACK1 and JACK2 are interchangeable and JACK2 has
>>> "cleanup" routine
>>> +     * that JACK1 does not have, we need to determine which version
>>> is in use at
>>> +     * runtime. Unfortunatly there is no way to determine which is
>>> in use other
>>> +     * then to look for symbols that are missing in JACK1, which in
>>> this case is
>>> +     * `jack_get_version`. An issue has been raised over this, but
>>> to be
>>> +     * compatible with older versions we must use this method to
>>> determine which
>>> +     * library is in use. If at some time the jack developers implement
>>> +     * `jack_get_version` in JACK1, this code will need to be
>>> revisited.
>>> +     *
>>> +     * At worst the workaround will be enabled and we will introduce
>>> a small
>>> +     * memory leak if the jack server is restarted. This is better
>>> then the
>>> +     * alternative which would be a use after free segfault.
>>> +     */
>>> +
>>> +    handle = dlopen("libjack.so", RTLD_LAZY | RTLD_NOLOAD);
>>> +    if (!handle) {
>>> +        dolog("unable to open libjack.so to determine version\n");
>>> +        dolog("assuming JACK2 and enabling the close bug
>>> workaround\n");
>>> +        QJackWorkaroundCloseBug = 1;
>>> +    } else {
>>> +        if (dlsym(handle, "jack_get_version")) {
>>> +            dolog("JACK2 detected, enabling close bug workaround\n");
>>> +            QJackWorkaroundCloseBug = 1;
>>> +        }
>>> +        dlclose(handle);
>>> +    }
>>> +
>>>      audio_driver_register(&jack_driver);
>>>      jack_set_thread_creator(qjack_thread_creator);
>>>      jack_set_error_function(qjack_error);
>>> diff --git a/configure b/configure
>>> index 2acc4d1465..43d2893fbb 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -3754,7 +3754,8 @@ for drv in $audio_drv_list; do
>>>
>>>      jack | try-jack)
>>>      if $pkg_config jack --exists; then
>>> -        jack_libs=$($pkg_config jack --libs)
>>> +        # dl is needed to check at runtime if jack1 or jack2 is in use
>>> +        jack_libs="$($pkg_config jack --libs) -ldl"
>>>          if test "$drv" = "try-jack"; then
>>>              audio_drv_list=$(echo "$audio_drv_list" | sed -e
>>> 's/try-jack/jack/')
>>>          fi
>>
>> Why not checking jack_get_version() using compile_prog here?
>>
>> Thanks,
>>
>> Phil.
> 
> Hi Phil,
> 
> Because the library can be swapped out after compile time as the
> versions are ABI compatible by design.

IIUC in the GH issue you linked you describe a problem from v1.9.1
to v1.9.14. I see jack_get_version() is already available in v1.9.1:
https://github.com/jackaudio/jack2/blob/1.9.1/common/jack/jack.h#L55

Why would someone link with jack2 then replace it with jack1 without
rebuilding? That sounds silly...

> 
> -Geoff
> 


