Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CFBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED91220719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/kA9SCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED91220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQ0i-0000nC-22
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGPzv-0008SR-SK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGPzu-0000xm-Na
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:32:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGPzu-0000xb-JP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584981138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmdyQ6vyJHOuL+StfP8SNhDHBe5wuR9qpkm3UV/vs4o=;
 b=c/kA9SCzt1NpXBq5QgWZIAPEIC/Fk3VpOZpAyKOZDNoHVRYUOlG1W3f5SeD3tHTUgrjV/W
 MFIgoG9XFmPWhGHxvosiiSeQKR62dw9IOrlqiPG5FMP0BiC7tfCTkUXuUW0Ed0o072t3YC
 xeYg+mUsAxjcioGHAbG6ye4XJeuVgVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-sGYvVLGtO7CZRslFDhcqvg-1; Mon, 23 Mar 2020 12:32:14 -0400
X-MC-Unique: sGYvVLGtO7CZRslFDhcqvg-1
Received: by mail-wm1-f72.google.com with SMTP id v184so27103wme.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9MSZ3GlyizUjRA0oiwXzv2IVEWyWCFyUIgn++Pq+VB0=;
 b=H82Wr8hjiNQjl/qjouMJOtFjRxpz29kXe2E4J3UIjHJH7UfEnzVHXdVl9Frev2EmEd
 LRi6je9+dgQ23+fETmL0EK6X8UU7zcsCF3ph66TVfot0QLYh7dj+BJL34DxsCNdV0YYx
 ZFwxOBPlBAYqhCMhIk7eJ7xY7QQ4Lp8px1WkF8xOfzH5oydK7HvuxhWUba7OPEL2MhEG
 kcsyMDCMfDMT3zOPWwZe9S/r1VQKyDYhixkCXA9EBz8z02UZ+kqoVfRp2ClA8wDYVNH6
 VE95wKAU367dkBUx16PfifVqQ8xnCmh/7Awf4efuP1l/dj/jdHWf5XqjnfPi7nTqRoQz
 SzOA==
X-Gm-Message-State: ANhLgQ0Cu3iAg5oTWxCl+q7SkRpelEn8XzdE6SK8WjyH54h8tgS5jPum
 WF2F82D84Cpmr7pDTdlRAFpiv0FIi8fM9b17zBfyh7oRsquERmDN2abLU3hUW1mGkTK1oWHkzPk
 mi+iBsAvAOjbpriA=
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr128434wml.50.1584981133205;
 Mon, 23 Mar 2020 09:32:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+cYTdKgLkoddiPB23B0+CQWULMwTRK49XdvDJKn4zfBodmcD3SJK/Kfw/uFo4aGEsldEw2Q==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr128413wml.50.1584981132941;
 Mon, 23 Mar 2020 09:32:12 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d5sm14901099wrh.40.2020.03.23.09.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 09:32:12 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] tests/vm: fix basevm config
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b15df133-87b8-7980-abb3-c14aabd7c350@redhat.com>
Date: Mon, 23 Mar 2020 17:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-6-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 5:15 PM, Alex Benn=C3=A9e wrote:
> When the patch was merged it was part of a longer series which had
> already merged the config changes. Semu-revert the config related

Typo "semi-revert"?

> changes for now so things will build.
>=20
> Fixes: b081986c85fd2
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/basevm.py | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index cffe7c4600e..756ccf7acae 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -358,23 +358,23 @@ class BaseVM(object):
>                             "local-hostname: {}-guest\n".format(name)])
>           mdata.close()
>           udata =3D open(os.path.join(cidir, "user-data"), "w")
> -        print("guest user:pw {}:{}".format(self._config['guest_user'],
> -                                           self._config['guest_pass']))
> +        print("guest user:pw {}:{}".format(self.GUEST_USER,
> +                                           self.GUEST_PASS))
>           udata.writelines(["#cloud-config\n",
>                             "chpasswd:\n",
>                             "  list: |\n",
> -                          "    root:%s\n" % self._config['root_pass'],
> -                          "    %s:%s\n" % (self._config['guest_user'],
> -                                           self._config['guest_pass']),
> +                          "    root:%s\n" % self.ROOT_PASS,
> +                          "    %s:%s\n" % (self.GUEST_USER,
> +                                           self.GUEST_PASS),
>                             "  expire: False\n",
>                             "users:\n",
> -                          "  - name: %s\n" % self._config['guest_user'],
> +                          "  - name: %s\n" % self.GUEST_USER,
>                             "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
>                             "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % self._config['ssh_pub_key'],
> +                          "    - %s\n" % SSH_PUB_KEY,
>                             "  - name: root\n",
>                             "    ssh-authorized-keys:\n",
> -                          "    - %s\n" % self._config['ssh_pub_key'],
> +                          "    - %s\n" % SSH_PUB_KEY,
>                             "locale: en_US.UTF-8\n"])
>           proxy =3D os.environ.get("http_proxy")
>           if not proxy is None:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


