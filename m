Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D78C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441F320723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUG81Se9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441F320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnioz-0003FA-Is
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnins-0002Lc-2H
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:17:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnino-0000jz-SQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592918245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yYNM5u/4mJli+dxJSU2SE719mdN5URU2YQPSf3QZ010=;
 b=KUG81Se90fAQehuzVmqB8xBlYaEHQ6Bktzlqlxi8jV+FeXrCBVKrIgQJAZM4Kwg/hjDdJE
 oEynjsYEIgeIc+jQqcAURmuPMix+JvkGNaVUgvAgrRtrHX8gBzmwyHU0u175Z22GGVOLfk
 QiUMd+U0yJCjG5Puzf/DeEE/+8D6+ao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-K47q-uszPyWlNY7cgCf-1w-1; Tue, 23 Jun 2020 09:17:18 -0400
X-MC-Unique: K47q-uszPyWlNY7cgCf-1w-1
Received: by mail-wr1-f69.google.com with SMTP id i10so11773041wrn.21
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yYNM5u/4mJli+dxJSU2SE719mdN5URU2YQPSf3QZ010=;
 b=C5FryenWZ4qn9X+V8vkB3npZphY22B76TlGx80Gw9lJUkTMJlgFIHq4Q4DJ6ZvWdeb
 6VaPQ0+HDPfD3GJmTQ+50lX57HoZY9MfwhBnMvvqz9qVvZuVpGlCMGto4a0axDY73NqE
 EbRTi5c12L3xqqEkew1T4GNOdDWsPBd2WUHShQGHAb9yCfeD5+DVEUOBHAL2gz0L2pE4
 Y8BPlT8nFBYPKQw3jKPSnVNUN6A1gh+EklN1eGCw9PsyDimtRmRGa9hoLk4h0If2R4no
 wuxc85FBsdJVy56GaMNtdgjr0PqQnF8gcGDf1O42+EmnNZthxK+YPZRcc0FOJy86LXqJ
 d7Eg==
X-Gm-Message-State: AOAM531AtdhuFLJ4v+WdPSHWpeo0K0X0ztWIcfSo+4osX7SOwShzmtlF
 ++liNGyvaiwlus9mjPqOiiriHAwi4Mc/HHEDbrxwhOry86xBb0MQexZ46+MglO5dcD2e8PoJ1Sg
 XgfnxaTRFIUCjXYY=
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr24468596wmg.153.1592918237256; 
 Tue, 23 Jun 2020 06:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/kG5mBwL0TbQOsAEhV8QqchSUZuZjNgPcDBPJFI5j+Kx32ZCwyuwb6mTPPg6H8YtwDAaTkg==
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr24468568wmg.153.1592918236965; 
 Tue, 23 Jun 2020 06:17:16 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 65sm2718637wma.48.2020.06.23.06.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 06:17:16 -0700 (PDT)
Subject: Re: [PATCH v9 04/10] configure: Generate rule to calculate the base
 architecture of a target
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
 <20200618123342.10693-5-philmd@redhat.com>
 <08f176aa-56a1-3bd0-5889-806f383bca8b@suse.de>
 <eed19fd0-8817-7b63-0f81-5c4df35f3174@redhat.com>
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
Message-ID: <d89e9324-5943-dbf3-dbb1-a55917d5e131@redhat.com>
Date: Tue, 23 Jun 2020 15:17:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <eed19fd0-8817-7b63-0f81-5c4df35f3174@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 10:45 AM, Philippe Mathieu-Daudé wrote:
> On 6/23/20 10:01 AM, Claudio Fontana wrote:
>> Hi Philippe, Alex,
>>
>> On 6/18/20 2:33 PM, Philippe Mathieu-Daudé wrote:
>>> From: Alex Bennée <alex.bennee@linaro.org>
>>>
>>> As we encode the base architecture in configure.sh, we can emit
>>> the base-arch() function into config-host.mak.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> I found this change a bit strange, but maybe I am missing some context.
> 
> This is used in patch 9:
> "Makefile: Allow target-specific optional Kconfig"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg713823.html
> 
>>
>> Would it not be easier to read the information from the
>> config-target.mak files as it is already emitted there?
> 
> So you are suggesting moving the SUBDIR_DEVICES_MAK creation code
> to Makefile.target, before until now it is target-agnostic but we
> are making it target-specific. Yes, it could work...
> 
> I keep respining this series since the semihosting rework. Frankly
> I don't remember why it became so complicated, I need to jump into
> the code again.
> 
> I guess when Paolo introduced Kconfig, the accelerator configs were
> almost static, so SUBDIR_DEVICES_MAK was only dependent of host
> config.
> 
> The semihosting "device" depends of accelerator and target configs.
> 
> Maybe the problem is to see minikconf generating device selectors,
> as kconfig is also used for generic features (such accelerator,
> not really "device").

This might be solved easily using Meson... Maybe better wait for it?

>
>>
>>> ---
>>>  configure | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index ba88fd1824..c0d7fbc30e 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -7927,6 +7927,8 @@ if test "$linux" = "yes" ; then
>>>      fi
>>>  fi
>>>  
>>> +target_to_base_map=""
>>> +
>>>  for target in $target_list; do
>>>  target_dir="$target"
>>>  config_target_mak=$target_dir/config-target.mak
>>> @@ -8155,6 +8157,7 @@ target_arch_name="$(upper $TARGET_ARCH)"
>>>  echo "TARGET_$target_arch_name=y" >> $config_target_mak
>>>  echo "TARGET_NAME=$target_name" >> $config_target_mak
>>>  echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
>>> +target_to_base_map="$target_dir,$TARGET_BASE_ARCH $target_to_base_map"
>>>  if [ "$TARGET_ABI_DIR" = "" ]; then
>>>    TARGET_ABI_DIR=$TARGET_ARCH
>>>  fi
>>> @@ -8370,6 +8373,22 @@ if test "$ccache_cpp2" = "yes"; then
>>>    echo "export CCACHE_CPP2=y" >> $config_host_mak
>>>  fi
>>>  
>>> +# Export a rule for calculating base arch from target_dir for use by
>>> +# the Kconfig generator
>>> +echo "# Usage: \$(call base-arch, target-dir)" >> $config_host_mak
>>> +echo "# Return the base architecture for a target." >> $config_host_mak
>>> +echo "# e.g \$(call base-arch, aarch64-linux-user) returns 'arm'" >> $config_host_mak
>>> +echo "base-arch = \$(strip \\" >> $config_host_mak
>>> +close_braces=""
>>> +for pairs in $target_to_base_map
>>> +do
>>> +    dir="${pairs%%,*}"
>>> +    base="${pairs#*,}"
>>> +    echo "\$(if \$(findstring $dir,\$1),$base, \\" >> $config_host_mak
>>> +    close_braces="$close_braces )"
>>> +done
>>> +echo "$close_braces )" >> $config_host_mak
>>> +
>>>  # If we're using a separate build tree, set it up now.
>>>  # DIRS are directories which we simply mkdir in the build tree;
>>>  # LINKS are things to symlink back into the source tree
>>>
>>
> 


