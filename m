Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51B720756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6sKNhgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51B720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Wd5-0005yz-Lo
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5WcP-0005UV-MA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:55:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5WcO-0005LZ-28
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597161314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3ZibnC//1CFaPoaIP5MyH7z6inKY9T6njZHhqZ2E4Zg=;
 b=R6sKNhgE3zjh1LN2ajx0wirumtAPsDFa9EKRoZFMFeSk1wowLIKjdoTQTAUvPHwW9SZOx1
 dx+HT4Uq/Nvi4OeI2ZPCDWtH1kyabYGy3PPSa8K/NDsMJcXI/ZmeWT03regiDoIcy0aHTn
 rNlUl9xVJ3lnNaP/mjflPzpAoe1jr1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-fx7LgZnxMH2q8-ho9DH7Tw-1; Tue, 11 Aug 2020 11:55:13 -0400
X-MC-Unique: fx7LgZnxMH2q8-ho9DH7Tw-1
Received: by mail-wr1-f70.google.com with SMTP id d6so5745383wrv.23
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ZibnC//1CFaPoaIP5MyH7z6inKY9T6njZHhqZ2E4Zg=;
 b=Z6gXLr8BzBDgGo29350KCOLsCm8H2YsxPt8aHrFtXYr4xgHewpd1uP16PE9qYYLNPD
 aOmYglZaeZE0VilL9e1nfUcg3qtgM8BhWuwPrvF0eKuvV0OqVr2QVJ6TI0Z9ob3RrJsr
 6SYHYp9naBzcwwBCCBbJGv42RhWGhE+4XKnPSfJAfj/SpCFCq+4Xc9aglgVsdldKK77D
 hPAgDyDo8YfhIiFVwIajC5wL/PlinPmvRc3f7OGH8GftaB3Ime8c3ybvGCj2PjF6MSyf
 LDX8qQNZQWrVNLO2hbiKk9nwmobBCmFxChxKo7vV74EOjBQAw1pwCrzoIgasnMRHG1PJ
 Z+2w==
X-Gm-Message-State: AOAM533wpILPkWVDFCR5U5RPqG0pYvswna5JFjttLuyN0cCHiwy558M8
 HHRPN1pvCEPb2L7j9YJkNlaB0md1tP7wbbJbdCfTtjUQlpGr37eGmiOrhSIdSTI5h95wzup+TXK
 oqDZnIv7IxXRHr+8=
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr32199256wru.201.1597161310156; 
 Tue, 11 Aug 2020 08:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVyN36Pz25HRDaZWSTxlCupFd9avpc38QuAFhcVT9E50Z6Hi+NFwAoWWhrzj6Oss6gENOhYw==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr32199241wru.201.1597161309962; 
 Tue, 11 Aug 2020 08:55:09 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm26520880wrj.21.2020.08.11.08.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 08:55:09 -0700 (PDT)
Subject: Re: [PATCH v2] CODING_STYLE.rst: flesh out our naming conventions.
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200810105147.10670-1-alex.bennee@linaro.org>
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
Message-ID: <3dfae8bc-7f8d-1b1c-c805-5eab4e8fbb19@redhat.com>
Date: Tue, 11 Aug 2020 17:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200810105147.10670-1-alex.bennee@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 8/10/20 12:51 PM, Alex Bennée wrote:
> Mention a few of the more common naming conventions we follow in the
> code base including common variable names and function prefix and
> suffix examples.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
...
> +Function Naming Conventions
> +---------------------------
> +
> +The ``qemu_`` prefix is used for utility functions that are widely
> +called from across the code-base. This includes wrapped versions of
> +standard library functions (e.g. qemu_strtol) where the prefix is
> +added to the function name to alert readers that they are seeing a
> +wrapped version; otherwise avoid this prefix.
> +
> +If there are two versions of a function to be called with or without a
> +lock held, the function that expects the lock to be already held
> +usually uses the suffix ``_locked``.

And if there is only one version? I'm looking at:

  /* With q->lock */
  static void nvme_kick(NVMeQueuePair *q)
  {
  ...
  }

Should the style be enforced here and this function renamed
nvme_kick_locked()?

In this particular case, I think so, because we also have:

  /* With q->lock */
  static void nvme_put_free_req_locked(...)
  {
  ...
  }

  /* With q->lock */
  static void nvme_wake_free_req_locked(NVMeQueuePair *q)
  {
  ...
  }

For more cases:

$ git grep -A1 -i '\/\*.*with.*lock'


